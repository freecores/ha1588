`timescale 1ns/1ns

module ptp_parser (
  input        clk, rst,
  input [31:0] ptp_data,
  input        ptp_valid,
  input        ptp_sop,
  input        ptp_eop,
  input [ 1:0] ptp_mod,
  input [29:0] ptp_time,

  output reg        ptp_found,
  output reg [41:0] ptp_infor
);

reg [31:0] ptp_data_d1;
reg        ptp_valid_d1;
reg        ptp_sop_d1;
reg        ptp_eop_d1;
reg [ 1:0] ptp_mod_d1;
always @(posedge rst or posedge clk) begin
  if (rst) begin
    ptp_data_d1  <= 32'h00000000;
    ptp_valid_d1 <= 1'b0;
    ptp_sop_d1   <= 1'b0;
    ptp_eop_d1   <= 1'b0;
    ptp_mod_d1   <= 2'b00;
  end
  else begin
    if (ptp_valid) begin
      ptp_data_d1  <= ptp_data;
      ptp_mod_d1   <= ptp_mod;
    end
      ptp_valid_d1 <= ptp_valid;
      ptp_sop_d1   <= ptp_sop;
      ptp_eop_d1   <= ptp_eop;
  end
end

reg [ 9:0] ptp_cnt;
reg ptp_vlan, ptp_ip, ptp_udp, ptp_port, ptp_event;
reg [ 3:0] ptp_msgid;
reg [15:0] ptp_seqid;
always @(posedge rst or posedge clk) begin
  if (rst)
    ptp_cnt <= 10'd0;
  else
    if (ptp_valid && ptp_sop)
      ptp_cnt <= 10'd0;
    else if (ptp_valid)
      ptp_cnt <= ptp_cnt + 10'd1 - ptp_vlan;
end

always @(posedge rst or posedge clk) begin
  if (rst) begin
    ptp_vlan  <= 1'b0;
    ptp_ip    <= 1'b0;
    ptp_udp   <= 1'b0;
    ptp_port  <= 1'b0;
    ptp_event <= 1'b0;
    ptp_msgid <= 4'd0;
    ptp_seqid <= 16'd0;
  end
  else if (ptp_valid_d1 && ptp_sop_d1) begin
    ptp_vlan  <= 1'b0;
    ptp_ip    <= 1'b0;
    ptp_udp   <= 1'b0;
    ptp_port  <= 1'b0;
    ptp_event <= 1'b0;
    ptp_msgid <= 4'd0;
    ptp_seqid <= 16'd0;
  end
  else begin
    if (ptp_valid_d1 && ptp_cnt==10'd4)  // ether_type == vlan
      ptp_vlan  <= ( ptp_data_d1[31:16]==16'h8100);
    else
      ptp_vlan  <= 1'b0;
    if (ptp_valid_d1 && ptp_cnt==10'd4)  // ether_type == ip
      ptp_ip    <= ( ptp_data_d1[31:16]==16'h0800);
    if (ptp_valid_d1 && ptp_cnt==10'd6)  // ip_type == udp
      ptp_udp   <= ( ptp_data_d1[ 7: 0]== 8'h11 && ptp_ip);
    if (ptp_valid_d1 && ptp_cnt==10'd10) // udp_dest_port == ptp_event
      ptp_port  <= ( ptp_data_d1[31:16]==16'h013f && ptp_udp);
    if (ptp_valid_d1 && ptp_cnt==10'd11) // ptp_message_id == sync || delay_req
      ptp_event <= ((ptp_data_d1[11: 8]== 4'h0 || ptp_data_d1[11:8]==4'h2) && ptp_port);

    if (ptp_valid_d1 && ptp_cnt==10'd11) // ptp_sequence_id
      ptp_msgid <=   ptp_data_d1[11: 8];
    if (ptp_valid_d1 && ptp_cnt==10'd19) // ptp_sequence_id
      ptp_seqid <=   ptp_data_d1[31:16];
  end
end

always @(posedge rst or posedge clk) begin
  if (rst) begin
    ptp_found <=  1'b0;
    ptp_infor <= 48'd0;
  end
  else if (ptp_valid_d1 && ptp_sop_d1) begin
    ptp_found <=  1'b0;
    ptp_infor <= 48'd0;
  end
  else if (ptp_valid_d1 && ptp_eop_d1) begin
    ptp_found <=  ptp_event;
    ptp_infor <= {ptp_seqid, ptp_msgid[1:0], ptp_time};
  end
  else begin
    ptp_found <=  1'b0;
    ptp_infor <= 48'd0;
  end
end

endmodule
