library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;
use work.pace_pkg.all;
use work.target_pkg.all;
use work.video_controller_pkg.all;

package project_pkg is

	--  
	-- PACE constants which *MUST* be defined
	--
	
	constant PACE_HAS_PLL										  : boolean := true;
	
  -- Reference clock is 24MHz
  constant PACE_VIDEO_CONTROLLER_TYPE       : PACEVideoController_t := PACE_VIDEO_VGA_800x600_60Hz;
  constant PACE_CLK0_DIVIDE_BY        		  : natural := 2;
  constant PACE_CLK0_MULTIPLY_BY      		  : natural := 1;   -- 24*1/2 = 12MHz
  constant PACE_CLK1_DIVIDE_BY        		  : natural := 3;
  constant PACE_CLK1_MULTIPLY_BY      		  : natural := 5;  	-- 24*5/3 = 40MHz
	constant PACE_VIDEO_H_SCALE         		  : integer := 2;
	constant PACE_VIDEO_V_SCALE         		  : integer := 2;
	constant PACE_ENABLE_ADV724							  : std_logic := '0';

	constant PACE_ADV724_STD								  : std_logic := ADV724_STD_PAL;

  -- P2-specific constants
  constant P2_JAMMA_IS_MAPLE                : boolean := false;
  constant P2_JAMMA_IS_NGC                  : boolean := true;

	-- Cabal-specific constants

	constant CABAL_USE_WF68K_CORE						  : boolean := true;
	constant CABAL_USE_TG68_CORE						  : boolean := not CABAL_USE_WF68K_CORE;
	
	constant CABAL_CPU_CLK_ENA_DIVIDE_BY	    : natural := 2;
	constant CABAL_1MHz_CLK0_COUNTS			      : natural := 12;
	
	constant USE_VIDEO_VBLANK_INTERRUPT 		  : boolean := false;
	
end;
