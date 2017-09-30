library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.local.all;

entity demodulator is
  port (
    Step_s : in  std_logic_vector(Step_bits_c -1 downto 0);
    Fm_s   : out std_logic_vector(Step_bits_c -1 downto 0)
    );
end entity;

architecture logic of demodulator is

  signal Step_i : std_logic_vector(Step_bits_c -1 downto 0);
  signal Fm_o   : std_logic_vector(Step_bits_c -1 downto 0);

begin

  Step_i <= Step_s;
  Fm_o   <= std_logic_vector(signed(Step_i)-2991937);
  Fm_s   <= Fm_o;

end architecture;
