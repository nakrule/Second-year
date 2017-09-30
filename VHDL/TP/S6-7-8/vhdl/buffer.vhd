library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.local.all;

entity Buff is
  port (
	Clk3x_s : IN std_logic;
	Reset_i : IN std_logic;
	Step_s : IN std_logic_vector(Step_bits_c -1 downto 0);
	Step_buf_s : OUT std_logic_vector(Step_bits_c -1 downto 0)
  ) ;
end entity; -- Buff

architecture Behav of Buff is
begin
	memory:process(Clk3x_s, Reset_i)
	begin
		if Reset_i = '1' then
			Step_buf_s <= std_logic_vector(to_unsigned(2991936, Step_bits_c));
		elsif rising_edge(Clk3x_s) then
			Step_buf_s <= Step_s;
		end if;
	end process;

end architecture ; -- Behav
