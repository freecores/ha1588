`timescale 1ns/1ns

module rgs (
  // generic bus interface
  input         rst,clk,
  input         wr_in,rd_in,
  input  [ 5:0] addr_in,
  input  [31:0] data_in,
  output [31:0] data_out,
  // rtc interface
  input         rtc_clk_in,
  output        rtc_rst_out,
  output        time_ld_out,
  output [37:0] time_reg_ns_out,
  output [47:0] time_reg_sec_out,
  output        period_ld_out,
  output [39:0] period_out,
  output [37:0] time_acc_modulo_out,
  output        adj_ld_out,
  output [31:0] adj_ld_data_out,
  output [39:0] period_adj_out,
  input  [37:0] time_reg_ns_in,
  input  [47:0] time_reg_sec_in,
  // tsu interface
  output        q_rst_out,
  output        q_rd_clk_out,
  output        q_rd_en_out,
  input  [ 7:0] q_stat_in,
  input  [55:0] q_data_in
);

parameter const_00 = 8'h00;
parameter const_04 = 8'h04;
parameter const_08 = 8'h08;
parameter const_0C = 8'h0C;
parameter const_10 = 8'h10;
parameter const_14 = 8'h14;
parameter const_18 = 8'h18;
parameter const_1C = 8'h1C;
parameter const_20 = 8'h20;
parameter const_24 = 8'h24;
parameter const_28 = 8'h28;
parameter const_2C = 8'h2C;
parameter const_30 = 8'h30;
parameter const_34 = 8'h34;
parameter const_38 = 8'h38;
parameter const_3C = 8'h3C;
parameter const_40 = 8'h40;
parameter const_44 = 8'h44;
parameter const_48 = 8'h48;
parameter const_4C = 8'h4C;

wire cs_00 = (addr_in[5:0]==const_00[5:0])? 1'b1: 1'b0;
wire cs_04 = (addr_in[5:0]==const_04[5:0])? 1'b1: 1'b0;
wire cs_08 = (addr_in[5:0]==const_08[5:0])? 1'b1: 1'b0;
wire cs_0c = (addr_in[5:0]==const_0c[5:0])? 1'b1: 1'b0;
wire cs_10 = (addr_in[5:0]==const_10[5:0])? 1'b1: 1'b0;
wire cs_14 = (addr_in[5:0]==const_14[5:0])? 1'b1: 1'b0;
wire cs_18 = (addr_in[5:0]==const_18[5:0])? 1'b1: 1'b0;
wire cs_1c = (addr_in[5:0]==const_1c[5:0])? 1'b1: 1'b0;
wire cs_20 = (addr_in[5:0]==const_20[5:0])? 1'b1: 1'b0;
wire cs_24 = (addr_in[5:0]==const_24[5:0])? 1'b1: 1'b0;
wire cs_28 = (addr_in[5:0]==const_28[5:0])? 1'b1: 1'b0;
wire cs_2c = (addr_in[5:0]==const_2c[5:0])? 1'b1: 1'b0;
wire cs_30 = (addr_in[5:0]==const_30[5:0])? 1'b1: 1'b0;
wire cs_34 = (addr_in[5:0]==const_34[5:0])? 1'b1: 1'b0;
wire cs_38 = (addr_in[5:0]==const_38[5:0])? 1'b1: 1'b0;
wire cs_3c = (addr_in[5:0]==const_3c[5:0])? 1'b1: 1'b0;
wire cs_40 = (addr_in[5:0]==const_40[5:0])? 1'b1: 1'b0;
wire cs_44 = (addr_in[5:0]==const_44[5:0])? 1'b1: 1'b0;
wire cs_48 = (addr_in[5:0]==const_48[5:0])? 1'b1: 1'b0;
wire cs_4c = (addr_in[5:0]==const_4c[5:0])? 1'b1: 1'b0;

reg [31:0] reg_00;  // ctrl  8 bit
reg [31:0] reg_04;  // stat  8 bit
reg [31:0] reg_08;  // queu 24 bit
reg [31:0] reg_0c;  // queu 32 bit
reg [31:0] reg_10;  // tout 16 s
reg [31:0] reg_14;  // tout 32 s
reg [31:0] reg_18;  // tout 30 ns
reg [31:0] reg_1c;  // tout  8 nsf
reg [31:0] reg_20;  // peri  8 ns
reg [31:0] reg_24;  // peri 32 nsf
reg [31:0] reg_28;  // amod 30 ns
reg [31:0] reg_2c;  // amod  8 nsf
reg [31:0] reg_30;  // ajld 32 bit
reg [31:0] reg_34;  // 
reg [31:0] reg_38;  // ajpr  8 ns
reg [31:0] reg_3c;  // ajpr 32 nsf
reg [31:0] reg_40;  // tmin 16 s
reg [31:0] reg_44;  // tmin 32 s
reg [31:0] reg_48;  // tmin 30 ns
reg [31:0] reg_4c;  // tmin  8 nsf

// write registers
always @(posedge clk) begin
  if (wr_in && cs_00) reg_00 <= data_in;
  if (wr_in && cs_04) reg_04 <= data_in;
  if (wr_in && cs_08) reg_08 <= data_in;
  if (wr_in && cs_0c) reg_0c <= data_in;
  if (wr_in && cs_10) reg_10 <= data_in;
  if (wr_in && cs_14) reg_14 <= data_in;
  if (wr_in && cs_18) reg_18 <= data_in;
  if (wr_in && cs_1c) reg_1c <= data_in;
  if (wr_in && cs_20) reg_20 <= data_in;
  if (wr_in && cs_24) reg_24 <= data_in;
  if (wr_in && cs_28) reg_28 <= data_in;
  if (wr_in && cs_2c) reg_2c <= data_in;
  if (wr_in && cs_30) reg_30 <= data_in;
  if (wr_in && cs_34) reg_34 <= data_in;
  if (wr_in && cs_38) reg_38 <= data_in;
  if (wr_in && cs_3c) reg_3c <= data_in;
  if (wr_in && cs_40) reg_40 <= data_in;
  if (wr_in && cs_44) reg_44 <= data_in;
  if (wr_in && cs_48) reg_48 <= data_in;
  if (wr_in && cs_4c) reg_4c <= data_in;
end

// read registers
reg  [37:0] time_reg_ns_int;
reg  [47:0] time_reg_sec_int;
reg  [55:0] q_data_int;
reg  [ 7:0] q_stat_int;

reg  [31:0] data_out_reg;
always @(posedge clk) begin
  if (cs_00) data_out_reg <= reg_00;
  if (cs_04) data_out_reg <= {24'd0, q_stat_int[ 7: 0]};
  if (cs_08) data_out_reg <= { 8'd0, q_data_int[55:32]};
  if (cs_0c) data_out_reg <=         q_data_int[31: 0];
  if (cs_10) data_out_reg <= reg_10;
  if (cs_14) data_out_reg <= reg_14;
  if (cs_18) data_out_reg <= reg_18;
  if (cs_1c) data_out_reg <= reg_1c;
  if (cs_20) data_out_reg <= reg_20;
  if (cs_24) data_out_reg <= reg_24;
  if (cs_28) data_out_reg <= reg_28;
  if (cs_2c) data_out_reg <= reg_2c;
  if (cs_30) data_out_reg <= reg_30;
  if (cs_34) data_out_reg <= reg_34;
  if (cs_38) data_out_reg <= reg_38;
  if (cs_3c) data_out_reg <= reg_3c;
  if (cs_40) data_out_reg <= {16'd0, time_reg_sec_int[47:32]);
  if (cs_44) data_out_reg <=         time_reg_sec_int[31: 0];
  if (cs_48) data_out_reg <= { 2'd0, time_reg_ns_int [37: 8]};
  if (cs_4c) data_out_reg <= {24'd0, time_reg_ns_int [ 7: 0]};
end
assign data_out = data_out_reg;

// register mapping
wire rtc_rst = reg_00[7];
wire que_rst = reg_00[6];
wire time_ld = reg_00[5];
wire perd_ld = reg_00[4];
wire adjt_ld = reg_00[3];
wire time_rd = reg_00[2];
wire queu_rd = reg_00[1];
//wire         = reg_00[0];
assign time_reg_sec_out   [47:0] = {reg_10[15: 0], reg_14[31: 0]};
assign time_reg_ns_out    [37:0] = {reg_18[29: 0], reg_1c[ 7: 0]};
assign period_out         [39:0] = {reg_20[ 7: 0], reg_24[31: 0]};
assign time_acc_modulo_out[37:0] = {reg_28[29: 0], reg_2c[ 7: 0]};
assign adj_ld_data_out    [31:0] =  reg_30[31: 0];
assign period_adj_out     [39:0] = {reg_38[ 7: 0], reg_3c[31: 0]};

// real time clock
reg rtc_rst_d1, rtc_rst_d2, rtc_rst_d3;
assign rtc_rst_out = rtc_rst_d2 && !rtc_rst_d3;
always @(posedge clk) begin
  rtc_rst_d1 <= rtc_rst;
  rtc_rst_d2 <= rtc_rst_d1;
  rtc_rst_d3 <= rtc_rst_d2;
end

reg time_ld_d1, time_ld_d2, time_ld_d3;
assign time_ld_out = time_ld_d2 && !time_ld_d3;
always @(posedge clk) begin
  time_ld_d1 <= time_ld;
  time_ld_d2 <= time_ld_d1;
  time_ld_d3 <= time_ld_d2;
end

reg perd_ld_d1, perd_ld_d2, perd_ld_d3;
assign period_ld_out  = perd_ld_d2 && !perd_ld_d3;
always @(posedge clk) begin
  perd_ld_d1 <= perd_ld;
  perd_ld_d2 <= perd_ld_d1;
  perd_ld_d3 <= perd_ld_d2;
end

reg adjt_ld_d1, adjt_ld_d2, adjt_ld_d3;
assign adj_ld_out = adjt_ld_d2 && !adjt_ld_d3;
always @(posedge clk) begin
  adjt_ld_d1 <= adjt_ld;
  adjt_ld_d2 <= adjt_ld_d1;
  adjt_ld_d3 <= adjt_ld_d2;
end

reg time_rd_d1, time_rd_d2, time_rd_d3;
wire time_reg_in_latch = time_rd_d2 && !time_rd_d3;
always @(posedge rtc_clk_in) begin
  time_rd_d1 <= time_rd;
  time_rd_d2 <= time_rd_d1;
  time_rd_d3 <= time_rd_d2;
end

always @(posedge rtc_clk_in) begin
  if (time_reg_in_latch) begin
    time_reg_ns_int  <= time_reg_ns_in;
    time_reg_sec_int <= time_reg_sec_in;	  
  end
end

// time stamp queue
assign q_rd_clk_out = clk;

reg que_rst_d1, que_rst_d2, que_rst_d3;
assign q_rst_out = que_rst_d2 && !que_rst_d3;
always @(posedge clk) begin
  que_rst_d1 <= que_rst;
  que_rst_d2 <= que_rst_d1;
  que_rst_d3 <= que_rst_d2;
end

reg queu_rd_d1, queu_rd_d2, queu_rd_d3;
assign q_rd_en_out = queu_rd_d2 && !queu_rd_d3;
always @(posedge clk) begin
  queu_rd_d1 <= queu_rd;
  queu_rd_d2 <= queu_rd_d1;
  queu_rd_d3 <= queu_rd_d2;
end

always @(posedge clk) begin
  q_data_int <= q_data_in;
  q_stat_int <= q_stat_in;
end

endmodule
