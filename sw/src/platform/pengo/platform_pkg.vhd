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
	constant PACE_VIDEO_NUM_SPRITES 	    : natural := 16;
	constant PACE_VIDEO_H_SIZE				    : integer := 224;
	constant PACE_VIDEO_V_SIZE				    : integer := 288;
	constant PACE_VIDEO_L_CROP            : integer := 0;
	constant PACE_VIDEO_R_CROP            : integer := PACE_VIDEO_L_CROP;
  constant PACE_VIDEO_PIPELINE_DELAY    : integer := 5;
	
	constant PACE_INPUTS_NUM_BYTES        : integer := 3;
	
	--
	-- Platform-specific constants (optional)
	--

	constant CLK0_FREQ_MHz			          : natural := 
    PACE_CLKIN0 * PACE_CLK0_MULTIPLY_BY / PACE_CLK0_DIVIDE_BY;
  constant CPU_FREQ_MHz                 : natural := 3;

	constant PACMAN_CPU_CLK_ENA_DIVIDE_BY : natural := CLK0_FREQ_MHz / CPU_FREQ_MHz;

	-- Palette : Table of RGB entries	

	type pal_entry_typ is array (0 to 2) of std_logic_vector(5 downto 0);
	type pal_typ is array (0 to 31) of pal_entry_typ;

	constant pal : pal_typ :=
	(
		1 => (0=>"110111", 1=>"110111", 2=>"110111"),
		2 => (0=>"111111", 1=>"000000", 2=>"000000"),
		3 => (0=>"000000", 1=>"111111", 2=>"000000"),
		4 => (0=>"001000", 1=>"001000", 2=>"110111"),
		5 => (0=>"000000", 1=>"111111", 2=>"110111"),
		6 => (0=>"111111", 1=>"111111", 2=>"000000"),
		7 => (0=>"111111", 1=>"101110", 2=>"110111"),
		8 => (0=>"111111", 1=>"101110", 2=>"010001"),
		9 => (0=>"110111", 1=>"010001", 2=>"000000"),
		10 => (0=>"111111", 1=>"101110", 2=>"000000"),
		11 => (0=>"111111", 1=>"111111", 2=>"010001"),
		12 => (0=>"000000", 1=>"110111", 2=>"110111"),
		13 => (0=>"110111", 1=>"110111", 2=>"000000"),
		14 => (0=>"011010", 1=>"011010", 2=>"110111"),
		15 => (0=>"110111", 1=>"000000", 2=>"110111"),
		17 => (0=>"110111", 1=>"110111", 2=>"110111"),
		18 => (0=>"000000", 1=>"011010", 2=>"110111"),
		19 => (0=>"000000", 1=>"110111", 2=>"110111"),
		20 => (0=>"000000", 1=>"111111", 2=>"110111"),
		21 => (0=>"110111", 1=>"010001", 2=>"000000"),
		22 => (0=>"111111", 1=>"000000", 2=>"000000"),
		23 => (0=>"111111", 1=>"101110", 2=>"000000"),
		24 => (0=>"110111", 1=>"110111", 2=>"000000"),
		25 => (0=>"111111", 1=>"111111", 2=>"000000"),
		26 => (0=>"111111", 1=>"111111", 2=>"010001"),
		27 => (0=>"000000", 1=>"101110", 2=>"000000"),
		28 => (0=>"010001", 1=>"110111", 2=>"000000"),
		29 => (0=>"000000", 1=>"111111", 2=>"000000"),
		30 => (0=>"111111", 1=>"101110", 2=>"110111"),
		31 => (0=>"110111", 1=>"000000", 2=>"110111"),
		others => (others => (others => '0'))
	);

	-- Colour Look-up Table (CLUT) : Table of palette entries
	-- - each row has four (4) palette indexes
	--   decoded from 2 bits of tile data
	
	type clut_entry_typ is array (0 to 3) of std_logic_vector(3 downto 0);
	type clut_typ is array (0 to 63) of clut_entry_typ;

	constant clut : clut_typ :=
	(
		1 => (0=>X"0", 1=>X"5", 2=>X"3", 3=>X"1"),
		2 => (0=>X"0", 1=>X"5", 2=>X"2", 3=>X"1"),
		3 => (0=>X"0", 1=>X"5", 2=>X"6", 3=>X"1"),
		4 => (0=>X"0", 1=>X"5", 2=>X"7", 3=>X"1"),
		5 => (0=>X"0", 1=>X"5", 2=>X"A", 3=>X"1"),
		6 => (0=>X"0", 1=>X"5", 2=>X"B", 3=>X"1"),
		7 => (0=>X"0", 1=>X"5", 2=>X"C", 3=>X"1"),
		8 => (0=>X"0", 1=>X"5", 2=>X"D", 3=>X"1"),
		9 => (0=>X"0", 1=>X"5", 2=>X"4", 3=>X"1"),
		10 => (0=>X"0", 1=>X"3", 2=>X"6", 3=>X"1"),
		11 => (0=>X"0", 1=>X"3", 2=>X"2", 3=>X"1"),
		12 => (0=>X"0", 1=>X"3", 2=>X"7", 3=>X"1"),
		13 => (0=>X"0", 1=>X"3", 2=>X"5", 3=>X"1"),
		14 => (0=>X"0", 1=>X"2", 2=>X"3", 3=>X"1"),
		16 => (0=>X"0", 1=>X"8", 2=>X"3", 3=>X"1"),
		17 => (0=>X"0", 1=>X"9", 2=>X"2", 3=>X"5"),
		18 => (0=>X"0", 1=>X"8", 2=>X"5", 3=>X"D"),
		19 => (0=>X"4", 1=>X"4", 2=>X"4", 3=>X"4"),
		22 => (0=>X"0", 1=>X"2", 2=>X"2", 3=>X"2"),
		23 => (0=>X"0", 1=>X"3", 2=>X"3", 3=>X"3"),
		24 => (0=>X"0", 1=>X"6", 2=>X"6", 3=>X"6"),
		25 => (0=>X"0", 1=>X"7", 2=>X"7", 3=>X"7"),
		26 => (0=>X"0", 1=>X"A", 2=>X"A", 3=>X"A"),
		27 => (0=>X"0", 1=>X"B", 2=>X"B", 3=>X"B"),
		28 => (0=>X"0", 1=>X"1", 2=>X"1", 3=>X"1"),
		29 => (0=>X"0", 1=>X"5", 2=>X"5", 3=>X"5"),
		30 => (0=>X"8", 1=>X"9", 2=>X"A", 3=>X"B"),
		31 => (0=>X"C", 1=>X"D", 2=>X"E", 3=>X"F"),
		33 => (0=>X"0", 1=>X"3", 2=>X"7", 3=>X"D"),
		34 => (0=>X"0", 1=>X"C", 2=>X"F", 3=>X"B"),
		35 => (0=>X"0", 1=>X"C", 2=>X"E", 3=>X"B"),
		36 => (0=>X"0", 1=>X"C", 2=>X"6", 3=>X"B"),
		37 => (0=>X"0", 1=>X"C", 2=>X"7", 3=>X"B"),
		38 => (0=>X"0", 1=>X"C", 2=>X"3", 3=>X"B"),
		39 => (0=>X"0", 1=>X"C", 2=>X"8", 3=>X"B"),
		40 => (0=>X"0", 1=>X"C", 2=>X"D", 3=>X"B"),
		41 => (0=>X"0", 1=>X"C", 2=>X"4", 3=>X"B"),
		42 => (0=>X"0", 1=>X"C", 2=>X"9", 3=>X"B"),
		43 => (0=>X"0", 1=>X"C", 2=>X"5", 3=>X"B"),
		44 => (0=>X"0", 1=>X"C", 2=>X"2", 3=>X"B"),
		45 => (0=>X"0", 1=>X"C", 2=>X"B", 3=>X"2"),
		46 => (0=>X"0", 1=>X"8", 2=>X"C", 3=>X"2"),
		47 => (0=>X"0", 1=>X"8", 2=>X"F", 3=>X"2"),
		48 => (0=>X"0", 1=>X"3", 2=>X"2", 3=>X"1"),
		49 => (0=>X"0", 1=>X"2", 2=>X"F", 3=>X"3"),
		50 => (0=>X"0", 1=>X"F", 2=>X"E", 3=>X"2"),
		51 => (0=>X"0", 1=>X"E", 2=>X"7", 3=>X"F"),
		52 => (0=>X"0", 1=>X"7", 2=>X"6", 3=>X"E"),
		53 => (0=>X"0", 1=>X"6", 2=>X"5", 3=>X"7"),
		54 => (0=>X"0", 1=>X"5", 2=>X"0", 3=>X"6"),
		55 => (0=>X"0", 1=>X"0", 2=>X"B", 3=>X"5"),
		56 => (0=>X"0", 1=>X"B", 2=>X"C", 3=>X"0"),
		57 => (0=>X"0", 1=>X"C", 2=>X"D", 3=>X"B"),
		58 => (0=>X"0", 1=>X"D", 2=>X"8", 3=>X"C"),
		59 => (0=>X"0", 1=>X"8", 2=>X"9", 3=>X"D"),
		60 => (0=>X"0", 1=>X"9", 2=>X"A", 3=>X"8"),
		61 => (0=>X"0", 1=>X"A", 2=>X"1", 3=>X"9"),
		62 => (0=>X"0", 1=>X"1", 2=>X"4", 3=>X"A"),
		63 => (0=>X"0", 1=>X"4", 2=>X"3", 3=>X"1"),
		others => (others => (others => '0'))
	);

	-- pacman (only) has an off-by-1 bug with the first 3 sprites
	-- see MAME vidhrdw/pacman.c for details
	constant XOFFSETHACK 							: natural := 0;
	constant SOUND_ROM_INIT_FILE			: string := "../../../../src/platform/pengo/roms/pengsnd.hex";

	constant PENGO_USE_ENCRYPTED_ROM	: boolean := false;
	
  type from_PLATFORM_IO_t is record
    not_used  : std_logic;
  end record;

  type to_PLATFORM_IO_t is record
    not_used  : std_logic;
  end record;

end;
