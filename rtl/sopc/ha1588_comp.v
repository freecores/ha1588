// ha1588_comp.v

// This file was auto-generated as part of a SOPC Builder generate operation.
// If you edit it your changes will probably be lost.

module ha1588_comp (
		input  wire        clk,              //        clock.clk
		input  wire        rst,              //  clock_reset.reset
		input  wire        wr_in,            // avalon_slave.write
		input  wire        rd_in,            //             .read
		input  wire [7:0]  addr_in,          //             .address
		input  wire [31:0] data_in,          //             .writedata
		output wire [31:0] data_out,         //             .readdata
		input  wire        rtc_clk,          //    ref_clock.export
		output wire [31:0] rtc_time_ptp_ns,  //             .export
		output wire [47:0] rtc_time_ptp_sec, //             .export
		input  wire        rx_gmii_clk,      // gmii_monitor.export
		input  wire        rx_gmii_ctrl,     //             .export
		input  wire [7:0]  rx_gmii_data,     //             .export
		input  wire        rx_giga_mode,     //             .export
		input  wire        tx_gmii_clk,      //             .export
		input  wire        tx_gmii_ctrl,     //             .export
		input  wire [7:0]  tx_gmii_data,     //             .export
		input  wire        tx_giga_mode      //             .export
	);

	ha1588 #(
		.addr_is_in_word (1)
	) ha1588_comp (
		.clk              (clk),              //        clock.clk
		.rst              (rst),              //  clock_reset.reset
		.wr_in            (wr_in),            // avalon_slave.write
		.rd_in            (rd_in),            //             .read
		.addr_in          (addr_in),          //             .address
		.data_in          (data_in),          //             .writedata
		.data_out         (data_out),         //             .readdata
		.rtc_clk          (rtc_clk),          //    ref_clock.export
		.rtc_time_ptp_ns  (rtc_time_ptp_ns),  //             .export
		.rtc_time_ptp_sec (rtc_time_ptp_sec), //             .export
		.rx_gmii_clk      (rx_gmii_clk),      // gmii_monitor.export
		.rx_gmii_ctrl     (rx_gmii_ctrl),     //             .export
		.rx_gmii_data     (rx_gmii_data),     //             .export
		.rx_giga_mode     (rx_giga_mode),     //             .export
		.tx_gmii_clk      (tx_gmii_clk),      //             .export
		.tx_gmii_ctrl     (tx_gmii_ctrl),     //             .export
		.tx_gmii_data     (tx_gmii_data),     //             .export
		.tx_giga_mode     (tx_giga_mode)      //             .export
	);

endmodule
