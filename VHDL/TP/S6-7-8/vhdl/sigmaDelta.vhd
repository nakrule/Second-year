library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sigmaDelta is
  port(
    clk_i   : in  std_logic;
    Dna_i   : in  std_logic_vector(23 downto 0);
    Reset_i : in  std_logic;
    Dna_o   : out std_logic
    );
end entity;

architecture logic of sigmaDelta is

  signal Dna_full_s     : std_logic_vector(23 downto 0);
  signal Dna_offset_s   : std_logic_vector(23 downto 0);
  signal Dna_i_s        : std_logic_vector(15 downto 0);
  signal Input_resize_s : std_logic_vector(17 downto 0);
  signal Dna_s          : signed(17 downto 0);
  signal Delta_s        : signed(17 downto 0);
  signal Delta_b_s      : signed(17 downto 0);
  signal S_s            : signed(17 downto 0);
  signal Out_s          : signed(17 downto 0);

begin

  Dna_full_s   <= "000" & Dna_i(23 downto 3);  -- /8
  Dna_offset_s <= std_logic_vector(to_signed(32768 + to_integer(signed(Dna_full_s)), 24));

  Dna_i_s <= Dna_offset_s(15 downto 0);

  Input_resize_s <= "00" & Dna_i_s;

  Dna_s <= signed(Input_resize_s);

  Delta_b_s <= Out_s(16) & Out_s(16) & "0000000000000000";

  Delta_s <= Dna_s + Delta_b_s;

  S_s <= Delta_s + Out_s;

  process(clk_i, Reset_i)
  begin
    if Reset_i = '1' then
      Out_s <= (others => '0');
      Dna_o <= '0';
    elsif rising_edge(clk_i) then
      Out_s <= S_s;
      Dna_o <= Out_s(16);
    end if;
  end process;

end architecture;
