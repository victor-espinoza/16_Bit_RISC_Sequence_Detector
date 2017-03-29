`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// 
// Author:          Victor Espinoza
// Email:           victor.alfonso94@gmail.com
// Create Date:     15:13:32 09/22/2013 
// Module Name:     dff 
// File Name:       dff.v
//                  
// Description:     This D flip flop module is used to store the data that was 
//                  passed on from the assign statements in order to figure out
//                  the appropriate values of Q[2:0]. It will either store 
//                  the values for Moore_Q or Mealy_Q, depending on whether 
//                  M=0 or M=1.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module dff(clk, reset, d, q);

   input     clk, reset, d;
   output    q;
   reg       q;
   
   always @ (posedge clk, posedge reset)
      if (reset==1)      
         q <= 1'b0;
      else
         q <= d;

endmodule
