`timescale 1ns/1ns

module ptp_drv_bfm_sv
(
	input         up_clk,
	output        up_wr,
	output        up_rd,
	output [ 7:0] up_addr,
	output [31:0] up_data_wr,
	input  [31:0] up_data_rd
);

import "DPI-C" context task ptp_drv_bfm_c
(
	input real fw_delay
);

reg  [ 7:0] up_addr_o;
reg  [31:0] up_data_o;
wire [31:0] up_data_i;
reg         up_wr_o;
reg         up_rd_o;

export "DPI-C" task cpu_wr;
task cpu_wr(input int addr, input int data);
	integer i;
	//$display("wr %08x %08x", addr, data);
	for (i=0; i<1; i=i+1) @(posedge up_clk);
	up_addr_o = addr;
	up_data_o = data;
	up_wr_o   = 1'b1;
	for (i=0; i<1; i=i+1) @(posedge up_clk);
	up_addr_o = addr;
	up_data_o = data;
	up_wr_o   = 1'b0;
	for (i=0; i<1; i=i+1) @(posedge up_clk);
endtask

export "DPI-C" task cpu_rd;
task cpu_rd(input int addr, output int data);
	integer i;
	for (i=0; i<2; i=i+1) @(posedge up_clk);
	up_addr_o = addr;
	up_rd_o   = 1'b1;
	for (i=0; i<1; i=i+1) @(posedge up_clk);
	up_addr_o = addr;
	up_rd_o   = 1'b0;
	for (i=0; i<2; i=i+1) @(posedge up_clk);
	//$display("rd %08x %08x", addr, data);
endtask

export "DPI-C" task cpu_hd;
task cpu_hd(input int t);
	integer i;
	//$display("#%d",t);
	for (i=0; i<=t; i=i+1) @(posedge up_clk);
endtask

assign up_wr      = up_wr_o;
assign up_rd      = up_rd_o;
assign up_addr    = up_addr_o;
assign up_data_wr = up_data_o;
assign up_data_i  = up_data_rd;



// start cpu bfm C model
reg up_start;
initial begin
	up_wr_o   = 1'b0;
	up_rd_o   = 1'b0;
	up_addr_o = 'd0;
	up_data_o = 'd0;

	@(posedge up_start);
	#100 ptp_drv_bfm_c(5);
end

endmodule
