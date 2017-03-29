`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Author:         Victor Espinoza
// Email:          victor.alfonso94@gmail.com
// Create Date:    14:51:24 09/22/2013  
// Module Name:    debounce 
// File Name:      debounce.v
//
// Description:    This debounce module is used to provide the clock input to the 
//                 sequence detector.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module debounce(D_in, clk_in, reset, D_out);

   input  D_in, clk_in, reset;
   output D_out;
   wire   D_out;

   // The following template provides a one-shot pulse
   // from a non-clock input (D_in)
   //      input D_in clk_in, reset;
   //      output D_out;
   //      wire D_out;
 
   reg q9, q8, q7, q6, q5, q4, q3, q2, q1, q0;

   always @ (posedge clk_in or posedge reset)
      if (reset == 1'b1)
         {q9, q8, q7, q6, q5, q4, q3, q2, q1, q0} <= 10'b0;
      else begin
         //shift the new sample that's on the D_in input
         q9 <= q8; q8 <= q7; q7 <= q6; q6 <= q5; q5 <= q4; 
         q4 <= q3; q3 <= q2; q2 <= q1; q1 <= q0; q0 <= D_in;
      end 
      
   // create the debounced, one-shot output pulse
   assign D_out = !q9 & q8 & q7 & q6 & q5 & 
                   q4 & q3 & q2 & q1 & q0;
      
endmodule