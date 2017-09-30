----------------------------------------------------------------------------------
-- Company: HES-SO
-- Engineer: Samuel Riedo & Pascal Roulin
-- Create Date:    09:20:02 03/02/2017
-- Design Name: vga.vhd
-- Project Name: Super Mario World - FPGA Edition
-- Target Devices: Digilent NEXYS 3 (Xilinx Spartan 6 XC6LX16-CS324)
-- Description: Video Graphics Array
-- Revision 0.01 - File Created
--          1.00 - First functionnal version
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.marioPackage.all;

entity vga is
  port (
    pixel_clk : in  std_logic;          -- 40MHz
    rst       : in  std_logic;          -- active high
    hs        : out std_logic;          -- Horizontale synchonization impulsion
    vs        : out std_logic;          -- Vertical synchonization impulsion
    blank     : out std_logic;         -- If 1,  video output must be null
    hcount    : out std_logic_vector(10 downto 0);  -- Pixel x coordinate
    vcount    : out std_logic_vector(10 downto 0));  -- Pixel y coordinate
end entity vga;

architecture logic of vga is

  signal hcounter : integer range 0 to HMAX;
  signal vcounter : integer range 0 to VMAX;
  signal en       : std_logic;

begin

  hcount <= std_logic_vector(to_unsigned(hcounter, 11));
  vcount <= std_logic_vector(to_unsigned(vcounter, 11));
  en     <= '1' when (hcounter = HMAX) else '0';

  -- Processus: Pixel Counter
  process(rst, pixel_clk)
  begin
    if rst = '1' then
      hcounter <= 0;
    elsif rising_edge(pixel_clk) then
	   if hcounter = HMAX then
		  hcounter <= 0;
		else
      hcounter <= hcounter + 1;
		end if;
    end if;
  end process;

-- Processus: Line Counter
  process(rst, pixel_clk, en)
  begin
      if rst = '1' then
        vcounter <= 0;
      elsif rising_edge(pixel_clk) then
		if en = '1' then
		  if vcounter = VMAX then
		  vcounter <= 0;
		  else
        vcounter <= vcounter + 1;
		  end if;
      end if;
    end if;
  end process;

  process (pixel_clk, rst) is
  begin
    if rst = '1' then                   -- asynchronous reset (active low)
      hs <= '0';
    elsif rising_edge(pixel_clk) then   -- rising clock edge
      if (hcounter >= HFP and hcounter < HSP) then
        hs <= '1';
      else
        hs <= '0';
      end if;
    end if;
  end process;

  process (pixel_clk, rst) is
  begin
    if rst = '1' then                   -- asynchronous reset (active low)
      vs <= '0';
    elsif rising_edge(pixel_clk) then   -- rising clock edge
      if (vcounter >= VFP and vcounter < VSP) then
        vs <= '1';
      else
        vs <= '0';
      end if;
    end if;
  end process;

  process (pixel_clk, rst) is
  begin
    if rst = '1' then                   -- asynchronous reset (active low)
      blank <= '1';
    elsif rising_edge(pixel_clk) then   -- rising clock edge
      if (hcounter < HLINES and vcounter < VLINES) then
        blank <= '0';
      else
        blank <= '1';
      end if;
    end if;
  end process;

end architecture logic;
