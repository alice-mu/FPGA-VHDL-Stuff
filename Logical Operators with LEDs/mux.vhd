library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;



entity mux is
   port (
			 PB         : in  std_logic_vector(3 downto 0); -- push buttons for the evaluation of this mux
			 DIN2 		: in  std_logic_vector(7 downto 0);	-- 2 8 bit inputs 
			 DIN1 		: in  std_logic_vector(7 downto 0);
			 DOUT			: out	std_logic_vector(7 downto 0) -- chosen input as output
        );
end entity mux;


architecture syn of mux is

   
begin

	DOUT <= DIN2 when PB = "0111" ELSE -- output is din2 only when you press pb3
				DIN1; --else choose din1

end architecture syn;
