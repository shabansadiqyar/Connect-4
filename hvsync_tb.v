`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:28:29 05/31/2016
// Design Name:   hvsync_generator
// Module Name:   C:/Users/152/Downloads/project/hvsync_tb.v
// Project Name:  project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: hvsync_generator
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module hvsync_tb;

	// Inputs
	reg clk;

	// Outputs
	wire vga_h_sync;
	wire vga_v_sync;
	wire inDisplayArea;
	wire [9:0] CounterX;
	wire [9:0] CounterY;

	// Instantiate the Unit Under Test (UUT)
	hvsync_generator uut (
		.clk(clk), 
		.vga_h_sync(vga_h_sync), 
		.vga_v_sync(vga_v_sync), 
		.inDisplayArea(inDisplayArea), 
		.CounterX(CounterX), 
		.CounterY(CounterY)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
	end
	
	always
	#2 clk = ~clk;
      
endmodule

