`timescale 1ns/1ns

module rtc (
  input rst, clk,
  // 1. direct time adjustment: ToD set up
  input time_ld,
  input [37:0] time_reg_ns_in,   // 37:8 ns, 7:0 ns_fraction
  input [47:0] time_reg_sec_in,  // 47:0 sec
  // 2. frequency adjustment: frequency set up for drift compensation
  input period_ld,
  input [39:0] period_in,        // 39:32 ns, 31:0 ns_fraction
  input [37:0] time_acc_modulo,  // 37: 8 ns,  7:0 ns_fraction
  // 3. precise time adjustment: small time difference adjustment with a time mark
  input adj_ld,
  input [31:0] adj_ld_data,
  input [39:0] period_adj,  // 39:32 ns, 31:0 ns_fraction

  // time output: for internal with ns fraction
  output [37:0] time_reg_ns,  // 37:8 ns, 7:0 ns_fraction
  output [47:0] time_reg_sec, // 47:0 sec
  // time output: for external with ptp standard
  output [31:0] time_ptp_ns,  // 31:0 ns
  output [47:0] time_ptp_sec  // 47:0 sec
);

reg  [39:0] period_fix;  // 39:32 ns, 31:0 ns_fraction
reg  [31:0] adj_cnt;
reg  [39:0] time_adj;    // 39:32 ns, 31:0 ns_fraction
// frequency and small time difference adjustment registers
always @(posedge rst or posedge clk) begin
  if (rst) begin
    period_fix <= period_fix;  //40'd0;
    adj_cnt    <= 32'hffffffff;
    time_adj   <= time_adj;    //40'd0;
  end
  else begin
    if (period_ld)  // load period adjustment
      period_fix <= period_in;
    else
      period_fix <= period_fix;

    if (adj_ld)  // load precise time adjustment time mark
      adj_cnt  <= adj_ld_data;
    else if (adj_cnt==32'hffffffff)
      adj_cnt  <= adj_cnt;  // no cycling
    else
      adj_cnt  <= adj_cnt - 1;  // counting down

    if (adj_cnt==0)  // change period temparorily
      time_adj <= period_fix + period_adj;
    else
      time_adj <= period_fix + 0;
  end
end

reg  [39:0] time_adj_08n_32f;  // 39:32 ns, 31:0 ns_fraction
wire [15:0] time_adj_08n_08f;  // 15: 8 ns,  7:0 ns_fraction
reg  [23:0] time_adj_00n_24f;  //           23:0 ns_fraction
// delta-sigma circuit to keep the lower 24bit of time_adj
always @(posedge rst or posedge clk) begin
  if (rst) begin
    time_adj_08n_32f <= 40'd0;
    time_adj_00n_24f <= 24'd0;
  end
  else begin
    time_adj_08n_32f <= time_adj[39: 0] + {16'd0, time_adj_00n_24f};  // add the delta
    time_adj_00n_24f <= time_adj_08n_32f[23: 0];                      // save the delta
  end
end
assign time_adj_08n_08f = time_adj_08n_32f[39:24];  // output w/o the delta

reg  [37:0] time_acc_30n_08f;  // 37:8 ns , 7:0 ns_fraction
reg  [47:0] time_acc_48s;      // 47:0 sec
reg         time_acc_48s_inc;
// time accumulator (48bit_s + 30bit_ns + 8bit_ns_fraction)
always @(posedge rst or posedge clk) begin
  if (rst) begin
    time_acc_30n_08f <= 38'd0;
    time_acc_48s     <= 48'd0;
    time_acc_48s_inc <=  1'b0;
  end
  else begin
    if (time_ld) begin  // direct write
      time_acc_30n_08f <= time_reg_ns_in;
      time_acc_48s     <= time_reg_sec_in;
    end
    else begin

      if (time_acc_30n_08f + {22'd0, time_adj_08n_08f} >= time_acc_modulo)
        time_acc_30n_08f <= time_acc_30n_08f + {22'd0, time_adj_08n_08f} - time_acc_modulo;
      else
        time_acc_30n_08f <= time_acc_30n_08f + {22'd0, time_adj_08n_08f};

      if (time_acc_48s_inc)
        time_acc_48s_inc <= 1'b0;
      else if (time_acc_modulo == 38'd0)
        time_acc_48s_inc <= 1'b0;
      else if (time_acc_30n_08f + {22'd0, time_adj_08n_08f} + {22'd0, time_adj_08n_08f} >= time_acc_modulo)
        time_acc_48s_inc <= 1'b1;
      else
        time_acc_48s_inc <= 1'b0;

      if (time_acc_48s_inc)
        time_acc_48s     <= time_acc_48s + 1;
      else
        time_acc_48s     <= time_acc_48s;

    end
  end
end

// time output (48bit_s + 30bit_ns + 8bit_ns_fraction)
assign time_reg_ns  = time_acc_30n_08f;
assign time_reg_sec = time_acc_48s;
// time output (48bit_s + 32bit_ns)
assign time_ptp_ns  = {2'b00, time_acc_30n_08f[37:8]};
assign time_ptp_sec = time_acc_48s;

endmodule
