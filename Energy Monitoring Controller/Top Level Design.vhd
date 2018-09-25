library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab3_top is port (
   clkin_50		: in	std_logic;
	pb				: in	std_logic_vector(2 downto 0);
 	sw   			: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds			: out std_logic_vector(7 downto 0);	-- for displaying the switch content
   seg7_data 	: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  : out	std_logic;							-- seg7 digi selectors
	seg7_char2  : out	std_logic							-- seg7 digi selectors
	
); 
end LogicalStep_Lab3_top;

architecture Energy_Monitor of LogicalStep_Lab3_top is

	component Compx4 port (
		a			:  in std_logic_vector(3 downto 0);
		b			:  in std_logic_vector(3 downto 0);
	
		a_greater  : out std_logic;
		b_greater  : out std_logic;
		equal      : out std_logic
	); 
	end component;
	
	component SevenSegment port (
		hex	   :  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
		sevenseg :  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
	); 
	end component;
	
	component segment7_mux port (
      clk        : in  std_logic := '0';
		DIN2 		: in  std_logic_vector(6 downto 0);	
		DIN1 		: in  std_logic_vector(6 downto 0);
		DOUT			: out	std_logic_vector(6 downto 0);
		DIG2			: out	std_logic;
		DIG1			: out	std_logic
   );
	end component;

	
	signal desired_temp : std_logic_vector(3 downto 0);
	signal current_temp : std_logic_vector(3 downto 0);
	signal fdoor_open   : std_logic;
	signal window_open  : std_logic;
	signal bdoor_open  : std_logic;
	
	signal curr_higher_than_desired : std_logic;
	signal curr_lower_than_desired : std_logic;
	signal curr_equal_desired : std_logic;
	
	signal curr_temp_7seg : std_logic_vector(6 downto 0);
	signal des_temp_7seg : std_logic_vector(6 downto 0);
	
	signal buttons :std_logic_vector(2 downto 0);

begin
 
	buttons <= pb(2 downto 0);
	desired_temp <= sw(7 downto 4);
	current_temp <= sw(3 downto 0);
--	fdoor_open <= buttons(2);
--	window_open <= buttons(1);
--	bdoor_open <= buttons(0);
	
	INST1: Compx4 port map (current_temp, desired_temp, curr_higher_than_desired, curr_lower_than_desired, curr_equal_desired);
	
	leds(2) <= (buttons(2) and buttons(1) and buttons(0) and curr_higher_than_desired);                
	leds(0) <= (buttons(2) and buttons(1) and buttons(0) and curr_lower_than_desired);
	leds(1) <= (curr_equal_desired);
	leds(3) <= (buttons(2) and buttons(1) and buttons(0) and (not curr_equal_desired));
	leds(4) <= not buttons(0);
	leds(5) <= not buttons(1);
	leds(6) <= not buttons(2);
	
	INST2: SevenSegment port map (current_temp, curr_temp_7seg);
	INST3: SevenSegment port map (desired_temp, des_temp_7seg);
	INST4: segment7_mux port map(clkin_50, des_temp_7seg, curr_temp_7seg, seg7_data, seg7_char1, seg7_char2);
	
	

end Energy_Monitor;

