# Simple Arithmetic Logic Unit implemented on an FPGA chip with peripherals like LEDs and push buttons

1. Two hexidecimals inputs taken from the switches on the board
2. Hexidecimal seven-segment displays display the output
3. if first push button is pushed, the two seven-segment displays just stays as the respective inputs
  if the 2nd push button is pushed, seven segment displays the result of logical AND of the inputs
  if the 3rd, displays logical OR
  if the 4th, displays XOR
  if the 5th, displays the result of addition
4. If more than one button is pressed, error condition raised; seven segment display lights up completely. displaying 8's


Below is the logical flow of the project, credits to the University of Waterloo ECE125 Lab Manual

![alt text](https://raw.githubusercontent.com/alice-mu/FPGA-VHDL-Stuff/master/Logical%20Operators%20with%20LEDs/project-1-flow.jpg)
    
