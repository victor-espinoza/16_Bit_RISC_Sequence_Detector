`timescale 1ps / 100fs
//////////////////////////////////////////////////////////////////////////////////
// 
// Author:           Victor Espinoza
// Email:            victor.alfonso94@gmail.com
// Create Date:      09:36:49 09/23/2013 
// Module Name:      sequence_detector_tb 
// File Name:        sequence_detector_tb.v
//
// Description:      This module creates a test bench to test a case of a 
//                   sequence to make sure that the sequence detector outputs
//                   a 1 whenever it detects the 101101 sequence. Depending on 
//                   whether M=0 (moore) or M=1 (mealy), the test bench executes
//                   the appropriate Moore or Mealy implementation for the 101101
//                   sequence.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module sequence_detector_tb();

//Inputs
   reg         clk, reset, X, M;

   //Outputs
   wire          Z;
   wire [2:0]  Q;

   //Local Declarations
   reg [44:1]  sequence_pattern;
   integer     i;
   
   //Instansiate the Unite Under Test (uut)
   sequence_detector uut (
    .clk(clk), .reset(reset), 
    .X(X),       .M(M),
    .Z(Z),      .Q(Q));
    
    //Generate 10 ps Clock
    always 
      #5 clk = ~clk;

    //Initialize Block for sequece of "test vectors," applied every clock cycle.
      
    initial begin
      $timeformat(-12, 1, " ps", 8);
      clk = 0; reset = 0; X = 0; M = 0;
      sequence_pattern = 44'b01100010101101011011111001011011011011101010;
      @(negedge clk)
         reset = 1;
      @(negedge clk)
         reset = 0;
         M=1;         //Meally implementation (M=0); to simulate the Moore
                      //implementation, set M = 1 and run the simulation again

      //this loop will "feed" the sequence detector with the 
      //test sequence patter from MSB to LSB
      for (i=44; i > 0; i=i-1) begin
         //change inputs on negative edge of clock
         @(negedge clk)
            X = sequence_pattern[i];
         //display outputs after the positive clock
         @(posedge clk)
            #1 $display("Time=%t X=%b Q=%b Z=%b", $time, X, Q, Z);
      end //end for-loop
      $stop;
    end //end of initial block

endmodule
