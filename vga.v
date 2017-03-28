`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:23:46 05/26/2016 
// Design Name: 
// Module Name:    vga 
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
module vga(clk, reset, btnL, btnR, btnD, vga_h_sync, vga_v_sync, vga_R, vga_G, vga_B);
	input clk, reset, btnL, btnR, btnD;
	output vga_h_sync, vga_v_sync, vga_R, vga_G, vga_B;

	wire inDisplayArea;
	wire [9:0] PixelX;
	wire [9:0] PixelY;

	clock clkpx (.clk(clk), .freq(25000000), .clk_en(clk_px));
	
	hvsync_generator syncgen(.clk(clk_px), .vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), 
	.inDisplayArea(inDisplayArea), .CounterX(PixelX), .CounterY(PixelY));
	
	reg [41:0] red;
	reg [41:0] ylw;
	reg [3:0] col;
	reg [2:0] columnA;
	reg [2:0] columnB;
	reg [2:0] columnC;
	reg [2:0] columnD;
	reg [2:0] columnE;
	reg [2:0] columnF;
	reg [2:0] columnG;
	reg player;
	reg [5:0] coordinate;
	reg [5:0] prev_coordinate;
	reg [2:0] height;
	reg winner;
	reg rw;
	reg yw;
	initial begin
		red = 42'b0000111_0000000_0000000_0000000_0000000_0000000;
		ylw = 42'b0000000_0000111_0000000_0000000_0000000_0000000;
		col = 3;
		columnA = 2;
		columnB = 2;
		columnC = 2;
		columnD = 0;
		columnE = 0;
		columnF = 0;
		columnG = 0;
		player = 1;
		winner = 0;
		rw = 0;
		yw = 0;
	end
	pieces redpieces (.encoding(red), .PixelX(PixelX), .PixelY(PixelY), .display(rDisplay));
	pieces ylwpieces (.encoding(ylw), .PixelX(PixelX), .PixelY(PixelY), .display(yDisplay));
	finish rwins (.encoding(red), .pos(coordinate), .done(rFinish));
	finish ywins (.encoding(ylw), .pos(coordinate), .done(yFinish));
		
/////////////////////////////////////////////////////////////////
	
	reg [2:0] vga_R;
	reg [2:0] vga_G;
	reg [1:0] vga_B;
	always @(posedge clk) begin
		if(inDisplayArea) begin
			if (PixelX > 145 && PixelX < 495 && PixelY > 40 && PixelY < 90 &&
				(PixelX - 145 > col * 50) && (PixelX - 145 < (col+1) * 50)) begin
				if (player) begin
					vga_R = 3'b111;
					vga_G = 3'b000;
					vga_B = 2'b00;
				end
				else begin
					vga_R = 3'b111;
					vga_G = 3'b111;
					vga_B = 2'b00;
				end
			end
			else if (PixelX >= 145 && PixelX <= 495 && PixelY >= 90 && PixelY <= 390) begin
				if ((PixelX-45) % 50 == 0 || (PixelY-40) %50 == 0) begin
					// black border
					vga_R = 3'b000;
					vga_G = 3'b000;
					vga_B = 2'b00;
				end
				else if (rDisplay) begin
					// Red Pieces
					vga_R = 3'b111;
					vga_G = 3'b000;
					vga_B = 2'b00;
				end
				else if (yDisplay) begin
					// Yellow Pieces
					vga_R = 3'b111;
					vga_G = 3'b111;
					vga_B = 2'b00;
				end
				else begin
					// teal empty spaces
					vga_R = 3'b000;
					vga_G = 3'b111;
					vga_B = 2'b11;
				end
			end
			else begin
				if (PixelX > 545 && PixelX < 595 && PixelY > 340 && PixelY < 390)
					if (rw) begin
						vga_R = 3'b111;
						vga_G = 3'b000;
						vga_B = 2'b00;
					end
					else if (yw) begin
						vga_R = 3'b111;
						vga_G = 3'b111;
						vga_B = 2'b00;
					end
					else begin
						vga_R = 3'b000;
						vga_G = 3'b111;
						vga_B = 2'b00;
					end
				else begin
					// white background
					vga_R = 3'b111;
					vga_G = 3'b111;
					vga_B = 2'b11;
				end
			end
		end
		else begin
			vga_R = 3'b000;
			vga_G = 3'b000;
			vga_B = 2'b00;
		end
	end
	
	// ===========================================================================
   // 763Hz timing signal for clock enable
   // ===========================================================================
	wire [17:0] clk_dv_inc;
	reg [16:0]  clk_dv;
   reg         clk_en;
   reg         clk_en_d;
   assign clk_dv_inc = clk_dv + 1;
   
   always @ (posedge clk) begin
		clk_dv   <= clk_dv_inc[16:0];
		clk_en   <= clk_dv_inc[17];
		clk_en_d <= clk_en;
	end
	
	// ===========================================================================
   // Stepping Control
   // ===========================================================================

	reg [3:0]   step_reset;
	reg [3:0]	step_left;
	reg [3:0]	step_right;
	reg [3:0]	step_down;

   always @ (posedge clk)
		if (clk_en)
		begin
			step_reset[3:0]  <= {reset, step_reset[3:1]};
			step_left[3:0]  <= {btnL, step_left[3:1]};
			step_right[3:0]  <= {btnR, step_right[3:1]};
			step_down[3:0]  <= {btnD, step_down[3:1]};
		end

	always @ (posedge clk) begin
		// RESET
		if(~step_reset[0] & step_reset[1] & step_reset[2] & clk_en_d) begin
			red = 42'b0;
			ylw = 42'b0;
			col = 3;
			columnA = 0;
			columnB = 0;
			columnC = 0;
			columnD = 0;
			columnE = 0;
			columnF = 0;
			columnG = 0;
			player = 1;
			winner = 0;
			coordinate = 0;
			rw = 0;
			yw = 0;
		end
		// LEFT
		else if(~step_left[0] & step_left[1] & step_left[2] & clk_en_d) begin
			if (col == 0)
				col = 0;
			else
				col = col - 1;
		end
		// RIGHT
		else if(~step_right[0] & step_right[1] & step_right[2] & clk_en_d) begin
			if (col == 6)
				col = 6;
			else
				col = col + 1;
		end
		// DOWN
		else if(~step_down[0] & step_down[1] & step_down[2] & clk_en_d) begin
			case (col)
				0 : height = columnA;
				1 : height = columnB;
				2 : height = columnC;
				3 : height = columnD;
				4 : height = columnE;
				5 : height = columnF;
				6 : height = columnG;
				default : height = 0;
			endcase
			if (height == 6)
				;
			else begin
				coordinate = col + 7*(5-height);
				if (player) begin
					red[coordinate] = 1;
//					if (~winner && yFinish) begin
//						winner = 1;
//						rw = 1;
//					end
				end
				else begin
					ylw[coordinate] = 1;
//					if (~winner && rFinish) begin
//						winner = 1;
//						yw = 1;
//					end
				end
				player = ~player;
				case (col)
					0 : columnA = height + 1;
					1 : columnB = height + 1;
					2 : columnC = height + 1;
					3 : columnD = height + 1;
					4 : columnE = height + 1;
					5 : columnF = height + 1;
					6 : columnG = height + 1;
					default : ;
				endcase
			end
			if (~winner) 
				if(rFinish && player) begin
					rw = 1;
					winner =1;
				end
				else if (yFinish && ~player) begin
					yw = 1;
					winner =1;
				end
		end
//		if (~winner) 
//			if(rFinish && ~player) begin
//				rw = 1;
//				winner =1;
//			end
//			else if (yFinish && player) begin
//				yw = 1;
//				winner =1;
//			end
	end
	
endmodule
