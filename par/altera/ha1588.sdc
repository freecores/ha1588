## Generated SDC file "ha1588.sdc"

## Copyright (C) 1991-2011 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 10.1 Build 197 01/19/2011 Service Pack 1 SJ Full Version"

## DATE    "Sat Mar 31 15:03:15 2012"

##
## DEVICE  "EP3C5F256C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {clk} -period 10.000 -waveform { 0.000 5.000 } [get_ports {clk}]
create_clock -name {rtc_clk} -period 8.000 -waveform { 0.000 4.000 } [get_ports {rtc_clk}]
create_clock -name {tx_gmii_clk} -period 8.000 -waveform { 0.000 4.000 } [get_ports {tx_gmii_clk}]
create_clock -name {rx_gmii_clk} -period 8.000 -waveform { 0.000 4.000 } [get_ports {rx_gmii_clk}]


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {rtc_clk}]  0.040 
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {rtc_clk}]  0.040 
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {rx_gmii_clk}]  0.040 
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {rx_gmii_clk}]  0.040 
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {tx_gmii_clk}]  0.040 
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {tx_gmii_clk}]  0.040 
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {rtc_clk}]  0.040 
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {rtc_clk}]  0.040 
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {rx_gmii_clk}]  0.040 
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {rx_gmii_clk}]  0.040 
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {tx_gmii_clk}]  0.040 
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {tx_gmii_clk}]  0.040 
set_clock_uncertainty -rise_from [get_clocks {rtc_clk}] -rise_to [get_clocks {clk}]  0.040 
set_clock_uncertainty -rise_from [get_clocks {rtc_clk}] -fall_to [get_clocks {clk}]  0.040 
set_clock_uncertainty -rise_from [get_clocks {rtc_clk}] -rise_to [get_clocks {rtc_clk}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {rtc_clk}] -fall_to [get_clocks {rtc_clk}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {rtc_clk}] -rise_to [get_clocks {rx_gmii_clk}]  0.040 
set_clock_uncertainty -rise_from [get_clocks {rtc_clk}] -fall_to [get_clocks {rx_gmii_clk}]  0.040 
set_clock_uncertainty -rise_from [get_clocks {rtc_clk}] -rise_to [get_clocks {tx_gmii_clk}]  0.040 
set_clock_uncertainty -rise_from [get_clocks {rtc_clk}] -fall_to [get_clocks {tx_gmii_clk}]  0.040 
set_clock_uncertainty -fall_from [get_clocks {rtc_clk}] -rise_to [get_clocks {clk}]  0.040 
set_clock_uncertainty -fall_from [get_clocks {rtc_clk}] -fall_to [get_clocks {clk}]  0.040 
set_clock_uncertainty -fall_from [get_clocks {rtc_clk}] -rise_to [get_clocks {rtc_clk}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {rtc_clk}] -fall_to [get_clocks {rtc_clk}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {rtc_clk}] -rise_to [get_clocks {rx_gmii_clk}]  0.040 
set_clock_uncertainty -fall_from [get_clocks {rtc_clk}] -fall_to [get_clocks {rx_gmii_clk}]  0.040 
set_clock_uncertainty -fall_from [get_clocks {rtc_clk}] -rise_to [get_clocks {tx_gmii_clk}]  0.040 
set_clock_uncertainty -fall_from [get_clocks {rtc_clk}] -fall_to [get_clocks {tx_gmii_clk}]  0.040 
set_clock_uncertainty -rise_from [get_clocks {rx_gmii_clk}] -rise_to [get_clocks {clk}]  0.040 
set_clock_uncertainty -rise_from [get_clocks {rx_gmii_clk}] -fall_to [get_clocks {clk}]  0.040 
set_clock_uncertainty -rise_from [get_clocks {rx_gmii_clk}] -rise_to [get_clocks {rtc_clk}]  0.040 
set_clock_uncertainty -rise_from [get_clocks {rx_gmii_clk}] -fall_to [get_clocks {rtc_clk}]  0.040 
set_clock_uncertainty -rise_from [get_clocks {rx_gmii_clk}] -rise_to [get_clocks {rx_gmii_clk}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {rx_gmii_clk}] -fall_to [get_clocks {rx_gmii_clk}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {rx_gmii_clk}] -rise_to [get_clocks {clk}]  0.040 
set_clock_uncertainty -fall_from [get_clocks {rx_gmii_clk}] -fall_to [get_clocks {clk}]  0.040 
set_clock_uncertainty -fall_from [get_clocks {rx_gmii_clk}] -rise_to [get_clocks {rtc_clk}]  0.040 
set_clock_uncertainty -fall_from [get_clocks {rx_gmii_clk}] -fall_to [get_clocks {rtc_clk}]  0.040 
set_clock_uncertainty -fall_from [get_clocks {rx_gmii_clk}] -rise_to [get_clocks {rx_gmii_clk}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {rx_gmii_clk}] -fall_to [get_clocks {rx_gmii_clk}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {tx_gmii_clk}] -rise_to [get_clocks {clk}]  0.040 
set_clock_uncertainty -rise_from [get_clocks {tx_gmii_clk}] -fall_to [get_clocks {clk}]  0.040 
set_clock_uncertainty -rise_from [get_clocks {tx_gmii_clk}] -rise_to [get_clocks {rtc_clk}]  0.040 
set_clock_uncertainty -rise_from [get_clocks {tx_gmii_clk}] -fall_to [get_clocks {rtc_clk}]  0.040 
set_clock_uncertainty -rise_from [get_clocks {tx_gmii_clk}] -rise_to [get_clocks {tx_gmii_clk}]  0.020 
set_clock_uncertainty -rise_from [get_clocks {tx_gmii_clk}] -fall_to [get_clocks {tx_gmii_clk}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {tx_gmii_clk}] -rise_to [get_clocks {clk}]  0.040 
set_clock_uncertainty -fall_from [get_clocks {tx_gmii_clk}] -fall_to [get_clocks {clk}]  0.040 
set_clock_uncertainty -fall_from [get_clocks {tx_gmii_clk}] -rise_to [get_clocks {rtc_clk}]  0.040 
set_clock_uncertainty -fall_from [get_clocks {tx_gmii_clk}] -fall_to [get_clocks {rtc_clk}]  0.040 
set_clock_uncertainty -fall_from [get_clocks {tx_gmii_clk}] -rise_to [get_clocks {tx_gmii_clk}]  0.020 
set_clock_uncertainty -fall_from [get_clocks {tx_gmii_clk}] -fall_to [get_clocks {tx_gmii_clk}]  0.020 


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -exclusive -group [get_clocks {clk}] \
                            -group [get_clocks {rtc_clk}] \
                            -group [get_clocks {rx_gmii_clk}] \
                            -group [get_clocks {tx_gmii_clk}]

#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_gd9:dffpipe18|dffe19a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_fd9:dffpipe15|dffe16a*}]


#**************************************************************
# Set Multicycle Path
#**************************************************************

set_multicycle_path -from [get_registers {tsu:u_rx_tsu|ptp_parser:parser|*}] -to [get_registers {tsu:u_rx_tsu|ptp_parser:parser|*}] -setup -end 4
set_multicycle_path -from [get_registers {tsu:u_rx_tsu|ptp_parser:parser|*}] -to [get_registers {tsu:u_rx_tsu|ptp_parser:parser|*}] -hold  -end 3
set_multicycle_path -from [get_registers {tsu:u_tx_tsu|ptp_parser:parser|*}] -to [get_registers {tsu:u_tx_tsu|ptp_parser:parser|*}] -setup -end 4
set_multicycle_path -from [get_registers {tsu:u_tx_tsu|ptp_parser:parser|*}] -to [get_registers {tsu:u_tx_tsu|ptp_parser:parser|*}] -hold  -end 3


#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

