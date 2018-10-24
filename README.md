Project Overview:  
Sequence Detector implemented using FPGA logic.
  
In this project I designed and implemented a sequential circuit (in verilog) that functions as a dual implementation non-overlapping sequence detector. The sequence detector has an input X that is used to detect the non-overlapping sequence of "101101". The output Z becomes a 1 upon completion of the correct input sequence and is a 0 otherwise. My circuit has both a "Mealy" implementation and a "Moore" implementation. A "mode" input (M) specifies which implementation is being used: If M=0, a "Mealy" implementation is chosen and if M=1, then the "Moore" implementation is chosen.   
  
Here is a top-level diagram of what my project looks like:  

![ScreenShot](https://cloud.githubusercontent.com/assets/14812721/24821419/4a0b4856-1ba3-11e7-8e55-8ef070c25a3e.jpg)

Dependencies:  
This project was created using Xilinx ISE Project Navigator Version: 14.7.    
     
    
Project Verification:    
The verification for this project was done by running the circuit through the sequence_detector_tb() module. This module feeds the sequence detector with an appropriate test sequence value and verifys that the sequence detector is in fact outputting the correct values. 
