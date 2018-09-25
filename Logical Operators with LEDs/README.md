# Simple Arithmetic Logic Unit implemented on an FPGA chip with peripherals like LEDs and push buttons

1. Two hexidecimals inputs taken from the switches on the board
2. Hexidecimal seven-segment displays display the output
3. if first push button is pushed, the two seven-segment displays just stays as the respective inputs
  if the 2nd push button is pushed, seven segment displays the result of logical AND of the inputs
  if the 3rd, displays logical OR
  if the 4th, displays XOR
  if the 5th, displays the result of addition
4. If more than one button is pressed, error condition raised; seven segment display lights up completely. displaying 8's
