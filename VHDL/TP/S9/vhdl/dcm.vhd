----------------------------------------------------------------------------------
-- Company: HES-SO
-- Engineer: Samuel Riedo & Pascal Roulin
-- Create Date:    09:20:02 03/02/2017
-- Design Name:    dcm.vhd
-- Project Name: Super Mario World - FPGA Edition
-- Target Devices: Digilent NEXYS 3 (Xilinx Spartan 6 XC6LX16-CS324)
-- Description: Input: 100MHz clock
--              Output: 40MHz clock
-- Revision 0.01 - File Created
--          1.00 - First functionnal version
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity dcm is
  port
    (                                   -- Clock in ports
      CLK_IN1  : in  std_logic;
      -- Clock out ports
      CLK_OUT1 : out std_logic;
      -- Status and control signals
      RESET    : in  std_logic;
      LOCKED   : out std_logic
      );
end dcm;

architecture xilinx of dcm is
  attribute CORE_GENERATION_INFO           : string;
  attribute CORE_GENERATION_INFO of xilinx : architecture is "DCM,clk_wiz_v3_6,
    {component_name=DCM,use_phase_alignment=true,use_min_o_jitter=false,
     use_max_i_jitter=false,use_dyn_phase_shift=false,use_inclk_switchover=false,
     use_dyn_reconfig=false, feedback_source=FDBK_AUTO,primtype_sel=DCM_SP,
     num_out_clk=1,clkin1_period=10.0,clkin2_period=10.0,use_power_down=false,
     use_reset=true,use_locked=true,use_inclk_stopped=false,use_status=false,
     use_freeze=false,use_clk_valid=false,feedback_type=SINGLE,clock_mgr_type=AUTO,
     manual_override=false}";
  -- Input clock buffering / unused connectors
  signal clkin1                            : std_logic;
  -- Output clock buffering
  signal clkfb                             : std_logic;
  signal clk0                              : std_logic;
  signal clkfx                             : std_logic;
  signal clkfbout                          : std_logic;
  signal locked_internal                   : std_logic;
  signal status_internal                   : std_logic_vector(7 downto 0);
begin


  -- Input buffering
  --------------------------------------
  clkin1_buf : IBUFG
    port map
    (O => clkin1,
     I => CLK_IN1);


  -- Clocking primitive
  --------------------------------------
  -- Instantiation of the DCM primitive
  --    * Unused inputs are tied off
  --    * Unused outputs are labeled unused
  dcm_sp_inst : DCM_SP
    generic map
    (CLKDV_DIVIDE       => 2.500,
     CLKFX_DIVIDE       => 5,
     CLKFX_MULTIPLY     => 2,
     CLKIN_DIVIDE_BY_2  => false,
     CLKIN_PERIOD       => 10.0,
     CLKOUT_PHASE_SHIFT => "NONE",
     CLK_FEEDBACK       => "1X",
     DESKEW_ADJUST      => "SYSTEM_SYNCHRONOUS",
     PHASE_SHIFT        => 0,
     STARTUP_WAIT       => false)
    port map
    -- Input clock
    (CLKIN    => clkin1,
     CLKFB    => clkfb,
     -- Output clocks
     CLK0     => clk0,
     CLK90    => open,
     CLK180   => open,
     CLK270   => open,
     CLK2X    => open,
     CLK2X180 => open,
     CLKFX    => clkfx,
     CLKFX180 => open,
     CLKDV    => open,
     -- Ports for dynamic phase shift
     PSCLK    => '0',
     PSEN     => '0',
     PSINCDEC => '0',
     PSDONE   => open,
     -- Other control and status signals
     LOCKED   => locked_internal,
     STATUS   => status_internal,
     RST      => RESET,
     -- Unused pin, tie low
     DSSEN    => '0');

  LOCKED <= locked_internal;



  -- Output buffering
  -------------------------------------
  clkf_buf : BUFG
    port map
    (O => clkfb,
     I => clk0);


  clkout1_buf : BUFG
    port map
    (O => CLK_OUT1,
     I => clkfx);

end xilinx;
