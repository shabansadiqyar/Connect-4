`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:39:52 05/26/2016 
// Design Name: 
// Module Name:    clock 
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
module clock(clk, freq, clk_en);

	input clk;
	input [31:0] freq;
	output clk_en;
	
	reg clk_temp;
	reg [26:0] counter;
	reg [26:0]	cycles;
	
	assign clk_en = clk_temp;
		
	initial begin
		counter = 0;
		cycles = (100000000 / freq) - 1;
	end
	
	always @ (posedge clk) begin
		
		counter <= counter + 1;
		if (counter == cycles) begin
			clk_temp <= 1;
			counter <= 0;
		end
		else
			clk_temp <= 0;
		
	end

endmodule
