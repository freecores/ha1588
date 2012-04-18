//--------------------------------------------------------------------------
// master_bfm_tb.v 
// This test bench instantiates a master BFM and an onchip RAM
// as the slave DUT. The test starts with master BFM writing an
// amount of data to the slave according to the number of
// transactions which is defined by user.
//
// Next, master BFM starts reading back the data from slave.
// The read back data is compared with the desired data .
//
// The test case is defined in the test_input.v file while the
// result checking rountine is defined in test_result.v file
//--------------------------------------------------------------------------

// console messaging level
`define VERBOSITY VERBOSITY_INFO

//BFM hierachy
`define MSTR_BFM tb.DUT.the_master_bfm.master_bfm

//test bench parameters
`define NUM_TRANS 5  //user-defined number of transactions to be performed
`define INDEX_ZERO 0  //burst cycle with index zero for non-bursting transactions

// BFM related parameters
`define AV_ADDRESS_W 16
`define AV_SYMBOL_W 8
`define AV_NUMSYMBOLS 4

// derived parameters
`define AV_DATA_W (`AV_SYMBOL_W * `AV_NUMSYMBOLS)


//-----------------------------------------------------------------------------
// Test Top Level begins here
//-----------------------------------------------------------------------------
module master_bfm_tb();

  //importing verbosity and avalon_mm packages
  import verbosity_pkg::*;
  import avalon_mm_pkg::*;
  
  // instantiate SOPC system module
  test_bench tb();  
   
  //local variables   
  Request_t command_request, response_request;
  reg [`AV_ADDRESS_W-1:0] command_addr, response_addr;
  reg [`AV_DATA_W-1:0] command_data, response_data;
  reg [`AV_NUMSYMBOLS-1:0] byte_enable;
  reg [`AV_DATA_W-1:0] idle;  
  integer init_latency;
  reg [`AV_DATA_W-1:0] master_scoreboard [$];
  reg [`AV_DATA_W-1:0] expected_data;    
  integer failure = 0;
  integer checked = 0;
  event start_test;
  event go_check;
  
  //initialize the master BFM
  initial
  begin
    set_verbosity(`VERBOSITY);
    `MSTR_BFM.init();	
	//wait for reset to de-assert and trigger start_test event
    wait(`MSTR_BFM.reset == 0);
	-> start_test;
  end
    
  //check responses received by master BFM
  always @(posedge tb.clk_0)
  begin    
    while (`MSTR_BFM.get_response_queue_size() > 0)
	begin	     
	  //pop out the response desriptor from queue when queue is not empty
	  master_pop_and_get_response(response_request, response_addr, response_data);
	  //trigger event to check the response with expected data
	  -> go_check;
	end
  end
  
  //simulation ends here
  //both write and read transactions do have response descriptors, so the number 
  //of responses received by master BFM is double of NUM_TRANS
  initial
  begin
    while (checked != (`NUM_TRANS*2))
	  @(tb.clk_0);
	//we care only the result for read transactions
	$sformat(message, "%m: Test has completed. %0d pass, %0d fail", ((checked / 2) - failure), failure);
	print(VERBOSITY_INFO, message);
	$stop;
  end
    
  `include "test_input.v"
  `include "test_result.v"
  
  //----------------------------------------------------------------------------------
  // tasks
  //----------------------------------------------------------------------------------
  
  //this task sets the command descriptor for master BFM and push it to the queue
  task master_set_and_push_command;
  input Request_t request;
  input [`AV_ADDRESS_W-1:0] addr;
  input [`AV_DATA_W-1:0] data;
  input [`AV_NUMSYMBOLS-1:0] byte_enable;
  input [`AV_DATA_W-1:0] idle;
  input [31:0] init_latency;
    
  begin
	`MSTR_BFM.set_command_request(request);
    `MSTR_BFM.set_command_address(addr);    
    `MSTR_BFM.set_command_byte_enable(byte_enable,`INDEX_ZERO);
    `MSTR_BFM.set_command_idle(idle, `INDEX_ZERO);
	`MSTR_BFM.set_command_init_latency(init_latency);
	
	if (request == REQ_WRITE)
	begin
	   `MSTR_BFM.set_command_data(data, `INDEX_ZERO);      
	end
		
	`MSTR_BFM.push_command();
  end
  endtask
  
  //this task pops the response received by master BFM from queue
  task master_pop_and_get_response;
  output Request_t request;
  output [`AV_ADDRESS_W-1:0] addr;
  output [`AV_DATA_W-1:0] data;
    
  begin
    `MSTR_BFM.pop_response();
	request = Request_t' (`MSTR_BFM.get_response_request());
	addr = `MSTR_BFM.get_response_address();
    data = `MSTR_BFM.get_response_data(`INDEX_ZERO);	
  end
  endtask

endmodule
