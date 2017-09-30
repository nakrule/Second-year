----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    09:12:34 01/27/2017 
-- Design Name: 
-- Module Name:    PLL_Numerique - Behavioral 
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
library IEEE;
use IEEE.STD_LOGIC_1164.all;

use work.local.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PLL_Numerique is
  port(
    Fref_i  : in  std_logic;
    Clk_i   : in  std_logic;
    reset_i : in  std_logic;
    F_o     : out std_logic;
    Clk3x_o : out std_logic;
    Out_o   : out std_logic
    );
end PLL_Numerique;

architecture Behavioral of PLL_Numerique is

  component Buff is
    port (
      Clk3x_s    : in  std_logic;
      Reset_i    : in  std_logic;
      Step_s     : in  std_logic_vector(Step_bits_c -1 downto 0);
      Step_buf_s : out std_logic_vector(Step_bits_c -1 downto 0)
      );
  end component;

  component demodulator is
    port (
      Step_s : in  std_logic_vector(Step_bits_c -1 downto 0);
      Fm_s   : out std_logic_vector(Step_bits_c -1 downto 0)
      );
  end component;

  component Phase_Comparator is
    port(
      Fref_i        : in  std_logic;
      Fcomp_i       : in  std_logic;
      Clk_i         : in  std_logic;
      Reset_i       : in  std_logic;
      Delta_phase_o : out std_logic_vector (9 downto 0)
      );
  end component;

  component NCO is
    port (
      Clk_i   : in  std_logic;
      Step_s  : in  std_logic_vector(Step_bits_c -1 downto 0);
      Reset_i : in  std_logic;
      Fcomp_s : out std_logic
      );
  end component;

  component sigmaDelta is
    port(
      clk_i   : in  std_logic;
      Dna_i   : in  std_logic_vector(Step_bits_c -1 downto 0);
      Reset_i : in  std_logic;
      Dna_o   : out std_logic
      );
  end component;


  component Clk_Gen is
    port(
      clk_i          : in  std_logic;
      clk_o, clk3x_o : out std_logic
      );
  end component;

  component Pi is
    port (
      Delta_phase_s : in  std_logic_vector(9 downto 0);
      Clk3x_s       : in  std_logic;
      reset_i       : in  std_logic;
      Step_s        : out std_logic_vector(Step_bits_c -1 downto 0)
      );
  end component;

  signal clk3        : std_logic;
  signal steps       : std_logic_vector(Step_bits_c -1 downto 0);
  signal stepbufs    : std_logic_vector(Step_bits_c -1 downto 0);
  signal fm_s        : std_logic_vector(Step_bits_c -1 downto 0);
  signal fcomps      : std_logic;
  signal deltaphases : std_logic_vector(9 downto 0);
  signal clkis       : std_logic;

begin

  map1 : Buff
    port map(
      Clk3x_s    => clk3,
      Reset_i    => Reset_i,
      Step_s     => steps,
      Step_buf_s => stepbufs
      );


  map2 : demodulator
    port map(
      Step_s => stepbufs,
      Fm_s   => fm_s
      );

  map3 : Phase_Comparator
    port map(
      Fref_i        => Fref_i,
      Fcomp_i       => fcomps,
      Clk_i         => clk3,
      Reset_i       => Reset_i,
      Delta_phase_o => deltaphases
      );

  map4 : NCO
    port map(
      Clk_i   => clk3,
      Step_s  => steps,
      Reset_i => Reset_i,
      Fcomp_s => fcomps
      );

  map5 : sigmaDelta
    port map(
      clk_i   => clk3,
      Dna_i   => fm_s,
      Reset_i => Reset_i,
      Dna_o   => Out_o
      );

  map6 : Clk_Gen
    port map(
      clk_i   => Clk_i,
      clk_o   => clkis,
      clk3x_o => clk3
      );

  map7 : Pi
    port map(
      Delta_phase_s => deltaphases,
      Clk3x_s       => clk3,
      reset_i       => Reset_i,
      Step_s        => steps
      );

  F_o     <= fcomps;
  Clk3x_o <= clk3;
end Behavioral;
