----------------------------------------------------------------
-- Engineer: 	   Samuel Riedo & Pascal Roulin
-- 
-- Create Date:    09:12:29 05/04/2016 
-- Design Name: 
-- Module Name:    stateMachine - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 1 - Working version
-- Additional Comments: 
--
--------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity stateMachine is
    port(	convert_i				: in std_logic;
    		data_i				: in std_logic_vector (7 downto 0);
    		clk 					: in std_logic;
    		reset 				: in std_logic;

    		s1 					: out std_logic;
    		s2					: out std_logic;
    		s3					: out std_logic;
    		s4 					: out std_logic;
    		newData				: out std_logic;
    		busy					: out std_logic);
end entity stateMachine;

architecture arch of stateMachine is

	type etats is (zero, open1, sample, open2, compute, update, nextbyte); 
	signal currentState, futurState : etats;
	signal timerout 			: integer range 0 to 8;
	signal timerin				: std_logic;

begin

	-- clk and reset process
	process (clk, reset, timerin)
	begin
		if reset = '1' then
			currentState <= zero;
			timerout <= 0;
		elsif rising_edge(clk) then
			currentState <= futurState;	
			if timerin = '1' then
				if timerout = 8 then
					timerout <= 0;
				else
					timerout <= timerout + 1;
				end if;
			end if;		
		end if;
	end process;

	-- futurs state process
	process (currentState, convert_i, data_i, timerout)
	begin
		case currentState is
			when zero =>
				s1 <= '0';
				s2 <= '0';
				s3 <= '0';
				s4 <= '0';
				newData <= '0';
				busy <= '0';
				timerin <= '0';

				if convert_i = '1' then
					futurState <= open1;
				else
					futurState <= zero;
				end if;

			when open1 =>
				s1 <= '0';
				s2 <= '1';
				s3 <= '1';
				s4 <= '0';
				newData <= '0';
				busy <= '1';
				timerin <= '0';

				if timerout = 8 then
					futurState <= update;
				elsif timerout < 8 then
					futurState <= sample;
				else
					futurState <= open1;
				end if;

			when sample =>
				s1 <= data_i(timerout);
				s2 <= data_i(timerout);
				s3 <= '1';
				s4 <= '0';
				newData <= '0';
				busy <= '1';
				timerin <= '0';

				futurState <= open2;

			when open2 =>
				s1 <= '0';
				s2 <= '1';
				s3 <= '1';
				s4 <= '0';
				newData <= '0';
				busy <= '1';
				timerin <= '0';

				futurState <= compute;

			when compute =>
				s1 <= '0';
				s2 <= '1';
				s3 <= '0';
				s4 <= '0';
				newData <= '0';
				busy <= '1';
				timerin <= '1';

				futurState <= open1;

			when update =>
				s1 <= '0';
				s2 <= '1';
				s3 <= '1';
				s4 <= '1';
				newData <= '0';
				busy <= '1';
				timerin <= '1';

				futurState <= nextbyte;

			WHEN others =>
				s1 <= '0';
				s2 <= '1';
				s3 <= '1';
				s4 <= '0';
				newData <= '1';
				busy <= '1';
				timerin <= '0';
				futurState <= zero;
				
		end case;
	end process;

end architecture arch;