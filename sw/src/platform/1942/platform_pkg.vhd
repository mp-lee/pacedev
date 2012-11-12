library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.project_pkg.all;
use work.target_pkg.all;
use work.platform_variant_pkg.all;

package platform_pkg is

	--  
	-- PACE constants which *MUST* be defined
	--

	constant PACE_VIDEO_NUM_BITMAPS		    : natural := 0;
	constant PACE_VIDEO_NUM_TILEMAPS 	    : natural := 2;
	constant PACE_VIDEO_NUM_SPRITES 	    : natural := 0; --32;
	constant PACE_VIDEO_H_SIZE				    : integer := 256; -- clipped to 224
	constant PACE_VIDEO_V_SIZE				    : integer := 256;
	constant PACE_VIDEO_L_CROP            : integer := 0;
	constant PACE_VIDEO_R_CROP            : integer := PACE_VIDEO_L_CROP;
  constant PACE_VIDEO_PIPELINE_DELAY    : integer := 3;
  
  constant PACE_INPUTS_NUM_BYTES        : integer := 4;

	constant CLK0_FREQ_MHz		            : natural := 
    PACE_CLKIN0 * PACE_CLK0_MULTIPLY_BY / PACE_CLK0_DIVIDE_BY;
  
	--
	-- Platform-specific constants (optional)
	--

  constant PLATFORM                     : string := "1942";
  constant PLATFORM_SRC_DIR             : string := "../../../../../src/platform/" & PLATFORM & "/";
  constant PLATFORM_VARIANT_SRC_DIR     : string := PLATFORM_SRC_DIR & PLATFORM_VARIANT & "/";
  
	type palette_entry_t is array (0 to 2) of std_logic_vector(5 downto 0);
	type palette_entry_a is array (0 to 255) of palette_entry_t;

  -- the 1942 palette
	constant pal : palette_entry_a :=
	(
    1 => (0=>"000000", 1=>"010100", 2=>"000000"),
    2 => (0=>"000000", 1=>"100011", 2=>"000000"),
    3 => (0=>"010000", 1=>"011000", 2=>"000000"),
    4 => (0=>"011000", 1=>"010100", 2=>"010000"),
    5 => (0=>"011100", 1=>"011000", 2=>"010100"),
    6 => (0=>"000000", 1=>"011100", 2=>"000000"),
    7 => (0=>"100011", 1=>"100011", 2=>"100011"),
    8 => (0=>"010100", 1=>"010000", 2=>"001011"),
    9 => (0=>"000000", 1=>"010100", 2=>"000000"),
    10 => (0=>"100011", 1=>"011100", 2=>"011000"),
    11 => (0=>"000000", 1=>"011100", 2=>"100011"),
    12 => (0=>"011100", 1=>"011100", 2=>"011100"),
    13 => (0=>"000000", 1=>"011000", 2=>"011100"),
    14 => (0=>"000000", 1=>"010100", 2=>"100011"),
    15 => (0=>"000000", 1=>"011000", 2=>"100111"),
    17 => (0=>"000000", 1=>"010100", 2=>"000000"),
    18 => (0=>"000000", 1=>"100011", 2=>"000000"),
    19 => (0=>"010000", 1=>"011000", 2=>"000000"),
    20 => (0=>"011000", 1=>"010100", 2=>"010000"),
    21 => (0=>"011100", 1=>"011000", 2=>"010100"),
    22 => (0=>"000000", 1=>"011100", 2=>"000000"),
    23 => (0=>"100011", 1=>"100011", 2=>"100011"),
    24 => (0=>"010100", 1=>"010100", 2=>"010100"),
    25 => (0=>"011000", 1=>"011000", 2=>"011000"),
    26 => (0=>"100011", 1=>"011100", 2=>"011000"),
    27 => (0=>"011100", 1=>"011100", 2=>"011100"),
    28 => (0=>"000000", 1=>"010000", 2=>"010100"),
    29 => (0=>"010100", 1=>"011000", 2=>"011000"),
    30 => (0=>"000000", 1=>"010100", 2=>"100011"),
    31 => (0=>"000000", 1=>"011000", 2=>"100111"),
    33 => (0=>"100111", 1=>"100111", 2=>"100111"),
    34 => (0=>"100011", 1=>"100011", 2=>"100011"),
    35 => (0=>"011000", 1=>"011100", 2=>"011100"),
    36 => (0=>"010100", 1=>"011000", 2=>"011000"),
    37 => (0=>"010000", 1=>"010100", 2=>"010100"),
    38 => (0=>"011100", 1=>"011000", 2=>"010100"),
    39 => (0=>"100011", 1=>"011100", 2=>"011000"),
    40 => (0=>"000000", 1=>"010100", 2=>"100011"),
    41 => (0=>"000000", 1=>"011000", 2=>"100111"),
    42 => (0=>"000000", 1=>"010000", 2=>"011100"),
    46 => (0=>"000000", 1=>"010100", 2=>"100011"),
    47 => (0=>"000000", 1=>"011000", 2=>"100111"),
    49 => (0=>"000000", 1=>"010100", 2=>"000000"),
    50 => (0=>"000000", 1=>"100011", 2=>"000000"),
    51 => (0=>"011100", 1=>"011000", 2=>"010100"),
    52 => (0=>"011000", 1=>"010100", 2=>"010000"),
    53 => (0=>"011100", 1=>"011000", 2=>"010100"),
    54 => (0=>"000000", 1=>"011100", 2=>"000000"),
    55 => (0=>"100011", 1=>"100011", 2=>"100011"),
    56 => (0=>"010100", 1=>"010000", 2=>"001011"),
    57 => (0=>"011000", 1=>"010100", 2=>"010000"),
    58 => (0=>"100011", 1=>"011100", 2=>"011000"),
    59 => (0=>"000000", 1=>"011100", 2=>"100011"),
    60 => (0=>"011100", 1=>"011100", 2=>"011100"),
    61 => (0=>"000000", 1=>"011000", 2=>"011100"),
    62 => (0=>"000000", 1=>"010100", 2=>"100011"),
    63 => (0=>"000000", 1=>"011000", 2=>"100111"),
    65 => (0=>"101111", 1=>"111100", 2=>"000000"),
    66 => (0=>"100111", 1=>"110100", 2=>"000000"),
    67 => (0=>"011100", 1=>"101011", 2=>"000000"),
    68 => (0=>"010100", 1=>"011100", 2=>"000000"),
    69 => (0=>"001011", 1=>"010100", 2=>"000000"),
    70 => (0=>"110100", 1=>"110100", 2=>"100111"),
    71 => (0=>"101011", 1=>"101011", 2=>"011100"),
    72 => (0=>"100011", 1=>"100011", 2=>"010100"),
    73 => (0=>"011000", 1=>"011000", 2=>"001011"),
    74 => (0=>"010000", 1=>"010000", 2=>"000011"),
    75 => (0=>"111100", 1=>"110100", 2=>"000000"),
    76 => (0=>"111100", 1=>"100111", 2=>"000000"),
    77 => (0=>"111000", 1=>"000000", 2=>"000000"),
    78 => (0=>"011100", 1=>"000000", 2=>"000000"),
    129 => (0=>"100011", 1=>"101011", 2=>"111000"),
    130 => (0=>"010100", 1=>"100111", 2=>"101111"),
    131 => (0=>"101111", 1=>"101111", 2=>"101111"),
    132 => (0=>"101011", 1=>"010100", 2=>"100011"),
    133 => (0=>"101011", 1=>"100111", 2=>"111111"),
    134 => (0=>"101111", 1=>"000000", 2=>"000000"),
    135 => (0=>"110100", 1=>"010100", 2=>"000000"),
    136 => (0=>"110100", 1=>"100111", 2=>"000000"),
    137 => (0=>"111100", 1=>"111100", 2=>"111100"),
    138 => (0=>"110100", 1=>"110100", 2=>"000000"),
    139 => (0=>"000000", 1=>"101011", 2=>"000000"),
    140 => (0=>"001011", 1=>"111000", 2=>"101111"),
    141 => (0=>"010000", 1=>"011000", 2=>"000000"),
    142 => (0=>"011000", 1=>"101011", 2=>"000000"),
    193 => (0=>"100011", 1=>"101011", 2=>"111000"),
    194 => (0=>"010100", 1=>"100111", 2=>"101111"),
    195 => (0=>"101111", 1=>"101111", 2=>"101111"),
    196 => (0=>"101011", 1=>"010100", 2=>"100011"),
    197 => (0=>"101011", 1=>"100111", 2=>"111111"),
    198 => (0=>"101111", 1=>"000000", 2=>"000000"),
    199 => (0=>"110100", 1=>"010100", 2=>"000000"),
    200 => (0=>"110100", 1=>"100111", 2=>"000000"),
    201 => (0=>"111100", 1=>"111100", 2=>"111100"),
    202 => (0=>"110100", 1=>"110100", 2=>"000000"),
    203 => (0=>"000000", 1=>"101011", 2=>"000000"),
    204 => (0=>"001011", 1=>"111000", 2=>"101111"),
    205 => (0=>"010000", 1=>"011000", 2=>"000000"),
    206 => (0=>"011000", 1=>"101011", 2=>"000000"),
		others => (others => (others => '0'))
	);

	-- Colour Look-up Table (CLUT) : Table of palette entries
	-- - each row has four (4) palette indexes
	--   decoded from 2 bits of tile data
	
	type fg_clut_entry_t is array (0 to 3) of std_logic_vector(3 downto 0);
	type fg_clut_entry_a is array (0 to 63) of fg_clut_entry_t;

	constant fg_clut : fg_clut_entry_a :=
	(
     0 => (0=>X"F", 1=>X"1", 2=>X"2", 3=>X"3"),
     1 => (0=>X"F", 1=>X"2", 2=>X"3", 3=>X"4"),
     2 => (0=>X"F", 1=>X"3", 2=>X"4", 3=>X"5"),
     3 => (0=>X"F", 1=>X"4", 2=>X"5", 3=>X"6"),
     4 => (0=>X"F", 1=>X"5", 2=>X"6", 3=>X"7"),
     5 => (0=>X"F", 1=>X"6", 2=>X"7", 3=>X"8"),
     6 => (0=>X"F", 1=>X"7", 2=>X"8", 3=>X"9"),
     7 => (0=>X"F", 1=>X"8", 2=>X"9", 3=>X"A"),
     8 => (0=>X"F", 1=>X"9", 2=>X"A", 3=>X"B"),
     9 => (0=>X"F", 1=>X"A", 2=>X"B", 3=>X"C"),
    10 => (0=>X"F", 1=>X"B", 2=>X"C", 3=>X"D"),
    11 => (0=>X"F", 1=>X"C", 2=>X"D", 3=>X"E"),
    12 => (0=>X"F", 1=>X"D", 2=>X"E", 3=>X"F"),
    13 => (0=>X"F", 1=>X"E", 2=>X"F", 3=>X"1"),
    14 => (0=>X"F", 1=>X"F", 2=>X"1", 3=>X"2"),
    16 => (0=>X"F", 1=>X"0", 2=>X"0", 3=>X"0"),
    17 => (0=>X"F", 1=>X"1", 2=>X"1", 3=>X"1"),
    18 => (0=>X"F", 1=>X"2", 2=>X"2", 3=>X"2"),
    19 => (0=>X"F", 1=>X"3", 2=>X"3", 3=>X"3"),
    20 => (0=>X"F", 1=>X"4", 2=>X"4", 3=>X"4"),
    21 => (0=>X"F", 1=>X"5", 2=>X"5", 3=>X"5"),
    22 => (0=>X"F", 1=>X"6", 2=>X"6", 3=>X"6"),
    23 => (0=>X"F", 1=>X"7", 2=>X"7", 3=>X"7"),
    24 => (0=>X"F", 1=>X"8", 2=>X"8", 3=>X"8"),
    25 => (0=>X"F", 1=>X"9", 2=>X"9", 3=>X"9"),
    26 => (0=>X"F", 1=>X"A", 2=>X"A", 3=>X"A"),
    27 => (0=>X"F", 1=>X"B", 2=>X"B", 3=>X"B"),
    28 => (0=>X"F", 1=>X"C", 2=>X"C", 3=>X"C"),
    29 => (0=>X"F", 1=>X"D", 2=>X"D", 3=>X"D"),
    30 => (0=>X"F", 1=>X"E", 2=>X"E", 3=>X"E"),
    32 => (0=>X"F", 1=>X"3", 2=>X"1", 3=>X"4"),
    33 => (0=>X"F", 1=>X"4", 2=>X"3", 3=>X"5"),
    34 => (0=>X"F", 1=>X"5", 2=>X"4", 3=>X"6"),
    35 => (0=>X"F", 1=>X"6", 2=>X"5", 3=>X"7"),
    36 => (0=>X"F", 1=>X"7", 2=>X"6", 3=>X"8"),
    37 => (0=>X"F", 1=>X"8", 2=>X"7", 3=>X"A"),
    38 => (0=>X"F", 1=>X"A", 2=>X"8", 3=>X"B"),
    39 => (0=>X"F", 1=>X"B", 2=>X"A", 3=>X"E"),
    40 => (0=>X"F", 1=>X"E", 2=>X"B", 3=>X"D"),
    41 => (0=>X"F", 1=>X"D", 2=>X"E", 3=>X"C"),
    42 => (0=>X"F", 1=>X"C", 2=>X"D", 3=>X"9"),
    43 => (0=>X"F", 1=>X"9", 2=>X"C", 3=>X"2"),
    44 => (0=>X"F", 1=>X"2", 2=>X"9", 3=>X"1"),
    45 => (0=>X"F", 1=>X"1", 2=>X"2", 3=>X"3"),
    48 => (0=>X"F", 1=>X"9", 2=>X"D", 3=>X"E"),
    49 => (0=>X"F", 1=>X"4", 2=>X"D", 3=>X"A"),
    50 => (0=>X"F", 1=>X"1", 2=>X"2", 3=>X"9"),
    51 => (0=>X"F", 1=>X"1", 2=>X"0", 3=>X"3"),
    60 => (0=>X"F", 1=>X"9", 2=>X"9", 3=>X"9"),
    61 => (0=>X"F", 1=>X"A", 2=>X"A", 3=>X"A"),
    62 => (0=>X"F", 1=>X"A", 2=>X"6", 3=>X"2"),
    63 => (0=>X"F", 1=>X"C", 2=>X"F", 3=>X"F"),
    others => (others => X"F")
	);

	type bg_clut_entry_t is array (0 to 7) of std_logic_vector(3 downto 0);
	type bg_clut_entry_a is array (0 to 32) of bg_clut_entry_t;

	constant bg_clut : bg_clut_entry_a :=
	(
     0 => (0=>X"0", 1=>X"1", 2=>X"2", 3=>X"3", 4=>X"4", 5=>X"5", 6=>X"8", 7=>X"A"),
     1 => (0=>X"0", 1=>X"1", 2=>X"7", 3=>X"C", 4=>X"4", 5=>X"5", 6=>X"E", 7=>X"F"),
     2 => (0=>X"0", 1=>X"1", 2=>X"2", 3=>X"3", 4=>X"4", 5=>X"5", 6=>X"6", 7=>X"A"),
     3 => (0=>X"0", 1=>X"1", 2=>X"D", 3=>X"3", 4=>X"4", 5=>X"E", 6=>X"9", 7=>X"F"),
     4 => (0=>X"0", 1=>X"1", 2=>X"A", 3=>X"3", 4=>X"4", 5=>X"5", 6=>X"6", 7=>X"8"),
     5 => (0=>X"0", 1=>X"1", 2=>X"2", 3=>X"E", 4=>X"F", 5=>X"5", 6=>X"6", 7=>X"7"),
     6 => (0=>X"0", 1=>X"1", 2=>X"8", 3=>X"3", 4=>X"B", 5=>X"E", 6=>X"6", 7=>X"F"),
     7 => (0=>X"0", 1=>X"1", 2=>X"7", 3=>X"B", 4=>X"9", 5=>X"E", 6=>X"D", 7=>X"F"),
     8 => (0=>X"0", 1=>X"1", 2=>X"F", 3=>X"C", 4=>X"4", 5=>X"5", 6=>X"6", 7=>X"7"),
     9 => (0=>X"0", 1=>X"1", 2=>X"A", 3=>X"F", 4=>X"4", 5=>X"E", 6=>X"6", 7=>X"7"),
    10 => (0=>X"0", 1=>X"1", 2=>X"2", 3=>X"3", 4=>X"4", 5=>X"5", 6=>X"6", 7=>X"9"),
    11 => (0=>X"0", 1=>X"A", 2=>X"2", 3=>X"9", 4=>X"8", 5=>X"5", 6=>X"6", 7=>X"7"),
    12 => (0=>X"0", 1=>X"8", 2=>X"A", 3=>X"3", 4=>X"4", 5=>X"5", 6=>X"D", 7=>X"B"),
    13 => (0=>X"0", 1=>X"1", 2=>X"2", 3=>X"3", 4=>X"C", 5=>X"5", 6=>X"6", 7=>X"D"),
    14 => (0=>X"0", 1=>X"1", 2=>X"2", 3=>X"3", 4=>X"5", 5=>X"8", 6=>X"9", 7=>X"A"),
    15 => (0=>X"0", 1=>X"8", 2=>X"2", 3=>X"9", 4=>X"4", 5=>X"5", 6=>X"6", 7=>X"7"),
    30 => (0=>X"0", 1=>X"1", 2=>X"2", 3=>X"3", 4=>X"4", 5=>X"5", 6=>X"6", 7=>X"7"),
    31 => (0=>X"0", 1=>X"D", 2=>X"8", 3=>X"9", 4=>X"A", 5=>X"B", 6=>X"C", 7=>X"E"),
    others => (others => X"F")
	);
  
  type from_PLATFORM_IO_t is record
    not_used  : std_logic;
  end record;

  type to_PLATFORM_IO_t is record
    not_used  : std_logic;
  end record;

end;
