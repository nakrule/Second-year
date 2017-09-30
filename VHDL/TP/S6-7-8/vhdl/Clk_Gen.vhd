-- PLL_Numerique

--///////////////////////////////////////////////
--         PACKAGE local FOR PLL_Numerique
--///////////////////////////////////////////////

--------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;
library UNISIM;
use UNISIM.Vcomponents.ALL;

entity Clk_3x is
   port ( CLKIN_IN        : in    std_logic;
          RST_IN          : in    std_logic;
          CLKFX_OUT       : out   std_logic;
          CLKFX180_OUT    : out   std_logic;
          LOCKED_OUT      : out   std_logic);
end Clk_3x;

architecture BEHAVIORAL of Clk_3x is
   signal CLKFB_IN        : std_logic;
   signal CLKFX_BUF       : std_logic;
   signal CLKFX180_BUF    : std_logic;
   signal CLKIN_IBUFG     : std_logic;
   signal CLK0_BUF        : std_logic;
   signal GND_BIT         : std_logic;
begin

   GND_BIT <= '0';

   CLKFX_BUFG_INST : BUFG
      port map (I=>CLKFX_BUF,
                O=>CLKFX_OUT);

   CLKFX180_BUFG_INST : BUFG
      port map (I=>CLKFX180_BUF,
                O=>CLKFX180_OUT);

   CLKIN_IBUFG_INST : IBUFG
      port map (I=>CLKIN_IN,
                O=>CLKIN_IBUFG);

   CLK0_BUFG_INST : BUFG
      port map (I=>CLK0_BUF,
                O=>CLKFB_IN);

   DCM_SP_INST : DCM_SP
   generic map( CLK_FEEDBACK => "1X",
            CLKDV_DIVIDE => 2.0,
            CLKFX_DIVIDE => 1,
            CLKFX_MULTIPLY => 3,
            CLKIN_DIVIDE_BY_2 => FALSE,
            CLKIN_PERIOD => 50.0,
            CLKOUT_PHASE_SHIFT => "NONE",
            DESKEW_ADJUST => "SYSTEM_SYNCHRONOUS",
            DFS_FREQUENCY_MODE => "LOW",
            DLL_FREQUENCY_MODE => "LOW",
            DUTY_CYCLE_CORRECTION => TRUE,
            FACTORY_JF => x"8080",
            PHASE_SHIFT => 0,
            STARTUP_WAIT => FALSE)
      port map (CLKFB=>CLKFB_IN,
                CLKIN=>CLKIN_IBUFG,
                DSSEN=>GND_BIT,
                PSCLK=>GND_BIT,
                PSEN=>GND_BIT,
                PSINCDEC=>GND_BIT,
                RST=>RST_IN,
                CLKDV=>open,
                CLKFX=>CLKFX_BUF,--open,--
                CLKFX180=>CLKFX180_BUF,--open,--
                CLK0=>CLK0_BUF,
                CLK2X=>open,--CLKFX_BUF,--
                CLK2X180=>open,--CLKFX180_BUF,--
                CLK90=>open,
                CLK180=>open,
                CLK270=>open,
                LOCKED=>LOCKED_OUT,
                PSDONE=>open,
                STATUS=>open);

end BEHAVIORAL;

----------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
LIBRARY UNISIM;
USE UNISIM.vcomponents.all;

entity Clk_Gen is
port(
   clk_i : IN std_logic;
   clk_o, clk3x_o : OUT std_logic
   );
End Clk_Gen;

architecture struct of Clk_Gen is

COMPONENT Clk_3x is
   port ( CLKIN_IN        : in    std_logic;
          RST_IN          : in    std_logic;
          CLKFX_OUT       : out   std_logic;
          CLKFX180_OUT    : out   std_logic;
          LOCKED_OUT      : out   std_logic);
end COMPONENT;

begin

Clk_3x1 : Clk_3x
port map (
CLKIN_IN => clk_i,
RST_IN => '0',
CLKFX_OUT => clk3x_o,
CLKFX180_OUT => open,
LOCKED_OUT => open
);

clk_o <= clk_i;

end struct;
