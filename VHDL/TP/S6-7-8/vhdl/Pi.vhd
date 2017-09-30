library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.local.all;

entity Pi is
  port (
    Delta_phase_s : in  std_logic_vector(9 downto 0);
    Clk3x_s       : in  std_logic;
    reset_i       : in  std_logic;
    Step_s        : out std_logic_vector(Step_bits_c -1 downto 0)
    );
end entity;

architecture logic of Pi is

  signal Input_i  : std_logic_vector(23 downto 0);
  signal Accu_i_s : std_logic_vector(23 downto 0);
  signal Reg_i_s  : std_logic_vector(23 downto 0);
  signal P_Term_s : std_logic_vector(23 downto 0);
  signal Accu_o_s : std_logic_vector(23 downto 0);
  signal I_Term_s : std_logic_vector(23 downto 0);
  signal Output_o : std_logic_vector(23 downto 0);

begin

  process(Delta_phase_s)
  begin
    if Delta_phase_s(9) = '1' then
      Input_i <= "11111111111111" & Delta_phase_s;
    else
      Input_i <= "00000000000000" & Delta_phase_s;
    end if;
  end process;

  Accu_i_s <= Input_i;
  Reg_i_s  <= std_logic_vector(signed(Accu_i_s)+signed(Accu_o_s));

  process(reset_i, Clk3x_s)
  begin
    if reset_i = '1' then
      Accu_o_s <= "000000101101101001110100";
    elsif rising_edge(Clk3x_s) then
      Accu_o_s <= Reg_i_s;
    end if;
  end process

  I_Term_s <= std_logic_vector(resize(to_signed(16, 24) * signed(Accu_o_s), 24));
  P_Term_s <= std_logic_vector(resize(to_signed(3276, 24) * signed(Input_i), 24));

  Output_o <= std_logic_vector(signed(I_Term_s)+signed(P_Term_s));

  Step_s <= Output_o;

end architecture;
