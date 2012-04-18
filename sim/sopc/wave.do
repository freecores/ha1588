onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {Master BFM}
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/DUT/the_master_bfm/clk
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/DUT/the_master_bfm/reset
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/DUT/the_master_bfm/avm_address
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/DUT/the_master_bfm/avm_waitrequest
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/DUT/the_master_bfm/avm_write
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/DUT/the_master_bfm/avm_writedata
add wave -noupdate -format Logic -radix hexadecimal /master_bfm_tb/tb/DUT/the_master_bfm/avm_read
add wave -noupdate -format Literal -radix hexadecimal /master_bfm_tb/tb/DUT/the_master_bfm/avm_readdata
add wave -noupdate -format Logic /master_bfm_tb/tb/DUT/the_master_bfm/avm_readdatavalid
add wave -noupdate -divider {Slave HA1588}
add wave -noupdate -format Logic /master_bfm_tb/tb/DUT/the_ha1588_comp/ha1588_comp/rst
add wave -noupdate -format Logic /master_bfm_tb/tb/DUT/the_ha1588_comp/ha1588_comp/clk
add wave -noupdate -format Logic /master_bfm_tb/tb/DUT/the_ha1588_comp/ha1588_comp/wr_in
add wave -noupdate -format Logic /master_bfm_tb/tb/DUT/the_ha1588_comp/ha1588_comp/rd_in
add wave -noupdate -format Literal /master_bfm_tb/tb/DUT/the_ha1588_comp/ha1588_comp/addr_in
add wave -noupdate -format Literal /master_bfm_tb/tb/DUT/the_ha1588_comp/ha1588_comp/data_in
add wave -noupdate -format Literal /master_bfm_tb/tb/DUT/the_ha1588_comp/ha1588_comp/data_out
add wave -noupdate -divider {Reg HA1588}
add wave -noupdate -format Logic /master_bfm_tb/tb/DUT/the_ha1588_comp/ha1588_comp/u_rgs/rst
add wave -noupdate -format Logic /master_bfm_tb/tb/DUT/the_ha1588_comp/ha1588_comp/u_rgs/clk
add wave -noupdate -format Logic /master_bfm_tb/tb/DUT/the_ha1588_comp/ha1588_comp/u_rgs/wr_in
add wave -noupdate -format Logic /master_bfm_tb/tb/DUT/the_ha1588_comp/ha1588_comp/u_rgs/rd_in
add wave -noupdate -format Literal /master_bfm_tb/tb/DUT/the_ha1588_comp/ha1588_comp/u_rgs/addr_in
add wave -noupdate -format Literal /master_bfm_tb/tb/DUT/the_ha1588_comp/ha1588_comp/u_rgs/data_in
add wave -noupdate -format Literal /master_bfm_tb/tb/DUT/the_ha1588_comp/ha1588_comp/u_rgs/data_out
add wave -noupdate -divider {New Divider}
add wave -noupdate -divider {New Divider}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {427662 ps} 0}
configure wave -namecolwidth 358
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
configure wave -timelineunits ps
update
WaveRestoreZoom {187361 ps} {579613 ps}
