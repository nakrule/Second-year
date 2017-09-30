----------------------------------------------------------------------------------
-- Company: HES-SO
-- Engineer: Samuel Riedo & Pascal Roulin
-- Create Date:    09:20:02 03/02/2017
-- Design Name:    marioPackage.vhd
-- Project Name: Super Mario World - FPGA Edition
-- Target Devices: Digilent NEXYS 3 (Xilinx Spartan 6 XC6LX16-CS324)
-- Description: All constants for Super Mario World - FPGA Edition project
-- Revision 0.01 - File Created
--          0.01 - vga controller constants added
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package marioPackage is
  -- vga constants
  constant HMAX   : integer := 1056;
  constant VMAX   : integer := 628;
  constant HLINES : integer := 800;
  constant VLINES : integer := 600;
  constant HSP    : integer := 968;
  constant HFP    : integer := 840;
  constant VFP    : integer := 601;
  constant VSP    : integer := 605;
  -- file constants
end marioPackage;
