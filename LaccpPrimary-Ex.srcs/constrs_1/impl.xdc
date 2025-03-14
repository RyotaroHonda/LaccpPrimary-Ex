set_operating_conditions -ambient_temp 40.0
set_operating_conditions -airflow 0
set_operating_conditions -heatsink none

set_property CONFIG_MODE SPIx4 [current_design]
set_property CONFIG_VOLTAGE 2.5 [current_design]
set_property CFGBVS VCCO [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]


create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 1024 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list clk_slow]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 2 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {u_LACCP/u_tx/state_tx[0]} {u_LACCP/u_tx/state_tx[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 8 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[1][0]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[1][1]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[1][2]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[1][3]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[1][4]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[1][5]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[1][6]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[1][7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 8 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[0][0]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[0][1]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[0][2]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[0][3]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[0][4]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[0][5]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[0][6]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[0][7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 8 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[2][0]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[2][1]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[2][2]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[2][3]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[2][4]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[2][5]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[2][6]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[2][7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 8 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[4][0]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[4][1]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[4][2]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[4][3]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[4][4]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[4][5]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[4][6]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[4][7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 8 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[3][0]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[3][1]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[3][2]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[3][3]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[3][4]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[3][5]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[3][6]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[3][7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 8 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[6][0]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[6][1]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[6][2]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[6][3]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[6][4]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[6][5]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[6][6]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[6][7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 8 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[7][0]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[7][1]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[7][2]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[7][3]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[7][4]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[7][5]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[7][6]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[7][7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 8 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[5][0]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[5][1]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[5][2]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[5][3]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[5][4]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[5][5]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[5][6]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_offset[5][7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 8 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/rx_output[0]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/rx_output[1]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/rx_output[2]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/rx_output[3]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/rx_output[4]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/rx_output[5]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/rx_output[6]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/rx_output[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 8 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[7][0]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[7][1]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[7][2]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[7][3]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[7][4]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[7][5]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[7][6]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[7][7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 8 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[2][0]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[2][1]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[2][2]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[2][3]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[2][4]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[2][5]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[2][6]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[2][7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 8 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[0][0]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[0][1]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[0][2]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[0][3]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[0][4]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[0][5]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[0][6]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[0][7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 3 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/state_scan[0]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/state_scan[1]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/state_scan[2]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 8 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[1][0]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[1][1]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[1][2]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[1][3]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[1][4]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[1][5]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[1][6]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[1][7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 8 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[3][0]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[3][1]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[3][2]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[3][3]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[3][4]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[3][5]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[3][6]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[3][7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 8 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[5][0]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[5][1]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[5][2]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[5][3]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[5][4]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[5][5]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[5][6]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[5][7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 8 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[4][0]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[4][1]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[4][2]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[4][3]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[4][4]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[4][5]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[4][6]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[4][7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 8 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[6][0]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[6][1]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[6][2]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[6][3]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[6][4]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[6][5]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[6][6]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/reg_tdc[6][7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 8 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/waveform_in[0]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/waveform_in[1]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/waveform_in[2]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/waveform_in[3]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/waveform_in[4]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/waveform_in[5]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/waveform_in[6]} {u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/waveform_in[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 2 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list {u_LACCP/u_rx/state_rx[0]} {u_LACCP/u_rx/state_rx[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
set_property port_width 5 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list {idelay_tap_out[0]} {idelay_tap_out[1]} {idelay_tap_out[2]} {idelay_tap_out[3]} {idelay_tap_out[4]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe22]
set_property port_width 4 [get_debug_ports u_ila_0/probe22]
connect_debug_port u_ila_0/probe22 [get_nets [list {bitslip_number[0]} {bitslip_number[1]} {bitslip_number[2]} {bitslip_number[3]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe23]
set_property port_width 32 [get_debug_ports u_ila_0/probe23]
connect_debug_port u_ila_0/probe23 [get_nets [list {link_addr_partter[0]} {link_addr_partter[1]} {link_addr_partter[2]} {link_addr_partter[3]} {link_addr_partter[4]} {link_addr_partter[5]} {link_addr_partter[6]} {link_addr_partter[7]} {link_addr_partter[8]} {link_addr_partter[9]} {link_addr_partter[10]} {link_addr_partter[11]} {link_addr_partter[12]} {link_addr_partter[13]} {link_addr_partter[14]} {link_addr_partter[15]} {link_addr_partter[16]} {link_addr_partter[17]} {link_addr_partter[18]} {link_addr_partter[19]} {link_addr_partter[20]} {link_addr_partter[21]} {link_addr_partter[22]} {link_addr_partter[23]} {link_addr_partter[24]} {link_addr_partter[25]} {link_addr_partter[26]} {link_addr_partter[27]} {link_addr_partter[28]} {link_addr_partter[29]} {link_addr_partter[30]} {link_addr_partter[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe24]
set_property port_width 10 [get_debug_ports u_ila_0/probe24]
connect_debug_port u_ila_0/probe24 [get_nets [list {first_bit_pattern[0]} {first_bit_pattern[1]} {first_bit_pattern[2]} {first_bit_pattern[3]} {first_bit_pattern[4]} {first_bit_pattern[5]} {first_bit_pattern[6]} {first_bit_pattern[7]} {first_bit_pattern[8]} {first_bit_pattern[9]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe25]
set_property port_width 4 [get_debug_ports u_ila_0/probe25]
connect_debug_port u_ila_0/probe25 [get_nets [list {partner_serdes_offset[0]} {partner_serdes_offset[1]} {partner_serdes_offset[2]} {partner_serdes_offset[3]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe26]
set_property port_width 5 [get_debug_ports u_ila_0/probe26]
connect_debug_port u_ila_0/probe26 [get_nets [list {tap_value_out[0]} {tap_value_out[1]} {tap_value_out[2]} {tap_value_out[3]} {tap_value_out[4]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe27]
set_property port_width 16 [get_debug_ports u_ila_0/probe27]
connect_debug_port u_ila_0/probe27 [get_nets [list {u_HBU/hb_counter[0]} {u_HBU/hb_counter[1]} {u_HBU/hb_counter[2]} {u_HBU/hb_counter[3]} {u_HBU/hb_counter[4]} {u_HBU/hb_counter[5]} {u_HBU/hb_counter[6]} {u_HBU/hb_counter[7]} {u_HBU/hb_counter[8]} {u_HBU/hb_counter[9]} {u_HBU/hb_counter[10]} {u_HBU/hb_counter[11]} {u_HBU/hb_counter[12]} {u_HBU/hb_counter[13]} {u_HBU/hb_counter[14]} {u_HBU/hb_counter[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe28]
set_property port_width 24 [get_debug_ports u_ila_0/probe28]
connect_debug_port u_ila_0/probe28 [get_nets [list {u_HBU/local_hbf_number[0]} {u_HBU/local_hbf_number[1]} {u_HBU/local_hbf_number[2]} {u_HBU/local_hbf_number[3]} {u_HBU/local_hbf_number[4]} {u_HBU/local_hbf_number[5]} {u_HBU/local_hbf_number[6]} {u_HBU/local_hbf_number[7]} {u_HBU/local_hbf_number[8]} {u_HBU/local_hbf_number[9]} {u_HBU/local_hbf_number[10]} {u_HBU/local_hbf_number[11]} {u_HBU/local_hbf_number[12]} {u_HBU/local_hbf_number[13]} {u_HBU/local_hbf_number[14]} {u_HBU/local_hbf_number[15]} {u_HBU/local_hbf_number[16]} {u_HBU/local_hbf_number[17]} {u_HBU/local_hbf_number[18]} {u_HBU/local_hbf_number[19]} {u_HBU/local_hbf_number[20]} {u_HBU/local_hbf_number[21]} {u_HBU/local_hbf_number[22]} {u_HBU/local_hbf_number[23]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe29]
set_property port_width 1 [get_debug_ports u_ila_0/probe29]
connect_debug_port u_ila_0/probe29 [get_nets [list u_HBU/backbeat_signal]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe30]
set_property port_width 1 [get_debug_ports u_ila_0/probe30]
connect_debug_port u_ila_0/probe30 [get_nets [list u_Miku_Inst/u_CbtLane/u_cbttx/u_cdcm_tx/gen_cdcm8.u_cdcm_tx_oserdes/bit_slip]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe31]
set_property port_width 1 [get_debug_ports u_ila_0/probe31]
connect_debug_port u_ila_0/probe31 [get_nets [list u_LACCP/u_rx/frame_invalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe32]
set_property port_width 1 [get_debug_ports u_ila_0/probe32]
connect_debug_port u_ila_0/probe32 [get_nets [list u_HBU/frame_state]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe33]
set_property port_width 1 [get_debug_ports u_ila_0/probe33]
connect_debug_port u_ila_0/probe33 [get_nets [list u_LACCP/u_rx/frame_valid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe34]
set_property port_width 1 [get_debug_ports u_ila_0/probe34]
connect_debug_port u_ila_0/probe34 [get_nets [list u_HBU/heartbeat_signal]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe35]
set_property port_width 1 [get_debug_ports u_ila_0/probe35]
connect_debug_port u_ila_0/probe35 [get_nets [list u_LACCP/u_rx/invalid_frame_length]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe36]
set_property port_width 1 [get_debug_ports u_ila_0/probe36]
connect_debug_port u_ila_0/probe36 [get_nets [list u_LACCP/u_RCAP/is_done]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe37]
set_property port_width 1 [get_debug_ports u_ila_0/probe37]
connect_debug_port u_ila_0/probe37 [get_nets [list is_ready_for_daq]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe38]
set_property port_width 1 [get_debug_ports u_ila_0/probe38]
connect_debug_port u_ila_0/probe38 [get_nets [list u_LACCP/u_RCAP/secondary_is_ready]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe39]
set_property port_width 1 [get_debug_ports u_ila_0/probe39]
connect_debug_port u_ila_0/probe39 [get_nets [list u_LACCP/u_rx/unexpected_preamble]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe40]
set_property port_width 1 [get_debug_ports u_ila_0/probe40]
connect_debug_port u_ila_0/probe40 [get_nets [list valid_link_addr]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_slow]
