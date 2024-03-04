`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:11:26 11/01/2023 
// Design Name: 
// Module Name:    GRF 
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
module GRF(
	input [31:0] pc,
	input [4:0] a1,
	input [4:0] a2,
	input [4:0] a3,
	input [31:0] wd,
	input we,
	input reset,
	input clk,
	output [31:0] rd1,
	output [31:0] rd2
    );
	reg [31:0] grf[31:0];
	integer i;
	initial begin
		for (i = 0; i < 32; i = i + 1) begin
			grf[i] = 0;
		end
	end
	assign rd1 = (a1 == 0) ? 0 : grf[a1];
	assign rd2 = (a2 == 0) ? 0 : grf[a2];
	always @(posedge clk) begin
		if (reset) begin
			for (i = 0; i < 32; i = i + 1) begin
				grf[i] <= 0;
			end
		end
		else begin
			if (we) begin
				grf[a3] <= wd;
				if (a3) begin
					$display("%d@%h: $%d <= %h", $time, pc, a3, wd);
				end
			end
		end
	end
	
endmodule
