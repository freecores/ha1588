quit -sim
vlib work
vdel -lib work -all
vlib work

# compile vendor independent files
vlog -work work ../../rtl/top/ha1588.v +initreg+0
vlog -work work ../../rtl/reg/reg.v +initreg+0
vlog -work work ../../rtl/rtc/rtc.v +initreg+0
vlog -work work ../../rtl/tsu/tsu.v +initreg+0
vlog -work work ../../rtl/tsu/ptp_queue.v +initreg+0
vlog -work work ../../rtl/tsu/ptp_parser.v +initreg+0

# compile vendor dependent files
vlog -work work altera_mf.v

# compile testbench files
vlog -work work -sv ha1588_tb.v

# compile driver bfm files
vlog -work work -sv ptp_drv_bfm/ptp_drv_bfm.v

# compile driver bfm files
# Sytemverilog DPI steps to combine sv and c
# step 1: generate dpiheader.h
vlog -work work -sv -dpiheader dpiheader.h ptp_drv_bfm/ptp_drv_bfm.v
# step 2: generate ptp_drv_bfm.obj
vsim -dpiexportobj ptp_drv_bfm_sv ptp_drv_bfm_sv
# step 3: generate ptp_drv_bfm_c.obj
gcc -c -I $::env(MODEL_TECH)/../include ptp_drv_bfm/ptp_drv_bfm.c
# step 4: generate ptp_drv_bfm_c.dll
gcc -shared -Bsymbolic -o ptp_drv_bfm_c.dll ptp_drv_bfm.o \
    ptp_drv_bfm_sv.obj -L $::env(MODEL_TECH) -lmtipli

vsim -novopt \
     -sv_lib ptp_drv_bfm_c \
     -t ps \
     ha1588_tb 

log -r */*
radix -hexadecimal
do wave.do

run 10000ns
