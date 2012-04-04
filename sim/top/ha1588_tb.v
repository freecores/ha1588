`timescale 1ns/1ns

module ha1588_tb ();

reg up_clk;
wire up_wr, up_rd;
wire [ 7:0] up_addr;
wire [31:0] up_data_wr, up_data_rd;
initial begin
             up_clk = 1'b0;
  forever #5 up_clk = !up_clk;
end

reg rtc_clk;
initial begin
             rtc_clk = 1'b0;
  forever #4 rtc_clk = !rtc_clk;
end

reg rst;
initial begin
      rst = 1'b1;
  #10 rst = 1'b0;
end

ptp_drv_bfm_sv PTP_DRV_BFM (
  .up_clk(up_clk),
  .up_wr(up_wr),
  .up_rd(up_rd),
  .up_addr(up_addr),
  .up_data_wr(up_data_wr),
  .up_data_rd(up_data_rd)
);

ha1588 PTP_HA_DUT(
  .rst(rst),
  .clk(up_clk),
  .wr_in(up_wr),
  .rd_in(up_rd),
  .addr_in(up_addr),
  .data_in(up_data_wr),
  .data_out(up_data_rd),

  .rtc_clk(rtc_clk),

  .rx_gmii_clk(),
  .rx_gmii_ctrl(),
  .rx_gmii_data(),
  .tx_gmii_clk(),
  .tx_gmii_ctrl(),
  .tx_gmii_data()
);

initial begin
	ha1588_tb.PTP_DRV_BFM.up_start = 1;
	#100000000 $stop;
end

endmodule
