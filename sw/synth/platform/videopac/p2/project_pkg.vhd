library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;
use work.pace_pkg.all;

package project_pkg is

	--  
	-- PACE constants which *MUST* be defined
	--
	
	constant PACE_HAS_PLL								: boolean := false;
	
  -- Reference clock is 24MHz
  constant PACE_CLK0_DIVIDE_BY        : natural := 21;
  constant PACE_CLK0_MULTIPLY_BY      : natural := 31;  		-- 24*31/21 = 35.429MHz (want 35.469)
  constant PACE_CLK1_DIVIDE_BY        : natural := 21;
  constant PACE_CLK1_MULTIPLY_BY      : natural := 31;  		-- (not used)

	constant PACE_ENABLE_ADV724					: std_logic := '1';
	constant PACE_ADV724_STD						: std_logic := ADV724_STD_PAL;

  -- P2-specific constants
  constant P2_JAMMA_IS_MAPLE          : boolean := false;
  constant P2_JAMMA_IS_NGC            : boolean := true;

	-- Videopac-specific constants
	constant VIDEOPAC_CART_NAME					: string := "kcmunch.hex";
					
end;
