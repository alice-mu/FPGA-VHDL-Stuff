library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;
	pb					: in	std_logic_vector(3 downto 0); -- 4 push buttons
 	sw   				: in  std_logic_vector(7 downto 0); -- The switch inputs
   leds				: out std_logic_vector(7 downto 0); -- for displaying the switch content
   seg7_data 		: out std_logic_vector(6 downto 0); -- 7-bit outputs to a 7-segment
	seg7_char1  	: out	std_logic;				    		-- seg7 digit1 selector
	seg7_char2  	: out	std_logic				    		-- seg7 digit2 selector
	
); 
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is
--
-- Components Used ---
------------------------------------------------------------------- 
  component SevenSegment port (
   hex   		:  in  std_logic_vector(3 downto 0);   -- The 4 bit data to be displayed
   sevenseg 	:  out std_logic_vector(6 downto 0)    -- 7-bit outputs to a 7-segment
   ); 
   end component;
	
	component segment7_mux port (
		clk      : in std_logic := '0';
		DIN2     : in std_logic_vector(6 downto 0);
		DIN1     : in std_logic_vector(6 downto 0);
		DOUT     : out std_logic_vector(6 downto 0);
		DIG2     : out std_logic;
		DIG1     : out std_logic
	
	);
	end component;
	
	component mux port (
      PB          : in  std_logic_vector(3 downto 0);		--push button to determine which of the two other inputs to output
		DIN2 		   : in  std_logic_vector(7 downto 0);		--one of two 8-bit inputs to be selected as output
		DIN1 		   : in  std_logic_vector(7 downto 0);
		DOUT	  		: out	std_logic_vector(7 downto 0)		--selected output determined by push button

	);
	end component;
	
	component logproce port (
		PB				: in std_logic_vector(3 downto 0);		--push buttons corresponding to the three logic operators
		DIN1			: in std_logic_vector(3 downto 0);		--operands to be evaluated depending on push buttons
		DIN2			: in std_logic_vector(3 downto 0);
		DOUT	  		: out	std_logic_vector(7 downto 0)		--output of operation determined by push buttons
	
	);
	end component;
	
-- Create any signals, or temporary variables to be used
--
--  std_logic_vector is a signal which can be used for logic operations such as OR, AND, NOT, XOR
--

	signal hex_A		: std_logic_vector(3 downto 0);		--4-bit determined by switches
	signal hex_B      : std_logic_vector(3 downto 0);
	
	signal sum			: std_logic_vector(7 downto 0);		--the result from the adder component
	signal conc		   : std_logic_vector(7 downto 0);		--the result from the concatenation of hex_A and hex_B
	
	signal muxout1		: std_logic_vector(7 downto 0);		--the chosen result from the mux instance that intakes sum and conc
	signal muxout1A	: std_logic_vector(3 downto 0);		--the first 4-bit to be input into the SevenSeg decoder to turn into 7-bits
	signal muxout1B	: std_logic_vector(3 downto 0);		--the second 4-bit to be input into the SevenSeg decoder to turn into 7-bits
	
	signal seg7_A		: std_logic_vector(6 downto 0);		--7-bit outputs from the SevenSeg decoder
	signal seg7_B     : std_logic_vector(6 downto 0);
	

	signal logicfunc  : std_logic_vector(7 downto 0);		--the result from the logicfunc component concatenated to 8-bits
	signal muxout2		: std_logic_vector(7 downto 0);		--the chosen result from the mux instance that intakes sum and the result from the logicfunc
	
	

	
	signal led0			: std_logic;								--LED outputs
	signal led1			: std_logic;
	signal led2			: std_logic;
	signal led3			: std_logic;
	signal led4			: std_logic;
	signal led5			: std_logic;
	signal led6			: std_logic;
	signal led7			: std_logic;
				

-- Here the circuit begins

begin

	leds(0) <= muxout2(0);			--outputting 8-bit results to the bits' corresponding LED lights
	leds(1) <= muxout2(1);
	leds(2) <= muxout2(2);
	leds(3) <= muxout2(3);
	leds(4) <= muxout2(4);
	leds(5) <= muxout2(5);
	leds(6) <= muxout2(6);
	leds(7) <= muxout2(7);
								
	
	hex_A <= sw(3 downto 0);		--hex_A and hex_B bits determined by their respective LED lights
	hex_B <= sw(7 downto 4);
	
	conc <= std_logic_vector(hex_A & hex_B);		--one of the inputs for muxout1, to be seperated back into two 4-bits if chosen for SevenSeg decoder
		
	sum <= std_logic_vector((unsigned("0000" & hex_A) + unsigned("0000" & hex_B)));		--hex_A and hex_B concatenated to make 8-bits,
																													--then typecasted to unsigned to be added together,
																													--then typecasted back to std logic vector as the sum
	
	muxout1A <= muxout1(3 downto 0);		--taking first half of muxout1 to be put through the SevenSeg decoder and displayed as a digit
	muxout1B <= muxout1(7 downto 4);		--taking second half of muxout1 to be put through the SevenSeg decoder and displayed as a digit

	INST1: SevenSegment port map(muxout1A, seg7_A);		--converting 4-bits for digit displays
	INST2: SevenSegment port map(muxout1B, seg7_B);		--converting 4-bits for digit displays
	
	INST3: segment7_mux port map(clkin_50, seg7_A, seg7_B, seg7_data, seg7_char1, seg7_char2);
	
	INST4: mux			  port map(pb, sum, conc, muxout1);		--choosing sum or conc to be displayed as digits depending on pb3
	INST5: mux			  port map(pb, sum, logicfunc, muxout2);	--choosing sum or logicfunc to be displayed on LEDs depending on pb3
	INST6: logproce     port map(pb, hex_A, hex_B, logicfunc);		--performing logic operators on hex_A and hex_B depending on the inputs 
	                                                               --from push buttons 2 downto 0

end SimpleCircuit;

