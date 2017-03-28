`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:43:47 05/26/2016
// Design Name:   vga
// Module Name:   C:/Users/152/Desktop/project/vga_tb.v
// Project Name:  project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vga_tb;

	// Inputs
	reg clk;

	// Outputs
	wire vga_h_sync;
	wire vga_v_sync;
	wire [2:0] vga_R;
	wire [2:0] vga_G;
	wire [1:0] vga_B;

	// Instantiate the Unit Under Test (UUT)
	vga uut (
		.clk(clk), 
		.vga_h_sync(vga_h_sync), 
		.vga_v_sync(vga_v_sync), 
		.vga_R(vga_R), 
		.vga_G(vga_G), 
		.vga_B(vga_B)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
        
		// Add stimulus here

	end
	
	always
	#2 clk = ~clk;
      
endmodule

