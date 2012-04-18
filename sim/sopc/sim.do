quit -sim

vlib work
vdel -lib work -all

vlib work
vmap work work
vlog -sv -work work $env(QUARTUS_ROOTDIR)/../ip/altera/sopc_builder_ip/verification/lib/verbosity_pkg.sv
vlog -sv -work work $env(QUARTUS_ROOTDIR)/../ip/altera/sopc_builder_ip/verification/lib/avalon_mm_pkg.sv
vlog -sv -work work $env(QUARTUS_ROOTDIR)/../ip/altera/sopc_builder_ip/verification/altera_avalon_mm_master_bfm/altera_avalon_mm_master_bfm.sv
vlog -sv -work work ../../rtl/sopc/ha1588_inst.v
vlog -sv -work work ./master_bfm_tb.v

vsim -novopt work.master_bfm_tb

log -r */*
radix -hexadecimal
do wave.do

run 1000 ns
