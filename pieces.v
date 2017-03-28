`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    07:00:09 06/08/2016 
// Design Name: 
// Module Name:    pieces 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module pieces(encoding, PixelX, PixelY, display);

	input [41:0] encoding;
	input [9:0] PixelX;
	input [9:0] PixelY;
	output display;
	reg [5:0] coordinate;
	
	always @* begin
		coordinate <= ((PixelX-145) / 50) + 7 * ((PixelY-90) / 50);
	end

	assign display = encoding[coordinate];

endmodule
