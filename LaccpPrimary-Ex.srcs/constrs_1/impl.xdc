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
connect_debug_port u_ila_0/clk [get_nets [list u_MMCM_CDCM/inst/mmcm_slow]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 5 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {u_LACCP/u_sw/rd_valid_rx_fifo[0]} {u_LACCP/u_sw/rd_valid_rx_fifo[1]} {u_LACCP/u_sw/rd_valid_rx_fifo[2]} {u_LACCP/u_sw/rd_valid_rx_fifo[3]} {u_LACCP/u_sw/rd_valid_rx_fifo[4]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 64 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {u_LACCP/u_sw/reg_bus_data[0]} {u_LACCP/u_sw/reg_bus_data[1]} {u_LACCP/u_sw/reg_bus_data[2]} {u_LACCP/u_sw/reg_bus_data[3]} {u_LACCP/u_sw/reg_bus_data[4]} {u_LACCP/u_sw/reg_bus_data[5]} {u_LACCP/u_sw/reg_bus_data[6]} {u_LACCP/u_sw/reg_bus_data[7]} {u_LACCP/u_sw/reg_bus_data[8]} {u_LACCP/u_sw/reg_bus_data[9]} {u_LACCP/u_sw/reg_bus_data[10]} {u_LACCP/u_sw/reg_bus_data[11]} {u_LACCP/u_sw/reg_bus_data[12]} {u_LACCP/u_sw/reg_bus_data[13]} {u_LACCP/u_sw/reg_bus_data[14]} {u_LACCP/u_sw/reg_bus_data[15]} {u_LACCP/u_sw/reg_bus_data[16]} {u_LACCP/u_sw/reg_bus_data[17]} {u_LACCP/u_sw/reg_bus_data[18]} {u_LACCP/u_sw/reg_bus_data[19]} {u_LACCP/u_sw/reg_bus_data[20]} {u_LACCP/u_sw/reg_bus_data[21]} {u_LACCP/u_sw/reg_bus_data[22]} {u_LACCP/u_sw/reg_bus_data[23]} {u_LACCP/u_sw/reg_bus_data[24]} {u_LACCP/u_sw/reg_bus_data[25]} {u_LACCP/u_sw/reg_bus_data[26]} {u_LACCP/u_sw/reg_bus_data[27]} {u_LACCP/u_sw/reg_bus_data[28]} {u_LACCP/u_sw/reg_bus_data[29]} {u_LACCP/u_sw/reg_bus_data[30]} {u_LACCP/u_sw/reg_bus_data[31]} {u_LACCP/u_sw/reg_bus_data[32]} {u_LACCP/u_sw/reg_bus_data[33]} {u_LACCP/u_sw/reg_bus_data[34]} {u_LACCP/u_sw/reg_bus_data[35]} {u_LACCP/u_sw/reg_bus_data[36]} {u_LACCP/u_sw/reg_bus_data[37]} {u_LACCP/u_sw/reg_bus_data[38]} {u_LACCP/u_sw/reg_bus_data[39]} {u_LACCP/u_sw/reg_bus_data[40]} {u_LACCP/u_sw/reg_bus_data[41]} {u_LACCP/u_sw/reg_bus_data[42]} {u_LACCP/u_sw/reg_bus_data[43]} {u_LACCP/u_sw/reg_bus_data[44]} {u_LACCP/u_sw/reg_bus_data[45]} {u_LACCP/u_sw/reg_bus_data[46]} {u_LACCP/u_sw/reg_bus_data[47]} {u_LACCP/u_sw/reg_bus_data[48]} {u_LACCP/u_sw/reg_bus_data[49]} {u_LACCP/u_sw/reg_bus_data[50]} {u_LACCP/u_sw/reg_bus_data[51]} {u_LACCP/u_sw/reg_bus_data[52]} {u_LACCP/u_sw/reg_bus_data[53]} {u_LACCP/u_sw/reg_bus_data[54]} {u_LACCP/u_sw/reg_bus_data[55]} {u_LACCP/u_sw/reg_bus_data[56]} {u_LACCP/u_sw/reg_bus_data[57]} {u_LACCP/u_sw/reg_bus_data[58]} {u_LACCP/u_sw/reg_bus_data[59]} {u_LACCP/u_sw/reg_bus_data[60]} {u_LACCP/u_sw/reg_bus_data[61]} {u_LACCP/u_sw/reg_bus_data[62]} {u_LACCP/u_sw/reg_bus_data[63]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 2 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {u_LACCP/u_tx/state_tx[0]} {u_LACCP/u_tx/state_tx[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 2 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {u_LACCP/u_sw/state_switch[0]} {u_LACCP/u_sw/state_switch[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 2 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {u_LACCP/u_rx/state_rx[0]} {u_LACCP/u_rx/state_rx[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 16 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list {u_LACCP/u_RCAP/reg_hbc_offset[0]} {u_LACCP/u_RCAP/reg_hbc_offset[1]} {u_LACCP/u_RCAP/reg_hbc_offset[2]} {u_LACCP/u_RCAP/reg_hbc_offset[3]} {u_LACCP/u_RCAP/reg_hbc_offset[4]} {u_LACCP/u_RCAP/reg_hbc_offset[5]} {u_LACCP/u_RCAP/reg_hbc_offset[6]} {u_LACCP/u_RCAP/reg_hbc_offset[7]} {u_LACCP/u_RCAP/reg_hbc_offset[8]} {u_LACCP/u_RCAP/reg_hbc_offset[9]} {u_LACCP/u_RCAP/reg_hbc_offset[10]} {u_LACCP/u_RCAP/reg_hbc_offset[11]} {u_LACCP/u_RCAP/reg_hbc_offset[12]} {u_LACCP/u_RCAP/reg_hbc_offset[13]} {u_LACCP/u_RCAP/reg_hbc_offset[14]} {u_LACCP/u_RCAP/reg_hbc_offset[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 24 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list {u_HBU/local_hbf_number[0]} {u_HBU/local_hbf_number[1]} {u_HBU/local_hbf_number[2]} {u_HBU/local_hbf_number[3]} {u_HBU/local_hbf_number[4]} {u_HBU/local_hbf_number[5]} {u_HBU/local_hbf_number[6]} {u_HBU/local_hbf_number[7]} {u_HBU/local_hbf_number[8]} {u_HBU/local_hbf_number[9]} {u_HBU/local_hbf_number[10]} {u_HBU/local_hbf_number[11]} {u_HBU/local_hbf_number[12]} {u_HBU/local_hbf_number[13]} {u_HBU/local_hbf_number[14]} {u_HBU/local_hbf_number[15]} {u_HBU/local_hbf_number[16]} {u_HBU/local_hbf_number[17]} {u_HBU/local_hbf_number[18]} {u_HBU/local_hbf_number[19]} {u_HBU/local_hbf_number[20]} {u_HBU/local_hbf_number[21]} {u_HBU/local_hbf_number[22]} {u_HBU/local_hbf_number[23]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 16 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list {u_HBU/hb_counter[0]} {u_HBU/hb_counter[1]} {u_HBU/hb_counter[2]} {u_HBU/hb_counter[3]} {u_HBU/hb_counter[4]} {u_HBU/hb_counter[5]} {u_HBU/hb_counter[6]} {u_HBU/hb_counter[7]} {u_HBU/hb_counter[8]} {u_HBU/hb_counter[9]} {u_HBU/hb_counter[10]} {u_HBU/hb_counter[11]} {u_HBU/hb_counter[12]} {u_HBU/hb_counter[13]} {u_HBU/hb_counter[14]} {u_HBU/hb_counter[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 32 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list {link_addr_partter[0]} {link_addr_partter[1]} {link_addr_partter[2]} {link_addr_partter[3]} {link_addr_partter[4]} {link_addr_partter[5]} {link_addr_partter[6]} {link_addr_partter[7]} {link_addr_partter[8]} {link_addr_partter[9]} {link_addr_partter[10]} {link_addr_partter[11]} {link_addr_partter[12]} {link_addr_partter[13]} {link_addr_partter[14]} {link_addr_partter[15]} {link_addr_partter[16]} {link_addr_partter[17]} {link_addr_partter[18]} {link_addr_partter[19]} {link_addr_partter[20]} {link_addr_partter[21]} {link_addr_partter[22]} {link_addr_partter[23]} {link_addr_partter[24]} {link_addr_partter[25]} {link_addr_partter[26]} {link_addr_partter[27]} {link_addr_partter[28]} {link_addr_partter[29]} {link_addr_partter[30]} {link_addr_partter[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list u_HBU/backbeat_signal]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe10]
set_property port_width 1 [get_debug_ports u_ila_0/probe10]
connect_debug_port u_ila_0/probe10 [get_nets [list u_LACCP/u_rx/frame_invalid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe11]
set_property port_width 1 [get_debug_ports u_ila_0/probe11]
connect_debug_port u_ila_0/probe11 [get_nets [list u_HBU/frame_state]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe12]
set_property port_width 1 [get_debug_ports u_ila_0/probe12]
connect_debug_port u_ila_0/probe12 [get_nets [list u_LACCP/u_rx/frame_valid]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe13]
set_property port_width 1 [get_debug_ports u_ila_0/probe13]
connect_debug_port u_ila_0/probe13 [get_nets [list u_HBU/heartbeat_signal]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe14]
set_property port_width 1 [get_debug_ports u_ila_0/probe14]
connect_debug_port u_ila_0/probe14 [get_nets [list u_LACCP/u_sw/inter_connect]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe15]
set_property port_width 1 [get_debug_ports u_ila_0/probe15]
connect_debug_port u_ila_0/probe15 [get_nets [list u_LACCP/u_sw/intra_connect]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe16]
set_property port_width 1 [get_debug_ports u_ila_0/probe16]
connect_debug_port u_ila_0/probe16 [get_nets [list u_LACCP/u_rx/invalid_frame_length]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe17]
set_property port_width 1 [get_debug_ports u_ila_0/probe17]
connect_debug_port u_ila_0/probe17 [get_nets [list u_LACCP/u_RCAP/is_done]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe18]
set_property port_width 1 [get_debug_ports u_ila_0/probe18]
connect_debug_port u_ila_0/probe18 [get_nets [list is_ready_for_daq]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe19]
set_property port_width 1 [get_debug_ports u_ila_0/probe19]
connect_debug_port u_ila_0/probe19 [get_nets [list u_LACCP/u_sw/miku_connect]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe20]
set_property port_width 1 [get_debug_ports u_ila_0/probe20]
connect_debug_port u_ila_0/probe20 [get_nets [list u_LACCP/u_RCAP/offset_is_received]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe21]
set_property port_width 1 [get_debug_ports u_ila_0/probe21]
connect_debug_port u_ila_0/probe21 [get_nets [list u_LACCP/u_rx/unexpected_preamble]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe22]
set_property port_width 1 [get_debug_ports u_ila_0/probe22]
connect_debug_port u_ila_0/probe22 [get_nets [list valid_link_addr]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk_slow]
