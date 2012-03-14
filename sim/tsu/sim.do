quit -sim

vlib altera
vlog -work altera altera_mf.v

vlib work
vlog -work work ../../rtl/tsu/tsu_queue.v
vlog -work work ../../rtl/tsu/ptp_parser.v
vlog -work work ../../rtl/tsu/ptp_queue.v
vlog -work work gmii_rx_bfm.v
vlog -work work gmii_tx_bfm.v
vlog -work work tsu_queue_tb.v
vsim -novopt -L altera work.tsu_queue_tb

log -r */*
radix -hexadecimal
do wave.do

run -all
