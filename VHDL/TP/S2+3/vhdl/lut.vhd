----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 	   Samuel Riedo & Pacal Roulin
-- 
-- Create Date:    09:03:09 10/14/2016 
-- Design Name: 
-- Module Name:    Lut - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity lut is

	port(
		new_data_i 			: in std_logic;
		clk					: in std_logic;
		reset				: in std_logic;
		
		data_o				: out std_logic_vector (7 downto 0)
	);

end lut;
----------------------------------------------------------------------------------
architecture Behavioral of main is
	signal data_s 				: integer range 0 to 254;
	signal address_s			: integer range 0 to 359;
	signal address_v			: integer range 0 to 90;
	signal current_part 		: integer range 0 to 3;

begin

	process(clk, reset)
	begin

		if reset = '1' then
			data_o <= "11111111";
			
		elsif rising_edge(clk) and new_data_i = '1' then
			-- Convertion 
			if current_part = 0  or current_part = 1 then
				data_o <= std_logic_vector(to_unsigned(127+data_s, 8));	
			else
				data_o <= std_logic_vector(to_unsigned(127-data_s, 8));
			end if;
			
			-- address_s actualisation
			if address_s = 359 then
				address_s <= 0;
			else
				address_s <= address_s + 1;
			end if;
			
		end if;
	
	end process;
	
----------------------------------------------------------------------------------	
	process(address_s)

	begin
	
		-- address_s between 0-90
		if (address_s <= 90) then
			address_v <= address_s;
			current_part <= 0;
		-- address_s between 91-180
		elsif (address_s <= 180) then
			address_v <= 180-address_s;
			current_part <= 1;
		-- address_s between 181-270	
		elsif (address_s <= 270) then
			address_v <= (address_s-180);
			current_part <= 2;
		-- address_s between 271-359
		else
			address_v <= (360-address_s);
			current_part <= 3;
		end if;

		case address_v is
			when 0=> 
				data_s <= 0;

			when 1=> 
				data_s <= 2;

			when 2=> 
				data_s <= 4;

			when 3=> 
				data_s <= 7;

			when 4=> 
				data_s <= 9;

			when 5=> 
				data_s <= 11;

			when 6=> 
				data_s <= 13;

			when 7=> 
				data_s <= 15;

			when 8=> 
				data_s <= 18;

			when 9=> 
				data_s <= 20;

			when 10=> 
				data_s <= 22;

			when 11=> 
				data_s <= 24;

			when 12=> 
				data_s <= 26;

			when 13=> 
				data_s <= 29;

			when 14=> 
				data_s <= 31;

			when 15=> 
				data_s <= 33;

			when 16=> 
				data_s <= 35;

			when 17=> 
				data_s <= 37;

			when 18=> 
				data_s <= 39;

			when 19=> 
				data_s <= 41;

			when 20=> 
				data_s <= 43;

			when 21=> 
				data_s <= 46;

			when 22=> 
				data_s <= 48;

			when 23=> 
				data_s <= 50;

			when 24=> 
				data_s <= 52;

			when 25=> 
				data_s <= 54;

			when 26=> 
				data_s <= 56;

			when 27=> 
				data_s <= 58;

			when 28=> 
				data_s <= 60;

			when 29=> 
				data_s <= 62;

			when 30=> 
				data_s <= 63;

			when 31=> 
				data_s <= 65;

			when 32=> 
				data_s <= 67;

			when 33=> 
				data_s <= 69;

			when 34=> 
				data_s <= 71;

			when 35=> 
				data_s <= 73;

			when 36=> 
				data_s <= 75;

			when 37=> 
				data_s <= 76;

			when 38=> 
				data_s <= 78;

			when 39=> 
				data_s <= 80;

			when 40=> 
				data_s <= 82;

			when 41=> 
				data_s <= 83;

			when 42=> 
				data_s <= 85;

			when 43=> 
				data_s <= 87;

			when 44=> 
				data_s <= 88;

			when 45=> 
				data_s <= 90;

			when 46=> 
				data_s <= 91;

			when 47=> 
				data_s <= 93;

			when 48=> 
				data_s <= 94;

			when 49=> 
				data_s <= 96;

			when 50=> 
				data_s <= 97;

			when 51=> 
				data_s <= 99;

			when 52=> 
				data_s <= 100;

			when 53=> 
				data_s <= 101;

			when 54=> 
				data_s <= 103;

			when 55=> 
				data_s <= 104;

			when 56=> 
				data_s <= 105;

			when 57=> 
				data_s <= 107;

			when 58=> 
				data_s <= 108;

			when 59=> 
				data_s <= 109;

			when 60=> 
				data_s <= 110;

			when 61=> 
				data_s <= 111;

			when 62=> 
				data_s <= 112;

			when 63=> 
				data_s <= 113;

			when 64=> 
				data_s <= 114;

			when 65=> 
				data_s <= 115;

			when 66=> 
				data_s <= 116;

			when 67=> 
				data_s <= 117;

			when 68=> 
				data_s <= 118;

			when 69=> 
				data_s <= 119;

			when 70=> 
				data_s <= 119;

			when 71=> 
				data_s <= 120;

			when 72=> 
				data_s <= 121;

			when 73=> 
				data_s <= 121;

			when 74=> 
				data_s <= 122;

			when 75=> 
				data_s <= 123;

			when 76=> 
				data_s <= 123;

			when 77=> 
				data_s <= 124;

			when 78=> 
				data_s <= 124;

			when 79=> 
				data_s <= 125;

			when 80=> 
				data_s <= 125;

			when 81=> 
				data_s <= 125;

			when 82=> 
				data_s <= 126;

			when 83=> 
				data_s <= 126;

			when 84=> 
				data_s <= 126;

			when 85=> 
				data_s <= 127;

			when 86=> 
				data_s <= 127;

			when 87=> 
				data_s <= 127;

			when 88=> 
				data_s <= 127;

			when 89=> 
				data_s <= 127;

			when others =>
				data_s <= 127;
		end case;
		
	end process;

end Behavioral;