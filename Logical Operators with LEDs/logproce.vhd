library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity logproce is
	PORT(
		PB				: in std_logic_vector(3 downto 0);		--push button inputs
		DIN1			: in std_logic_vector(3 downto 0);		--hex_A
		DIN2			: in std_logic_vector(3 downto 0);		--hex_B
		DOUT	  		: out	std_logic_vector(7 downto 0)		--result logic operator chosen by pb
        );
end entity logproce;

architecture syn of logproce is

begin

	DOUT <= ("0000" & (DIN1 AND DIN2)) WHEN (PB(0) = '0') AND (PB(1) = '1') AND (PB(2) = '1') AND (PB(3) = '1') ELSE		--when only pb 0 is ON ('0' is ON state) 
	                                                                                                                     --hex_A and hex_B are ANDded together 
																																								--and concatenated with 0000 to 8-bits
				("0000" & (DIN1 OR DIN2)) WHEN (PB(1) = '0') AND (PB(0) = '1') AND (PB(2) = '1') AND (PB(3) = '1') ELSE		--when only pb 1 is ON
																																								--two inputs are ORed and concatenated
				("0000" & (DIN1 XOR DIN2)) WHEN (PB(2) = '0') AND (PB(0) = '1') AND (PB(1) = '1') AND (PB(3) = '1') ELSE		--when only pb 2 is ON
																																								--two inputs are XORed and concatenated
				(DIN2 & DIN1) WHEN ((PB(0) = '1') AND (PB(1) = '1') AND (PB(2) = '1')) ELSE		--just concatenate the two inputs when no buttons are pushed
				("11111111");																						--if more than one button is pressed, all LEDs light up
	
end architecture syn;