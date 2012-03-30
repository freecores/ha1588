`timescale 1ns/1ns

module top (
  input         rst,clk,
  input         wr_in,rd_in,
  input  [ 5:0] addr_in,
  input  [31:0] data_in,
  output [31:0] data_out,

  input       rtc_clk,

  input       rx_gmii_clk,
  input       rx_gmii_ctrl,
  input [7:0] rx_gmii_data,
  input       tx_gmii_clk,
  input       tx_gmii_ctrl,
  input [7:0] tx_gmii_data
);

rgs u_rgs
(
  .rst(),
  .clk(),
  .wr_in(),
  .rd_in(),
  .addr_in(),
  .data_in(),
  .data_out(),
  .rtc_clk_in(),
  .rtc_rst_out(),
  .time_ld_out(),
  .time_reg_ns_out(),
  .time_reg_sec_out(),
  .period_ld_out(),
  .period_out(),
  .time_acc_modulo_out(),
  .adj_ld_out(),
  .adj_ld_data_out(),
  .period_adj_out(),
  .time_reg_ns_in(),
  .time_reg_sec_in(),
  .q_rst_out(),
  .q_rd_clk_out(),
  .q_rd_en_out(),
  .q_stat_in(),
  .q_data_in()
);

rtc u_rtc
(
  .rst(),
  .clk(),
  .time_ld(),
  .time_reg_ns_in(),
  .time_reg_sec_in(),
  .period_ld(),
  .period_in(),
  .time_acc_modulo(),
  .adj_ld(),
  .adj_ld_data(),
  .period_adj(),
  .time_reg_ns(),
  .time_reg_sec()
);

tsu u_tsu
(
  .rst(),
  .gmii_clk(),
  .gmii_ctrl(),
  .gmii_data(),
  .rtc_timer_clk(),
  .rtc_timer_in(),
  .q_rst(),
  .q_rd_clk(),
  .q_rd_en(),
  .q_rd_stat(),
  .q_rd_data()
);

endmodule
