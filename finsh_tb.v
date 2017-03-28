`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:12:47 06/08/2016
// Design Name:   finish
// Module Name:   D:/Downloads/152A/project/finsh_tb.v
// Project Name:  project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: finish
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module finsh_tb;

	// Inputs
	reg [41:0] encoding;
	reg [5:0] pos;

	// Outputs
	wire done;

	// Instantiate the Unit Under Test (UUT)
	finish uut (
		.encoding(encoding), 
		.pos(pos), 
		.done(done)
	);

	initial begin
		// Initialize Inputs
		encoding = 0;
		pos = 0;

//    #5
//		encoding = 42'b1111;
//		pos = 0;
//		
//		#5
//		encoding = 42'b1110;
//		pos = 0;
//		
//		#5
//		encoding = 42'b1100;
//		pos = 0;
//		
//		#5
//		encoding = 42'b0000111_0000000_0000000_0000000_0000000_0000000;
//		pos = 38;
		
		#10
		encoding = 42'b1000000010000000100000001;
		pos = 0;
		
		#10
		encoding = 42'b100000001000000010000001;
		pos = 0;
		
		#10
		encoding = 42'b1111;
		pos = 0;
		
		#10
		encoding = 42'b11101;
		pos = 0;
		
		#10
		encoding = 42'b1000000100000010000001;
		pos = 0;
		
		#10
		encoding = 42'b10000001000000100000001;
		pos = 0;

	end
      
endmodule

