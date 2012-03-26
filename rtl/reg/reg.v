`timescale 1ns/1ns

module reg (
  // generic bus interface
  input         rst,clk,
  input         wr_in,rd_in,
  input  [ 3:0] addr_in,
  input  [31:0] data_in,
  output [31:0] data_out,
  // rtc interface
  input         rtc_rst,rtc_clk,
  output        time_ld,
  output [37:0] time_reg_ns_out,
  output [47:0] time_reg_sec_out,
  output        period_ld,
  output [39:0] period_out,
  output [37:0] time_acc_modulo_out,
  output        adj_ld,
  output [31:0] adj_ld_data_out,
  output [39:0] period_adj_out,	  
  input  [37:0] time_reg_ns_in,
  input  [47:0] time_reg_sec_in,
  // tsu interface
  output        q_rst,
  output        q_rd_clk,
  output        q_rd_en,
  input  [ 7:0] q_rd_stat,
  input  [55:0] q_rd_data
);

endmodule
