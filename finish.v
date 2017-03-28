`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:30:13 06/08/2016 
// Design Name: 
// Module Name:    finish 
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
module finish(encoding, pos, done);
	
	input [41:0] encoding;
	input [5:0] pos;
	output reg done;
	
	always @* begin
		// Horizontal
		if (encoding[pos+1] && encoding[pos+2] && encoding[pos+3] && (pos%7 < 4))
			done <= 1;
		else if (encoding[pos-1] && encoding[pos+1] && encoding[pos+2] && (pos%7 < 5) && (pos%7 > 0))
			done <= 1;
		else if (encoding[pos-2] && encoding[pos-1] && encoding[pos+1] && (pos%7 < 6) && (pos%7 > 1))
			done <= 1;
		else if (encoding[pos-3] && encoding[pos-2] && encoding[pos-1] && (pos%7 > 2))
			done <= 1;
		// Veritical
		else if (encoding[pos+7] && encoding[pos+14] && encoding[pos+21] && (pos < 21))
			done <= 1;
//		else if (encoding[pos-7] && encoding[pos+7] && encoding[pos+14] && (pos < 28) && (pos > 6))
//			done <= 1;
//		else if (encoding[pos-14] && encoding[pos-7] && encoding[pos+7] && (pos < 35) && (pos > 13))
//			done <= 1;
//		else if (encoding[pos-21] && encoding[pos-14] && encoding[pos-7] && (pos > 20))
//			done <= 1;
		// Diagonal \
		else if (encoding[pos+8] && encoding[pos+16] && encoding[pos+24] && (pos%7 < 4) && (pos < 21))
			done <= 1;
		else if (encoding[pos-8] && encoding[pos+8] && encoding[pos+16] && (pos%7 < 5) && (pos%7 > 0) && (pos < 28) && (pos > 6))
			done <= 1;
		else if (encoding[pos-16] && encoding[pos-8] && encoding[pos+8] && (pos%7 < 6) && (pos%7 > 1) && (pos < 35) && (pos > 13))
			done <= 1;
		else if (encoding[pos-24] && encoding[pos-16] && encoding[pos-8] && (pos%7 > 2) && (pos > 20))
			done <= 1;
		// Diagonal /
		else if (encoding[pos+6] && encoding[pos+12] && encoding[pos+18] && (pos%7 > 2) && (pos < 21))
			done <= 1;
		else if (encoding[pos-6] && encoding[pos+6] && encoding[pos+12] && (pos%7 > 1) && (pos%7 < 6) && (pos < 28) && (pos > 6))
			done <= 1;
		else if (encoding[pos-12] && encoding[pos-6] && encoding[pos+6] && (pos%7 > 0) && (pos%7 < 5) && (pos < 35) && (pos > 13))
			done <= 1;
		else if (encoding[pos-18] && encoding[pos-12] && encoding[pos-6] && (pos%7 < 4) && (pos > 20))
			done <= 1;
//		// Diagonal Right
//		else if (((pos/8) < 4) && (pos < 25))
//			if (encoding[pos+8] && encoding[pos+16] && encoding[pos+24])
//				done <= 1;
//		else if (encoding[pos-8] && encoding[pos+8] && encoding[pos+16] && ((pos/8) < 5) && ((pos/7) > 0) && (pos < 29) && (pos > 7))
//			done <= 1;
//		else if (encoding[pos-16] && encoding[pos-8] && encoding[pos+8] && ((pos/8) < 6) && ((pos/8) > 1) && (pos < 36) && (pos > 15))
//			done <= 1;
//		else if (encoding[pos-24] && encoding[pos-16] && encoding[pos-8] && ((pos/8) > 2) && (pos > 23))
//			done <= 1;
//		// Diagonal Left
//		else if (encoding[pos+6] && encoding[pos+12] && encoding[pos+18] && (pos%6 > 2) && (pos < 25))
//			done <= 1;
//		else if (encoding[pos-6] && encoding[pos+6] && encoding[pos+12] && (pos%6 > 1) && (pos%6 < 6) && (pos < 31) && (pos > 11))
//			done <= 1;
//		else if (encoding[pos-12] && encoding[pos-6] && encoding[pos+6] && (pos%6 > 0) && (pos%6 < 5) && (pos < 37) && (pos > 17))
//			done <= 1;
//		else if (encoding[pos-18] && encoding[pos-12] && encoding[pos-6] && (pos%6 < 4) && (pos > 23))
//			done <= 1;
		// No solution
		else 
			done <= 0;
	end

endmodule
