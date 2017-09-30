----------------------------------------------------------------
-- Engineer: 	   Samuel Riedo & Pascal Roulin
-- 
-- Create Date:    09:12:29 05/04/2016 
-- Design Name: 
-- Module Name:    topLevel
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 1 - First working version
-- Additional Comments: 
--
--------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity topLevel is
    Port(	convert_i				: in std_logic;
    		clk 					: in std_logic;
    		reset 				: in std_logic;

    		s1 					: out std_logic;
    		s2					: out std_logic;
    		s3					: out std_logic;
    		s4 					: out std_logic;
    		busy					: out std_logic);
end entity topLevel;

architecture arch of topLevel is

	signal	newDataBus		: std_logic;
	signal	dataBus			: std_logic_vector (7 downto 0);

	component stateMachine is
	    port(	convert_i			: in std_logic;
	    		data_i			: in std_logic_vector (7 downto 0);
	    		clk 				: in std_logic;
	    		reset 			: in std_logic;

	    		s1 				: out std_logic;
	    		s2				: out std_logic;
	    		s3				: out std_logic;
	    		s4 				: out std_logic;
	    		newData			: out std_logic;
	    		busy				: out std_logic
		);
	end component stateMachine;

	component lut is
		port(
				new_data_i 	: in std_logic;
				clk			: in std_logic;
				reset		: in std_logic;

				data_o		: out std_logic_vector (7 downto 0)
		);
	end component;

begin

	map1:stateMachine
		port map(
			convert_i => convert_i,
			data_i => dataBus,
			clk => clk,
			reset => reset,

			s1 => s1,
			s2 => s2,
			s3 => s3,
			s4 => s4,
			newData => newDataBus,
			busy =>busy
		);

	map2:lut
		port map(
			new_data_i => newDataBus,
			clk => clk,
			reset => reset,
			data_o => dataBus
		);

end architecture arch;