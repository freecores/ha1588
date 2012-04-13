/*
 * tsu.v
 * 
 * Copyright (c) 2012, BABY&HW. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
 * MA 02110-1301  USA
 */

`timescale 1ns/1ns

module tsu (
    input       rst,

    input       gmii_clk,
    input       gmii_ctrl,
    input [7:0] gmii_data,
    
    input        rtc_timer_clk,
    input [79:0] rtc_timer_in,  // timeStamp1s_48bit + timeStamp1ns_32bit

    input         q_rst,
    input         q_rd_clk,
    input         q_rd_en,
    output [  7:0] q_rd_stat,
    output [127:0] q_rd_data  // null_16bit + timeStamp1s_48bit + timeStamp1ns_32bit + msgId_4bit + ckSum_12bit + seqId_16bit 
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
wire ts_req = int_gmii_ctrl;  // TODO: check frame start delimiter
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

reg [31:0] int_data_d1;
reg        int_valid_d1;
reg        int_sop_d1;
reg        int_eop_d1;
reg [ 1:0] int_mod_d1;
always @(posedge rst or posedge gmii_clk) begin
  if (rst) begin
    int_data_d1  <= 32'h00000000;
    int_valid_d1 <= 1'b0;
    int_sop_d1   <= 1'b0;
    int_eop_d1   <= 1'b0;
    int_mod_d1   <= 2'b00;
  end
  else begin
    if (int_valid) begin
      int_data_d1  <= int_data;
      int_mod_d1   <= int_mod;
    end
      int_valid_d1 <= int_valid;
      int_sop_d1   <= int_sop;
      int_eop_d1   <= int_eop;
  end
end

// ptp packet parser here
// works at 1/4 gmii_clk frequency, needs multicycle timing constraint
wire        ptp_found;
wire [31:0] ptp_infor;
ptp_parser parser(
  .clk(gmii_clk),
  .rst(rst),
  .int_data(int_data_d1),
  .int_valid(int_valid_d1),
  .int_sop(int_sop_d1),
  .int_eop(int_eop_d1),
  .int_mod(int_mod_d1),
  .ptp_found(ptp_found),
  .ptp_infor(ptp_infor)
);

// ptp time stamp dcfifo
wire q_wr_clk = gmii_clk;
wire q_wr_en = ptp_found && int_eop_d1;
wire [127:0] q_wr_data = {16'd0, gmii_time_stamp, ptp_infor};  // 16+80+32 bit
wire [3:0] q_wrusedw;
wire [3:0] q_rdusedw;

ptp_queue queue(
  .aclr(q_rst),

  .wrclk(q_wr_clk),
  .wrreq(q_wr_en && q_wrusedw<15),  // write with overflow protection
  .data(q_wr_data),
  .wrusedw(q_wrusedw),

  .rdclk(q_rd_clk),
  .rdreq(q_rd_en && q_rdusedw>0 ),  // read with underflow protection
  .q(q_rd_data),
  .rdusedw(q_rdusedw)
);

assign q_rd_stat = {4'd0, q_rdusedw};

endmodule
