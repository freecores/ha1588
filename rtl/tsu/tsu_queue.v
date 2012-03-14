`timescale 1ns/1ns

module tsu_queue (
    input       rst,

    input       gmii_clk,
    input       gmii_ctrl,
    input [7:0] gmii_data,
    
    input        rtc_timer_clk,
    input [79:0] rtc_timer_in,

    input         q_rst,
    input         q_rd_clk,
    input         q_rd_en,
    output [ 7:0] q_rd_stat,
    output [91:0] q_rd_data
);

// buffer gmii input
reg       int_gmii_ctrl;
reg       int_gmii_ctrl_d1, int_gmii_ctrl_d2, int_gmii_ctrl_d3, int_gmii_ctrl_d4, int_gmii_ctrl_d5;
reg [7:0] int_gmii_data;
reg [7:0] int_gmii_data_d1;
always @(posedge rst or posedge gmii_clk) begin
  if (rst) begin
    int_gmii_ctrl    <= 1'b0;
    int_gmii_ctrl_d1 <= 1'b0;
    int_gmii_ctrl_d2 <= 1'b0;
    int_gmii_ctrl_d3 <= 1'b0;
    int_gmii_ctrl_d4 <= 1'b0;
    int_gmii_ctrl_d5 <= 1'b0;
    int_gmii_data    <= 8'h00;
    int_gmii_data_d1 <= 8'h00;
  end
  else begin
    int_gmii_ctrl    <= gmii_ctrl;
    int_gmii_ctrl_d1 <= int_gmii_ctrl;
    int_gmii_ctrl_d2 <= int_gmii_ctrl_d1;
    int_gmii_ctrl_d3 <= int_gmii_ctrl_d2;
    int_gmii_ctrl_d4 <= int_gmii_ctrl_d3;
    int_gmii_ctrl_d5 <= int_gmii_ctrl_d4;
    int_gmii_data    <= gmii_data;
    int_gmii_data_d1 <= int_gmii_data;
  end
end

// ptp CDC time stamping
wire ts_req = int_gmii_ctrl;
reg  ts_req_d1, ts_req_d2, ts_req_d3;
always @(posedge rst or posedge rtc_timer_clk) begin
  if (rst) begin
    ts_req_d1 <= 1'b0;
    ts_req_d2 <= 1'b0;
    ts_req_d3 <= 1'b0;
  end
  else begin
    ts_req_d1 <= ts_req;
    ts_req_d2 <= ts_req_d1;
    ts_req_d3 <= ts_req_d2;
  end
end
reg [79:0] rtc_time_stamp;
always @(posedge rst or posedge rtc_timer_clk) begin
  if (rst)
    rtc_time_stamp <= 80'd0;
  else 
    if (ts_req_d2 & !ts_req_d3)
      rtc_time_stamp <= rtc_timer_in;
end
reg ts_ack, ts_ack_clr;
always @(posedge ts_ack_clr or posedge rtc_timer_clk) begin
  if (ts_ack_clr)
    ts_ack <= 1'b0;
  else
    if (ts_req_d2 & !ts_req_d3)
      ts_ack <= 1'b1;
end

reg ts_ack_d1, ts_ack_d2, ts_ack_d3;
always @(posedge rst or posedge gmii_clk) begin
  if (rst) begin
    ts_ack_d1 <= 1'b0;
    ts_ack_d2 <= 1'b0;
    ts_ack_d3 <= 1'b0;
  end
  else begin
    ts_ack_d1 <= ts_ack;
    ts_ack_d2 <= ts_ack_d1;
    ts_ack_d3 <= ts_ack_d2;
  end
end
reg [79:0] gmii_time_stamp;
always @(posedge rst or posedge gmii_clk) begin
  if (rst) begin
    gmii_time_stamp <= 80'd0;
    ts_ack_clr      <= 1'b0;
  end
  else begin
    if (ts_ack_d2 & !ts_ack_d3) begin
      gmii_time_stamp <= rtc_time_stamp;
      ts_ack_clr      <= 1'b1;
    end
    else begin
      gmii_time_stamp <= gmii_time_stamp;
      ts_ack_clr      <= 1'b0;
    end
  end
end

// 8b-32b datapath gearbox
reg        int_valid;
reg        int_sop, int_eop;
reg [ 1:0] int_bcnt, int_mod;
reg [31:0] int_data;
always @(posedge rst or posedge gmii_clk) begin
  if (rst)
    int_bcnt <= 2'd0;
  else
    if (int_gmii_ctrl_d1 | (int_bcnt!=2'd0))
      int_bcnt <= int_bcnt + 2'd1;
    else
      int_bcnt <= 2'd0;
end
always @(posedge rst or posedge gmii_clk) begin
  if (rst) begin
    int_data  <= 32'd0;
    int_valid <=  1'b0;
    int_mod   <=  2'd0;
  end
  else begin
    if (int_gmii_ctrl_d1) begin
      int_data[ 7: 0] <= (int_bcnt==2'd3)? int_gmii_data_d1:int_data[ 7: 0];
      int_data[15: 8] <= (int_bcnt==2'd2)? int_gmii_data_d1:int_data[15: 8];
      int_data[23:16] <= (int_bcnt==2'd1)? int_gmii_data_d1:int_data[23:16];
      int_data[31:24] <= (int_bcnt==2'd0)? int_gmii_data_d1:int_data[31:24];
    end

    if (int_bcnt==2'd3)
      int_valid <= 1'b1;
    else
      int_valid <= 1'b0;

    if (int_gmii_ctrl_d1 & !int_gmii_ctrl_d2)
      int_mod <= 2'd0;
    else if (!int_gmii_ctrl_d1 & int_gmii_ctrl_d2)
      int_mod <= int_bcnt;

    if (int_gmii_ctrl & !int_gmii_ctrl_d5 & int_bcnt==2'd3)
      int_sop <= 1'b1;
    else
      int_sop <= 1'b0;

    if (!int_gmii_ctrl & int_bcnt==2'd3)
      int_eop <= 1'b1;
    else
      int_eop <= 1'b0;

  end
end

// ptp packet parser here
// works at 1/4 gmii_clk frequency, needs multicycle timing constraint
wire        ptp_found;
wire [91:0] ptp_infor;
ptp_parser parser(
  .clk(gmii_clk),
  .rst(rst),
  .ptp_data(int_data),
  .ptp_valid(int_valid),
  .ptp_sop(int_sop),
  .ptp_eop(int_eop),
  .ptp_mod(int_mod),
  .ptp_time(gmii_time_stamp),
  .ptp_found(ptp_found),
  .ptp_infor(ptp_infor)
);

// ptp time stamp dcfifo
wire q_wr_clk = gmii_clk;
wire q_wr_en = ptp_found;
wire [95:0] q_wr_data = {4'd0, ptp_infor};
wire [2:0] q_wrusedw;
wire [2:0] q_rdusedw;

ptp_queue queue(
  .aclr(q_rst),

  .wrclk(q_wr_clk),
  .wrreq(q_wr_en && q_wrusedw<=5),
  .data(q_wr_data),
  .wrusedw(q_wrusedw),

  .rdclk(q_rd_clk),
  .rdreq(q_rd_en && q_rdusedw>=1),
  .q(q_rd_data),
  .rdusedw(q_rdusedw)
);

assign q_rd_stat = {5'd0, q_rdusedw};

endmodule
