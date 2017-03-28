`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:30:26 05/26/2016 
// Design Name: 
// Module Name:    hvsync_generator 
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
module hvsync_generator(clk, vga_h_sync, vga_v_sync, inDisplayArea, CounterX, CounterY);
input clk;
output vga_h_sync, vga_v_sync;
output reg inDisplayArea;
output [9:0] CounterX;
output [9:0] CounterY;

//////////////////////////////////////////////////
reg [9:0] CountX;
reg [9:0] CountY;

//assign CounterX = CountX;
//assign CounterY = CountY;
assign CounterX = PixelX;
assign CounterY = PixelY;

initial begin
	CountX = 0;
	CountY = 0;
end

parameter CountXmaxed = 799; // horizontal pixels per line	800-1
parameter CountYmaxed = 524; // vertical lines per frame		525-1
parameter hpulse = 96; 	// hsync pulse length
parameter vpulse = 2; 	// vsync pulse length
parameter hbp = 144; 	// end of horizontal back porch		96+40+8
parameter hfp = 784; 	// beginning of horizontal front porch	144+640
parameter vbp = 35; 		// end of vertical back porch			2+25+8
parameter vfp = 515; 	// beginning of vertical front porch	35+480
// active horizontal video is therefore: 784 - 144 = 640

always @(posedge clk)
	if(CountX < CountXmaxed)
		CountX <= CountX + 1;
	else 	
	begin
		CountX <= 0;
		if (CountY < CountYmaxed)
			CountY <= CountY + 1;
		else
			CountY <= 0;
	end

assign vga_h_sync = (CountX < hpulse) ? 0:1;
assign vga_v_sync = (CountY < vpulse) ? 0:1;

reg [9:0] PixelX;
reg [9:0] PixelY;
always @(posedge clk)
	if(CountX >= hbp && CountX < hfp && CountY >= vbp && CountY < vfp) begin
		inDisplayArea <= 1;
		PixelX <= CountX - hbp;
		PixelY <= CountY - vbp;
	end
	else begin
		inDisplayArea <= 0;
		PixelX <= 0;
		PixelY <= 0;
	end

endmodule

