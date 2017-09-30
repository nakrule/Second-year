library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity PLL_Numerique_tb is end PLL_Numerique_tb;

architecture comp of PLL_Numerique_tb is

  component PLL_Numerique is
    port(clk_i, reset_i, fref_i : in std_logic; F_o, out_o, clk3x_o : out std_logic);
  end component;
  signal clk_sti, clk_3x_sti, fref_sti : std_logic;
  signal reset_sti                     : std_logic;
  signal F_obs, out_obs                : std_logic;
  signal out_dec_obs                   : integer;
  signal omega_s                       : real;


-- to be customized by user
  constant f_clk_sti_c   : real := 20000000.0;  -- Frequence de l'horloge systeme d'entree 20 MHz (60MHz/3)
  constant fe_porteuse_c : real := 10700000.0;  -- Frequence d'entree centrale
  constant deltaf_c      : real := 150000.0;  -- Modulation de frequence plus/moins 150 kHz
  constant fe_audio_c    : real := 12500.0;   -- Frequence audio 12.5 kHz
  constant ampl_sinus    : real := 0.97;  -- Amplitude du sinus Audio (reduction par rapport a deltaf_c
-- enf of customization by user

  constant clockperiod_c : time := (1.0/f_clk_sti_c) * 1 sec;

  shared variable init_temps_v : time;
  shared variable t_v          : real;

  signal inputperiod_s : time := (1.0/fe_porteuse_c) * 1 sec;
  signal fe_input_sti  : real;

  for all : PLL_Numerique use entity work.PLL_Numerique;

begin

  PLL_Numerique1 : PLL_Numerique
    port map (clk_i => clk_sti, reset_i => reset_sti, fref_i => fref_sti, F_o => F_obs,
              out_o => out_obs, clk3x_o => clk_3x_sti);

  process
  begin
    reset_sti    <= '1';
    init_temps_v := now;
    wait for 100 ps;
    reset_sti    <= '0';
    wait;
  end process;

  process (clk_sti, reset_sti)
  begin
    if reset_sti = '1' then
      fe_input_sti <= fe_porteuse_c;
      omega_s      <= 0.0;
    elsif rising_edge(clk_sti) then
      t_v          := real((now - init_temps_v) / 1 ps) / 1000000000000.0;
      omega_s      <= (2.0*math_pi*fe_audio_c*t_v);
      fe_input_sti <= fe_porteuse_c + (ampl_sinus*real(deltaf_c)*sin(omega_s));
    end if;
  end process;

  inputperiod_s <= (1.0/fe_input_sti) * 1 sec;
  fref_sti      <= '0' when reset_sti = '1' else not fref_sti after inputperiod_s/2;

  clk_sti <= '0' when reset_sti = '1' else not clk_sti after clockperiod_c/2;

  process (clk_3x_sti, reset_sti)
  begin
    if reset_sti = '1' then
      out_dec_obs <= 0;
    elsif rising_edge(clk_3x_sti) then
      if out_obs = '1' then out_dec_obs <= out_dec_obs + 1;
      else out_dec_obs                  <= out_dec_obs - 1;
      end if;
    end if;
  end process;

end comp;
