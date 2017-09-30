library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity Phase_Comparator is
  port(
    Fref_i        : in  std_logic;
    Fcomp_i       : in  std_logic;
    Clk_i         : in  std_logic;
    Reset_i       : in  std_logic;
    Delta_phase_o : out std_logic_vector (9 downto 0)
    );
end entity;

architecture Behav of Phase_Comparator is

  signal En_s                                : std_logic;
  signal Fref_synchro_s                      : std_logic;
  signal Fcomp_synchro_s                     : std_logic;
  signal Fref_delay_s                        : std_logic;
  signal Fcomp_delay_s                       : std_logic;
  signal Fref_flk_s, Fcomp_flk_s             : std_logic;
  signal Delta_phase_s                       : integer range -512 to 511;
  signal Plus_3_s, Plus_2_s, Plus_1_s        : std_logic;
  signal Moins_3_s, Moins_2_s, Moins_1_s     : std_logic;
  signal Set_s, Pas_de_dephasage_s           : std_logic;
  signal Fin_calcul_dp_s, Reset_s            : std_logic;
  signal Start_calcul_dp_s, Calcul_dp_s      : std_logic;
  signal Preset_s, End_s                     : std_logic;
  signal En_cnt_s, Load_1_cnt_s, Clr_cnt_s   : std_logic;
  signal Fref_delay_not_s, Fcomp_delay_not_s : std_logic;
  signal Cnt_s                               : integer range 0 to 5;
  signal Delta_phase_mod_old_s               : integer range 0 to 5;
  signal Delta_phase_new_s                   : integer range 0 to 5;

begin
  En_s <= Fref_flk_s;

  Counter : process(Clk_i, Reset_i)
  begin
    if Reset_i = '1' then
      Delta_phase_s <= 0;
    elsif rising_edge(Clk_i) then
      if En_s = '1' then
        if Delta_phase_s <= 500 then
          if Plus_3_s = '1' then
            Delta_phase_s <= Delta_phase_s + 3;
          elsif Plus_2_s = '1' then
            Delta_phase_s <= Delta_phase_s + 2;
          elsif Plus_1_s = '1' then
            Delta_phase_s <= Delta_phase_s + 1;
          end if;
        end if;
        if Delta_phase_s >= -500 then
          if Moins_3_s = '1' then
            Delta_phase_s <= Delta_phase_s - 3;
          elsif Moins_2_s = '1' then
            Delta_phase_s <= Delta_phase_s - 2;
          elsif Moins_1_s = '1' then
            Delta_phase_s <= Delta_phase_s - 1;
          end if;
        end if;
      end if;
    end if;
  end process;

  Delta_phase_o <= std_logic_vector(to_signed(Delta_phase_s, 10));


-- purpose: DFF
-- type   : sequential
-- inputs : Clk_i, Reset_i, Fref_i, Fcomp_i
-- outputs: Fref_fkl_s, Fcomp_flk_s
  process (Clk_i, Reset_i) is
  begin  -- process
    if Reset_i = '1' then               -- asynchronous reset (active low)
      Fref_synchro_s  <= '0';
      Fcomp_synchro_s <= '0';
      Fref_delay_s    <= '0';
      Fcomp_delay_s   <= '0';
    elsif rising_edge(Clk_i) then       -- rising clock edge
      Fref_synchro_s  <= Fref_i;
      Fcomp_synchro_s <= Fcomp_i;
      Fref_delay_s    <= Fref_synchro_s;
      Fcomp_delay_s   <= Fcomp_synchro_s;
    end if;
  end process;

  Fref_delay_not_s  <= not Fref_delay_s;
  Fcomp_delay_not_s <= not Fcomp_delay_s;

  Fref_flk_s  <= Fref_synchro_s and (not Fref_delay_s);
  Fcomp_flk_s <= Fcomp_synchro_s and (not Fcomp_delay_s);

  SRFF : process (Clk_i, Preset_s) is
  begin  -- process SR FF
    if Preset_s = '1' then              -- asynchronous reset (active low)
      End_s <= '1';
    elsif rising_edge(Clk_i) then       -- rising clock edge
      if Set_s = '1' and Reset_s = '0' then
        End_s <= '1';
      elsif Set_s = '0' and Reset_s = '1' then
        End_s <= '0';
      end if;
    end if;
  end process SRFF;

  Set_s    <= Pas_de_dephasage_s or Fin_calcul_dp_s;
  Reset_s  <= Start_calcul_dp_s or Calcul_dp_s;
  Preset_s <= Reset_i;

  --And gates
  Pas_de_dephasage_s <= End_s and Fref_flk_s and Fcomp_flk_s;
  Start_calcul_dp_s  <= End_s and Fref_flk_s and not(Fcomp_flk_s);
  Calcul_dp_s        <= not(End_s) and not(Fref_flk_s) and not(Fcomp_flk_s);
  Fin_calcul_dp_s    <= not(End_s) and Fcomp_flk_s;

  -- Old
  Old : process(Reset_i, Clk_i)
  begin
    if Reset_i = '1' then
      Delta_phase_mod_old_s <= 0;
    elsif rising_edge(Clk_i) then
      if En_s = '1' then
        Delta_phase_mod_old_s <= Delta_phase_new_s;
      end if;
    end if;
  end process;

-- purpose: Counter Modulo 6
-- type   : sequential
-- inputs : Clk_i, Reset_i, En_cnt_s, Load_1_cnt_s, Clr_cnt_s
-- outputs: Cnt_s
  CounterModulo6 : process (Clk_i, Reset_i) is
  begin  -- process CounterModulo6
    if Reset_i = '1' then               -- asynchronous reset (active low)
      Cnt_s <= 0;
    elsif rising_edge(Clk_i) then       -- rising clock edge
      if En_cnt_s = '1' then
        if Cnt_s = 5 then
          Cnt_s <= 0;
        else
          Cnt_s <= Cnt_s + 1;
        end if;
      elsif Load_1_cnt_s = '1' then
        Cnt_s <= 1;
      elsif Clr_cnt_s = '1' then
        Cnt_s <= 0;
      end if;
    end if;
  end process CounterModulo6;

  En_cnt_s          <= Calcul_dp_s;
  Load_1_cnt_s      <= Start_calcul_dp_s;
  Clr_cnt_s         <= Pas_de_dephasage_s;
  Delta_phase_new_s <= Cnt_s;

  Table : process(Delta_phase_mod_old_s, Delta_phase_new_s)
  begin
    Plus_3_s  <= '0';
    Plus_2_s  <= '0';
    Plus_1_s  <= '0';
    Moins_3_s <= '0';
    Moins_2_s <= '0';
    Moins_1_s <= '0';
    case Delta_phase_mod_old_s is
      when 0 =>
        case Delta_phase_new_s is
          when 1 =>
            Plus_1_s <= '1';
          when 2 =>
            Plus_2_s <= '1';
          when 3 =>
            Plus_3_s <= '1';
          when 4 =>
            Moins_2_s <= '1';
          when 5 =>
            Moins_1_s <= '1';
          when others =>
            null;
        end case;
      when 1 =>
        case Delta_phase_new_s is
          when 0 =>
            Moins_1_s <= '1';
          when 2 =>
            Plus_1_s <= '1';
          when 3 =>
            Plus_2_s <= '1';
          when 4 =>
            Moins_3_s <= '1';
          when 5 =>
            Moins_2_s <= '1';
          when others =>
            null;
        end case;
      when 2 =>
        case Delta_phase_new_s is
          when 0 =>
            Moins_2_s <= '1';
          when 1 =>
            Moins_1_s <= '1';
          when 3 =>
            Plus_1_s <= '1';
          when 4 =>
            Plus_2_s <= '1';
          when 5 =>
            Plus_3_s <= '1';
          when others =>
            null;
        end case;
      when 3 =>
        case Delta_phase_new_s is
          when 0 =>
            Moins_3_s <= '1';
          when 1 =>
            Moins_2_s <= '1';
          when 2 =>
            Moins_1_s <= '1';
          when 4 =>
            Plus_1_s <= '1';
          when 5 =>
            Plus_2_s <= '1';
          when others =>
            null;
        end case;
      when 4 =>
        case Delta_phase_new_s is
          when 0 =>
            Plus_2_s <= '1';
          when 1 =>
            Moins_3_s <= '1';
          when 2 =>
            Moins_2_s <= '1';
          when 3 =>
            Moins_1_s <= '1';
          when 5 =>
            Plus_1_s <= '1';
          when others =>
            null;
        end case;
      when 5 =>
        case Delta_phase_new_s is
          when 0 =>
            Plus_1_s <= '1';
          when 1 =>
            Plus_2_s <= '1';
          when 2 =>
            Moins_3_s <= '1';
          when 3 =>
            Moins_2_s <= '1';
          when 4 =>
            Moins_1_s <= '1';
          when others =>
            null;
        end case;
    end case;
  end process;

end Behav;
