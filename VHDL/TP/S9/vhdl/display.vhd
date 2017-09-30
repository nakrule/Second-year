----------------------------------------------------------------------------------
-- Company: HES-SO
-- Engineer: Samuel Riedo & Pascal Roulin
-- Create Date:    09:20:02 03/02/2017
-- Design Name:    display.vhd
-- Project Name: Super Mario World - FPGA Edition
-- Target Devices: Digilent NEXYS 3 (Xilinx Spartan 6 XC6LX16-CS324)
-- Description: Print a rectangle and a circle, only used as a vga demo
-- Revision 0.01 - File Created
--          1.00 - First functionnal version
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library work;
use work.marioPackage.all;

entity display is
  port (
    blank  : in  std_logic;             -- If 1, video output must be null
    hcount : in  std_logic_vector(10 downto 0);  -- Pixel x coordinate
    vcount : in  std_logic_vector(10 downto 0);  -- Pixel y coordinate
    red    : out std_logic_vector(2 downto 0);   -- Red color output
    green  : out std_logic_vector(2 downto 0);   -- Green color output
    blue   : out std_logic_vector(1 downto 0));  -- Blue color output
end entity display;

architecture logic of display is

  constant xc     : integer := 100;                -- circle x center
  constant yc     : integer := 100;                -- circle y center
  constant r2     : integer := 100;                -- circle rayon
  signal color    : std_logic_vector(7 downto 0);  -- Color output
  signal vcounter : integer range 0 to VMAX;
  signal hcounter : integer range 0 to HMAX;

begin

  vcounter <= to_integer(unsigned(vcount));
  hcounter <= to_integer(unsigned(hcount));

  red   <= color(7 downto 5) when blank = '0' else "000";
  green <= color(4 downto 2) when blank = '0' else "000";
  blue  <= color(1 downto 0) when blank = '0' else "00";

  process(hcounter, vcounter)
    variable temp : integer;
  begin
  -- cercle
    color <= "11111111";
    temp  := (((hcounter-xc)*(hcounter-xc))+((vcounter-yc)*(vcounter-yc)));
-- equation du cercle
    if temp = r2 then
      color <= "00000000";
    end if;

    --rectangle
    if(((vcounter = 200) or (vcounter = 400)) and ((hcounter > 200) and (hcounter < 600)))
      or
      (((hcounter = 200) or (hcounter = 600)) and ((vcounter > 200) and (vcounter < 400)))
    then
      color <= "00000000";
    end if;
  end process;
end architecture;
