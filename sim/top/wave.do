onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Logic /ha1588_tb/up_clk
add wave -noupdate -format Logic /ha1588_tb/up_wr
add wave -noupdate -format Logic /ha1588_tb/up_rd
add wave -noupdate -format Literal /ha1588_tb/up_addr
add wave -noupdate -format Literal /ha1588_tb/up_data_wr
add wave -noupdate -format Literal /ha1588_tb/up_data_rd
add wave -noupdate -format Logic /ha1588_tb/rtc_clk
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal /ha1588_tb/PTP_HA_DUT/u_rgs/addr_in
add wave -noupdate -format Logic /ha1588_tb/PTP_HA_DUT/u_rgs/wr_in
add wave -noupdate -format Logic /ha1588_tb/PTP_HA_DUT/u_rgs/rd_in
add wave -noupdate -format Literal /ha1588_tb/PTP_HA_DUT/u_rgs/data_in
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Logic /ha1588_tb/PTP_HA_DUT/u_rgs/cs_00
add wave -noupdate -format Literal /ha1588_tb/PTP_HA_DUT/u_rgs/reg_00
add wave -noupdate -format Literal /ha1588_tb/PTP_HA_DUT/u_rgs/data_out_reg
add wave -noupdate -divider {New Divider}
add wave -noupdate -format Literal /ha1588_tb/PTP_HA_DUT/u_rtc/time_reg_ns
add wave -noupdate -format Logic /ha1588_tb/PTP_HA_DUT/u_rtc/time_acc_48s_inc
add wave -noupdate -format Literal /ha1588_tb/PTP_HA_DUT/u_rtc/time_reg_sec
add wave -noupdate -divider {New Divider}
add wave -noupdate -divider {New Divider}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {135271 ps} 0}
configure wave -namecolwidth 222
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
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
WaveRestoreZoom {0 ps} {1136433 ps}
