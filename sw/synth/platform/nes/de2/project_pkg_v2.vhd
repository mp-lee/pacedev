library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;
use work.pace_pkg.all;

package project_pkg is

	--  
	-- PACE constants which *MUST* be defined
	--
	
  -- Reference clock is 50MHz
	constant PACE_HAS_PLL										  : boolean := true;
  constant PACE_HAS_SRAM                    : boolean := true;
  constant PACE_HAS_SDRAM                   : boolean := false;
  constant PACE_HAS_FLASH                   : boolean := false;
  constant PACE_HAS_SERIAL                  : boolean := false;

  constant PACE_JAMMA	                      : PACEJamma_t := PACE_JAMMA_NGC;

  -- PAL 	1.773447MHz x 12 = 21.281364
  -- NTSC	1.7897725MHz x 12 = 21.47727
  constant PACE_CLK0_DIVIDE_BY        		  : natural := 7;
  constant PACE_CLK0_MULTIPLY_BY      		  : natural := 3;   -- 50*3/7 = 21.428571MHz
  constant PACE_CLK1_DIVIDE_BY        		  : natural := 7;
  constant PACE_CLK1_MULTIPLY_BY      		  : natural := 3;   -- 50*3/7 = 21.428571MHz

	-- DE2 constants which *MUST* be defined
	
	constant DE2_LCD_LINE2									  : string := "NES TENNIS (VGA)";

	-- NES-specific constants

  -- used to specify VGA/CVBS
	constant PACE_ENABLE_ADV724					      : std_logic := '0';

	constant NES_USE_INTERNAL_WRAM					  : boolean := true;
	
	-- VERTICAL MIRRORING is the "normal" option
	constant NES_MIRROR_VERTICAL						  : boolean := true;
	constant NES_MIRROR_HORIZONTAL					  : boolean := not NES_MIRROR_VERTICAL;
	
  type from_PROJECT_IO_t is record
    not_used  : std_logic;
  end record;

  type to_PROJECT_IO_t is record
    not_used  : std_logic;
  end record;

end;
