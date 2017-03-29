`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
//
// Author:          Victor Espinoza
// Email:           victor.alfonso94@gmail.com
// Create Date:     23:02:03 09/22/2013  
// Module Name:     sequence_detector 
// File Name:       sequence_detector.v
//                   
// Description:     This sequence dector module determines the moore and mealy 
//                  state and output equations for the sequence 101101. It 
//                  determines the state of Q by using these equations and also
//                  determines the output Z based on those states. Depending on
//                  whether M=0 or M=1, the appropriate moore or mealy detector 
//                  executes. If the sequence is not followed correctly, then 
//                  Q goes to the appropriate state and continues through the 
//                  sequence pattern until a 101101 appears, in which case the
//                  Z output will become a 1. 
//
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module sequence_detector(clk, reset, M, X, Z, Q);

   //Inputs
   input    clk, reset, M, X;
   output    Z;
   output    [2:0] Q;
   wire       [2:0] Moore_Q;
   wire       [2:0] Mealy_Q;
   wire       moore_d0, moore_d1, moore_d2, Moore_Z;
   wire      mealy_d0, mealy_d1, mealy_d2, Mealy_Z;
   
   //2-to-1 mux to choose Moore/Mealy Q's and Moore/Mealy Z for global outputs
   //if M==1, then {Q,Z} = {Moore_Q, moore_Z} else {Q,Z} = {Mealy_Q, maely_Z}
   
   assign {Q,Z} = (M) ? {Moore_Q, Moore_Z} : {Mealy_Q, Mealy_Z};
   
   //****************************************
   //  Moore Sequence Detector for 10011
   //****************************************
   
   //  ***** Next State Combinational Logic *****
   assign   moore_d0 =  ( (  (Moore_Q[2]) &  (~Moore_Q[1]) & (~Moore_Q[0]) ) | 
                          ( (~Moore_Q[2]) &  (~Moore_Q[1]) &  (X) ) |
                          ( (~Moore_Q[0]) &   (X) ) );

   assign   moore_d1 =  ( ( (~Moore_Q[2]) &   (Moore_Q[1]) & (~Moore_Q[0]) &  (X) ) | 
                          (  (Moore_Q[2]) &   (Moore_Q[0]) &  (X) ) | 
                          ( (~Moore_Q[2]) &   (Moore_Q[0]) & (~X) ) );
                          
   assign   moore_d2 =  ( (  (Moore_Q[2]) &  (~Moore_Q[1]) & (~Moore_Q[0]) & (~X) ) | 
                          (  (Moore_Q[1]) &   (Moore_Q[0]) &  (X) ) | 
                          (  (Moore_Q[2]) &   (Moore_Q[0]) &  (X) ) );
   
   //  ***** State Register Using D-FF instances *****
   dff   moore_q0 (clk, reset, moore_d0, Moore_Q[0]),
         moore_q1 (clk, reset, moore_d1, Moore_Q[1]),
         moore_q2 (clk, reset, moore_d2, Moore_Q[2]);
   
   //  ***** Output Combinational Logic 
   assign   Moore_Z =      ( (Moore_Q[2]) &   (Moore_Q[1]) & (~Moore_Q[0]) );
   
    
   //****************************************
   //  Mealy Sequence Detector for 10011
   //****************************************

   //  ***** Next State Combinational Logic *****
   
   assign   mealy_d0 =  ( ( (~Mealy_Q[0]) &  (X) ) | 
                          (  (Mealy_Q[2]) & (~Mealy_Q[1]) & (~Mealy_Q[0]) ) | 
                          ( (~Mealy_Q[2]) & (~Mealy_Q[1]) &  (X) ) );
                          
   assign   mealy_d1 =  ( (  (Mealy_Q[1]) & (~Mealy_Q[0]) &  (X) ) | 
                          ( (~Mealy_Q[2]) &  (Mealy_Q[0]) & (~X) ) );
                          
   assign   mealy_d2 =  ( (  (Mealy_Q[2]) & (~Mealy_Q[0]) & (~X) ) | 
                          (  (Mealy_Q[1]) &  (Mealy_Q[0]) &  (X) ) );
   
   //  ***** State Register Using D-FF instances *****
   
   dff   mealy_q0 (clk, reset, mealy_d0, Mealy_Q[0]),
         mealy_q1 (clk, reset, mealy_d1, Mealy_Q[1]),
         mealy_q2 (clk, reset, mealy_d2, Mealy_Q[2]);

   //  ***** Output Combinational Logic *****
   assign   Mealy_Z =     (  (Mealy_Q[2]) & (Mealy_Q[0]) & (X) );
   
endmodule
