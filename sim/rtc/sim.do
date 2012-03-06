vlib work
vlog -work work ../../rtl/rtc/rtc_timer.v
vlog -work work rtc_timer_tb.v
vsim -novopt work.rtc_timer_tb

log -r */*
radix -hexadecimal
do wave.do

run -all
