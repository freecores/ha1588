`timescale 1ns/1ns

module tsu_queue_tb; 

reg        rst;
wire       gmii_rxclk;
wire       gmii_rxctrl;
wire [7:0] gmii_rxdata;
wire       gmii_txclk;
wire       gmii_txctrl;
wire [7:0] gmii_txdata;
reg        rtc_timer_clk;
reg [79:0] rtc_timer_in;

initial begin
  DUT_RX.ts_ack = 1'b0;

      rst = 1'b0;
  #10 rst = 1'b1;
  #20 rst = 1'b0;
end

initial begin
             rtc_timer_clk = 1'b0;
  forever #4 rtc_timer_clk = !rtc_timer_clk;
end

initial begin
                                   rtc_timer_in = 80'd0;
  forever @(posedge rtc_timer_clk) rtc_timer_in = rtc_timer_in +1;
end

tsu_queue DUT_RX
  (
    .rst(rst),

    .gmii_clk(gmii_rxclk),
    .gmii_ctrl(gmii_rxctrl),
    .gmii_data(gmii_rxdata),

    .rtc_timer_clk(rtc_timer_clk),
    .rtc_timer_in(rtc_timer_in)
  );

gmii_rx_bfm BFM_RX
  (
    .gmii_rxclk(gmii_rxclk),
    .gmii_rxctrl(gmii_rxctrl),
    .gmii_rxdata(gmii_rxdata)
  );

tsu_queue DUT_TX
  (
    .rst(rst),

    .gmii_clk(gmii_txclk),
    .gmii_ctrl(gmii_txctrl),
    .gmii_data(gmii_txdata),

    .rtc_timer_clk(rtc_timer_clk),
    .rtc_timer_in(rtc_timer_in)
  );

gmii_tx_bfm BFM_TX
  (
    .gmii_txclk(gmii_txclk),
    .gmii_txctrl(gmii_txctrl),
    .gmii_txdata(gmii_txdata)
  );

endmodule

