onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /tb_top/vif/PCLK
add wave -noupdate -radix hexadecimal /tb_top/vif/PRESETn
add wave -noupdate -radix hexadecimal /tb_top/vif/PADDR
add wave -noupdate -radix hexadecimal /tb_top/vif/PWRITE
add wave -noupdate -radix hexadecimal /tb_top/vif/PSEL
add wave -noupdate -radix hexadecimal /tb_top/vif/PENABLE
add wave -noupdate -radix hexadecimal /tb_top/vif/PWDATA
add wave -noupdate -radix hexadecimal /tb_top/vif/PREADY
add wave -noupdate -radix hexadecimal /tb_top/vif/PRDATA
add wave -noupdate -radix hexadecimal /tb_top/vif/PSLVERR
add wave -noupdate -radix hexadecimal /tb_top/dut/apb_slave_inst/wait_states
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/s_cpuif_wr_err
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/s_cpuif_wr_data
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/s_cpuif_wr_biten
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/s_cpuif_wr_ack
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/s_cpuif_req_stall_wr
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/s_cpuif_req_stall_rd
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/s_cpuif_req_is_wr
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/s_cpuif_req
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/s_cpuif_rd_err
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/s_cpuif_rd_data
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/s_cpuif_rd_ack
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/s_cpuif_addr
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/readback_err
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/readback_done
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/readback_data
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/readback_array
add wave -noupdate -radix unsigned /tb_top/dut/counter_delay
add wave -noupdate /tb_top/dut/start_increment
add wave -noupdate -radix hexadecimal -childformat {{/tb_top/dut/expanded_regfile_inst/hwif_out.init_control_status -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_out.mode_control_status -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_out.interrupt_control -radix hexadecimal -childformat {{/tb_top/dut/expanded_regfile_inst/hwif_out.interrupt_control.control -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_out.interrupt_control.data -radix hexadecimal}}} {/tb_top/dut/expanded_regfile_inst/hwif_out.power_control_status -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_out.reset_control_status -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_out.transmit_control_status -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_out.csr_reg -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_out.conf_reg -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_out.sys_stat_reg -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_out.int_reg -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_out.cntrl_reg -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_out.perf_reg -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_out.pm_reg -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_out.dbg_reg -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_out.err_reg -radix hexadecimal}} -expand -subitemconfig {/tb_top/dut/expanded_regfile_inst/hwif_out.init_control_status {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_out.mode_control_status {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_out.interrupt_control {-height 16 -radix hexadecimal -childformat {{/tb_top/dut/expanded_regfile_inst/hwif_out.interrupt_control.control -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_out.interrupt_control.data -radix hexadecimal}} -expand} /tb_top/dut/expanded_regfile_inst/hwif_out.interrupt_control.control {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_out.interrupt_control.data {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_out.power_control_status {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_out.reset_control_status {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_out.transmit_control_status {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_out.csr_reg {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_out.conf_reg {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_out.sys_stat_reg {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_out.int_reg {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_out.cntrl_reg {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_out.perf_reg {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_out.pm_reg {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_out.dbg_reg {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_out.err_reg {-height 16 -radix hexadecimal}} /tb_top/dut/expanded_regfile_inst/hwif_out
add wave -noupdate -radix hexadecimal -childformat {{/tb_top/dut/expanded_regfile_inst/hwif_in.init_control_status -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_in.mode_control_status -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_in.interrupt_control -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_in.power_control_status -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_in.reset_control_status -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_in.transmit_control_status -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_in.csr_reg -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_in.conf_reg -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_in.sys_stat_reg -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_in.int_reg -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_in.cntrl_reg -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_in.perf_reg -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_in.pm_reg -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_in.dbg_reg -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_in.err_reg -radix hexadecimal} {/tb_top/dut/expanded_regfile_inst/hwif_in.fifostatus -radix hexadecimal}} -subitemconfig {/tb_top/dut/expanded_regfile_inst/hwif_in.init_control_status {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_in.mode_control_status {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_in.interrupt_control {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_in.power_control_status {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_in.reset_control_status {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_in.transmit_control_status {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_in.csr_reg {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_in.conf_reg {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_in.sys_stat_reg {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_in.int_reg {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_in.cntrl_reg {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_in.perf_reg {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_in.pm_reg {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_in.dbg_reg {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_in.err_reg {-height 16 -radix hexadecimal} /tb_top/dut/expanded_regfile_inst/hwif_in.fifostatus {-height 16 -radix hexadecimal}} /tb_top/dut/expanded_regfile_inst/hwif_in
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/field_storage
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/field_combo
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/decoded_wr_data
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/decoded_wr_biten
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/decoded_req_is_wr
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/decoded_req
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/decoded_reg_strb
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/cpuif_wr_err
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/cpuif_wr_data
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/cpuif_wr_biten
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/cpuif_wr_ack
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/cpuif_req_stall_wr
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/cpuif_req_stall_rd
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/cpuif_req_masked
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/cpuif_req_is_wr
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/cpuif_req
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/cpuif_rd_err
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/cpuif_rd_data
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/cpuif_rd_ack
add wave -noupdate -radix hexadecimal /tb_top/dut/expanded_regfile_inst/cpuif_addr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {508 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 143
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {365 ps} {884 ps}
