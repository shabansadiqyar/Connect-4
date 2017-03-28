`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   07:15:18 06/08/2016
// Design Name:   redpieces
// Module Name:   D:/Downloads/152A/project/redpieces_tb.v
// Project Name:  project
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: redpieces
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module redpieces_tb;

	// Inputs
	reg [41:0] encoding;
	reg [9:0] PixelX;
	reg [9:0] PixelY;

	// Outputs
	wire display;
	

	// Instantiate the Unit Under Test (UUT)
	pieces uut (
		.encoding(encoding), 
		.PixelX(PixelX), 
		.PixelY(PixelY), 
		.display(display)
	);

	initial begin
		// Initialize Inputs
		encoding = 42'b101;
		PixelX = 0;
		PixelY = 0;
		
		#5
		// 0
		PixelX = 150;
		PixelY = 100;
		
		#5
		// 1
		PixelX = 200;
		PixelY = 100;
		
		#5
		// 2
		PixelX = 250;
		PixelY = 100;
		
		#5
		// 8
		PixelX = 200;
		PixelY = 150;
		
		#5
		PixelX = 250;
		PixelY = 150;
		
		#5
		PixelX = 490;
		PixelY = 380;

	end
      
endmodule

