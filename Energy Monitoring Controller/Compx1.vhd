-- single-bit comparator for practice
	
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Compx1 is port (
   
   a	 :  in  std_logic;
   b     :  in std_logic;
	
	a_greater  : out std_logic;
	b_greater  : out std_logic;
	equal      : out std_logic
); 
end Compx1;


architecture comparator of Compx1 is


begin
   
	a_greater <= (a and (not b));
	b_greater <= (b and (not a));
	equal     <= (not(a xor b));
	
	
end architecture comparator; 


