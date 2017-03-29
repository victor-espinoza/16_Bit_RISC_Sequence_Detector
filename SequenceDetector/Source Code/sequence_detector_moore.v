`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:00:44 09/22/2013 
// Design Name: 
// Module Name:    sequence_detector_moore 
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
module sequence_detector_moore(clk, reset, X, M, Z, Q);
	
	//Inputs
	input clk, reset, X, M;
	output Z;
	output [2:0] Q;
	
	wire 		moore_d0, moore_d1, moore_d2, Z;
	 
   //****************************************
	//  Moore Sequence Detector for 10011
	//****************************************
	
	//  ***** Next State Combinational Logic *****
	assign	moore_d0 =  ( ( (Q[2]) & (~Q[1]) & (~Q[0]) )  | 
							     ( (Q[1]) &  (Q[0]) & (X) ) );
	assign	moore_d1 =  ~Q[2]&Q[1]&~Q[0] + Q[2]&Q[0]&X + ~Q[2]&~Q[1]&Q[0]&~X;
	assign	moore_d2 =  Q[2]&~Q[1]&~Q[0] + Q[1]&Q[0]&X;
	
	//  ***** State Register Using D-FF instances *****
	dff	moore_q0 (clk, reset, moore_d0, Q[0]),
			moore_q1 (clk, reset, moore_d1, Q[1]),
			moore_q2 (clk, reset, moore_d2, Q[2]);
	
	//  ***** Output Combinational Logic 
	assign	Z =  Q[2]&Q[1]&~Q[0];

endmodule
