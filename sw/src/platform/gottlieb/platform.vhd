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
use work.platform_variant_pkg.all;
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
	signal cpu_a				      : std_logic_vector(15 downto 0);
	signal cpu_d_i			      : std_logic_vector(15 downto 0);
	signal cpu_d_o			      : std_logic_vector(15 downto 0);
	signal cpu_irq				    : std_logic;

  -- RAM signals        
	signal wram_cs				    : std_logic;
  signal wram_wr            : std_logic;
  alias wram_d_o      	    : std_logic_vector(7 downto 0) is sram_i.d(7 downto 0);

  -- VRAM/CRAM signals       
	signal vram_cs				    : std_logic;
	signal vram_wr				    : std_logic;
  signal vram_d_o           : std_logic_vector(7 downto 0);
	signal cram_cs				    : std_logic;
	signal cram_wr				    : std_logic;
  signal cram_d_o           : std_logic_vector(7 downto 0);

  -- ROM signals        
	signal rom_cs				      : std_logic;
  signal rom_d_o            : std_logic_vector(7 downto 0);
	
  -- I/O signals
	signal palette_cs			    : std_logic;
	signal palette_r			    : PAL_A_t(15 downto 0);
	signal nvram_cs				    : std_logic;
	signal nvram_wr				    : std_logic;
	signal nvram_data			    : std_logic_vector(7 downto 0);
	                        
  -- other signals   
	alias platform_reset			: std_logic is inputs_i(3).d(0);
	alias platform_pause      : std_logic is inputs_i(3).d(1);
	
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

	-- nvram $0000-$0FFF
	nvram_cs <=		'1' when STD_MATCH(cpu_a, X"0"&"------------") else '0';
	-- RAM $1000-$1FFF, $2000-$2FFF
	wram_cs <=		'1' when STD_MATCH(cpu_a, X"1"&"------------") else
                '1' when STD_MATCH(cpu_a, X"2"&"------------") else
								'0';
  -- video ram $3800-$3BFF
  vram_cs <=		'1' when STD_MATCH(cpu_a, X"3"&"10----------") else
                '0';
  -- character ram $4000-$4FFF
  cram_cs <=		'1' when STD_MATCH(cpu_a, X"4"&"------------") else
                '0';
	-- ROM $A000-$FFFF
  --            $A000-$BFFF
	rom_cs <= 	  '1' when STD_MATCH(cpu_a,  "101-------------") else 
  --            $C000-$FFFF
                '1' when STD_MATCH(cpu_a,  "11--------------") else 
                '0';

	-- I/O decoding
  -- Palette $C000-$C00F
	palette_cs <=				'1' when STD_MATCH(cpu_a, X"C00"&"----") else '0';

  -- memory block write enables
	nvram_wr <= nvram_cs and not cpu_r_wn;
  wram_wr <= wram_cs and not cpu_r_wn;
  vram_wr <= vram_cs and not cpu_r_wn;
  cram_wr <= cram_cs and not cpu_r_wn;

	-- memory read mux
	cpu_d_i <=  nvram_data when nvram_cs = '1' else
							wram_d_o when wram_cs = '1' else
							vram_d_o when vram_cs = '1' else
							cram_d_o when cram_cs = '1' else
              rom_d_o when rom_cs = '1' else
							(others => '0');
		
	-- implementation of palette RAM
	process (clk_20M)
		variable offset : integer range 0 to 2**4-1;
	begin
		if rising_edge(clk_20M) then
      if clk_1M_en = '1' then
        if palette_cs = '1' and cpu_r_wn = '0' then
          offset := to_integer(unsigned(cpu_a(3 downto 0)));
          palette_r(offset) <= cpu_d_o;
        end if;
      end if;
		end if;
		graphics_o.pal <= palette_r;
	end process;

--	-- irqa interrupt at scanline 240
--	process (clk_20M, rst_20M)
--	begin
--		if rst_20M = '1' then
--			count240 <= '0';
--		elsif rising_edge(clk_20M) then
--			if graphics_i.y = std_logic_vector(to_unsigned(0, graphics_i.y'length)) then
--				count240 <= '0';
--			-- check for 240
--			--elsif video_counter = 240 then
--			elsif graphics_i.y = std_logic_vector(to_unsigned(239, graphics_i.y'length)) then
--				count240 <= '1';
--			end if;
--		end if;
--	end process;
--
--	-- irqb every 32 scanlines
--	va11 <= graphics_i.y(5);

	-- cpu interrupts
	cpu_irq <= '0';

  -- unused outputs
  flash_o <= NULL_TO_FLASH;
  sprite_reg_o <= NULL_TO_SPRITE_REG;
  sprite_o <= NULL_TO_SPRITE_CTL;
  --tilemap_o <= NULL_TO_TILEMAP_CTL;
  graphics_o.bit8(0) <= (others => '0');
  graphics_o.bit16(0) <= (others => '0');
  osd_o <= NULL_TO_OSD;
  snd_o <= NULL_TO_SOUND;
  ser_o <= NULL_TO_SERIAL;
  spi_o <= NULL_TO_SPI;
	leds_o <= (others => '0');

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

  BLK_CPU : block
    component zet is
      port
      (
        -- Wishbone master interface
        wb_clk_i      : in std_logic;
        wb_rst_i      : in std_logic;
        wb_dat_i      : in std_logic_vector(15 downto 0);
        wb_dat_o      : out std_logic_vector(15 downto 0);
        wb_adr_o      : out std_logic_vector(19 downto 1);
        wb_we_o       : out std_logic;
        wb_tga_o      : out std_logic;  -- io/mem
        wb_sel_o      : out std_logic_vector(1 downto 0);
        wb_stb_o      : out std_logic;
        wb_cyc_o      : out std_logic;
        wb_ack_i      : in std_logic;
        wb_tgc_i      : in std_logic;   -- intr
        wb_tgc_o      : out std_logic;  -- inta
        nmi           : in std_logic;
        nmia          : out std_logic;

        -- for debugging purposes
        pc            : out std_logic_vector(19 downto 0)
      );
    end component zet;
  begin
  end block BLK_CPU;
  
	-- Battery-backed CMOS RAM
	nvram_inst : entity work.spram
		generic map
		(
			init_file		=> VARIANT_ROM_DIR & "nvram.hex",
			widthad_a		=> 10,
			width_a		  => 8
		)
		port map
		(
			clock				=> clk_20M,
			address			=> cpu_a(9 downto 0),
			wren				=> nvram_wr,
			data				=> cpu_d_o,
			q						=> nvram_data
		);
  
	GEN_FPGA_ROMS : if true generate
    type rom_data_t is array (natural range <>) of std_logic_vector(7 downto 0);
    signal rom_data : rom_data_t(0 to 2);
  begin

    GEN_ROMS : for i in 0 to 2 generate
    begin
      rom_inst : entity work.sprom
        generic map
        (
          init_file		=> VARIANT_ROM_DIR & "qb-rom" & integer'image(i) & ".hex",
          widthad_a		=> 13
        )
        port map
        (
          clock			=> clk_20M,
          address		=> cpu_a(12 downto 0),
          q					=> rom_data(i)
        );
    end generate GEN_ROMS;
        
    rom_d_o <=  rom_data(0) when STD_MATCH(cpu_a, "101-------------") else
                rom_data(1) when STD_MATCH(cpu_a, "110-------------") else
                rom_data(2) when STD_MATCH(cpu_a, "111-------------") else
                (others => '0');
                  
	end generate GEN_FPGA_ROMS;

  -- wren_a *MUST* be GND for CYCLONEII_SAFE_WRITE=VERIFIED_SAFE
  vram_inst : entity work.dpram
    generic map
    (
      init_file		=> VARIANT_ROM_DIR & "vram.hex",
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
      address_a		=> bitmap_i(1).a(9 downto 0),
      wren_a			=> '0',
      data_a			=> (others => 'X'),
      q_a					=> bitmap_o(1).d(7 downto 0)
    );

  -- wren_a *MUST* be GND for CYCLONEII_SAFE_WRITE=VERIFIED_SAFE
  cram_inst : entity work.dpram
    generic map
    (
      --numwords_a	=> 4096,
      widthad_a		=> 12
    )
    port map
    (
      clock_b			=> clk_20M,
      address_b		=> cpu_a(11 downto 0),
      wren_b			=> cram_wr,
      data_b			=> cpu_d_o,
      q_b					=> cram_d_o,

      clock_a			=> clk_video,
      address_a		=> bitmap_i(1).a(11 downto 0),
      wren_a			=> '0',
      data_a			=> (others => 'X'),
      q_a					=> bitmap_o(1).d(15 downto 8)
    );

end SYN;