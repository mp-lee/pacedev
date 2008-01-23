library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;
use work.pace_pkg.all;
use work.video_controller_pkg.all;

package project_pkg is

	--  
	-- PACE constants which *MUST* be defined
	--
	
	constant PACE_HAS_PLL								      : boolean := true;	
	
  constant PACE_VIDEO_CONTROLLER_TYPE       : PACEVideoController_t := PACE_VIDEO_LCM_320x240_60Hz;
  constant PACE_CLK0_DIVIDE_BY              : natural := 5;
  constant PACE_CLK0_MULTIPLY_BY            : natural := 2;   -- 50*2/5 = 20MHz
  constant PACE_CLK1_DIVIDE_BY              : natural := 5;
  constant PACE_CLK1_MULTIPLY_BY            : natural := 4;   -- 50*9/25 = 18MHz
	constant PACE_VIDEO_H_SCALE               : integer := 1;
	constant PACE_VIDEO_V_SCALE               : integer := 1;

	-- DE2 constants which *MUST* be defined
	
	constant DE2_JAMMA_IS_MAPLE	              : boolean := false;
	constant DE2_JAMMA_IS_NGC                 : boolean := false;

	constant DE2_LCD_LINE2							      : string := "  GALXWARS-LCD  ";
		
	-- Galaxy Wars-specific constants
	
	constant INVADERS_CPU_CLK_ENA_DIVIDE_BY   : natural := 10;
	constant INVADERS_1MHz_CLK0_COUNTS				: natural := 20;

	constant INVADERS_USE_INTERNAL_WRAM       : boolean := true;		
	constant USE_VIDEO_VBLANK_INTERRUPT       : boolean := false;
	
end;
