`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////// 
//
// Author:         Victor Espinoza
// Email:          victor.alfonso94@gmail.com
// Create Date:    14:50:04 09/22/2013  
// Module Name:    clk_50MHz 
// File Name:      clk_50MHz.v
//                 
// Description:    This clock module is used to "clock" the debounce circuit with
//                 a 500Hz clock. This module divides our clock by the number
//                 specified in our if condition. In order to obtain this value, 
//                 we had to divide our Incoming frequency by our Outgoing frequency
//                 Once we obtained this number, we had to divide by 2 in order
//                 to get the appropriate counter number.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clk_50MHz(clk_in, reset, clk_out);

   input    clk_in, reset;
   output    clk_out;
   reg      clk_out;
   integer  i;
   
   //***************************************************************
   //The following verilog code will "divide" an incoming clock 
   //by the 32-bit decimal value specified in the "if condition"
   //
   //The value of the counter that counts the incoming clock ticks
   //is equal to [ (Incoming Frequency / Outgoing Freq) /2 ]
   //***************************************************************

   always @(posedge clk_in or posedge reset) begin
      if (reset == 1'b1) begin
         i = 0;
         clk_out = 0;
      end//if
      // got a clock, so increment the counter and
      // test to see if half a period has elapsed
      else begin
         i = i + 1;
         if (i >=  50000)  begin 
            clk_out = ~clk_out;
            i = 0;
         end //if
      end //else
   
   end//always
   
endmodule
