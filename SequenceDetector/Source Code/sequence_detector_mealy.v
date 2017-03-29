`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:02:44 09/22/2013 
// Design Name: 
// Module Name:    sequence_detector_mealy 
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
module sequence_detector_mealy(clk, reset, X, M, Z, Q);

	//Inputs
	input clk, reset, X, M;
	output Z;
	output [2:0] Q;
	
	wire		mealy_d0, mealy_d1, mealy_d2, Z;
	 
	//****************************************
	//  Mealy Sequence Detector for 10011
	//****************************************

	//  ***** Next State Combinational Logic *****
	
	assign	mealy_d0 =  ((~Q[0]&X) + (~Q[2]&~Q[1]&X) + (Q[2]&~Q[1]&~Q[0]) + (Q[2]&~Q[1]&X));
	assign	mealy_d1 =  ((Q[1]&~Q[0]&X) + (~Q[2]&Q[0]&~X));
	assign	mealy_d2 =  ((Q[2]&~Q[0]&~X) + (Q[1]&Q[0]&X));
	
	//  ***** State Register Using D-FF instances *****
	
	dff	mealy_q0 (clk, reset, mealy_d0, Q[0]),
			mealy_q1 (clk, reset, mealy_d1, Q[1]),
			mealy_q2 (clk, reset, mealy_d2, Q[2]);

	//  ***** Output Combinational Logic *****
	assign	Z =  (Q[2]&Q[0]&X);

endmodule
