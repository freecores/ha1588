//megafunction wizard: %Altera SOPC Builder%
//GENERATION: STANDARD
//VERSION: WM1.0


//Legal Notice: (C)2012 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module ha1588_comp_avalon_slave_arbitrator (
                                             // inputs:
                                              clk,
                                              ha1588_comp_avalon_slave_readdata,
                                              master_bfm_latency_counter,
                                              master_bfm_m0_address_to_slave,
                                              master_bfm_m0_read,
                                              master_bfm_m0_write,
                                              master_bfm_m0_writedata,
                                              reset_n,

                                             // outputs:
                                              d1_ha1588_comp_avalon_slave_end_xfer,
                                              ha1588_comp_avalon_slave_address,
                                              ha1588_comp_avalon_slave_read,
                                              ha1588_comp_avalon_slave_readdata_from_sa,
                                              ha1588_comp_avalon_slave_reset,
                                              ha1588_comp_avalon_slave_write,
                                              ha1588_comp_avalon_slave_writedata,
                                              master_bfm_granted_ha1588_comp_avalon_slave,
                                              master_bfm_qualified_request_ha1588_comp_avalon_slave,
                                              master_bfm_read_data_valid_ha1588_comp_avalon_slave,
                                              master_bfm_requests_ha1588_comp_avalon_slave
                                           )
;

  output           d1_ha1588_comp_avalon_slave_end_xfer;
  output  [  7: 0] ha1588_comp_avalon_slave_address;
  output           ha1588_comp_avalon_slave_read;
  output  [ 31: 0] ha1588_comp_avalon_slave_readdata_from_sa;
  output           ha1588_comp_avalon_slave_reset;
  output           ha1588_comp_avalon_slave_write;
  output  [ 31: 0] ha1588_comp_avalon_slave_writedata;
  output           master_bfm_granted_ha1588_comp_avalon_slave;
  output           master_bfm_qualified_request_ha1588_comp_avalon_slave;
  output           master_bfm_read_data_valid_ha1588_comp_avalon_slave;
  output           master_bfm_requests_ha1588_comp_avalon_slave;
  input            clk;
  input   [ 31: 0] ha1588_comp_avalon_slave_readdata;
  input            master_bfm_latency_counter;
  input   [ 15: 0] master_bfm_m0_address_to_slave;
  input            master_bfm_m0_read;
  input            master_bfm_m0_write;
  input   [ 31: 0] master_bfm_m0_writedata;
  input            reset_n;

  reg              d1_ha1588_comp_avalon_slave_end_xfer;
  reg              d1_reasons_to_wait;
  reg              enable_nonzero_assertions;
  wire             end_xfer_arb_share_counter_term_ha1588_comp_avalon_slave;
  wire    [  7: 0] ha1588_comp_avalon_slave_address;
  wire             ha1588_comp_avalon_slave_allgrants;
  wire             ha1588_comp_avalon_slave_allow_new_arb_cycle;
  wire             ha1588_comp_avalon_slave_any_bursting_master_saved_grant;
  wire             ha1588_comp_avalon_slave_any_continuerequest;
  wire             ha1588_comp_avalon_slave_arb_counter_enable;
  reg              ha1588_comp_avalon_slave_arb_share_counter;
  wire             ha1588_comp_avalon_slave_arb_share_counter_next_value;
  wire             ha1588_comp_avalon_slave_arb_share_set_values;
  wire             ha1588_comp_avalon_slave_beginbursttransfer_internal;
  wire             ha1588_comp_avalon_slave_begins_xfer;
  wire             ha1588_comp_avalon_slave_end_xfer;
  wire             ha1588_comp_avalon_slave_firsttransfer;
  wire             ha1588_comp_avalon_slave_grant_vector;
  wire             ha1588_comp_avalon_slave_in_a_read_cycle;
  wire             ha1588_comp_avalon_slave_in_a_write_cycle;
  wire             ha1588_comp_avalon_slave_master_qreq_vector;
  wire             ha1588_comp_avalon_slave_non_bursting_master_requests;
  wire             ha1588_comp_avalon_slave_read;
  wire    [ 31: 0] ha1588_comp_avalon_slave_readdata_from_sa;
  reg              ha1588_comp_avalon_slave_reg_firsttransfer;
  wire             ha1588_comp_avalon_slave_reset;
  reg              ha1588_comp_avalon_slave_slavearbiterlockenable;
  wire             ha1588_comp_avalon_slave_slavearbiterlockenable2;
  wire             ha1588_comp_avalon_slave_unreg_firsttransfer;
  wire             ha1588_comp_avalon_slave_waits_for_read;
  wire             ha1588_comp_avalon_slave_waits_for_write;
  wire             ha1588_comp_avalon_slave_write;
  wire    [ 31: 0] ha1588_comp_avalon_slave_writedata;
  wire             in_a_read_cycle;
  wire             in_a_write_cycle;
  wire             master_bfm_granted_ha1588_comp_avalon_slave;
  wire             master_bfm_m0_arbiterlock;
  wire             master_bfm_m0_arbiterlock2;
  wire             master_bfm_m0_continuerequest;
  wire             master_bfm_qualified_request_ha1588_comp_avalon_slave;
  wire             master_bfm_read_data_valid_ha1588_comp_avalon_slave;
  wire             master_bfm_requests_ha1588_comp_avalon_slave;
  wire             master_bfm_saved_grant_ha1588_comp_avalon_slave;
  wire    [ 15: 0] shifted_address_to_ha1588_comp_avalon_slave_from_master_bfm_m0;
  wire             wait_for_ha1588_comp_avalon_slave_counter;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_reasons_to_wait <= 0;
      else 
        d1_reasons_to_wait <= ~ha1588_comp_avalon_slave_end_xfer;
    end


  assign ha1588_comp_avalon_slave_begins_xfer = ~d1_reasons_to_wait & ((master_bfm_qualified_request_ha1588_comp_avalon_slave));
  //assign ha1588_comp_avalon_slave_readdata_from_sa = ha1588_comp_avalon_slave_readdata so that symbol knows where to group signals which may go to master only, which is an e_assign
  assign ha1588_comp_avalon_slave_readdata_from_sa = ha1588_comp_avalon_slave_readdata;

  assign master_bfm_requests_ha1588_comp_avalon_slave = ({master_bfm_m0_address_to_slave[15 : 10] , 10'b0} == 16'h0) & (master_bfm_m0_read | master_bfm_m0_write);
  //ha1588_comp_avalon_slave_arb_share_counter set values, which is an e_mux
  assign ha1588_comp_avalon_slave_arb_share_set_values = 1;

  //ha1588_comp_avalon_slave_non_bursting_master_requests mux, which is an e_mux
  assign ha1588_comp_avalon_slave_non_bursting_master_requests = master_bfm_requests_ha1588_comp_avalon_slave;

  //ha1588_comp_avalon_slave_any_bursting_master_saved_grant mux, which is an e_mux
  assign ha1588_comp_avalon_slave_any_bursting_master_saved_grant = 0;

  //ha1588_comp_avalon_slave_arb_share_counter_next_value assignment, which is an e_assign
  assign ha1588_comp_avalon_slave_arb_share_counter_next_value = ha1588_comp_avalon_slave_firsttransfer ? (ha1588_comp_avalon_slave_arb_share_set_values - 1) : |ha1588_comp_avalon_slave_arb_share_counter ? (ha1588_comp_avalon_slave_arb_share_counter - 1) : 0;

  //ha1588_comp_avalon_slave_allgrants all slave grants, which is an e_mux
  assign ha1588_comp_avalon_slave_allgrants = |ha1588_comp_avalon_slave_grant_vector;

  //ha1588_comp_avalon_slave_end_xfer assignment, which is an e_assign
  assign ha1588_comp_avalon_slave_end_xfer = ~(ha1588_comp_avalon_slave_waits_for_read | ha1588_comp_avalon_slave_waits_for_write);

  //end_xfer_arb_share_counter_term_ha1588_comp_avalon_slave arb share counter enable term, which is an e_assign
  assign end_xfer_arb_share_counter_term_ha1588_comp_avalon_slave = ha1588_comp_avalon_slave_end_xfer & (~ha1588_comp_avalon_slave_any_bursting_master_saved_grant | in_a_read_cycle | in_a_write_cycle);

  //ha1588_comp_avalon_slave_arb_share_counter arbitration counter enable, which is an e_assign
  assign ha1588_comp_avalon_slave_arb_counter_enable = (end_xfer_arb_share_counter_term_ha1588_comp_avalon_slave & ha1588_comp_avalon_slave_allgrants) | (end_xfer_arb_share_counter_term_ha1588_comp_avalon_slave & ~ha1588_comp_avalon_slave_non_bursting_master_requests);

  //ha1588_comp_avalon_slave_arb_share_counter counter, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          ha1588_comp_avalon_slave_arb_share_counter <= 0;
      else if (ha1588_comp_avalon_slave_arb_counter_enable)
          ha1588_comp_avalon_slave_arb_share_counter <= ha1588_comp_avalon_slave_arb_share_counter_next_value;
    end


  //ha1588_comp_avalon_slave_slavearbiterlockenable slave enables arbiterlock, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          ha1588_comp_avalon_slave_slavearbiterlockenable <= 0;
      else if ((|ha1588_comp_avalon_slave_master_qreq_vector & end_xfer_arb_share_counter_term_ha1588_comp_avalon_slave) | (end_xfer_arb_share_counter_term_ha1588_comp_avalon_slave & ~ha1588_comp_avalon_slave_non_bursting_master_requests))
          ha1588_comp_avalon_slave_slavearbiterlockenable <= |ha1588_comp_avalon_slave_arb_share_counter_next_value;
    end


  //master_bfm/m0 ha1588_comp/avalon_slave arbiterlock, which is an e_assign
  assign master_bfm_m0_arbiterlock = ha1588_comp_avalon_slave_slavearbiterlockenable & master_bfm_m0_continuerequest;

  //ha1588_comp_avalon_slave_slavearbiterlockenable2 slave enables arbiterlock2, which is an e_assign
  assign ha1588_comp_avalon_slave_slavearbiterlockenable2 = |ha1588_comp_avalon_slave_arb_share_counter_next_value;

  //master_bfm/m0 ha1588_comp/avalon_slave arbiterlock2, which is an e_assign
  assign master_bfm_m0_arbiterlock2 = ha1588_comp_avalon_slave_slavearbiterlockenable2 & master_bfm_m0_continuerequest;

  //ha1588_comp_avalon_slave_any_continuerequest at least one master continues requesting, which is an e_assign
  assign ha1588_comp_avalon_slave_any_continuerequest = 1;

  //master_bfm_m0_continuerequest continued request, which is an e_assign
  assign master_bfm_m0_continuerequest = 1;

  assign master_bfm_qualified_request_ha1588_comp_avalon_slave = master_bfm_requests_ha1588_comp_avalon_slave & ~((master_bfm_m0_read & ((master_bfm_latency_counter != 0))));
  //local readdatavalid master_bfm_read_data_valid_ha1588_comp_avalon_slave, which is an e_mux
  assign master_bfm_read_data_valid_ha1588_comp_avalon_slave = master_bfm_granted_ha1588_comp_avalon_slave & master_bfm_m0_read & ~ha1588_comp_avalon_slave_waits_for_read;

  //ha1588_comp_avalon_slave_writedata mux, which is an e_mux
  assign ha1588_comp_avalon_slave_writedata = master_bfm_m0_writedata;

  //master is always granted when requested
  assign master_bfm_granted_ha1588_comp_avalon_slave = master_bfm_qualified_request_ha1588_comp_avalon_slave;

  //master_bfm/m0 saved-grant ha1588_comp/avalon_slave, which is an e_assign
  assign master_bfm_saved_grant_ha1588_comp_avalon_slave = master_bfm_requests_ha1588_comp_avalon_slave;

  //allow new arb cycle for ha1588_comp/avalon_slave, which is an e_assign
  assign ha1588_comp_avalon_slave_allow_new_arb_cycle = 1;

  //placeholder chosen master
  assign ha1588_comp_avalon_slave_grant_vector = 1;

  //placeholder vector of master qualified-requests
  assign ha1588_comp_avalon_slave_master_qreq_vector = 1;

  //~ha1588_comp_avalon_slave_reset assignment, which is an e_assign
  assign ha1588_comp_avalon_slave_reset = ~reset_n;

  //ha1588_comp_avalon_slave_firsttransfer first transaction, which is an e_assign
  assign ha1588_comp_avalon_slave_firsttransfer = ha1588_comp_avalon_slave_begins_xfer ? ha1588_comp_avalon_slave_unreg_firsttransfer : ha1588_comp_avalon_slave_reg_firsttransfer;

  //ha1588_comp_avalon_slave_unreg_firsttransfer first transaction, which is an e_assign
  assign ha1588_comp_avalon_slave_unreg_firsttransfer = ~(ha1588_comp_avalon_slave_slavearbiterlockenable & ha1588_comp_avalon_slave_any_continuerequest);

  //ha1588_comp_avalon_slave_reg_firsttransfer first transaction, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          ha1588_comp_avalon_slave_reg_firsttransfer <= 1'b1;
      else if (ha1588_comp_avalon_slave_begins_xfer)
          ha1588_comp_avalon_slave_reg_firsttransfer <= ha1588_comp_avalon_slave_unreg_firsttransfer;
    end


  //ha1588_comp_avalon_slave_beginbursttransfer_internal begin burst transfer, which is an e_assign
  assign ha1588_comp_avalon_slave_beginbursttransfer_internal = ha1588_comp_avalon_slave_begins_xfer;

  //ha1588_comp_avalon_slave_read assignment, which is an e_mux
  assign ha1588_comp_avalon_slave_read = master_bfm_granted_ha1588_comp_avalon_slave & master_bfm_m0_read;

  //ha1588_comp_avalon_slave_write assignment, which is an e_mux
  assign ha1588_comp_avalon_slave_write = master_bfm_granted_ha1588_comp_avalon_slave & master_bfm_m0_write;

  assign shifted_address_to_ha1588_comp_avalon_slave_from_master_bfm_m0 = master_bfm_m0_address_to_slave;
  //ha1588_comp_avalon_slave_address mux, which is an e_mux
  assign ha1588_comp_avalon_slave_address = shifted_address_to_ha1588_comp_avalon_slave_from_master_bfm_m0 >> 2;

  //d1_ha1588_comp_avalon_slave_end_xfer register, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          d1_ha1588_comp_avalon_slave_end_xfer <= 1;
      else 
        d1_ha1588_comp_avalon_slave_end_xfer <= ha1588_comp_avalon_slave_end_xfer;
    end


  //ha1588_comp_avalon_slave_waits_for_read in a cycle, which is an e_mux
  assign ha1588_comp_avalon_slave_waits_for_read = ha1588_comp_avalon_slave_in_a_read_cycle & ha1588_comp_avalon_slave_begins_xfer;

  //ha1588_comp_avalon_slave_in_a_read_cycle assignment, which is an e_assign
  assign ha1588_comp_avalon_slave_in_a_read_cycle = master_bfm_granted_ha1588_comp_avalon_slave & master_bfm_m0_read;

  //in_a_read_cycle assignment, which is an e_mux
  assign in_a_read_cycle = ha1588_comp_avalon_slave_in_a_read_cycle;

  //ha1588_comp_avalon_slave_waits_for_write in a cycle, which is an e_mux
  assign ha1588_comp_avalon_slave_waits_for_write = ha1588_comp_avalon_slave_in_a_write_cycle & 0;

  //ha1588_comp_avalon_slave_in_a_write_cycle assignment, which is an e_assign
  assign ha1588_comp_avalon_slave_in_a_write_cycle = master_bfm_granted_ha1588_comp_avalon_slave & master_bfm_m0_write;

  //in_a_write_cycle assignment, which is an e_mux
  assign in_a_write_cycle = ha1588_comp_avalon_slave_in_a_write_cycle;

  assign wait_for_ha1588_comp_avalon_slave_counter = 0;

//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //ha1588_comp/avalon_slave enable non-zero assertions, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          enable_nonzero_assertions <= 0;
      else 
        enable_nonzero_assertions <= 1'b1;
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module master_bfm_m0_arbitrator (
                                  // inputs:
                                   clk,
                                   d1_ha1588_comp_avalon_slave_end_xfer,
                                   ha1588_comp_avalon_slave_readdata_from_sa,
                                   master_bfm_granted_ha1588_comp_avalon_slave,
                                   master_bfm_m0_address,
                                   master_bfm_m0_read,
                                   master_bfm_m0_write,
                                   master_bfm_m0_writedata,
                                   master_bfm_qualified_request_ha1588_comp_avalon_slave,
                                   master_bfm_read_data_valid_ha1588_comp_avalon_slave,
                                   master_bfm_requests_ha1588_comp_avalon_slave,
                                   reset_n,

                                  // outputs:
                                   master_bfm_latency_counter,
                                   master_bfm_m0_address_to_slave,
                                   master_bfm_m0_readdata,
                                   master_bfm_m0_readdatavalid,
                                   master_bfm_m0_reset,
                                   master_bfm_m0_waitrequest
                                )
;

  output           master_bfm_latency_counter;
  output  [ 15: 0] master_bfm_m0_address_to_slave;
  output  [ 31: 0] master_bfm_m0_readdata;
  output           master_bfm_m0_readdatavalid;
  output           master_bfm_m0_reset;
  output           master_bfm_m0_waitrequest;
  input            clk;
  input            d1_ha1588_comp_avalon_slave_end_xfer;
  input   [ 31: 0] ha1588_comp_avalon_slave_readdata_from_sa;
  input            master_bfm_granted_ha1588_comp_avalon_slave;
  input   [ 15: 0] master_bfm_m0_address;
  input            master_bfm_m0_read;
  input            master_bfm_m0_write;
  input   [ 31: 0] master_bfm_m0_writedata;
  input            master_bfm_qualified_request_ha1588_comp_avalon_slave;
  input            master_bfm_read_data_valid_ha1588_comp_avalon_slave;
  input            master_bfm_requests_ha1588_comp_avalon_slave;
  input            reset_n;

  reg              active_and_waiting_last_time;
  wire             master_bfm_latency_counter;
  reg     [ 15: 0] master_bfm_m0_address_last_time;
  wire    [ 15: 0] master_bfm_m0_address_to_slave;
  reg              master_bfm_m0_read_last_time;
  wire    [ 31: 0] master_bfm_m0_readdata;
  wire             master_bfm_m0_readdatavalid;
  wire             master_bfm_m0_reset;
  wire             master_bfm_m0_run;
  wire             master_bfm_m0_waitrequest;
  reg              master_bfm_m0_write_last_time;
  reg     [ 31: 0] master_bfm_m0_writedata_last_time;
  wire             pre_flush_master_bfm_m0_readdatavalid;
  wire             r_0;
  //r_0 master_run cascaded wait assignment, which is an e_assign
  assign r_0 = 1 & (master_bfm_qualified_request_ha1588_comp_avalon_slave | ~master_bfm_requests_ha1588_comp_avalon_slave) & ((~master_bfm_qualified_request_ha1588_comp_avalon_slave | ~master_bfm_m0_read | (1 & ~d1_ha1588_comp_avalon_slave_end_xfer & master_bfm_m0_read))) & ((~master_bfm_qualified_request_ha1588_comp_avalon_slave | ~master_bfm_m0_write | (1 & master_bfm_m0_write)));

  //cascaded wait assignment, which is an e_assign
  assign master_bfm_m0_run = r_0;

  //optimize select-logic by passing only those address bits which matter.
  assign master_bfm_m0_address_to_slave = {6'b0,
    master_bfm_m0_address[9 : 0]};

  //latent slave read data valids which may be flushed, which is an e_mux
  assign pre_flush_master_bfm_m0_readdatavalid = 0;

  //latent slave read data valid which is not flushed, which is an e_mux
  assign master_bfm_m0_readdatavalid = 0 |
    pre_flush_master_bfm_m0_readdatavalid |
    master_bfm_read_data_valid_ha1588_comp_avalon_slave;

  //master_bfm/m0 readdata mux, which is an e_mux
  assign master_bfm_m0_readdata = ha1588_comp_avalon_slave_readdata_from_sa;

  //actual waitrequest port, which is an e_assign
  assign master_bfm_m0_waitrequest = ~master_bfm_m0_run;

  //latent max counter, which is an e_assign
  assign master_bfm_latency_counter = 0;

  //~master_bfm_m0_reset assignment, which is an e_assign
  assign master_bfm_m0_reset = ~reset_n;


//synthesis translate_off
//////////////// SIMULATION-ONLY CONTENTS
  //master_bfm_m0_address check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          master_bfm_m0_address_last_time <= 0;
      else 
        master_bfm_m0_address_last_time <= master_bfm_m0_address;
    end


  //master_bfm/m0 waited last time, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          active_and_waiting_last_time <= 0;
      else 
        active_and_waiting_last_time <= master_bfm_m0_waitrequest & (master_bfm_m0_read | master_bfm_m0_write);
    end


  //master_bfm_m0_address matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (master_bfm_m0_address != master_bfm_m0_address_last_time))
        begin
          $write("%0d ns: master_bfm_m0_address did not heed wait!!!", $time);
          $stop;
        end
    end


  //master_bfm_m0_read check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          master_bfm_m0_read_last_time <= 0;
      else 
        master_bfm_m0_read_last_time <= master_bfm_m0_read;
    end


  //master_bfm_m0_read matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (master_bfm_m0_read != master_bfm_m0_read_last_time))
        begin
          $write("%0d ns: master_bfm_m0_read did not heed wait!!!", $time);
          $stop;
        end
    end


  //master_bfm_m0_write check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          master_bfm_m0_write_last_time <= 0;
      else 
        master_bfm_m0_write_last_time <= master_bfm_m0_write;
    end


  //master_bfm_m0_write matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (master_bfm_m0_write != master_bfm_m0_write_last_time))
        begin
          $write("%0d ns: master_bfm_m0_write did not heed wait!!!", $time);
          $stop;
        end
    end


  //master_bfm_m0_writedata check against wait, which is an e_register
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          master_bfm_m0_writedata_last_time <= 0;
      else 
        master_bfm_m0_writedata_last_time <= master_bfm_m0_writedata;
    end


  //master_bfm_m0_writedata matches last port_name, which is an e_process
  always @(posedge clk)
    begin
      if (active_and_waiting_last_time & (master_bfm_m0_writedata != master_bfm_m0_writedata_last_time) & master_bfm_m0_write)
        begin
          $write("%0d ns: master_bfm_m0_writedata did not heed wait!!!", $time);
          $stop;
        end
    end



//////////////// END SIMULATION-ONLY CONTENTS

//synthesis translate_on

endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module ha1588_inst_reset_clk_0_domain_synch_module (
                                                     // inputs:
                                                      clk,
                                                      data_in,
                                                      reset_n,

                                                     // outputs:
                                                      data_out
                                                   )
;

  output           data_out;
  input            clk;
  input            data_in;
  input            reset_n;

  reg              data_in_d1 /* synthesis ALTERA_ATTRIBUTE = "{-from \"*\"} CUT=ON ; PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  reg              data_out /* synthesis ALTERA_ATTRIBUTE = "PRESERVE_REGISTER=ON ; SUPPRESS_DA_RULE_INTERNAL=R101"  */;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_in_d1 <= 0;
      else 
        data_in_d1 <= data_in;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_out <= 0;
      else 
        data_out <= data_in_d1;
    end



endmodule



// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

module ha1588_inst (
                     // 1) global signals:
                      clk_0,
                      reset_n,

                     // the_ha1588_comp
                      rtc_clk_to_the_ha1588_comp,
                      rtc_time_one_pps_from_the_ha1588_comp,
                      rtc_time_ptp_ns_from_the_ha1588_comp,
                      rtc_time_ptp_sec_from_the_ha1588_comp,
                      rx_giga_mode_to_the_ha1588_comp,
                      rx_gmii_clk_to_the_ha1588_comp,
                      rx_gmii_ctrl_to_the_ha1588_comp,
                      rx_gmii_data_to_the_ha1588_comp,
                      tx_giga_mode_to_the_ha1588_comp,
                      tx_gmii_clk_to_the_ha1588_comp,
                      tx_gmii_ctrl_to_the_ha1588_comp,
                      tx_gmii_data_to_the_ha1588_comp
                   )
;

  output           rtc_time_one_pps_from_the_ha1588_comp;
  output  [ 31: 0] rtc_time_ptp_ns_from_the_ha1588_comp;
  output  [ 47: 0] rtc_time_ptp_sec_from_the_ha1588_comp;
  input            clk_0;
  input            reset_n;
  input            rtc_clk_to_the_ha1588_comp;
  input            rx_giga_mode_to_the_ha1588_comp;
  input            rx_gmii_clk_to_the_ha1588_comp;
  input            rx_gmii_ctrl_to_the_ha1588_comp;
  input   [  7: 0] rx_gmii_data_to_the_ha1588_comp;
  input            tx_giga_mode_to_the_ha1588_comp;
  input            tx_gmii_clk_to_the_ha1588_comp;
  input            tx_gmii_ctrl_to_the_ha1588_comp;
  input   [  7: 0] tx_gmii_data_to_the_ha1588_comp;

  wire             clk_0_reset_n;
  wire             d1_ha1588_comp_avalon_slave_end_xfer;
  wire    [  7: 0] ha1588_comp_avalon_slave_address;
  wire             ha1588_comp_avalon_slave_read;
  wire    [ 31: 0] ha1588_comp_avalon_slave_readdata;
  wire    [ 31: 0] ha1588_comp_avalon_slave_readdata_from_sa;
  wire             ha1588_comp_avalon_slave_reset;
  wire             ha1588_comp_avalon_slave_write;
  wire    [ 31: 0] ha1588_comp_avalon_slave_writedata;
  wire             master_bfm_granted_ha1588_comp_avalon_slave;
  wire             master_bfm_latency_counter;
  wire    [ 15: 0] master_bfm_m0_address;
  wire    [ 15: 0] master_bfm_m0_address_to_slave;
  wire             master_bfm_m0_read;
  wire    [ 31: 0] master_bfm_m0_readdata;
  wire             master_bfm_m0_readdatavalid;
  wire             master_bfm_m0_reset;
  wire             master_bfm_m0_waitrequest;
  wire             master_bfm_m0_write;
  wire    [ 31: 0] master_bfm_m0_writedata;
  wire             master_bfm_qualified_request_ha1588_comp_avalon_slave;
  wire             master_bfm_read_data_valid_ha1588_comp_avalon_slave;
  wire             master_bfm_requests_ha1588_comp_avalon_slave;
  wire             reset_n_sources;
  wire             rtc_time_one_pps_from_the_ha1588_comp;
  wire    [ 31: 0] rtc_time_ptp_ns_from_the_ha1588_comp;
  wire    [ 47: 0] rtc_time_ptp_sec_from_the_ha1588_comp;
  ha1588_comp_avalon_slave_arbitrator the_ha1588_comp_avalon_slave
    (
      .clk                                                   (clk_0),
      .d1_ha1588_comp_avalon_slave_end_xfer                  (d1_ha1588_comp_avalon_slave_end_xfer),
      .ha1588_comp_avalon_slave_address                      (ha1588_comp_avalon_slave_address),
      .ha1588_comp_avalon_slave_read                         (ha1588_comp_avalon_slave_read),
      .ha1588_comp_avalon_slave_readdata                     (ha1588_comp_avalon_slave_readdata),
      .ha1588_comp_avalon_slave_readdata_from_sa             (ha1588_comp_avalon_slave_readdata_from_sa),
      .ha1588_comp_avalon_slave_reset                        (ha1588_comp_avalon_slave_reset),
      .ha1588_comp_avalon_slave_write                        (ha1588_comp_avalon_slave_write),
      .ha1588_comp_avalon_slave_writedata                    (ha1588_comp_avalon_slave_writedata),
      .master_bfm_granted_ha1588_comp_avalon_slave           (master_bfm_granted_ha1588_comp_avalon_slave),
      .master_bfm_latency_counter                            (master_bfm_latency_counter),
      .master_bfm_m0_address_to_slave                        (master_bfm_m0_address_to_slave),
      .master_bfm_m0_read                                    (master_bfm_m0_read),
      .master_bfm_m0_write                                   (master_bfm_m0_write),
      .master_bfm_m0_writedata                               (master_bfm_m0_writedata),
      .master_bfm_qualified_request_ha1588_comp_avalon_slave (master_bfm_qualified_request_ha1588_comp_avalon_slave),
      .master_bfm_read_data_valid_ha1588_comp_avalon_slave   (master_bfm_read_data_valid_ha1588_comp_avalon_slave),
      .master_bfm_requests_ha1588_comp_avalon_slave          (master_bfm_requests_ha1588_comp_avalon_slave),
      .reset_n                                               (clk_0_reset_n)
    );

  ha1588_comp the_ha1588_comp
    (
      .addr_in          (ha1588_comp_avalon_slave_address),
      .clk              (clk_0),
      .data_in          (ha1588_comp_avalon_slave_writedata),
      .data_out         (ha1588_comp_avalon_slave_readdata),
      .rd_in            (ha1588_comp_avalon_slave_read),
      .rst              (ha1588_comp_avalon_slave_reset),
      .rtc_clk          (rtc_clk_to_the_ha1588_comp),
      .rtc_time_one_pps (rtc_time_one_pps_from_the_ha1588_comp),
      .rtc_time_ptp_ns  (rtc_time_ptp_ns_from_the_ha1588_comp),
      .rtc_time_ptp_sec (rtc_time_ptp_sec_from_the_ha1588_comp),
      .rx_giga_mode     (rx_giga_mode_to_the_ha1588_comp),
      .rx_gmii_clk      (rx_gmii_clk_to_the_ha1588_comp),
      .rx_gmii_ctrl     (rx_gmii_ctrl_to_the_ha1588_comp),
      .rx_gmii_data     (rx_gmii_data_to_the_ha1588_comp),
      .tx_giga_mode     (tx_giga_mode_to_the_ha1588_comp),
      .tx_gmii_clk      (tx_gmii_clk_to_the_ha1588_comp),
      .tx_gmii_ctrl     (tx_gmii_ctrl_to_the_ha1588_comp),
      .tx_gmii_data     (tx_gmii_data_to_the_ha1588_comp),
      .wr_in            (ha1588_comp_avalon_slave_write)
    );

  master_bfm_m0_arbitrator the_master_bfm_m0
    (
      .clk                                                   (clk_0),
      .d1_ha1588_comp_avalon_slave_end_xfer                  (d1_ha1588_comp_avalon_slave_end_xfer),
      .ha1588_comp_avalon_slave_readdata_from_sa             (ha1588_comp_avalon_slave_readdata_from_sa),
      .master_bfm_granted_ha1588_comp_avalon_slave           (master_bfm_granted_ha1588_comp_avalon_slave),
      .master_bfm_latency_counter                            (master_bfm_latency_counter),
      .master_bfm_m0_address                                 (master_bfm_m0_address),
      .master_bfm_m0_address_to_slave                        (master_bfm_m0_address_to_slave),
      .master_bfm_m0_read                                    (master_bfm_m0_read),
      .master_bfm_m0_readdata                                (master_bfm_m0_readdata),
      .master_bfm_m0_readdatavalid                           (master_bfm_m0_readdatavalid),
      .master_bfm_m0_reset                                   (master_bfm_m0_reset),
      .master_bfm_m0_waitrequest                             (master_bfm_m0_waitrequest),
      .master_bfm_m0_write                                   (master_bfm_m0_write),
      .master_bfm_m0_writedata                               (master_bfm_m0_writedata),
      .master_bfm_qualified_request_ha1588_comp_avalon_slave (master_bfm_qualified_request_ha1588_comp_avalon_slave),
      .master_bfm_read_data_valid_ha1588_comp_avalon_slave   (master_bfm_read_data_valid_ha1588_comp_avalon_slave),
      .master_bfm_requests_ha1588_comp_avalon_slave          (master_bfm_requests_ha1588_comp_avalon_slave),
      .reset_n                                               (clk_0_reset_n)
    );

  master_bfm the_master_bfm
    (
      .avm_address       (master_bfm_m0_address),
      .avm_read          (master_bfm_m0_read),
      .avm_readdata      (master_bfm_m0_readdata),
      .avm_readdatavalid (master_bfm_m0_readdatavalid),
      .avm_waitrequest   (master_bfm_m0_waitrequest),
      .avm_write         (master_bfm_m0_write),
      .avm_writedata     (master_bfm_m0_writedata),
      .clk               (clk_0),
      .reset             (master_bfm_m0_reset)
    );

  //reset is asserted asynchronously and deasserted synchronously
  ha1588_inst_reset_clk_0_domain_synch_module ha1588_inst_reset_clk_0_domain_synch
    (
      .clk      (clk_0),
      .data_in  (1'b1),
      .data_out (clk_0_reset_n),
      .reset_n  (reset_n_sources)
    );

  //reset sources mux, which is an e_mux
  assign reset_n_sources = ~(~reset_n |
    0);


endmodule


//synthesis translate_off



// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE

// AND HERE WILL BE PRESERVED </ALTERA_NOTE>


// If user logic components use Altsync_Ram with convert_hex2ver.dll,
// set USE_convert_hex2ver in the user comments section above

// `ifdef USE_convert_hex2ver
// `else
// `define NO_PLI 1
// `endif

//`include "c:/altera/10.1/quartus/eda/sim_lib/altera_mf.v"
//`include "c:/altera/10.1/quartus/eda/sim_lib/220model.v"
//`include "c:/altera/10.1/quartus/eda/sim_lib/sgate.v"
// C:/altera/10.1/ip/altera/sopc_builder_ip/verification/lib/verbosity_pkg.sv
// C:/altera/10.1/ip/altera/sopc_builder_ip/verification/lib/avalon_mm_pkg.sv
// C:/altera/10.1/ip/altera/sopc_builder_ip/verification/altera_avalon_mm_master_bfm/altera_avalon_mm_master_bfm.sv

`include "../../rtl/sopc/master_bfm.v"
`include "../../rtl/top/ha1588.v"
`include "../../rtl/reg/reg.v"
`include "../../rtl/rtc/rtc.v"
`include "../../rtl/tsu/tsu.v"
`include "../../rtl/tsu/ptp_parser.v"
`include "../../rtl/tsu/ptp_queue.v"
`include "../../rtl/sopc/ha1588_comp.v"

`timescale 1ns / 1ps

module test_bench 
;


  wire             clk;
  reg              clk_0;
  reg              reset_n;
  wire             rtc_clk_to_the_ha1588_comp;
  wire             rtc_time_one_pps_from_the_ha1588_comp;
  wire    [ 31: 0] rtc_time_ptp_ns_from_the_ha1588_comp;
  wire    [ 47: 0] rtc_time_ptp_sec_from_the_ha1588_comp;
  wire             rx_giga_mode_to_the_ha1588_comp;
  wire             rx_gmii_clk_to_the_ha1588_comp;
  wire             rx_gmii_ctrl_to_the_ha1588_comp;
  wire    [  7: 0] rx_gmii_data_to_the_ha1588_comp;
  wire             tx_giga_mode_to_the_ha1588_comp;
  wire             tx_gmii_clk_to_the_ha1588_comp;
  wire             tx_gmii_ctrl_to_the_ha1588_comp;
  wire    [  7: 0] tx_gmii_data_to_the_ha1588_comp;


// <ALTERA_NOTE> CODE INSERTED BETWEEN HERE
//  add your signals and additional architecture here
// AND HERE WILL BE PRESERVED </ALTERA_NOTE>

  //Set us up the Dut
  ha1588_inst DUT
    (
      .clk_0                                 (clk_0),
      .reset_n                               (reset_n),
      .rtc_clk_to_the_ha1588_comp            (rtc_clk_to_the_ha1588_comp),
      .rtc_time_one_pps_from_the_ha1588_comp (rtc_time_one_pps_from_the_ha1588_comp),
      .rtc_time_ptp_ns_from_the_ha1588_comp  (rtc_time_ptp_ns_from_the_ha1588_comp),
      .rtc_time_ptp_sec_from_the_ha1588_comp (rtc_time_ptp_sec_from_the_ha1588_comp),
      .rx_giga_mode_to_the_ha1588_comp       (rx_giga_mode_to_the_ha1588_comp),
      .rx_gmii_clk_to_the_ha1588_comp        (rx_gmii_clk_to_the_ha1588_comp),
      .rx_gmii_ctrl_to_the_ha1588_comp       (rx_gmii_ctrl_to_the_ha1588_comp),
      .rx_gmii_data_to_the_ha1588_comp       (rx_gmii_data_to_the_ha1588_comp),
      .tx_giga_mode_to_the_ha1588_comp       (tx_giga_mode_to_the_ha1588_comp),
      .tx_gmii_clk_to_the_ha1588_comp        (tx_gmii_clk_to_the_ha1588_comp),
      .tx_gmii_ctrl_to_the_ha1588_comp       (tx_gmii_ctrl_to_the_ha1588_comp),
      .tx_gmii_data_to_the_ha1588_comp       (tx_gmii_data_to_the_ha1588_comp)
    );

  initial
    clk_0 = 1'b0;
  always
    #10 clk_0 <= ~clk_0;
  
  initial 
    begin
      reset_n <= 0;
      #200 reset_n <= 1;
    end

endmodule


//synthesis translate_on