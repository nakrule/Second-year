----------------------------------------------------------------------------------
-- Company: HES-SO
-- Engineer: Samuel Riedo & Pascal Roulin
-- Create Date:    09:20:02 03/02/2017
-- Design Name: vgaDisplayTopModule.vhd
-- Project Name: Super Mario World - FPGA Edition
-- Target Devices: Digilent NEXYS 3 (Xilinx Spartan 6 XC6LX16-CS324)
-- Description: Top module for vga demo
-- Revision 0.01 - File Created
--          1.00 - First functionnal version
----------------------------------------------------------------------------------
library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vgagenerator is
  port (
    fpga_clk : in  std_logic;
    rst      : in  std_logic;
    HS       : out std_logic;
    VS       : out std_logic;
    red      : out std_logic_vector(2 downto 0);
    green    : out std_logic_vector(2 downto 0);
    blue     : out std_logic_vector(1 downto 0));
end entity;  -- vgagenerator

architecture behav of vgagenerator is
  signal pixel_clk : std_logic;
  signal hcount    : std_logic_vector(10 downto 0);
  signal vcount    : std_logic_vector(10 downto 0);
  signal blank     : std_logic;
  signal locked    : std_logic;

  component display is
    port (
      hcount : in  std_logic_vector(10 downto 0);  -- Pixel x coordinate
      vcount : in  std_logic_vector(10 downto 0);  -- Pixel y coordinate
      blank  : in  std_logic;           -- If 1, video output must be null
      red    : out std_logic_vector(2 downto 0);   -- Red color output
      green  : out std_logic_vector(2 downto 0);   -- Green color output
      blue   : out std_logic_vector(1 downto 0));  -- Blue color output
  end component;

  component dcm is
    port
      (                                 -- Clock in ports
        CLK_IN1  : in  std_logic;
        -- Clock out ports
        CLK_OUT1 : out std_logic;
        -- Status and control signals
        RESET    : in  std_logic;
        LOCKED   : out std_logic
        );
  end component;

  component vga is
    port (
      pixel_clk : in  std_logic;        -- 40MHz
      rst       : in  std_logic;        -- active low
      hs        : out std_logic;        -- Horizontale synchonization impulsion
      vs        : out std_logic;        -- Vertical synchonization impulsion
      blank     : out std_logic;        -- If 1,  video output must be null
      hcount    : out std_logic_vector(10 downto 0);   -- Pixel x coordinate
      vcount    : out std_logic_vector(10 downto 0));  -- Pixel y coordinate
  end component;
begin

  dcm_map : dcm
    port map
    (
      CLK_IN1  => fpga_clk,
      CLK_OUT1 => pixel_clk,
      RESET    => rst,
      LOCKED   => LOCKED);

  vga_map : vga
    port map (
      pixel_clk => pixel_clk,
      rst       => rst,
      hs        => hs,
      vs        => vs,
      blank     => blank,
      hcount    => hcount,
      vcount    => vcount);

  display_map : display
    port map(
      blank  => blank,
      hcount => hcount,
      vcount => vcount,
      red    => red,
      green  => green,
      blue   => blue);

end architecture;
