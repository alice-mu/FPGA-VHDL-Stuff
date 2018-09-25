library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Compx4 is port (
   
	a			:  in std_logic_vector(3 downto 0);
	b			:  in std_logic_vector(3 downto 0);
	
	a_greater  : out std_logic;
	b_greater  : out std_logic;
	equal      : out std_logic
); 
end Compx4;


architecture comparator of Compx4 is

	component Compx1 port (
		a	   :  in  std_logic;
		b     :  in std_logic;
		a_greater  : out std_logic;
		b_greater  : out std_logic;
		equal      : out std_logic
	); 
	end component;
	
	signal a0	:  std_logic;
	signal a1	:  std_logic;
	signal a2	:  std_logic;
	signal a3	:  std_logic;
	signal b0	:  std_logic;
	signal b1	:  std_logic;
	signal b2	:  std_logic;
	signal b3	:  std_logic;
	
   signal a_greater_3	   :  std_logic;
   signal a_greater_2	   :  std_logic;
	signal a_greater_1	   :  std_logic;
	signal a_greater_0	   :  std_logic;
		
   signal b_greater_3	   :  std_logic;
   signal b_greater_2	   :  std_logic;
	signal b_greater_1	   :  std_logic;
	signal b_greater_0	   :  std_logic;		
	
	signal equal_3	   :  std_logic;
   signal equal_2	   :  std_logic;
	signal equal_1	   :  std_logic;
	signal equal_0	   :  std_logic;

begin
   
	a0 <= a(0);
	a1 <= a(1);
	a2 <= a(2);
	a3 <= a(3);
	b0 <= b(0);
	b1 <= b(1);
	b2 <= b(2);
	b3 <= b(3);
	
	a_greater <= a_greater_3 or (equal_3 and (a_greater_2 or (equal_2 and (a_greater_1 or (equal_1 and a_greater_0)))));
	b_greater <= b_greater_3 or (equal_3 and (b_greater_2 or (equal_2 and (b_greater_1 or (equal_1 and b_greater_0)))));
	equal     <= equal_3 and equal_2 and equal_1 and equal_0;
	
	INST1: Compx1 port map(a0, b0, a_greater_0, b_greater_0, equal_0);
	INST2: Compx1 port map(a1, b1, a_greater_1, b_greater_1, equal_1);
	INST3: Compx1 port map(a2, b2, a_greater_2, b_greater_2, equal_2);
	INST4: Compx1 port map(a3, b3, a_greater_3, b_greater_3, equal_3);
	
end architecture comparator; 


