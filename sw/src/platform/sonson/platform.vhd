library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.pace_pkg.all;
use work.sdram_pkg.all;
use work.video_controller_pkg.all;
use work.sprite_pkg.all;
use work.target_pkg.all;
use work.platform_pkg.all;
use work.project_pkg.all;

entity platform is
  generic
  (
    NUM_INPUT_BYTES   : integer
  );
  port
  (
    -- clocking and reset
    clkrst_i        : in from_CLKRST_t;

    -- misc I/O
    buttons_i       : in from_BUTTONS_t;
    switches_i      : in from_SWITCHES_t;
    leds_o          : out to_LEDS_t;

    -- controller inputs
    inputs_i        : in from_MAPPED_INPUTS_t(0 to NUM_INPUT_BYTES-1);

    -- FLASH/SRAM
    flash_i         : in from_FLASH_t;
    flash_o         : out to_FLASH_t;
		sram_i					: in from_SRAM_t;
		sram_o					: out to_SRAM_t;
		sdram_i         : in from_SDRAM_t;
		sdram_o         : out to_SDRAM_t;

    -- graphics
    
    bitmap_i        : in from_BITMAP_CTL_a(1 to PACE_VIDEO_NUM_BITMAPS);
    bitmap_o        : out to_BITMAP_CTL_a(1 to PACE_VIDEO_NUM_BITMAPS);
    
    tilemap_i       : in from_TILEMAP_CTL_a(1 to PACE_VIDEO_NUM_TILEMAPS);
    tilemap_o       : out to_TILEMAP_CTL_a(1 to PACE_VIDEO_NUM_TILEMAPS);

    sprite_reg_o    : out to_SPRITE_REG_t;
    sprite_i        : in from_SPRITE_CTL_t;
    sprite_o        : out to_SPRITE_CTL_t;
		spr0_hit				: in std_logic;

    -- various graphics information
    graphics_i      : in from_GRAPHICS_t;
    graphics_o      : out to_GRAPHICS_t;
    
    -- OSD
    osd_i           : in from_OSD_t;
    osd_o           : out to_OSD_t;

    -- sound
    snd_i           : in from_SOUND_t;
    snd_o           : out to_SOUND_t;
    
    -- SPI (flash)
    spi_i           : in from_SPI_t;
    spi_o           : out to_SPI_t;

    -- serial
    ser_i           : in from_SERIAL_t;
    ser_o           : out to_SERIAL_t;

    -- custom i/o
    project_i       : in from_PROJECT_IO_t;
    project_o       : out to_PROJECT_IO_t;
    platform_i      : in from_PLATFORM_IO_t;
    platform_o      : out to_PLATFORM_IO_t;
    target_i        : in from_TARGET_IO_t;
    target_o        : out to_TARGET_IO_t
  );

end platform;

architecture SYN of platform is

	constant WILLIAMS_VRAM_SIZE		: integer := 2**WILLIAMS_VRAM_WIDTHAD;

	alias clk_20M					    : std_logic is clkrst_i.clk(0);
  alias rst_20M             : std_logic is clkrst_i.rst(0);
	alias clk_video				    : std_logic is clkrst_i.clk(1);
	signal cpu_reset			    : std_logic;
  
  -- uP signals  
  signal clk_1M_en			    : std_logic;
	signal clk_1M_en_n		    : std_logic;
	signal cpu_r_wn				    : std_logic;
	signal cpu_vma				    : std_logic;
	signal cpu_ba				      : std_logic;
	signal cpu_bs				      : std_logic;
	signal cpu_a				      : std_logic_vector(15 downto 0);
	signal cpu_d_i			      : std_logic_vector(7 downto 0);
	signal cpu_d_o			      : std_logic_vector(7 downto 0);
	signal cpu_irq				    : std_logic;
	signal cpu_firq				    : std_logic;
	signal cpu_nmi				    : std_logic;

  -- ROM signals        
	signal rom_cs				      : std_logic;
  signal rom_d_o            : std_logic_vector(7 downto 0);
	
  -- RAM signals        
	signal wram_cs				    : std_logic;
  signal wram_wr            : std_logic;
  alias wram_d_o      	    : std_logic_vector(7 downto 0) is sram_i.d(7 downto 0);
	signal vram_cs				    : std_logic;
  signal vram_d_o           : std_logic_vector(7 downto 0);
  signal vram_wr            : std_logic;
	signal cram_cs				    : std_logic;
  signal cram_d_o           : std_logic_vector(7 downto 0);
  signal cram_wr            : std_logic;

  -- other signals   
	alias platform_reset			: std_logic is inputs_i(3).d(0);
	alias platform_pause      : std_logic is inputs_i(3).d(1);
	signal va11						    : std_logic;
	signal count240				    : std_logic;
	
begin

	-- cpu09 core uses negative clock edge
	clk_1M_en_n <= not (clk_1M_en and not platform_pause);
	--clk_1M_en_n <= not (clk_1M_en and not platform_pause) or cpu_halt;

	-- add game reset later
	cpu_reset <= rst_20M or platform_reset;
	
  -- SRAM signals (may or may not be used)
  sram_o.a(sram_o.a'left downto 17) <= (others => '0');
  sram_o.a(16 downto 0)	<= 	std_logic_vector(resize(unsigned(cpu_a), 17));
  sram_o.d <= std_logic_vector(resize(unsigned(cpu_d_o), sram_o.d'length)) 
								when (wram_wr = '1') else (others => 'Z');
  sram_o.be <= std_logic_vector(to_unsigned(1, sram_o.be'length));
  sram_o.cs <= '1';
  sram_o.oe <= not wram_wr;
  sram_o.we <= wram_wr;

	-- RAM $0000-$0FFF
	wram_cs <=		'1' when STD_MATCH(cpu_a,  "0000------------") else
								'0';
  -- ROM $4000-$FFFF
  --            $4000-$7FFF
	rom_cs  <= 	  '1' when STD_MATCH(cpu_a,  "01--------------") else 
  --            $8000-$FFFF
                '1' when STD_MATCH(cpu_a,  "1---------------") else 
                '0';
  -- video ram $1000-$13FF
  vram_cs <=		'1' when STD_MATCH(cpu_a,  "000100----------") else
                '0';
  -- colour ram $1400-$17FF
  cram_cs <=		'1' when STD_MATCH(cpu_a,  "000101----------") else
                '0';

  -- memory block write enables
  wram_wr <= wram_cs and clk_1M_en and not cpu_r_wn;
  vram_wr <= vram_cs and clk_1M_en and not cpu_r_wn;
  cram_wr <= cram_cs and clk_1M_en and not cpu_r_wn;

	-- memory read mux
	cpu_d_i <=  wram_d_o when wram_cs = '1' else
							vram_d_o when vram_cs = '1' else
							cram_d_o when cram_cs = '1' else
              rom_d_o when rom_cs = '1' else
							(others => 'Z');
		
	-- irqa interrupt at scanline 240
	process (clk_20M, rst_20M)
	begin
		if rst_20M = '1' then
			count240 <= '0';
		elsif rising_edge(clk_20M) then
			if graphics_i.y = std_logic_vector(to_unsigned(0, graphics_i.y'length)) then
				count240 <= '0';
			-- check for 240
			--elsif video_counter = 240 then
			elsif graphics_i.y = std_logic_vector(to_unsigned(239, graphics_i.y'length)) then
				count240 <= '1';
			end if;
		end if;
	end process;

	-- irqb every 32 scanlines
	va11 <= graphics_i.y(5);

	-- cpu interrupts
	cpu_irq <= '0';
	cpu_firq <= '0';
	cpu_nmi <= '0';

  -- system timing
  process (clk_20M, rst_20M)
    variable count : integer range 0 to 20-1;
  begin
    if rst_20M = '1' then
      count := 0;
    elsif rising_edge(clk_20M) then
      clk_1M_en <= '0'; -- default
      case count is
        when 0 =>
          clk_1M_en <= '1';
        when others =>
          null;
      end case;
      if count = count'high then
        count := 0;
      else
        count := count + 1;
      end if;
    end if;
  end process;

	cpu_inst : entity work.cpu09
		port map
		(	
			clk				=> clk_1M_en_n,
			rst				=> cpu_reset,
			rw				=> cpu_r_wn,
			vma				=> cpu_vma,
      ba        => cpu_ba,
      bs        => cpu_bs,
			addr		  => cpu_a,
		  data_in		=> cpu_d_i,
		  data_out	=> cpu_d_o,
			halt			=> '0',
			hold			=> '0',
			irq				=> cpu_irq,
			firq			=> cpu_firq,
			nmi				=> cpu_nmi
		);

	GEN_FPGA_ROMS : if true generate
    signal rom4_d_o   : std_logic_vector(7 downto 0);
    signal rom8_d_o   : std_logic_vector(7 downto 0);
    signal romC_d_o   : std_logic_vector(7 downto 0);
  begin
  
    rom_4000_inst : entity work.sprom
      generic map
      (
        init_file		=> SONSON_ROM_DIR & "ss_01e.hex",
        widthad_a		=> 14
      )
      port map
      (
        clock			=> clk_20M,
        address		=> cpu_a(13 downto 0),
        q					=> rom4_d_o
      );
    
    rom_8000_inst : entity work.sprom
      generic map
      (
        init_file		=> SONSON_ROM_DIR & "ss_02e.hex",
        widthad_a		=> 14
      )
      port map
      (
        clock			=> clk_20M,
        address		=> cpu_a(13 downto 0),
        q					=> rom8_d_o
      );
      
    rom_C000_inst : entity work.sprom
      generic map
      (
        init_file		=> SONSON_ROM_DIR & "ss_03e.hex",
        widthad_a		=> 14
      )
      port map
      (
        clock			=> clk_20M,
        address		=> cpu_a(13 downto 0),
        q					=> romC_d_o
      );
		
    rom_d_o <=  rom4_d_o when STD_MATCH(cpu_a, "01--------------") else
                rom8_d_o when STD_MATCH(cpu_a, "10--------------") else
                romC_d_o;
                  
	end generate GEN_FPGA_ROMS;

  -- wren_a *MUST* be GND for CYCLONEII_SAFE_WRITE=VERIFIED_SAFE
  vram_inst : entity work.dpram
    generic map
    (
      init_file		=> SONSON_ROM_DIR & "vram.hex",
      widthad_a		=> 10
    )
    port map
    (
      clock_b			=> clk_20M,
      address_b		=> cpu_a(9 downto 0),
      wren_b			=> vram_wr,
      data_b			=> cpu_d_o,
      q_b					=> vram_d_o,

      clock_a			=> clk_video,
      address_a		=> tilemap_i(1).tile_a(9 downto 0),
      wren_a			=> '0',
      data_a			=> (others => 'X'),
      q_a					=> tilemap_o(1).tile_d(7 downto 0)
    );
  tilemap_o(1).tile_d(tilemap_o(1).tile_d'left downto 8) <= (others => 'Z');
  
  -- wren_a *MUST* be GND for CYCLONEII_SAFE_WRITE=VERIFIED_SAFE
  cram_inst : entity work.dpram
    generic map
    (
      init_file		=> SONSON_ROM_DIR & "cram.hex",
      widthad_a		=> 10
    )
    port map
    (
      clock_b			=> clk_20M,
      address_b		=> cpu_a(9 downto 0),
      wren_b			=> cram_wr,
      data_b			=> cpu_d_o,
      q_b					=> cram_d_o,

      clock_a			=> clk_video,
      address_a		=> tilemap_i(1).attr_a(9 downto 0),
      wren_a			=> '0',
      data_a			=> (others => 'X'),
      q_a					=> tilemap_o(1).attr_d(7 downto 0)
    );
  tilemap_o(1).attr_d(tilemap_o(1).attr_d'left downto 8) <= (others => 'Z');

  -- unused outputs
  flash_o <= NULL_TO_FLASH;
  sprite_reg_o <= NULL_TO_SPRITE_REG;
  sprite_o <= NULL_TO_SPRITE_CTL;
  graphics_o.bit8(0) <= (others => '0');
  graphics_o.bit16(0) <= (others => '0');
  osd_o <= NULL_TO_OSD;
  snd_o <= NULL_TO_SOUND;
  ser_o <= NULL_TO_SERIAL;
  spi_o <= NULL_TO_SPI;
	leds_o <= (others => '0');

end SYN;
