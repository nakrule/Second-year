package local is
  constant phase_bits_c       : integer := 10;
  constant Delta_Sigma_bits_c : integer := 16;
  constant Step_bits_c        : integer := 24;
end local;

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;
use work.local.all;

entity NCO is
  port (
    Clk_i   : in  std_logic;
    Step_s  : in  std_logic_vector(Step_bits_c - 1 downto 0);
    Reset_i : in  std_logic;
    Fcomp_s : out std_logic
    );
end entity;  -- NCO

architecture Behav of NCO is
  signal Cnt_s : unsigned(Step_bits_c-1 downto 0);
begin
  Counter : process(Clk_i, Reset_i)
  begin
    if Reset_i = '1' then
      Cnt_s <= (others => '0');
    elsif rising_edge(Clk_i) then
      Cnt_s <= Cnt_s + unsigned(Step_s);
    end if;
  end process;
  Fcomp_s <= '1' when Cnt_s <= ((2**Step_bits_c)/2)-1 else '0';

end architecture;
