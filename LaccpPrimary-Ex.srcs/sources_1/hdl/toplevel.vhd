library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_MISC.ALL;
use ieee.numeric_std.all;

library UNISIM;
use UNISIM.VComponents.all;

library mylib;
use mylib.defToplevel.all;
use mylib.defBCT.all;
use mylib.defMikumari.all;
use mylib.defLaccp.all;
use mylib.defHeartBeatUnit.all;
use mylib.defBusAddressMap.all;
use mylib.defSiTCP.all;
use mylib.defRBCP.all;
use mylib.defMiiRstTimer.all;

entity toplevel is
  Port (
    -- System ---------------------------------------------------------------
    PROGB_ON            : out std_logic;
    BASE_CLKP           : in std_logic;
    BASE_CLKN           : in std_logic;
    USR_RSTB            : in std_logic;
    LED                 : out std_logic_vector(4 downto 1);
    DIP                 : in std_logic_vector(4 downto 1);
    VP                  : in std_logic;
    VN                  : in std_logic;

-- GTX ------------------------------------------------------------------
    GTX_REFCLK_P        : in std_logic;
    GTX_REFCLK_N        : in std_logic;
    GTX_TX_P            : out std_logic_vector(kNumGtx downto 1);
    GTX_RX_P            : in  std_logic_vector(kNumGtx downto 1);
    GTX_TX_N            : out std_logic_vector(kNumGtx downto 1);
    GTX_RX_N            : in  std_logic_vector(kNumGtx downto 1);

-- SPI flash ------------------------------------------------------------
    MOSI                : out std_logic;
    DIN                 : in std_logic;
    FCSB                : out std_logic;

-- MIKUMARI connector ---------------------------------------------------
    MIKUMARI_RXP             : in std_logic;
    MIKUMARI_RXN             : in std_logic;
    MIKUMARI_TXP             : out std_logic;
    MIKUMARI_TXN             : out std_logic;

-- EEPROM ---------------------------------------------------------------
    EEP_CS              : out std_logic_vector(2 downto 1);
    EEP_SK              : out std_logic_vector(2 downto 1);
    EEP_DI              : out std_logic_vector(2 downto 1);
    EEP_DO              : in std_logic_vector(2 downto 1);

-- NIM-IO ---------------------------------------------------------------
    NIM_IN              : in std_logic_vector(2 downto 1);
    NIM_OUT             : out std_logic_vector(2 downto 1);

-- JItter cleaner -------------------------------------------------------
    CDCE_PDB            : out std_logic;
    CDCE_LOCK           : in std_logic;
    CDCE_SCLK           : out std_logic;
    CDCE_SO             : in std_logic;
    CDCE_SI             : out std_logic;
    CDCE_LE             : out std_logic;
    CDCE_REFP           : out std_logic;
    CDCE_REFN           : out std_logic;

    CLK_FASTP           : in std_logic;
    CLK_FASTN           : in std_logic;
    CLK_SLOWP           : in std_logic;
    CLK_SLOWN           : in std_logic

-- Main port ------------------------------------------------------------
-- Up port --
--    MAIN_IN_U           : in std_logic_vector(31 downto 0);
-- Down port --
    --MAIN_IN_D           : in std_logic_vector(31 downto 0);

-- Mezzanine slot -------------------------------------------------------
-- Up slot --
--    MZN_UP              : in std_logic_vector(31 downto 0);
--    MZN_UN              : in std_logic_vector(31 downto 0);

-- Dwon slot --
--    MZN_DP              : in std_logic_vector(31 downto 0);
--    MZN_DN              : in std_logic_vector(31 downto 0)

-- DDR3 SDRAM -----------------------------------------------------------

  );
end toplevel;

architecture Behavioral of toplevel is
  attribute mark_debug : string;

  -- System --------------------------------------------------------------------------------
  signal sitcp_reset  : std_logic;
  signal pwr_on_reset : std_logic;
  signal system_reset : std_logic;
  signal laccp_reset  : std_logic;
  signal user_reset   : std_logic;

  signal mii_reset    : std_logic;
  signal emergency_reset  : std_logic_vector(kNumGtx-1 downto 0);

  signal bct_reset    : std_logic;
  signal rst_from_bus : std_logic;

  signal delayed_usr_rstb : std_logic;

  -- DIP -----------------------------------------------------------------------------------
  signal dip_sw       : std_logic_vector(DIP'range);
  subtype DipID is integer range 0 to 4;
  type regLeaf is record
    Index : DipID;
  end record;
  constant kSiTCP     : regLeaf := (Index => 1);
  constant kClkOut    : regLeaf := (Index => 2);
  constant kIdle      : regLeaf := (Index => 3);
  constant kNC4       : regLeaf := (Index => 4);
  constant kDummy     : regLeaf := (Index => 0);

  -- MIKUMARI -----------------------------------------------------------------------------
  constant  kPcbVersion : string:= "GN-2006-4";
  --constant  kPcbVersion : string:= "GN-2006-1";

  function GetMikuIoStd(version: string) return string is
  begin
    case version is
      when  "GN-2006-4" => return "LVDS";
      when others       => return "LVDS_25";
    end case;
  end function;

  -- CDCM --
  signal power_on_init        : std_logic;

  signal cbt_lane_up          : std_logic;
  signal pattern_error        : std_logic;
  signal watchdog_error       : std_logic;

  signal mod_clk              : std_logic;

    -- Mikumari --
  signal miku_tx_ack        : std_logic;
  signal miku_data_tx       : std_logic_vector(7 downto 0);
  signal miku_valid_tx      : std_logic;
  signal miku_last_tx       : std_logic;

  signal mikumari_link_up   : std_logic;
  signal miku_data_rx       : std_logic_vector(7 downto 0);
  signal miku_valid_rx      : std_logic;
  signal miku_last_rx       : std_logic;
  signal checksum_err       : std_logic;
  signal frame_broken       : std_logic;
  signal recv_terminated    : std_logic;

  signal check_count        : integer range 0 to 127:= 0;

  signal pulse_tx, pulse_rx : std_logic;
  signal pulse_type_tx, pulse_type_rx : MikumariPulseType;
  signal busy_pulse_tx      : std_logic;

  -- LACCP --
  signal is_ready_for_daq   : std_logic;

  signal is_ready_laccp_intra   : std_logic_vector(kNumExtIntraPort-1 downto 0);
  signal valid_laccp_intra_in   : std_logic_vector(kNumExtIntraPort-1 downto 0);
  signal valid_laccp_intra_out  : std_logic_vector(kNumExtIntraPort-1 downto 0);
  signal data_laccp_intra_in    : ExtIntraType;
  signal data_laccp_intra_out   : ExtIntraType;

  -- RLIGP --
  signal link_addr_partter  : std_logic_vector(kPosRegister'range);
  signal valid_link_addr    : std_logic;

  -- RCAP --
  signal valid_hbc_offset   : std_logic;
  signal hbc_offset         : std_logic_vector(kWidthHbCount-1 downto 0);

  -- Heartbeat --
  signal heartbeat_signal   : std_logic;
  signal heartbeat_count    : std_logic_vector(kWidthHbCount-1 downto 0);
  signal hbf_number         : std_logic_vector(kWidthHbfNum-1 downto 0);
  signal hbf_state          : HbfStateType;
  signal frame_ctrl_gate    : std_logic;

  attribute mark_debug of is_ready_for_daq   : signal is "true";
  attribute mark_debug of link_addr_partter  : signal is "true";
  attribute mark_debug of valid_link_addr    : signal is "true";

  -- C6C ----------------------------------------------------------------------------------
  signal c6c_reset              : std_logic;
  signal c6c_fast, c6c_slow     : std_logic;

  -- MIG ----------------------------------------------------------------------------------

  -- SDS ---------------------------------------------------------------------
  signal shutdown_over_temp     : std_logic;
  signal uncorrectable_flag     : std_logic;

  -- FMP ---------------------------------------------------------------------

  -- BCT -----------------------------------------------------------------------------------
  signal addr_LocalBus          : LocalAddressType;
  signal data_LocalBusIn        : LocalBusInType;
  signal data_LocalBusOut       : DataArray;
  signal re_LocalBus            : ControlRegArray;
  signal we_LocalBus            : ControlRegArray;
  signal ready_LocalBus         : ControlRegArray;

  -- TSD -----------------------------------------------------------------------------------
  type typeTcpData is array(kNumGtx-1 downto 0) of std_logic_vector(kWidthDataTCP-1 downto 0);
  signal wd_to_tsd                              : typeTcpData;
  signal we_to_tsd, empty_to_tsd, re_from_tsd   : std_logic_vector(kNumGtx-1 downto 0);

  -- SiTCP ---------------------------------------------------------------------------------
  type typeUdpAddr is array(kNumGtx-1 downto 0) of std_logic_vector(kWidthAddrRBCP-1 downto 0);
  type typeUdpData is array(kNumGtx-1 downto 0) of std_logic_vector(kWidthDataRBCP-1 downto 0);

  signal tcp_isActive, close_req, close_act    : std_logic_vector(kNumGtx-1 downto 0);

  signal tcp_tx_clk   : std_logic_vector(kNumGtx-1 downto 0);
  signal tcp_rx_wr    : std_logic_vector(kNumGtx-1 downto 0);
  signal tcp_rx_data  : typeTcpData;
  signal tcp_tx_full  : std_logic_vector(kNumGtx-1 downto 0);
  signal tcp_tx_wr    : std_logic_vector(kNumGtx-1 downto 0);
  signal tcp_tx_data  : typeTcpData;

  signal rbcp_addr    : typeUdpAddr;
  signal rbcp_wd      : typeUdpData;
  signal rbcp_we      : std_logic_vector(kNumGtx-1 downto 0); --: Write enable
  signal rbcp_re      : std_logic_vector(kNumGtx-1 downto 0); --: Read enable
  signal rbcp_ack     : std_logic_vector(kNumGtx-1 downto 0); -- : Access acknowledge
  signal rbcp_rd      : typeUdpData;

  signal rbcp_gmii_addr    : typeUdpAddr;
  signal rbcp_gmii_wd      : typeUdpData;
  signal rbcp_gmii_we      : std_logic_vector(kNumGtx-1 downto 0); --: Write enable
  signal rbcp_gmii_re      : std_logic_vector(kNumGtx-1 downto 0); --: Read enable
  signal rbcp_gmii_ack     : std_logic_vector(kNumGtx-1 downto 0); -- : Access acknowledge
  signal rbcp_gmii_rd      : typeUdpData;

  component WRAP_SiTCP_GMII_XC7K_32K
    port
      (
        CLK                   : in std_logic; --: System Clock >129MHz
        RST                   : in std_logic; --: System reset
        -- Configuration parameters
        FORCE_DEFAULTn        : in std_logic; --: Load default parameters
        EXT_IP_ADDR           : in std_logic_vector(31 downto 0); --: IP address[31:0]
        EXT_TCP_PORT          : in std_logic_vector(15 downto 0); --: TCP port #[15:0]
        EXT_RBCP_PORT         : in std_logic_vector(15 downto 0); --: RBCP port #[15:0]
        PHY_ADDR              : in std_logic_vector(4 downto 0);  --: PHY-device MIF address[4:0]

        -- EEPROM
        EEPROM_CS             : out std_logic; --: Chip select
        EEPROM_SK             : out std_logic; --: Serial data clock
        EEPROM_DI             : out    std_logic; --: Serial write data
        EEPROM_DO             : in std_logic; --: Serial read data
        --    user data, intialial values are stored in the EEPROM, 0xFFFF_FC3C-3F
        USR_REG_X3C           : out    std_logic_vector(7 downto 0); --: Stored at 0xFFFF_FF3C
        USR_REG_X3D           : out    std_logic_vector(7 downto 0); --: Stored at 0xFFFF_FF3D
        USR_REG_X3E           : out    std_logic_vector(7 downto 0); --: Stored at 0xFFFF_FF3E
        USR_REG_X3F           : out    std_logic_vector(7 downto 0); --: Stored at 0xFFFF_FF3F
        -- MII interface
        GMII_RSTn             : out    std_logic; --: PHY reset
        GMII_1000M            : in std_logic;  --: GMII mode (0:MII, 1:GMII)
        -- TX
        GMII_TX_CLK           : in std_logic; -- : Tx clock
        GMII_TX_EN            : out    std_logic; --: Tx enable
        GMII_TXD              : out    std_logic_vector(7 downto 0); --: Tx data[7:0]
        GMII_TX_ER            : out    std_logic; --: TX error
        -- RX
        GMII_RX_CLK           : in std_logic; -- : Rx clock
        GMII_RX_DV            : in std_logic; -- : Rx data valid
        GMII_RXD              : in std_logic_vector(7 downto 0); -- : Rx data[7:0]
        GMII_RX_ER            : in std_logic; --: Rx error
        GMII_CRS              : in std_logic; --: Carrier sense
        GMII_COL              : in std_logic; --: Collision detected
        -- Management IF
        GMII_MDC              : out std_logic; --: Clock for MDIO
        GMII_MDIO_IN          : in std_logic; -- : Data
        GMII_MDIO_OUT         : out    std_logic; --: Data
        GMII_MDIO_OE          : out    std_logic; --: MDIO output enable
        -- User I/F
        SiTCP_RST             : out    std_logic; --: Reset for SiTCP and related circuits
        -- TCP connection control
        TCP_OPEN_REQ          : in std_logic; -- : Reserved input, shoud be 0
        TCP_OPEN_ACK          : out    std_logic; --: Acknowledge for open (=Socket busy)
        TCP_ERROR             : out    std_logic; --: TCP error, its active period is equal to MSL
        TCP_CLOSE_REQ         : out    std_logic; --: Connection close request
        TCP_CLOSE_ACK         : in std_logic ;-- : Acknowledge for closing
        -- FIFO I/F
        TCP_RX_WC             : in std_logic_vector(15 downto 0); --: Rx FIFO write count[15:0] (Unused bits should be set 1)
        TCP_RX_WR             : out    std_logic; --: Write enable
        TCP_RX_DATA           : out    std_logic_vector(7 downto 0); --: Write data[7:0]
        TCP_TX_FULL           : out    std_logic; --: Almost full flag
        TCP_TX_WR             : in std_logic; -- : Write enable
        TCP_TX_DATA           : in std_logic_vector(7 downto 0); -- : Write data[7:0]
        -- RBCP
        RBCP_ACT              : out std_logic; -- RBCP active
        RBCP_ADDR             : out    std_logic_vector(31 downto 0); --: Address[31:0]
        RBCP_WD               : out    std_logic_vector(7 downto 0); --: Data[7:0]
        RBCP_WE               : out    std_logic; --: Write enable
        RBCP_RE               : out    std_logic; --: Read enable
        RBCP_ACK              : in std_logic; -- : Access acknowledge
        RBCP_RD               : in std_logic_vector(7 downto 0 ) -- : Read data[7:0]
        );
  end component;

  -- SFP transceiver -----------------------------------------------------------------------
  constant kMiiPhyad      : std_logic_vector(kWidthPhyAddr-1 downto 0):= "00000";
  signal mii_init_mdc, mii_init_mdio : std_logic;

  component mii_initializer is
    port(
      -- System
      CLK         : in std_logic;
      --RST         => system_reset,
      RST         : in std_logic;
      -- PHY
      PHYAD       : in std_logic_vector(kWidthPhyAddr-1 downto 0);
      -- MII
      MDC         : out std_logic;
      MDIO_OUT    : out std_logic;
      -- status
      COMPLETE    : out std_logic
      );
  end component;

  signal mmcm_reset_all   : std_logic;
  signal mmcm_reset       : std_logic_vector(kNumGtx-1 downto 0);
  signal mmcm_locked      : std_logic;

  signal gt0_qplloutclk, gt0_qplloutrefclk  : std_logic;
  signal gtrefclk_i, gtrefclk_bufg  : std_logic;
  signal txout_clk, rxout_clk       : std_logic_vector(kNumGtx-1 downto 0);
  signal user_clk, user_clk2, rxuser_clk, rxuser_clk2   : std_logic;

  signal eth_tx_clk       : std_logic_vector(kNumGtx-1 downto 0);
  signal eth_tx_en        : std_logic_vector(kNumGtx-1 downto 0);
  signal eth_tx_er        : std_logic_vector(kNumGtx-1 downto 0);
  signal eth_tx_d         : typeTcpData;

  signal eth_rx_clk       : std_logic_vector(kNumGtx-1 downto 0);
  signal eth_rx_dv        : std_logic_vector(kNumGtx-1 downto 0);
  signal eth_rx_er        : std_logic_vector(kNumGtx-1 downto 0);
  signal eth_rx_d         : typeTcpData;


  -- Clock ---------------------------------------------------------------------------
  signal clk_gbe, clk_sys   : std_logic;
  signal clk_locked         : std_logic;
  signal clk_sys_locked     : std_logic;
  signal clk_miku_locked    : std_logic;
  signal clk_spi            : std_logic;


  component clk_wiz_sys
    port
      (-- Clock in ports
        -- Clock out ports
        clk_sys          : out    std_logic;
        clk_indep_gtx    : out    std_logic;
        clk_spi          : out    std_logic;
--        clk_buf          : out    std_logic;
        -- Status and control signals
        reset            : in     std_logic;
        locked           : out    std_logic;
        clk_in1_p        : in     std_logic;
        clk_in1_n        : in     std_logic
        );
  end component;

  component mmcm_cdcm
    port
     (-- Clock in ports
      -- Clock out ports
      mmcm_fast          : out    std_logic;
      mmcm_slow          : out    std_logic;
      -- Status and control signals
      reset             : in     std_logic;
      locked            : out    std_logic;
      clk_in1           : in     std_logic
     );
  end component;

  signal clk_fast, clk_slow   : std_logic;
  signal mmcm_cdcm_locked     : std_logic;
  signal mmcm_cdcm_reset      : std_logic;
  --signal pll_is_locked        : std_logic;


 begin
  -- ===================================================================================
  -- body
  -- ===================================================================================

  -- Global ----------------------------------------------------------------------------
  u_DelayUsrRstb : entity mylib.DelayGen
    generic map(kNumDelay => 128)
    port map(clk_sys, USR_RSTB, delayed_usr_rstb);


  clk_miku_locked <= mmcm_cdcm_locked;
  clk_locked      <= clk_sys_locked and clk_miku_locked;

  --c6c_reset       <= (not clk_sys_locked) or (not delayed_usr_rstb);
  c6c_reset       <= '1';
  mmcm_cdcm_reset <= (not delayed_usr_rstb);

  system_reset    <= (not clk_miku_locked) or (not USR_RSTB);
  pwr_on_reset    <= (not clk_sys_locked) or (not USR_RSTB);
  laccp_reset     <= system_reset or (not mikumari_link_up);

  user_reset      <= system_reset or rst_from_bus or emergency_reset(0);
  bct_reset       <= system_reset or emergency_reset(0);

  NIM_OUT(1)  <= c6c_slow when(DIP(kClkOut.Index) = '1') else heartbeat_signal;
  NIM_OUT(2)  <= mod_clk  when(DIP(kClkOut.Index) = '1') else is_ready_for_daq;

  dip_sw(1)   <= DIP(1);
  dip_sw(2)   <= DIP(2);
  dip_sw(3)   <= DIP(3);
  dip_sw(4)   <= DIP(4);

  LED         <= mikumari_link_up & is_ready_for_daq & tcp_isActive(0) & clk_sys_locked;

  -- MIKUMARI --------------------------------------------------------------------------
  u_KeepInit : process(system_reset, clk_slow)
    variable counter   : integer:= 0;
  begin
    if(system_reset = '1') then
      power_on_init   <= '1';
      counter         := 16#0FFFFFFF#;
    elsif(clk_slow'event and clk_slow = '1') then
      if(counter = 0) then
        power_on_init   <= '0';
      else
        counter   := counter -1;
      end if;
    end if;
  end process;


  u_Miku_Inst : entity mylib.MikumariBlock
    generic map(
      -- CBT generic -------------------------------------------------------------
      -- CDCM-Mod-Pattern --
      kCdcmModWidth    => 8,
      -- CDCM-TX --
      kIoStandardTx    => GetMikuIoStd(kPcbVersion),
      kTxPolarity      => FALSE,
      -- CDCM-RX --
      genIDELAYCTRL    => TRUE,
      kDiffTerm        => TRUE,
      kIoStandardRx    => GetMikuIoStd(kPcbVersion),
      kRxPolarity      => FALSE,
      kIoDelayGroup    => "idelay_1",
      kFixIdelayTap    => FALSE,
      kFreqFastClk     => 500.0,
      kFreqRefClk      => 200.0,
      -- Encoder/Decoder
      kNumEncodeBits   => 1,
      -- Master/Slave
      kCbtMode         => "Master",
      -- DEBUG --
      enDebugCBT       => FALSE,

      -- MIKUMARI generic --------------------------------------------------------
      -- Scrambler --
      enScrambler      => TRUE,
      -- DEBUG --
      enDebugMikumari  => FALSE
    )
    port map(
      -- System ports -----------------------------------------------------------
      rst           => system_reset,
      pwrOnRst      => pwr_on_reset,
      clkSer        => clk_fast,
      clkPar        => clk_slow,
      clkIndep      => clk_gbe,
      clkIdctrl     => clk_gbe,
      initIn        => power_on_init,

      TXP           => MIKUMARI_TXP,
      TXN           => MIKUMARI_TXN,
      RXP           => MIKUMARI_RXP,
      RXN           => MIKUMARI_RXN,
      modClk        => mod_clk,
      tapValueIn    => "00000",
      tapValueOut   => open,

      -- CBT ports ------------------------------------------------------------
      laneUp        => cbt_lane_up,
      idelayErr     => open,
      bitslipErr    => open,
      pattErr       => pattern_error,
      watchDogErr   => watchdog_error,

      -- Mikumari ports -------------------------------------------------------
      linkUp        => mikumari_link_up,

      -- TX port --
      -- Data I/F --
      dataInTx      => miku_data_tx,
      validInTx     => miku_valid_tx,
      frameLastInTx => miku_last_tx,
      txAck         => miku_tx_ack,

      pulseIn       => pulse_tx,
      pulseTypeTx   => pulse_type_tx,
      busyPulseTx   => busy_pulse_tx,

      -- RX port --
      -- Data I/F --
      dataOutRx   => miku_data_rx,
      validOutRx  => miku_valid_rx,
      frameLastRx => miku_last_rx,
      checksumErr => checksum_err,
      frameBroken => frame_broken,
      recvTermnd  => recv_terminated,

      pulseOut    => pulse_rx,
      pulseTypeRx => pulse_type_rx

    );

  --
  u_LACCP : entity mylib.LaccpMainBlock
    generic map
      (
        kPrimaryMode      => true,
        kNumInterconnect  => 1,
        enDebug           => true
      )
    port map
      (
        -- System --------------------------------------------------------
        rst               => laccp_reset,
        clk               => clk_slow,

        -- User Interface ------------------------------------------------
        isReadyForDaq     => is_ready_for_daq,
        laccpPulsesIn     => (others => '0'),
        laccpPulsesOut    => open,
        pulseInRejected   => open,

        -- RLIGP --
        addrMyLink        => X"C0A80001",
        validMyLink       => '1',
        addrPartnerLink   => link_addr_partter,
        validPartnerLink  => valid_link_addr,

        -- RCAP --
        hbuIsSyncedIn     => '0',
        syncPulseIn       => heartbeat_signal,
        syncPulseOut      => open,

        validOffset       => valid_hbc_offset,
        hbcOffset         => hbc_offset,

        -- LACCP Bus Port ------------------------------------------------
        -- Intra-port--
        isReadyIntraIn    => is_ready_laccp_intra,
        dataIntraIn       => data_laccp_intra_in,
        validIntraIn      => valid_laccp_intra_in,
        dataIntraOut      => data_laccp_intra_out,
        validIntraOut     => valid_laccp_intra_out,

        -- Interconnect --
        isReadyInterIn    => (others => '0'),
        existInterOut     => open,
        dataInterIn       => (others => (others => '0')),
        validInterIn      => (others => '0'),
        dataInterOut      => open,
        validInterOut     => open,

        -- MIKUMARI-Link -------------------------------------------------
        mikuLinkUpIn      => mikumari_link_up,

        -- TX port --
        dataTx            => miku_data_tx,
        validTx           => miku_valid_tx,
        frameLastTx       => miku_last_tx,
        txAck             => miku_tx_ack,

        pulseTx           => pulse_tx,
        pulseTypeTx       => pulse_type_tx,
        busyPulseTx       => busy_pulse_tx,

        -- RX port --
        dataRx            => miku_data_rx,
        validRx           => miku_valid_rx,
        frameLastRx       => miku_last_rx,
        checkSumErrRx     => checksum_err,
        frameBrokenRx     => frame_broken,
        recvTermndRx      => recv_terminated,

        pulseRx           => pulse_rx,
        pulseTypeRx       => pulse_type_rx

      );

  u_sync_nim1 : entity mylib.synchronizer port map(clk_slow, NIM_IN(1), frame_ctrl_gate);

  u_HBU : entity mylib.PrimaryHeartBeatUnit
    generic map
      (
        enDebug           => true
      )
    port map
      (
        -- System --
        rst               => laccp_reset,
        primaryRst        => '0',
        clk               => clk_slow,

        -- Sync I/F --

        -- HeartBeat I/F --
        heartbeatOut      => heartbeat_signal,
        heartbeatCount    => heartbeat_count,
        hbfNumber         => hbf_number,

        -- DAQ I/F --
        hbfCtrlGateIn     => frame_ctrl_gate,
        forceOn           => '0',
        frameState        => hbf_state,

        -- LACCP Bus --
        dataBusIn         => data_laccp_intra_out(GetExtIntraIndex(kPortHBU)),
        validBusIn        => valid_laccp_intra_out(GetExtIntraIndex(kPortHBU)),
        dataBusOut        => data_laccp_intra_in(GetExtIntraIndex(kPortHBU)),
        validBusOut       => valid_laccp_intra_in(GetExtIntraIndex(kPortHBU)),
        isReadyOut        => is_ready_laccp_intra(GetExtIntraIndex(kPortHBU))

      );



  -- C6C -------------------------------------------------------------------------------
  u_C6C_Inst : entity mylib.CDCE62002Controller
    generic map(
      kSysClkFreq         => 125_000_000
      )
    port map(
      rst                 => system_reset,
      clk                 => clk_slow,
      refClkIn            => clk_sys,

      chipReset           => c6c_reset,
      clkIndep            => clk_sys,
      chipLock            => CDCE_LOCK,

      -- Module output --
      PDB                 => CDCE_PDB,
      REF_CLKP            => CDCE_REFP,
      REF_CLKN            => CDCE_REFN,
      CSB_SPI             => CDCE_LE,
      SCLK_SPI            => CDCE_SCLK,
      MOSI_SPI            => CDCE_SI,
      MISO_SPI            => CDCE_SO,

      -- Local bus --
      addrLocalBus        => addr_LocalBus,
      dataLocalBusIn      => data_LocalBusIn,
      dataLocalBusOut     => data_LocalBusOut(kC6C.ID),
      reLocalBus          => re_LocalBus(kC6C.ID),
      weLocalBus          => we_LocalBus(kC6C.ID),
      readyLocalBus       => ready_LocalBus(kC6C.ID)
    );

  -- MIG -------------------------------------------------------------------------------

  -- TSD -------------------------------------------------------------------------------
  gen_tsd: for i in 0 to kNumGtx-1 generate
    u_TSD_Inst : entity mylib.TCP_sender
      port map(
        RST                     => pwr_on_reset,
        CLK                     => clk_sys,

        -- data from EVB --
        rdFromEVB               => X"00",
        rvFromEVB               => '0',
        emptyFromEVB            => '1',
        reToEVB                 => open,

         -- data to SiTCP
         isActive                => tcp_isActive(i),
         afullTx                 => tcp_tx_full(i),
         weTx                    => tcp_tx_wr(i),
         wdTx                    => tcp_tx_data(i)

        );
  end generate;

  -- SDS --------------------------------------------------------------------
  u_SDS_Inst : entity mylib.SelfDiagnosisSystem
    port map(
      rst               => user_reset,
      clk               => clk_slow,
      clkIcap           => clk_spi,

      -- Module input  --
      VP                => VP,
      VN                => VN,

      -- Module output --
      shutdownOverTemp  => shutdown_over_temp,
      uncorrectableAlarm => uncorrectable_flag,

      -- Local bus --
      addrLocalBus      => addr_LocalBus,
      dataLocalBusIn    => data_LocalBusIn,
      dataLocalBusOut   => data_LocalBusOut(kSDS.ID),
      reLocalBus        => re_LocalBus(kSDS.ID),
      weLocalBus        => we_LocalBus(kSDS.ID),
      readyLocalBus     => ready_LocalBus(kSDS.ID)
      );


  -- FMP --------------------------------------------------------------------
  u_FMP_Inst : entity mylib.FlashMemoryProgrammer
    port map(
      rst               => user_reset,
      clk               => clk_slow,
      clkSpi            => clk_spi,

      -- Module output --
      CS_SPI            => FCSB,
--      SCLK_SPI          => USR_CLK,
      MOSI_SPI          => MOSI,
      MISO_SPI          => DIN,

      -- Local bus --
      addrLocalBus      => addr_LocalBus,
      dataLocalBusIn    => data_LocalBusIn,
      dataLocalBusOut   => data_LocalBusOut(kFMP.ID),
      reLocalBus        => re_LocalBus(kFMP.ID),
      weLocalBus        => we_LocalBus(kFMP.ID),
      readyLocalBus     => ready_LocalBus(kFMP.ID)
      );


  -- BCT -------------------------------------------------------------------------------
  -- Actual local bus
  u_BCT_Inst : entity mylib.BusController
    port map(
      rstSys                    => bct_reset,
      rstFromBus                => rst_from_bus,
      reConfig                  => PROGB_ON,
      clk                       => clk_slow,
      -- Local Bus --
      addrLocalBus              => addr_LocalBus,
      dataFromUserModules       => data_LocalBusOut,
      dataToUserModules         => data_LocalBusIn,
      reLocalBus                => re_LocalBus,
      weLocalBus                => we_LocalBus,
      readyLocalBus             => ready_LocalBus,
      -- RBCP --
      addrRBCP                  => rbcp_addr(0),
      wdRBCP                    => rbcp_wd(0),
      weRBCP                    => rbcp_we(0),
      reRBCP                    => rbcp_re(0),
      ackRBCP                   => rbcp_ack(0),
      rdRBCP                    => rbcp_rd(0)
      );

  -- SiTCP Inst ------------------------------------------------------------------------
  sitcp_reset     <= pwr_on_reset;

  gen_SiTCP : for i in 0 to kNumGtx-1 generate

    eth_tx_clk(i)      <= eth_rx_clk(0);

    u_SiTCP_Inst : WRAP_SiTCP_GMII_XC7K_32K
      port map
      (
        CLK               => clk_sys, --: System Clock >129MHz
        RST               => sitcp_reset, --: System reset
        -- Configuration parameters
        FORCE_DEFAULTn    => dip_sw(kSiTCP.Index), --: Load default parameters
        EXT_IP_ADDR       => X"00000000", --: IP address[31:0]
        EXT_TCP_PORT      => X"0000", --: TCP port #[15:0]
        EXT_RBCP_PORT     => X"0000", --: RBCP port #[15:0]
        PHY_ADDR          => "00000", --: PHY-device MIF address[4:0]
        -- EEPROM
        EEPROM_CS         => EEP_CS(i+1), --: Chip select
        EEPROM_SK         => EEP_SK(i+1), --: Serial data clock
        EEPROM_DI         => EEP_DI(i+1), --: Serial write data
        EEPROM_DO         => EEP_DO(i+1), --: Serial read data
        --    user data, intialial values are stored in the EEPROM, 0xFFFF_FC3C-3F
        USR_REG_X3C       => open, --: Stored at 0xFFFF_FF3C
        USR_REG_X3D       => open, --: Stored at 0xFFFF_FF3D
        USR_REG_X3E       => open, --: Stored at 0xFFFF_FF3E
        USR_REG_X3F       => open, --: Stored at 0xFFFF_FF3F
        -- MII interface
        GMII_RSTn         => open, --: PHY reset
        GMII_1000M        => '1',  --: GMII mode (0:MII, 1:GMII)
        -- TX
        GMII_TX_CLK       => eth_tx_clk(i), --: Tx clock
        GMII_TX_EN        => eth_tx_en(i),  --: Tx enable
        GMII_TXD          => eth_tx_d(i),   --: Tx data[7:0]
        GMII_TX_ER        => eth_tx_er(i),  --: TX error
        -- RX
        GMII_RX_CLK       => eth_rx_clk(0), --: Rx clock
        GMII_RX_DV        => eth_rx_dv(i),  --: Rx data valid
        GMII_RXD          => eth_rx_d(i),   --: Rx data[7:0]
        GMII_RX_ER        => eth_rx_er(i),  --: Rx error
        GMII_CRS          => '0', --: Carrier sense
        GMII_COL          => '0', --: Collision detected
        -- Management IF
        GMII_MDC          => open, --: Clock for MDIO
        GMII_MDIO_IN      => '1', -- : Data
        GMII_MDIO_OUT     => open, --: Data
        GMII_MDIO_OE      => open, --: MDIO output enable
        -- User I/F
        SiTCP_RST         => emergency_reset(i), --: Reset for SiTCP and related circuits
        -- TCP connection control
        TCP_OPEN_REQ      => '0', -- : Reserved input, shoud be 0
        TCP_OPEN_ACK      => tcp_isActive(i), --: Acknowledge for open (=Socket busy)
        --    TCP_ERROR           : out    std_logic; --: TCP error, its active period is equal to MSL
        TCP_CLOSE_REQ     => close_req(i), --: Connection close request
        TCP_CLOSE_ACK     => close_act(i), -- : Acknowledge for closing
        -- FIFO I/F
        TCP_RX_WC         => X"0000",    --: Rx FIFO write count[15:0] (Unused bits should be set 1)
        TCP_RX_WR         => open, --: Read enable
        TCP_RX_DATA       => open, --: Read data[7:0]
        TCP_TX_FULL       => tcp_tx_full(i), --: Almost full flag
        TCP_TX_WR         => tcp_tx_wr(i),   -- : Write enable
        TCP_TX_DATA       => tcp_tx_data(i), -- : Write data[7:0]
        -- RBCP
        RBCP_ACT          => open, --: RBCP active
        RBCP_ADDR         => rbcp_gmii_addr(i), --: Address[31:0]
        RBCP_WD           => rbcp_gmii_wd(i),   --: Data[7:0]
        RBCP_WE           => rbcp_gmii_we(i),   --: Write enable
        RBCP_RE           => rbcp_gmii_re(i),   --: Read enable
        RBCP_ACK          => rbcp_gmii_ack(i),  --: Access acknowledge
        RBCP_RD           => rbcp_gmii_rd(i)    --: Read data[7:0]
        );

  u_RbcpCdc : entity mylib.RbcpCdc
  port map(
    -- Mikumari clock domain --
    rstSys      => system_reset,
    clkSys      => clk_slow,
    rbcpAddr    => rbcp_addr(i),
    rbcpWd      => rbcp_wd(i),
    rbcpWe      => rbcp_we(i),
    rbcpRe      => rbcp_re(i),
    rbcpAck     => rbcp_ack(i),
    rbcpRd      => rbcp_rd(i),

    -- GMII clock domain --
    rstXgmii    => pwr_on_reset,
    clkXgmii    => clk_sys,
    rbcpXgAddr  => rbcp_gmii_addr(i),
    rbcpXgWd    => rbcp_gmii_wd(i),
    rbcpXgWe    => rbcp_gmii_we(i),
    rbcpXgRe    => rbcp_gmii_re(i),
    rbcpXgAck   => rbcp_gmii_ack(i),
    rbcpXgRd    => rbcp_gmii_rd(i)
    );

    u_gTCP_inst : entity mylib.global_sitcp_manager
      port map(
        RST           => pwr_on_reset,
        CLK           => clk_sys,
        ACTIVE        => tcp_isActive(i),
        REQ           => close_req(i),
        ACT           => close_act(i),
        rstFromTCP    => open
        );
  end generate;

  -- SFP transceiver -------------------------------------------------------------------
  u_MiiRstTimer_Inst : entity mylib.MiiRstTimer
    port map(
      rst         => pwr_on_reset,
      clk         => clk_sys,
      rstMiiOut   => mii_reset
    );

  u_MiiInit_Inst : mii_initializer
    port map(
      -- System
      CLK         => clk_sys,
      --RST         => system_reset,
      RST         => mii_reset,
      -- PHY
      PHYAD       => kMiiPhyad,
      -- MII
      MDC         => mii_init_mdc,
      MDIO_OUT    => mii_init_mdio,
      -- status
      COMPLETE    => open
      );

  mmcm_reset_all  <= or_reduce(mmcm_reset);

  u_GtClockDist_Inst : entity mylib.GtClockDistributer2
    port map(
      -- GTX refclk --
      GT_REFCLK_P   => GTX_REFCLK_P,
      GT_REFCLK_N   => GTX_REFCLK_N,

      gtRefClk      => gtrefclk_i,
      gtRefClkBufg  => gtrefclk_bufg,

      -- USERCLK2 --
      mmcmReset     => mmcm_reset_all,
      mmcmLocked    => mmcm_locked,
      txOutClk      => txout_clk(0),
      rxOutClk      => rxout_clk(0),

      userClk       => user_clk,
      userClk2      => user_clk2,
      rxuserClk     => rxuser_clk,
      rxuserClk2    => rxuser_clk2,

      -- GTXE_COMMON --
      reset         => pwr_on_reset,
      clkIndep      => clk_gbe,
      clkQPLL       => gt0_qplloutclk,
      refclkQPLL    => gt0_qplloutrefclk
      );

  gen_pcspma : for i in 0 to kNumGtx-1 generate
    u_pcspma_Inst : entity mylib.GbEPcsPma
      port map(

        --An independent clock source used as the reference clock for an
        --IDELAYCTRL (if present) and for the main GT transceiver reset logic.
        --This example design assumes that this is of frequency 200MHz.
        independent_clock    => clk_gbe,

        -- Tranceiver Interface
        -----------------------
        gtrefclk             => gtrefclk_i,
        gtrefclk_bufg        => gtrefclk_bufg,

        gt0_qplloutclk       => gt0_qplloutclk,
        gt0_qplloutrefclk    => gt0_qplloutrefclk,

        userclk              => user_clk,
        userclk2             => user_clk2,
        rxuserclk            => rxuser_clk,
        rxuserclk2           => rxuser_clk2,

        mmcm_locked          => mmcm_locked,
        mmcm_reset           => mmcm_reset(i),

        -- clockout --
        txoutclk             => txout_clk(i),
        rxoutclk             => rxout_clk(i),

        -- Tranceiver Interface
        -----------------------
        txp                  => GTX_TX_P(i+1),
        txn                  => GTX_TX_N(i+1),
        rxp                  => GTX_RX_P(i+1),
        rxn                  => GTX_RX_N(i+1),

        -- GMII Interface (client MAC <=> PCS)
        --------------------------------------
        gmii_tx_clk          => eth_tx_clk(i),
        gmii_rx_clk          => eth_rx_clk(i),
        gmii_txd             => eth_tx_d(i),
        gmii_tx_en           => eth_tx_en(i),
        gmii_tx_er           => eth_tx_er(i),
        gmii_rxd             => eth_rx_d(i),
        gmii_rx_dv           => eth_rx_dv(i),
        gmii_rx_er           => eth_rx_er(i),
        -- Management: MDIO Interface
        -----------------------------

        mdc                  => mii_init_mdc,
        mdio_i               => mii_init_mdio,
        mdio_o               => open,
        mdio_t               => open,
        phyaddr              => "00000",
        configuration_vector => "00000",
        configuration_valid  => '0',

        -- General IO's
        ---------------
        status_vector        => open,
        reset                => pwr_on_reset
        );
  end generate;

  -- Clock inst ------------------------------------------------------------------------
  --clk_slow  <= clk_sys;
  u_ClkMan_Inst   : clk_wiz_sys
    port map (
      -- Clock out ports
      clk_sys         => clk_sys,
      clk_indep_gtx   => clk_gbe,
      clk_spi         => clk_spi,
      -- Status and control signals
      reset           => '0',
      locked          => clk_sys_locked,
      -- Clock in ports
      clk_in1_p       => BASE_CLKP,
      clk_in1_n       => BASE_CLKN
      );

  u_MMCM_CDCM : mmcm_cdcm
    port map (
      -- Clock out ports
      mmcm_fast => clk_fast,
      mmcm_slow => clk_slow,
      -- Status and control signals
      reset     => mmcm_cdcm_reset,
      locked    => mmcm_cdcm_locked,
      -- Clock in ports
      clk_in1   => clk_sys
    );

  -- CDCE clocks --
--  pll_is_locked   <= mmcm_cdcm_locked and CDCE_LOCK;

--  u_BUFG_Slow : BUFG
--    port map (
--      O => clk_slow, -- 1-bit output: Clock output
--      I => c6c_slow  -- 1-bit input: Clock input
--    );
--
--  u_BUFG_Fast : BUFG
--    port map (
--      O => clk_fast, -- 1-bit output: Clock output
--      I => c6c_fast  -- 1-bit input: Clock input
--    );

  u_IBUFDS_SLOW_inst : IBUFDS
    generic map (
       DIFF_TERM => FALSE, -- Differential Termination
       IBUF_LOW_PWR => FALSE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
       IOSTANDARD => "LVDS")
    port map (
       O => c6c_slow,  -- Buffer output
       I => CLK_SLOWP,  -- Diff_p buffer input (connect directly to top-level port)
       IB => CLK_SLOWN -- Diff_n buffer input (connect directly to top-level port)
       );

  u_IBUFDS_FAST_inst : IBUFDS
    generic map (
       DIFF_TERM => FALSE, -- Differential Termination
       IBUF_LOW_PWR => FALSE, -- Low power (TRUE) vs. performance (FALSE) setting for referenced I/O standards
       IOSTANDARD => "LVDS")
    port map (
       O => c6c_fast,  -- Buffer output
       I => CLK_FASTP,  -- Diff_p buffer input (connect directly to top-level port)
       IB => CLK_FASTN -- Diff_n buffer input (connect directly to top-level port)
       );

end Behavioral;
