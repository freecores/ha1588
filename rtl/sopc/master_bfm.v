// master_bfm.v

// This file was auto-generated as part of a SOPC Builder generate operation.
// If you edit it your changes will probably be lost.
// 
// The HDL file this wrapper is instantiating was not analysed successfully.
// This can cause problems with the wrapper not matching the child module.
// Please check that your hw.tcl file includes the following two commands:
// `set_module_property TOP_LEVEL_HDL_FILE` and
// `set_module_property TOP_LEVEL_HDL_MODULE`
// Please also check that the HDL file does not contain syntax errors.

module master_bfm (
		input  wire        clk,               //       clk.clk
		input  wire        reset,             // clk_reset.reset
		output wire [15:0] avm_address,       //        m0.address
		input  wire [31:0] avm_readdata,      //          .readdata
		output wire [31:0] avm_writedata,     //          .writedata
		input  wire        avm_waitrequest,   //          .waitrequest
		output wire        avm_write,         //          .write
		output wire        avm_read,          //          .read
		input  wire        avm_readdatavalid  //          .readdatavalid
	);

	altera_avalon_mm_master_bfm #(
		.AV_ADDRESS_W               (16),
		.AV_SYMBOL_W                (8),
		.AV_NUMSYMBOLS              (4),
		.AV_BURSTCOUNT_W            (3),
		.AV_READRESPONSE_W          (8),
		.AV_WRITERESPONSE_W         (8),
		.USE_READ                   (1),
		.USE_WRITE                  (1),
		.USE_ADDRESS                (1),
		.USE_BYTE_ENABLE            (0),
		.USE_BURSTCOUNT             (0),
		.USE_READ_DATA              (1),
		.USE_READ_DATA_VALID        (1),
		.USE_WRITE_DATA             (1),
		.USE_BEGIN_TRANSFER         (0),
		.USE_BEGIN_BURST_TRANSFER   (0),
		.USE_WAIT_REQUEST           (1),
		.USE_TRANSACTIONID          (0),
		.USE_WRITERESPONSE          (0),
		.USE_READRESPONSE           (0),
		.USE_CLKEN                  (0),
		.AV_BURST_LINEWRAP          (0),
		.AV_BURST_BNDR_ONLY         (0),
		.AV_MAX_PENDING_READS       (1),
		.AV_FIX_READ_LATENCY        (0),
		.AV_READ_WAIT_TIME          (0),
		.AV_WRITE_WAIT_TIME         (0),
		.REGISTER_WAITREQUEST       (0),
		.AV_REGISTERINCOMINGSIGNALS (0)
	) master_bfm (
		.clk                      (clk),               //       clk.clk
		.reset                    (reset),             // clk_reset.reset
		.avm_address              (avm_address),       //        m0.address
		.avm_readdata             (avm_readdata),      //          .readdata
		.avm_writedata            (avm_writedata),     //          .writedata
		.avm_waitrequest          (avm_waitrequest),   //          .waitrequest
		.avm_write                (avm_write),         //          .write
		.avm_read                 (avm_read),          //          .read
		.avm_readdatavalid        (avm_readdatavalid), //          .readdatavalid
		.avm_burstcount           (),                  // (terminated)
		.avm_begintransfer        (),                  // (terminated)
		.avm_beginbursttransfer   (),                  // (terminated)
		.avm_byteenable           (),                  // (terminated)
		.avm_arbiterlock          (),                  // (terminated)
		.avm_debugaccess          (),                  // (terminated)
		.avm_transactionid        (),                  // (terminated)
		.avm_readresponse         (8'b00000000),       // (terminated)
		.avm_readid               (8'b00000000),       // (terminated)
		.avm_writeresponserequest (),                  // (terminated)
		.avm_writeresponse        (8'b00000000),       // (terminated)
		.avm_writeresponsevalid   (1'b0),              // (terminated)
		.avm_writeid              (8'b00000000),       // (terminated)
		.avm_clken                ()                   // (terminated)
	);

endmodule
