library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

library work;
use work.project_pkg.all;
use work.target_pkg.all;

package platform_pkg is

	--  
	-- PACE constants which *MUST* be defined
	--

	constant PACE_VIDEO_NUM_BITMAPS 	    : natural := 0;
	constant PACE_VIDEO_NUM_TILEMAPS 	    : natural := 1;
	constant PACE_VIDEO_NUM_SPRITES 	    : natural := 0;
	constant PACE_VIDEO_H_SIZE				    : integer := 256;   -- 240
	constant PACE_VIDEO_V_SIZE				    : integer := 256;   -- 240
	constant PACE_VIDEO_PIPELINE_DELAY    : integer := 3;
	
	constant PACE_INPUTS_NUM_BYTES        : integer := 4;
		
	--
	-- Platform-specific constants (optional)
	--

	constant CLK0_FREQ_MHz			          : natural := 
    PACE_CLKIN0 * PACE_CLK0_MULTIPLY_BY / PACE_CLK0_DIVIDE_BY;

	constant WILLIAMS_CPU_CLK_ENA_DIVIDE_BY	  : natural := 
          CLK0_FREQ_MHz / 3;

  constant SONSON_SOURCE_ROOT_DIR   : string := "../../../../../src/platform/sonson/";
  constant SONSON_ROM_DIR           : string := SONSON_SOURCE_ROOT_DIR & "roms/";

	type palette_entry_t is array (0 to 2) of std_logic_vector(5 downto 0);
	type palette_entry_a is array (0 to 255) of palette_entry_t;

	constant pal : palette_entry_a :=
	(
    1 => (0=>"100111", 1=>"100111", 2=>"100111"),
    2 => (0=>"000000", 1=>"100011", 2=>"000000"),
    3 => (0=>"011100", 1=>"001011", 2=>"000111"),
    4 => (0=>"100111", 1=>"001011", 2=>"000111"),
    5 => (0=>"101111", 1=>"011000", 2=>"000000"),
    6 => (0=>"101111", 1=>"101111", 2=>"101111"),
    7 => (0=>"011100", 1=>"011100", 2=>"011100"),
    8 => (0=>"000000", 1=>"010000", 2=>"011000"),
    9 => (0=>"010000", 1=>"011000", 2=>"100111"),
    10 => (0=>"011000", 1=>"010000", 2=>"011000"),
    11 => (0=>"100011", 1=>"011000", 2=>"100011"),
    12 => (0=>"101011", 1=>"101011", 2=>"000000"),
    13 => (0=>"101011", 1=>"100111", 2=>"101011"),
    14 => (0=>"011100", 1=>"011100", 2=>"110100"),
    15 => (0=>"110100", 1=>"000000", 2=>"000000"),
    17 => (0=>"110100", 1=>"110100", 2=>"110100"),
    18 => (0=>"100111", 1=>"100111", 2=>"100111"),
    19 => (0=>"110100", 1=>"100111", 2=>"011100"),
    20 => (0=>"101011", 1=>"000000", 2=>"000000"),
    21 => (0=>"011100", 1=>"000000", 2=>"000000"),
    22 => (0=>"101011", 1=>"011100", 2=>"000000"),
    23 => (0=>"111000", 1=>"101111", 2=>"000000"),
    24 => (0=>"111100", 1=>"000000", 2=>"000000"),
    25 => (0=>"100011", 1=>"000000", 2=>"100111"),
    26 => (0=>"011000", 1=>"000000", 2=>"101011"),
    27 => (0=>"011100", 1=>"011100", 2=>"111000"),
    28 => (0=>"111100", 1=>"011100", 2=>"000000"),
    29 => (0=>"000000", 1=>"100011", 2=>"000000"),
    30 => (0=>"000000", 1=>"101011", 2=>"000000"),
    31 => (0=>"000011", 1=>"000011", 2=>"000011"),
		others => (others => (others => '0'))
	);

	-- Colour Look-up Table (CLUT) : Table of palette entries
	-- - each row has four (4) palette indexes
	--   decoded from 2 bits of tile data
	
	type tile_clut_entry_t is array (0 to 3) of std_logic_vector(3 downto 0);
	type tile_clut_entry_a is array (0 to 63) of tile_clut_entry_t;

	constant tile_clut : tile_clut_entry_a :=
	(
     0 => (0=>X"0", 1=>X"B", 2=>X"0", 3=>X"0"),
     1 => (0=>X"0", 1=>X"C", 2=>X"0", 3=>X"0"),
     2 => (0=>X"0", 1=>X"D", 2=>X"0", 3=>X"0"),
     3 => (0=>X"0", 1=>X"E", 2=>X"0", 3=>X"0"),
     4 => (0=>X"0", 1=>X"F", 2=>X"0", 3=>X"0"),
     6 => (0=>X"0", 1=>X"1", 2=>X"0", 3=>X"0"),
     7 => (0=>X"0", 1=>X"2", 2=>X"0", 3=>X"0"),
     8 => (0=>X"0", 1=>X"3", 2=>X"0", 3=>X"0"),
     9 => (0=>X"0", 1=>X"4", 2=>X"0", 3=>X"0"),
    10 => (0=>X"0", 1=>X"5", 2=>X"0", 3=>X"0"),
    11 => (0=>X"0", 1=>X"6", 2=>X"0", 3=>X"0"),
    12 => (0=>X"0", 1=>X"7", 2=>X"0", 3=>X"0"),
    13 => (0=>X"0", 1=>X"8", 2=>X"0", 3=>X"0"),
    14 => (0=>X"0", 1=>X"9", 2=>X"0", 3=>X"0"),
    15 => (0=>X"0", 1=>X"A", 2=>X"0", 3=>X"0"),
    16 => (0=>X"0", 1=>X"8", 2=>X"9", 3=>X"E"),
    17 => (0=>X"0", 1=>X"A", 2=>X"B", 3=>X"D"),
    18 => (0=>X"0", 1=>X"3", 2=>X"4", 3=>X"5"),
    19 => (0=>X"0", 1=>X"7", 2=>X"1", 3=>X"6"),
    20 => (0=>X"0", 1=>X"3", 2=>X"4", 3=>X"2"),
    21 => (0=>X"0", 1=>X"7", 2=>X"0", 3=>X"6"),
    22 => (0=>X"0", 1=>X"2", 2=>X"3", 3=>X"4"),
    23 => (0=>X"0", 1=>X"2", 2=>X"A", 3=>X"B"),
    24 => (0=>X"0", 1=>X"9", 2=>X"6", 3=>X"E"),
    25 => (0=>X"0", 1=>X"1", 2=>X"6", 3=>X"7"),
    26 => (0=>X"0", 1=>X"7", 2=>X"1", 3=>X"6"),
    27 => (0=>X"0", 1=>X"2", 2=>X"C", 3=>X"6"),
    28 => (0=>X"0", 1=>X"C", 2=>X"F", 3=>X"2"),
    29 => (0=>X"0", 1=>X"2", 2=>X"B", 3=>X"6"),
    30 => (0=>X"0", 1=>X"2", 2=>X"F", 3=>X"6"),
    31 => (0=>X"0", 1=>X"2", 2=>X"B", 3=>X"D"),
    32 => (0=>X"0", 1=>X"2", 2=>X"1", 3=>X"6"),
    33 => (0=>X"0", 1=>X"2", 2=>X"9", 3=>X"E"),
    34 => (0=>X"0", 1=>X"2", 2=>X"4", 3=>X"F"),
    35 => (0=>X"0", 1=>X"2", 2=>X"9", 3=>X"6"),
    36 => (0=>X"0", 1=>X"2", 2=>X"F", 3=>X"6"),
    37 => (0=>X"0", 1=>X"C", 2=>X"3", 3=>X"5"),
    38 => (0=>X"0", 1=>X"1", 2=>X"3", 3=>X"5"),
    39 => (0=>X"0", 1=>X"4", 2=>X"5", 3=>X"6"),
    40 => (0=>X"0", 1=>X"7", 2=>X"1", 3=>X"5"),
    41 => (0=>X"0", 1=>X"9", 2=>X"E", 3=>X"C"),
    42 => (0=>X"0", 1=>X"4", 2=>X"F", 3=>X"3"),
    43 => (0=>X"0", 1=>X"4", 2=>X"F", 3=>X"6"),
    44 => (0=>X"0", 1=>X"1", 2=>X"5", 3=>X"6"),
    45 => (0=>X"0", 1=>X"4", 2=>X"5", 3=>X"2"),
    46 => (0=>X"0", 1=>X"4", 2=>X"5", 3=>X"C"),
    47 => (0=>X"0", 1=>X"E", 2=>X"9", 3=>X"6"),
    48 => (0=>X"0", 1=>X"4", 2=>X"F", 3=>X"2"),
    49 => (0=>X"0", 1=>X"4", 2=>X"F", 3=>X"6"),
    50 => (0=>X"0", 1=>X"B", 2=>X"D", 3=>X"6"),
    51 => (0=>X"C", 1=>X"D", 2=>X"E", 3=>X"0"),
    52 => (0=>X"1", 1=>X"2", 2=>X"3", 3=>X"4"),
    53 => (0=>X"5", 1=>X"6", 2=>X"7", 3=>X"8"),
    54 => (0=>X"9", 1=>X"A", 2=>X"B", 3=>X"C"),
    55 => (0=>X"D", 1=>X"E", 2=>X"0", 3=>X"F"),
    56 => (0=>X"2", 1=>X"3", 2=>X"4", 3=>X"5"),
    57 => (0=>X"6", 1=>X"7", 2=>X"8", 3=>X"9"),
    58 => (0=>X"A", 1=>X"B", 2=>X"C", 3=>X"D"),
    59 => (0=>X"E", 1=>X"0", 2=>X"F", 3=>X"1"),
    60 => (0=>X"3", 1=>X"4", 2=>X"5", 3=>X"6"),
    61 => (0=>X"7", 1=>X"8", 2=>X"9", 3=>X"A"),
    62 => (0=>X"B", 1=>X"C", 2=>X"D", 3=>X"E"),
    63 => (0=>X"0", 1=>X"F", 2=>X"1", 3=>X"2"),
    others => (others => X"0")
  );

  type from_PLATFORM_IO_t is record
    not_used  : std_logic;
  end record;

  type to_PLATFORM_IO_t is record
    not_used  : std_logic;
  end record;

end;
