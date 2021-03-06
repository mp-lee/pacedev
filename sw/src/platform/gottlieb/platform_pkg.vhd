library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;
use work.project_pkg.all;
use work.target_pkg.all;
use work.platform_variant_pkg.all;

package platform_pkg is

	--  
	-- PACE constants which *MUST* be defined
	--

  constant QBERT_VIDEO_H_SIZE				    : integer := 256;
	constant QBERT_VIDEO_V_SIZE				    : integer := 240;

	constant PACE_VIDEO_NUM_BITMAPS 	    : natural := 0;
	constant PACE_VIDEO_NUM_TILEMAPS 	    : natural := 1;
	constant PACE_VIDEO_NUM_SPRITES 	    : natural := 64;
	constant PACE_VIDEO_H_SIZE				    : integer := QBERT_VIDEO_H_SIZE;
	constant PACE_VIDEO_V_SIZE				    : integer := QBERT_VIDEO_V_SIZE;
	constant PACE_VIDEO_L_CROP            : integer := 0;
	constant PACE_VIDEO_R_CROP            : integer := 0;
	constant PACE_VIDEO_PIPELINE_DELAY    : integer := 3;
	
	constant PACE_INPUTS_NUM_BYTES        : integer := 5;
		
	--
	-- Platform-specific constants (optional)
	--

	constant CLK0_FREQ_MHz			          : natural := 
    PACE_CLKIN0 * PACE_CLK0_MULTIPLY_BY / PACE_CLK0_DIVIDE_BY;

	constant WILLIAMS_CPU_CLK_ENA_DIVIDE_BY	  : natural := 
          CLK0_FREQ_MHz / 3;

  constant GOTTLIEB_SOURCE_ROOT_DIR : string := "../../../../../src/platform/gottlieb/";
  constant VARIANT_SOURCE_ROOT_DIR  : string := GOTTLIEB_SOURCE_ROOT_DIR & 
                                                PLATFORM_VARIANT & "/";
  constant VARIANT_ROM_DIR          : string := VARIANT_SOURCE_ROOT_DIR &
                                                "roms/";
  constant VARIANT_RAM_DIR          : string := VARIANT_SOURCE_ROOT_DIR &
                                                "rams/";

  type from_PLATFORM_IO_t is record
    not_used  : std_logic;
  end record;

  type to_PLATFORM_IO_t is record
    not_used  : std_logic;
  end record;

end;
