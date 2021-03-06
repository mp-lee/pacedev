library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

library work;
use work.pace_pkg.all;
use work.sdram_pkg.all;
use work.video_controller_pkg.all;
use work.sprite_pkg.all;
use work.project_pkg.all;
use work.platform_pkg.all;
use work.target_pkg.all;

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
end entity platform;

architecture SYN of platform is

  component osd_controller is
    generic
    (
      WIDTH_GPIO  : natural := 8
    );
    port
    (
      clk         : in std_logic;
      clk_en      : in std_logic;
      reset       : in std_logic;

      osd_key     : in std_logic;

      to_osd      : out to_OSD_t;
      from_osd    : in from_OSD_t;

      gpio_i      : in std_logic_vector(WIDTH_GPIO-1 downto 0);
      gpio_o      : out std_logic_vector(WIDTH_GPIO-1 downto 0);
      gpio_oe     : out std_logic_vector(WIDTH_GPIO-1 downto 0)
    );
  end component osd_controller;

	alias clk_20M					: std_logic is clkrst_i.clk(0);
	alias rst_20M					: std_logic is clkrst_i.rst(0);
	alias clk_video       : std_logic is clkrst_i.clk(1);
	alias rst_video       : std_logic is clkrst_i.rst(1);
	
  -- uP signals  
  signal clk_2M_ena			: std_logic;
  signal uP_addr        : std_logic_vector(15 downto 0);
  signal uP_datai       : std_logic_vector(7 downto 0);
  signal uP_datao       : std_logic_vector(7 downto 0);
  signal uPmemrd        : std_logic;
  signal uPmemwr        : std_logic;
  signal uPiord         : std_logic;
  signal uPiowr         : std_logic;
  signal uPintreq       : std_logic;
  signal uPintvec       : std_logic_vector(7 downto 0);
  signal uPintack       : std_logic;
  signal uPnmireq       : std_logic;
	alias io_addr					: std_logic_vector(7 downto 0) is uP_addr(7 downto 0);
	                        
  -- ROM signals        
	signal rom_cs					: std_logic;
  signal rom_datao      : std_logic_vector(7 downto 0);
                        
  -- keyboard signals
	signal kbd_cs					: std_logic;
	signal kbd_data				: std_logic_vector(7 downto 0);
	                        
  -- VRAM signals       
	signal vram_cs				: std_logic;
  signal vram_wr        : std_logic;
  signal vram_datao     : std_logic_vector(7 downto 0);

  -- hires signals
  signal hires_dat_cs   : std_logic := '0';
	signal hires_dat_wr   : std_logic := '0';
	signal hires_dat_o    : std_logic_vector(7 downto 0) := (others => '0');
	
  -- RAM signals        
  signal ram_wr         : std_logic;
  signal ram_datao      : std_logic_vector(7 downto 0);

  -- interrupt signals
  signal z80_wait_n     : std_logic := '1';
	signal int_cs					: std_logic;
  signal intena_wr      : std_logic;
  signal int_status     : std_logic_vector(7 downto 0);
  signal rtc_intrst     : std_logic;  -- clear RTC interrupt
	signal nmi_cs					: std_logic;
  signal nmiena_wr      : std_logic;
  signal nmi_status     : std_logic_vector(7 downto 0);
  signal nmirst         : std_logic;  -- clear NMI

  -- OSD GPIO signals
  signal gpio_to_osd    : std_logic_vector(7 downto 0);
  signal gpio_from_osd  : std_logic_vector(7 downto 0);

  -- fdc signals
	signal fdc_cs_n			  : std_logic;
	signal fdc_re_n       : std_logic;
	signal fdc_we_n       : std_logic;
  signal fdc_dat_o      : std_logic_vector(7 downto 0);
  signal fdc_drq        : std_logic;
  signal fdc_irq        : std_logic;

  signal drvsel_cs      : std_logic := '0';
  signal drvsel_r       : std_logic_vector(7 downto 0) := (others => '0');
  alias mfm_fm_n        : std_logic is drvsel_r(7);
  alias wsgen           : std_logic is drvsel_r(6);
  alias precomp         : std_logic is drvsel_r(5);
  alias sdsel           : std_logic is drvsel_r(4);
  alias ds              : std_logic_vector(4 downto 1) is drvsel_r(3 downto 0);
  
	signal port_ec        : std_logic_vector(7 downto 0);

  -- other signals      
	alias platform_reset	: std_logic is inputs_i(NUM_INPUT_BYTES-1).d(0);
	signal cpu_reset			: std_logic;  
	signal alpha_joy_cs		: std_logic;
	signal rtc_cs					: std_logic;
	signal snd_cs					: std_logic;
  signal uPmem_datai    : std_logic_vector(7 downto 0);
  signal uPio_datai     : std_logic_vector(7 downto 0);
	
begin

	cpu_reset <= rst_20M or platform_reset;
	
  -- not used for now
  uPintvec <= (others => '0');

  -- read mux
  uP_datai <= uPmem_datai when (uPmemrd = '1') else uPio_datai;

  BLK_SYSMEM : block
  begin

    GEN_DFLT_SYSMEM: if not TRS80_M4_SYSMEM_IN_BURCHED_SRAM generate
      ram_datao <= sram_i.d(ram_datao'range);
      sram_o.a <= std_logic_vector(RESIZE(unsigned(uP_addr), sram_o.a'length));
      sram_o.d <= std_logic_vector(RESIZE(unsigned(uP_datao), sram_o.d'length));
      sram_o.be <= std_logic_vector(to_unsigned(1, sram_o.be'length));
      sram_o.cs <= '1';
      sram_o.oe <= not ram_wr;
      sram_o.we <= ram_wr;
    end generate GEN_DFLT_SYSMEM;
    
    GEN_BURCHED_SYSMEM: if TRS80_M4_SYSMEM_IN_BURCHED_SRAM generate
      assert false
        report "TRS80_M4_SYSMEM_IN_BURCHED_SRAM option won't work on stock DE1 hardware"
          severity warning;
      -- hook up Burched SRAM module
      GEN_D: for i in 0 to 7 generate
        --ram_datao(i) <= gp_i(35-i);
        --gp_o.d(35-i) <= up_datao(i);
        --gp_o.d(27-i) <= 'Z';
      end generate;
      GEN_A: for i in 0 to 15 generate
        --gp_o.d(17-i) <= up_addr(i);
      end generate;
      --gp_o.d(1) <= '0';           -- A16
      --gp_o.d(0) <= '0';           -- CEAn
      --gp_o.d(18) <= '1';          -- upper byte WEn
      --gp_o.d(19) <= not ram_wr;   -- lower byte WEn
    end generate GEN_BURCHED_SYSMEM;

  end block BLK_SYSMEM;
  
	-- memory chip selects
	-- ROM $0000-$37FF
	rom_cs <= '1' when uP_addr(15 downto 14) = "00" and uP_addr(13 downto 11) /= "111" else '0';
	-- KEYBOARD $3800-$38FF
	kbd_cs <= '1' when uP_addr(15 downto 10) = (X"3" & "10") else '0';
	-- RAM (everything else)
	vram_cs <= '1' when uP_addr(15 downto 10) = (X"3" & "11") else '0';
	
	-- memory write enables
	vram_wr <= vram_cs and uPmemwr;
	-- always write thru to RAM
	ram_wr <= uPmemwr;

	-- I/O chip selects
	-- Alpha Joystick $00 (active low)
	alpha_joy_cs <= '1' when io_addr = X"00" else '0';
	-- MicroLabs Hires Data port
  hires_dat_cs <= '1' when io_addr = X"82" else '0';
	-- RDINTSTATUS $E0-E3 (active low)
	int_cs <= '1' when io_addr(7 downto 2) = "111000" else '0';
	-- NMI STATUS $E4
	nmi_cs <= '1' when io_addr = X"E4" else '0';
  -- reset RTC any read $EC-EF
  rtc_cs <= '1' when io_addr(7 downto 2) = "111011" else '0';
	-- FDC $F0-$F3
	fdc_cs_n <= '0' when io_addr(7 downto 2) = "111100" else '1';
	-- DRVSEL $F4
  drvsel_cs <= '1' when io_addr(7 downto 0) = X"F4" else '0';
  -- SOUND $FC-FF (Model I is $FF only)
	snd_cs <= '1' when io_addr(7 downto 2) = "111111" else '0';
	
	-- io read strobes
	nmirst <= nmi_cs and uPiord;
	rtc_intrst <= rtc_cs and uPiord;
  fdc_re_n <= not uPiord;
  
	-- io write enables
	-- WRINTMASKREQ $E0-E3
  intena_wr <= int_cs and uPiowr;
  -- NMIMASKREQ $E4
  nmiena_wr <= nmi_cs and uPiowr;
  -- FDC $F0-$F3
  fdc_we_n <= not uPiowr;
	-- SOUND OUTPUT $FC-FF (Model I is $FF only)
	snd_o.a <= uP_addr(snd_o.a'range);
	snd_o.d <= uP_datao;
	snd_o.rd <= '0';
  snd_o.wr <= snd_cs and uPiowr;
		
	-- memory read mux
	uPmem_datai <= 	rom_datao when rom_cs = '1' else
									kbd_data when kbd_cs = '1' else
									vram_datao when vram_cs = '1' else
									ram_datao;
	
	-- io read mux
	uPio_datai <= X"FF" when alpha_joy_cs = '1' else
                hires_dat_o when hires_dat_cs = '1' else
								(not int_status) when int_cs = '1' else
								(not nmi_status) when nmi_cs = '1' else
								fdc_dat_o when fdc_cs_n = '0' else
								X"FF";
		
	KBD_MUX : process (uP_addr, inputs_i)
  	variable kbd_data_v : std_logic_vector(7 downto 0);
	begin
    
  	kbd_data_v := X"00";
		for i in 0 to 7 loop
	 		if uP_addr(i) = '1' then
			  kbd_data_v := kbd_data_v or inputs_i(i).d;
			  -- hack - 2nd button is also <BREAK>
			  if i = 6 then
          kbd_data_v(2) := kbd_data_v(2) or buttons_i(1);
        end if;
		  end if;
		end loop;

  	-- assign the output
		kbd_data <= kbd_data_v;

  end process KBD_MUX;

  PROC_DRVSEL : process (clk_20M, rst_20M)
    subtype count_t is integer range 0 to 3999; -- 2ms watchdog
    variable count : count_t := count_t'high;
  begin
    if rst_20M = '1' then
      drvsel_r <= (others => '0');
      count := count_t'high;
      z80_wait_n <= '1';
    elsif rising_edge(clk_20M) then
      if clk_2M_ena = '1' then
        if drvsel_cs = '1' and upiowr = '1' then
          drvsel_r <= up_datao;
          z80_wait_n <= not up_datao(6);
          count := 0;
        elsif count /= count_t'high then
          count := count + 1;
        end if;
      end if;
      -- 'async' reset on reset, irq, drq or 2ms timeout
      if (cpu_reset or fdc_irq or fdc_drq) = '1' or (count = count_t'high) then
        z80_wait_n <= '1';
      end if;
    end if;
  end process PROC_DRVSEL;
  
  -- PORT $EC (various)
  process (clk_20M, rst_20M)
  begin
    if rst_20M = '1' then
      port_ec <= (others => '0');
    elsif rising_edge(clk_20M) then
      if clk_2M_ena = '1' then
        if io_addr(7 downto 0) = X"EC" then
          if upiowr = '1' then
            port_ec <= up_datao;
          end if;
        end if;
      end if;
    end if;
  end process;
  graphics_o.bit8(0)(7 downto 2) <= port_ec(7 downto 2);

  -- unused outputs
	sprite_reg_o <= NULL_TO_SPRITE_REG;
	sprite_o <= NULL_TO_SPRITE_CTL;
  tilemap_o(1).attr_d <= std_logic_vector(RESIZE(unsigned(switches_i(7 downto 0)), tilemap_o(1).attr_d'length));
	graphics_o.pal <= (others => (others => '0'));
	ser_o <= NULL_TO_SERIAL;
  spi_o <= NULL_TO_SPI;
  --gp_o.d(gp_o.d'left downto 52) <= (others => '0');

	clk_en_inst : entity work.clk_div
		generic map
		(
			DIVISOR		=> 10
		)
		port map
		(
			clk				=> clk_20M,
			reset			=> rst_20M,
			clk_en		=> clk_2M_ena
		);

  BLK_Z80 : block
  begin
  
    up_inst : entity work.Z80                                                
      port map
      (
        clk			=> clk_20M,                                   
        clk_en	=> clk_2M_ena,
        reset  	=> cpu_reset,                                     

        addr   	=> uP_addr,
        datai  	=> uP_datai,
        datao  	=> uP_datao,

        mem_rd 	=> uPmemrd,
        mem_wr 	=> uPmemwr,
        io_rd  	=> uPiord,
        io_wr  	=> uPiowr,

        wait_n  => z80_wait_n,
        intreq 	=> uPintreq,
        intvec 	=> uPintvec,
        intack 	=> uPintack,
        nmi    	=> uPnmireq
      );
  end block BLK_Z80;
  
	rom_inst : entity work.sprom
		generic map
		(
			init_file		=> "../../../../../src/platform/trs80/m3/roms/m3rom.hex",
			numwords_a	=> 16384,
			widthad_a		=> 14
		)
		port map
		(
			clock			=> clk_20M,
			address		=> up_addr(13 downto 0),
			q					=> rom_datao
		);
	
	tilerom_inst : entity work.sprom
		generic map
		(
			init_file		    => "../../../../../src/platform/trs80/m3/roms/trstile.hex",
			numwords_a	    => 4096,
			widthad_a		    => 12
		)
		port map
		(
			clock			=> clk_video,
			address		=> tilemap_i(1).tile_a(11 downto 0),
			q					=> tilemap_o(1).tile_d(7 downto 0)
		);
  tilemap_o(1).tile_d(tilemap_o(1).tile_d'left downto 8) <= (others => '0');

  GEN_HIRES: if TRS80_M4_HIRES_SUPPORT generate

    BLK_HIRES : block
      signal hires_a  : std_logic_vector(14 downto 0) := (others => '0');   -- Max 32KiB
      alias x_r       : std_logic_vector(5 downto 0) is hires_a(5 downto 0);
      alias y_r       : std_logic_vector(7 downto 0) is hires_a(13 downto 6);
      signal data_r   : std_logic_vector(7 downto 0) := (others => '0');
      signal mode_r   : std_logic_vector(7 downto 0) := (others => '0');
    begin

      process (clk_20M, cpu_reset)
        variable rd_r   : std_logic := '0';
        variable wr_r   : std_logic := '0';
      begin
        if cpu_reset = '1' then
          x_r <= (others => '0');
          y_r <= (others => '0');
          data_r <= (others => '0');
          mode_r <= (others => '0');
          wr_r := '0';
        elsif rising_edge(clk_20M) then
          hires_dat_wr <= '0';
          if io_addr(7 downto 2) = "100000" then
            -- write to a graphics register
            if wr_r = '0' and upiowr = '1' then
              -- leading-edge write
              case io_addr(1 downto 0) is
                when "00" =>
                  x_r <= up_datao(x_r'range);
                when "01" =>
                  y_r <= up_datao(y_r'range);
                when "10" =>
                  data_r <= up_datao;
                  hires_dat_wr <= '1';
                when others =>
                  mode_r <= up_datao;
              end case;
            elsif io_addr(1 downto 0) = "10" then
              -- write to data register
              if  (rd_r = '1' and upiord = '0' and mode_r(5) = '0') or
                  (wr_r = '1' and upiowr = '0' and mode_r(7) = '0') then
                -- trailing-edge read or write & y clock
                if mode_r(3) = '0' then
                  y_r <= y_r + 1;
                else
                  y_r <= y_r - 1;
                end if;
              elsif (rd_r = '1' and upiord = '0' and mode_r(4) = '0') or
                    (wr_r = '1' and upiowr = '0' and mode_r(6) = '0') then
                -- trailing-edge read or write & x clock
                if mode_r(2) = '0' then
                  x_r <= x_r + 1;
                else
                  x_r <= x_r - 1;
                end if;
              end if;
            end if;
          end if;
          rd_r := upiord;
          wr_r := upiowr;
        end if;
      end process;

      -- wren_a *MUST* be GND for CYCLONEII_SAFE_WRITE=VERIFIED_SAFE
      hires_ram_inst : entity work.dpram
        generic map
        (
          init_file		=> "", --"../../../../../src/platform/trs80/m3/roms/trsvram.hex",
          numwords_a	=> 2**TRS80_M4_HIRES_WIDTHA,
          widthad_a		=> TRS80_M4_HIRES_WIDTHA
        )
        port map
        (
          clock_b			=> clk_20M,
          address_b		=> hires_a(TRS80_M4_HIRES_WIDTHA-1 downto 0),
          wren_b			=> hires_dat_wr,
          data_b			=> data_r,
          q_b					=> hires_dat_o,

          clock_a			=> clk_video,
          address_a		=> bitmap_i(1).a(TRS80_M4_HIRES_WIDTHA-1 downto 0),
          wren_a			=> '0',
          data_a			=> (others => 'X'),
          q_a					=> bitmap_o(1).d(7 downto 0)
        );

      graphics_o.bit8(0)(1 downto 0) <= mode_r(1 downto 0);

    end block BLK_HIRES;
  end generate GEN_HIRES;
    
  GEN_NO_HIRES : if not TRS80_M4_HIRES_SUPPORT generate
    bitmap_o(1) <= NULL_TO_BITMAP_CTL;
    graphics_o.bit8(0)(1 downto 0) <= "00";
  end generate GEN_NO_HIRES;
  
	-- wren_a *MUST* be GND for CYCLONEII_SAFE_WRITE=VERIFIED_SAFE
	vram_inst : entity work.dpram
		generic map
		(
			init_file		=> "../../../../../src/platform/trs80/m3/roms/trsvram.hex",
			numwords_a	=> 1024,
			widthad_a		=> 10
		)
		port map
		(
			clock_b			=> clk_20M,
			address_b		=> uP_addr(9 downto 0),
			wren_b			=> vram_wr,
			data_b			=> uP_datao,
			q_b					=> vram_datao,

			clock_a			=> clk_video,
			address_a		=> tilemap_i(1).map_a(9 downto 0),
			wren_a			=> '0',
			data_a			=> (others => 'X'),
			q_a					=> tilemap_o(1).map_d(7 downto 0)
		);
	tilemap_o(1).map_d(tilemap_o(1).map_d'left downto 8) <= (others => '0');

  interrupts_inst : entity work.TRS80_Interrupts                    
    port map
    (
      clk           => clk_20M,
      reset         => cpu_reset,

      -- enable inputs                    
      z80_data      => uP_datao,
      intena_wr     => intena_wr,                  
      nmiena_wr     => nmiena_wr,
                  
      -- IRQ inputs
      reset_btn_int => '0',
      fdc_drq_int   => fdc_irq,                    
      fdc_dto_int   => '0',

      -- IRQ/status outputs
      int_status    => int_status,
      int_req       => uPintreq,
      nmi_status    => nmi_status,
      nmi_req       => uPnmireq,

      -- interrupt clear inputs
      rtc_reset     => rtc_intrst,
      nmi_reset     => nmirst
    );

  GEN_FDC : if TRS80_M4_FDC_SUPPORT generate
  
    BLK_FDC : block

      constant FDC_USE_FIFO : boolean := true;
      
      signal sync_reset   : std_logic := '1';
      
      signal step         : std_logic := '0';
      signal dirc         : std_logic := '0';
      signal rg           : std_logic := '0';
      signal rclk         : std_logic := '0';
      signal raw_read_n   : std_logic := '0';
      signal wg           : std_logic := '0';
      signal wd           : std_logic := '0';
      signal tr00_n       : std_logic := '0';
      signal ip_n         : std_logic := '0';
      signal wprt_n       : std_logic := '1';
      
      signal de_s         : std_logic_vector(4 downto 1);

      -- floppy data
      signal track              : std_logic_vector(7 downto 0) := (others => '0');
      signal offset             : std_logic_vector(12 downto 0) := (others => '0');
      signal rd_data_from_media : std_logic_vector(7 downto 0) := (others => '0');
      signal rd_data_from_flash_media : std_logic_vector(rd_data_from_media'range) := (others => '0');
      signal rd_data_from_sram_media  : std_logic_vector(rd_data_from_media'range) := (others => '0');
      signal rd_data_from_fifo  : std_logic_vector(7 downto 0) := (others => '0');
      signal wr_data_to_media   : std_logic_vector(7 downto 0) := (others => '0');
      signal media_wr           : std_logic := '0';
      
      signal fifo_rd      : std_logic := '0';
      signal fifo_wr      : std_logic := '0';
      signal fifo_flush   : std_logic := '0';

      signal floppy_dbg   : std_logic_vector(31 downto 0) := (others => '0');
      signal wd179x_dbg   : std_logic_vector(31 downto 0) := (others => '0');
      
    begin

      process (clk_20M, rst_20M)
        variable reset_r : std_logic_vector(3 downto 0) := (others => '0');
      begin
        if rst_20M = '1' then
          reset_r := (others => '1');
        elsif rising_edge(clk_20M) then
          reset_r := reset_r(reset_r'left-1 downto 0) & platform_reset;
        end if;
        sync_reset <= reset_r(reset_r'left);
      end process;
      
      wd179x_inst : entity work.wd179x
        port map
        (
          clk           => clk_20M,
          clk_20M_ena   => '1',
          reset         => sync_reset,
          
          -- micro bus interface
          mr_n          => '1',
          we_n          => fdc_we_n,
          cs_n          => fdc_cs_n,
          re_n          => fdc_re_n,
          a             => up_addr(1 downto 0),
          dal_i         => uP_datao,
          dal_o         => fdc_dat_o,
          clk_1mhz_en   => '1',
          drq           => fdc_drq,
          intrq         => fdc_irq,
          
          -- drive interface
          step          => step,
          dirc          => dirc,
          early         => open,    -- not used atm
          late          => open,    -- not used atm
          test_n        => '1',     -- not used
          hlt           => '1',     -- head always engaged atm
          rg            => rg,
          sso           => open,
          rclk          => rclk,
          raw_read_n    => raw_read_n,
          hld           => open,    -- not used atm
          tg43          => open,    -- not used on TRS-80 designs
          wg            => wg,
          wd            => wd,      -- 200ns (MFM) or 500ns (FM) pulse
          ready         => '1',     -- always read atm
          wf_n_i        => '1',     -- no write faults atm
          vfoe_n_o      => open,    -- not used in TRS-80 designs?
          tr00_n        => tr00_n,
          ip_n          => ip_n,
          wprt_n        => wprt_n,
          dden_n        => '1',     -- single density only atm
          
          debug         => wd179x_dbg
        );
        
      floppy_if_inst : entity work.floppy_if
        generic map
        (
          NUM_TRACKS      => 40
        )
        port map
        (
          clk           => clk_20M,
          clk_20M_ena   => '1',
          reset         => sync_reset,
          
          -- drive select lines
          drv_ena       => de_s,
          drv_sel       => ds,
          
          step          => step,
          dirc          => dirc,
          rg            => rg,
          rclk          => rclk,
          raw_read_n    => raw_read_n,
          wg            => wg,
          wd            => wd,
          tr00_n        => tr00_n,
          ip_n          => ip_n,
          
          -- media interface

          track         => track,
          dat_i         => rd_data_from_fifo,
          dat_o         => open,
          wr            => media_wr,
          -- random-access control
          offset        => offset,
          -- fifo control
          rd            => fifo_rd,
          flush         => fifo_flush,
          
          debug         => floppy_dbg
        );

      GEN_FLOPPY_FIFO : if FDC_USE_FIFO generate
        BLK_FIFO : block
					signal fifo_rd_pulse	: std_logic := '0';
          signal fifo_empty     : std_logic := '0';
          signal fifo_full      : std_logic := '0';
        begin
          fifo_inst : ENTITY work.floppy_fifo
            PORT map
            (
              rdclk		  => clk_20M,
              q		      => rd_data_from_fifo,
              rdreq		  => fifo_rd_pulse,
              rdempty		=> fifo_empty,

              wrclk		  => clk_20M,
              data		  => rd_data_from_media,
              wrreq		  => fifo_wr,
              wrfull		=> fifo_full,
              aclr      => fifo_flush
            );

          process (clk_20M, sync_reset)
            subtype count_t is integer range 0 to 7;
            variable count      : count_t := 0;
            variable offset_v   : std_logic_vector(12 downto 0) := (others => '0');
						variable fifo_rd_r	: std_logic := '0';
          begin
            if sync_reset = '1' then
              count := 0;
              offset_v := (others => '0');
            elsif rising_edge(clk_20M) then

              -- fifo read pulse is too wide - edge-detect
							fifo_rd_pulse <= '0';	-- default
							if fifo_rd = '1' and fifo_rd_r = '0' then
								fifo_rd_pulse <= '1';
							end if;
							fifo_rd_r := fifo_rd;

              fifo_wr <= '0';   -- default
              if count = count_t'high then
                if fifo_full = '0' then
                  fifo_wr <= '1';
                  if offset_v = 6272-1 then
                    offset_v := (others => '0');
                  else
                    offset_v := offset_v + 1;
                  end if;
                end if;
                count := 0;
              else
                count := count + 1;
                -- don't update when writing to FIFO
                flash_o.a(12 downto 0) <= offset_v;
              end if;
            end if;
          end process;

        end block BLK_FIFO;
        
      end generate GEN_FLOPPY_FIFO;
      
      GEN_FLOPPY_NO_FIFO : if not FDC_USE_FIFO generate
        -- each track is encoded in 8KiB
        -- - 40 tracks is 320(512) KiB
        flash_o.a(12 downto 0) <= offset;
        rd_data_from_fifo <= rd_data_from_media;
      end generate GEN_FLOPPY_NO_FIFO;
      
      BLK_FLASH_FLOPPY : block
      begin  

        flash_o.a(flash_o.a'left downto 20) <= (others => '0');
        -- support 2 drives in flash for now
        flash_o.a(19) <=  '0' when ds(1) = '1' else
                          '1' when ds(2) = '1' else
                          '0';
        flash_o.a(18 downto 13) <= track(5 downto 0);
        flash_o.cs <= '1';
        flash_o.oe <= '1';
        flash_o.we <= '0';

        rd_data_from_flash_media <= flash_i.d(rd_data_from_flash_media'range);

        wprt_n <= '0';  -- always write-protected
        
      end block BLK_FLASH_FLOPPY;
      
      BLK_SRAM_FLOPPY : block
      begin

        GEN_SRAM_FLOPPY : if TRS80_M4_SYSMEM_IN_BURCHED_SRAM generate

          sram_o.a(sram_o.a'left downto 19) <= (others => '0');
          -- support 2 drives in sram for now
          sram_o.a(18) <=  '0' when ds(3) = '1' else
                           '1' when ds(4) = '1' else
                           '0';
          sram_o.a(17 downto 12) <= track(5 downto 0);
          sram_o.a(11 downto 0) <= offset(12 downto 1);
          sram_o.be <= "00" & offset(0) & not offset(0);
          sram_o.cs <= '1';
          sram_o.oe <= '1';
          sram_o.we <= media_wr;

          rd_data_from_sram_media <=  sram_i.d(15 downto 8) when offset(0) = '1' else
                                      sram_i.d(7 downto 0);

          sram_o.d(sram_o.d'left downto 16) <= (others => '0');
          -- only 1 of these will be enabled
          sram_o.d(15 downto 0) <= wr_data_to_media & wr_data_to_media;

        end generate GEN_SRAM_FLOPPY;
        
        GEN_NO_SRAM_FLOPPY : if not TRS80_M4_SYSMEM_IN_BURCHED_SRAM generate
          rd_data_from_sram_media <= (others => '1');
        end generate GEN_NO_SRAM_FLOPPY;

      end block BLK_SRAM_FLOPPY;
      
      rd_data_from_media <= rd_data_from_flash_media when (ds(1) or ds(2)) = '1' else
                            rd_data_from_sram_media;
                              
      -- drive enable switches
      de_s <= not switches_i(3 downto 0);
      
      --gp_o.d(51 downto 36) <= -- memory address
      --                     floppy_dbg(31 downto 16) when switches_i(5 downto 4) = "11" else 
                           -- track & data byte
      --                     floppy_dbg(15 downto 0) when switches_i(5 downto 4) = "10" else
                           -- idam track and sector
      --                     wd179x_dbg(31 downto 16) when switches_i(5 downto 4) = "01" else
                           -- track & sector registers
      --                     wd179x_dbg(15 downto 0);

      leds_o(9) <= not tr00_n;

      -- extend the step signal so we can see it on the LED
      process (clk_20M, clk_2M_ena)
        subtype count_t is integer range 0 to 199999;  -- 100ms
        variable count : count_t := 0;
        variable step_r : std_logic := '0';
      begin
        if rising_edge(clk_20M) then
          -- leading edge step
          if step_r = '0' and step = '1' then
            count := count_t'high;
            leds_o(8) <= '1';
          elsif clk_2M_ena = '1' then
            if count /= 0 then
              count := count - 1;
            else
              leds_o(8) <= '0';
            end if;
          end if;
          step_r := step;
        end if;
      end process;

      leds_o(7) <= not ip_n;
      
      leds_o(3) <= ds(4);
      leds_o(2) <= ds(3);
      leds_o(1) <= ds(2);
      leds_o(0) <= ds(1);
      
    end block BLK_FDC;
    
  end generate GEN_FDC;

  GEN_NO_FDC : 	if 	not TRS80_M4_FDC_SUPPORT generate
                
    fdc_dat_o <= X"FF";
    fdc_drq <= '0';
    fdc_irq <= '0';
    leds_o <= (others => '0');
        
  end generate GEN_NO_FDC;

  -- wire some keys to the osd module
  gpio_to_osd(0) <= inputs_i(6).d(3); -- UP
  gpio_to_osd(1) <= inputs_i(6).d(4); -- DOWN
  gpio_to_osd(2) <= inputs_i(6).d(5); -- LEFT
  gpio_to_osd(3) <= inputs_i(6).d(6); -- RIGHT
  gpio_to_osd(4) <= inputs_i(6).d(0); -- ENTER
  gpio_to_osd(7 downto 5) <= (others => '0');

  GEN_OSD : if PACE_HAS_OSD generate

    osd_inst : osd_controller
      generic map
      (
        WIDTH_GPIO  => gpio_to_osd'length
      )
      port map
      (
        clk         => clk_20M,
        clk_en      => '1',
        reset       => cpu_reset,

        osd_key     => inputs_i(8).d(1),

        to_osd      => osd_o,
        from_osd    => osd_i,

        gpio_i      => gpio_to_osd,
        gpio_o      => gpio_from_osd
      );

  end generate GEN_OSD;
  
end architecture SYN;
