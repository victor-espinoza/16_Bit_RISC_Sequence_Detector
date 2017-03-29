`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Author:          Victor Espinoza
// Email:           victor.alfonso94@gmail.com
// Create Date:     16:43:09 09/22/2013 
// Module Name:     top_level 
// File Name:       top_level.v
//                   
// Description:     This top level module is used to pull together all of the other
//                  modules that we created into one place in order to produce
//                  a sequence detector that outputs a 1 when the sequence 101101
//                  is detected.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module top_level(clk, reset, M, X, step, Z,  Q);

   input clk, reset, M, X, step;
   output Z;
   output [2:0] Q;
   wire   one_shot, clk_to_sd;
   
      
   clk_50MHz u1(clk, reset, one_shot);
	
   debounce u2(step, one_shot, reset, clk_to_sd);
	
   sequence_detector u3(clk_to_sd, reset, M, X, Z, Q);

endmodule
