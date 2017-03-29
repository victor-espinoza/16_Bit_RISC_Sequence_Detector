`timescale 1ps / 100fs
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:46:26 09/22/2013 
// Design Name: 
// Module Name:    sequence_detector_mealy_tb 
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

module sequence_detector_mealy_tb();

	//Inputs
	reg			clk, reset, X, M;

	//Outputs
	wire Z;
	wire [2:0] Q;

	//Local Declarations
	reg [44:1] sequence_pattern;
	integer i;
	
	//Instansiate the Unite Under Test (uut)
	sequence_detector_mealy uut (
	 .clk(clk), .reset(reset), 
	 .X(X), 		.M(M),
	 .Z(Z),		.Q(Q));
	 
	 //Generate 10 ps Clock
	 always 
		#5 clk = ~clk;
		
	 //Initialize Block for the sequece of "test vectors," applied every clock cycle.
		
	 initial begin
		$timeformat(-12, 1, " ps", 8);
		clk = 0; reset = 0; X = 0; M = 0;
		sequence_pattern = 44'b01100010101101011011111001011011011011101010;
		@(negedge clk)
			reset = 1;
		@(negedge clk)
			reset = 0;
			M=0;					//Meally implementation (M=0); to simulate the Moore
									//implementation, set M = 1 and run the simulation again
									
		//this loop will "feed" the sequence detector with the 
		//test sequence patter from MSB to LSB
		for (i=44; i>0; i=i-1) begin
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
