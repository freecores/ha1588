`timescale 1ns/1ns

module ptp_parser (
  input        clk, rst,
  input [31:0] int_data,
  input        int_valid,
  input        int_sop,
  input        int_eop,
  input [ 1:0] int_mod,
  input [31:0] sop_time,

  output reg        ptp_found,
  output reg [51:0] ptp_infor
);

reg [31:0] int_data_d1;
reg        int_valid_d1;
reg        int_sop_d1;
reg        int_eop_d1;
reg [ 1:0] int_mod_d1;
always @(posedge rst or posedge clk) begin
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

reg [ 9:0] int_cnt, bypass_ipv4_cnt, bypass_ipv6_cnt, bypass_udp_cnt, ptp_cnt;
reg bypass_vlan, ptp_l2, bypass_ipv4, bypass_ipv6, found_udp, bypass_udp, ptp_l4, ptp_event;
reg [ 3:0] ptp_msgid;
reg [15:0] ptp_seqid;
always @(posedge rst or posedge clk) begin
  if (rst) begin
    int_cnt <= 10'd0;
    bypass_ipv4_cnt <= 10'd0;
    bypass_udp_cnt <= 10'd0;
  end
  else begin
    if (int_valid_d1 && int_sop_d1)
      int_cnt <= 10'd0;
    else if (int_valid_d1)
      int_cnt <= int_cnt + 10'd1 - bypass_vlan - (bypass_ipv4 || bypass_udp);

    if (int_valid_d1 && int_sop_d1)
      bypass_ipv4_cnt <= 10'd0;
    else if (int_valid_d1 && bypass_ipv4)
      bypass_ipv4_cnt <= bypass_ipv4_cnt + 10'd1;

    if (int_valid_d1 && int_sop_d1)
      bypass_udp_cnt <= 10'd0;
    else if (int_valid_d1 && bypass_udp)
      bypass_udp_cnt <= bypass_udp_cnt + 10'd1;
  end
end

always @(posedge rst or posedge clk) begin
  if (rst) begin
    bypass_vlan  <= 1'b0;
    bypass_ipv4  <= 1'b0;
    found_udp    <= 1'b0;
    bypass_udp   <= 1'b0;
    ptp_l2    <= 1'b0;
    ptp_l4    <= 1'b0;
    ptp_event <= 1'b0;
  end
  else if (int_valid_d1 && int_sop_d1) begin
    bypass_vlan  <= 1'b0;
    bypass_ipv4  <= 1'b0;
    found_udp    <= 1'b0;
    bypass_udp   <= 1'b0;
    ptp_l2    <= 1'b0;
    ptp_l4    <= 1'b0;
    ptp_event <= 1'b0;
  end
  else begin
    // bypass vlan
    // ether_type == cvlan
    if (int_valid_d1 && int_cnt==10'd3 && int_data_d1[31:16]==16'h8100)
      bypass_vlan <= 1'b1;
    else
      bypass_vlan <= 1'b0;
    // ether_type == svlan
    // TO BE ADDED HERE

    // bypass ipv4
    // ether_type == ip, ip_version == 4
    if      (int_valid_d1 && int_cnt==10'd3 && bypass_ipv4_cnt==10'd0 &&
             int_data_d1[31:16]==16'h0800 && int_data_d1[15:12]==4'h4)
      bypass_ipv4 <= 1'b1;
    else if (int_valid_d1 && bypass_ipv4_cnt==10'd4)
      bypass_ipv4 <= 1'b0;

    // bypass ipv6
    // ether_type == ip, ip_version == 6
    // TO BE ADDED HERE

    // check if it is UDP
    // ipv4_protocol == udp
    if      (int_valid_d1 && bypass_ipv4_cnt==10'd1 && int_data_d1[ 7: 0]== 8'h11)
      found_udp <= 1'b1;
    // ipv6_protocol == udp
    // TO BE ADDED HERE

    // bypass udp
    // ipv4_udp
    if      (int_valid_d1 && bypass_ipv4_cnt==10'd4 && bypass_udp_cnt==10'd0 && found_udp)
      bypass_udp <= 1'b1;
    else if (int_valid_d1 && bypass_udp_cnt==10'd2)
      bypass_udp <= 1'b0;
    // ipv6_udp
    // TO BE ADDED HERE

    // check if it is L2 PTP
    // ether_type == ptp
    if (int_valid_d1 && int_cnt==10'd3 && int_data_d1[31:16]==16'h88F7)
      ptp_l2 <= 1'b1;
    // check if it is L4 PTP
    // ipv4_udp_dest_port == ptp_event
    if (int_valid_d1 && bypass_udp_cnt==10'd0 && bypass_udp && int_data_d1[31:16]==16'h013f)
      ptp_l4 <= 1'b1;
    // ipv6_udp_dest_port == ptp_event
    // TO BE ADDED HERE

    // check if it is PTP Event message
    if      (int_valid_d1 && int_cnt==10'd3 && int_data_d1[31:16]==16'h88F7    && (int_data_d1[11: 8]== 4'h0 || int_data_d1[11:8]==4'h2))
      // ptp_message_id == sync || delay_req
      ptp_event <= 1'b1;
    else if (int_valid_d1 && int_cnt==10'd4 && bypass_udp_cnt==10'd1 && ptp_l4 && (int_data_d1[11: 8]== 4'h0 || int_data_d1[11:8]==4'h2))
      // ptp_message_id == sync || delay_req
      ptp_event <= 1'b1;
  end
end

always @(posedge rst or posedge clk) begin
  if (rst) begin
    ptp_msgid <= 4'd0;
    ptp_seqid <= 16'd0;
  end
  else if (int_valid_d1 && int_sop_d1) begin
    ptp_msgid <= 4'd0;
    ptp_seqid <= 16'd0;
  end
  else begin
    // get PTP identification information as additional information to Timestamp
    // message id
    if      (int_valid_d1 && int_cnt==10'd3 && int_data_d1[31:16]==16'h88F7)
      ptp_msgid <=   int_data_d1[11: 8];
    else if (int_valid_d1 && int_cnt==10'd4 && bypass_udp_cnt==10'd1 && ptp_l4)
      ptp_msgid <=   int_data_d1[11: 8];
    // sequence id
    if      (int_valid_d1 && int_cnt==10'd11 && ptp_l2)
      ptp_seqid <=   int_data_d1[31:16];
    else if (int_valid_d1 && int_cnt==10'd10 && ptp_l4)
      ptp_seqid <=   int_data_d1[31:16];
  end
end

always @(posedge rst or posedge clk) begin
  if (rst) begin
    ptp_found <=  1'b0;
    ptp_infor <= 52'd0;
  end
  else if (int_valid_d1 && int_sop_d1) begin
    ptp_found <=  1'b0;
    ptp_infor <= 52'd0;
  end
  else if (int_valid_d1 && int_eop_d1) begin
    ptp_found <=  ptp_event;
    ptp_infor <= {ptp_seqid, ptp_msgid, sop_time};  // 16+4+32
  end
  else begin
    ptp_found <=  1'b0;
    ptp_infor <= 52'd0;
  end
end

endmodule
