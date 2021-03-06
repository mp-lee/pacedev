library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use	ieee.numeric_std.all;

library work;
use work.pace_pkg.all;
use work.sdram_pkg.all;
use work.video_controller_pkg.all;
use work.kbd_pkg.all;
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

    -- graphics (control)
    video_o         : out to_VIDEO_t;

    -- OSD
    --osd_i           : in from_OSD_t;
    --osd_o           : out to_OSD_t;

    -- sound
    audio_i         : in from_AUDIO_t;
    audio_o         : out to_AUDIO_t;
    
    -- serial
    ser_i           : in from_SERIAL_t;
    ser_o           : out to_SERIAL_t
  );
end entity platform;

architecture SYN of platform is

  --
  -- COMPONENTS
  --

  component crtc6845s is
    port
    (
      -- INPUT
      I_E         : in std_logic;
      I_DI        : in std_logic_vector(7 downto 0);
      I_RS        : in std_logic;
      I_RWn       : in std_logic;
      I_CSn       : in std_logic;
      I_CLK       : in std_logic;
      I_RSTn      : in std_logic;

      -- OUTPUT
      O_RA        : out std_logic_vector(4 downto 0);
      O_MA        : out std_logic_vector(13 downto 0);
      O_H_SYNC    : out std_logic;
      O_V_SYNC    : out std_logic;
      O_DISPTMG   : out std_logic
    );
  end component crtc6845s;

  --
  -- SIGNALS
  --

  signal reset_n            : std_logic;

  alias clk_32M             : std_logic is clkrst_i.clk(0);
  alias rst_32M             : std_logic is clkrst_i.rst(0);
  signal sys_cycle          : std_logic_vector(4 downto 0);
  signal clk_16M_en         : std_logic;
  signal clk_8M_en          : std_logic;
  signal clk_4M_en          : std_logic;
  signal clk_2M_en          : std_logic;  -- CPU
  signal clk_2M_180_en      : std_logic;  -- 6845
  signal clk_1M_en          : std_logic;  -- CPU/SAA5050
  signal clk_1M_90_en       : std_logic;  -- 6845

  -- CPU signals
	signal cpu_clk_en					: std_logic;
  signal cpu_reset_n        : std_logic;
	signal cpu_a_ext					: std_logic_vector(23 downto 0);
	alias cpu_a								: std_logic_vector(15 downto 0) is cpu_a_ext(15 downto 0);
  signal cpu_d_i            : std_logic_vector(7 downto 0);
  signal cpu_d_o            : std_logic_vector(7 downto 0);
	signal cpu_rw_n						: std_logic;
  signal cpu_we             : std_logic;
  signal cpu_nmi_n          : std_logic;
  signal cpu_irq_n          : std_logic;

  -- MOS ROM signals
  signal mos_rom_cs         : std_logic;
  signal mos_rom_d          : std_logic_vector(7 downto 0);

  -- paged ROM signals
  signal paged_rom_r        : std_logic_vector(1 downto 0);
  signal paged_rom_cs       : std_logic;
  signal paged_rom_d        : std_logic_vector(7 downto 0);
  signal rom_3_d            : std_logic_vector(7 downto 0);

  -- RAM signals
  signal ram_cs             : std_logic;
  signal ram_d              : std_logic_vector(7 downto 0);
  signal ram_we             : std_logic;

  -- FRED memory space
  signal fred_cs            : std_logic;
  signal fred_d             : std_logic_vector(7 downto 0);
  signal teletext_cs        : std_logic;
  signal prestel_cs         : std_logic;
  signal ieee488_cs         : std_logic;
  signal acornexp_cs        : std_logic;
  signal cambridge_cs       : std_logic;
  signal winchester_cs      : std_logic;
  signal testhw_cs          : std_logic;
  signal userapp_cs         : std_logic;
  signal jimpage_cs         : std_logic;

  -- JIM memory space
  signal jim_cs             : std_logic;
  signal jim_d              : std_logic_vector(7 downto 0);
  signal jim_page_r         : std_logic_vector(7 downto 0);

  -- SHEILA memory space
  signal sheila_cs          : std_logic;
  signal sheila_d           : std_logic_vector(7 downto 0);
  signal crtc6845_cs        : std_logic;
  signal acia6850_cs        : std_logic;
  signal serialula_cs       : std_logic;
  signal videoula_cs        : std_logic;
  signal pagedrom_cs        : std_logic;
  signal sysvia_cs          : std_logic;
  signal uservia_cs         : std_logic;
  signal fdc8271_cs         : std_logic;
  signal econet_cs          : std_logic;
  signal adc7002_cs         : std_logic;
  signal tubeula_cs         : std_logic;

	signal video_a				    : std_logic_vector(14 downto 0);
	signal video_d				    : std_logic_vector(7 downto 0);

  signal audio_d            : std_logic_vector(15 downto 0);

  signal crtc6845_vsync     : std_logic;

  -- VIA clocks
  signal via6522_p2         : std_logic;
  signal via6522_clk4       : std_logic;

  -- System 6522 VIA $40-$4F (IC3)
  signal sysvia_pa_o        : std_logic_vector(7 downto 0);
  alias slow_databus_o      : std_logic_vector(7 downto 0) is sysvia_pa_o;
  signal sysvia_pa_oe_n     : std_logic_vector(7 downto 0);
  alias kbd_col             : std_logic_vector(3 downto 0) is sysvia_pa_o(3 downto 0);
  alias kbd_row             : std_logic_vector(2 downto 0) is sysvia_pa_o(6 downto 4);
  signal sysvia_pa_i        : std_logic_vector(7 downto 0);
  alias slow_databus_i      : std_logic_vector(7 downto 0) is sysvia_pa_i;
  alias kbd_bit             : std_logic is sysvia_pa_i(7);
  signal sysvia_pb_o        : std_logic_vector(7 downto 0);
  signal sysvia_pb_oe_n     : std_logic_vector(7 downto 0);
  signal sysvia_ca1_i       : std_logic;
  alias vsync_int           : std_logic is sysvia_ca1_i;
  signal sysvia_ca2_i       : std_logic;
  alias kbd_int             : std_logic is sysvia_ca2_i;
  signal sysvia_irq_n       : std_logic;

  -- Addressable Latch (IC32)
  signal addressable_latch  : std_logic_vector(7 downto 0);
  alias shift_led           : std_logic is addressable_latch(7);
  alias caps_led            : std_logic is addressable_latch(6);
  alias c                   : std_logic_vector(1 downto 0) is addressable_latch(5 downto 4);
  alias kbd_we_n            : std_logic is addressable_latch(3);
  alias speech_wr           : std_logic is addressable_latch(2);
  alias speech_rd           : std_logic is addressable_latch(1);
  alias sound_we            : std_logic is addressable_latch(0);

  -- other signals
  alias game_reset			    : std_logic is inputs_i(16).d(0);

begin

  assert false
    report  "CLK0_FREQ_MHz = " & integer'image(CLK0_FREQ_MHz) & "\n" &
            "CPU_FREQ_MHz = " &  integer'image(CPU_FREQ_MHz) & "\n" &
            "CPU_CLK_ENA_DIV = " & integer'image(BBCMICRO_CPU_CLK_ENA_DIVIDE_BY)
      severity note;
      
  -- clock generation - phase-aligned
  process (clk_32M, rst_32M)
  begin
    if rst_32M = '1' then
      sys_cycle <= (others => '0');
      via6522_p2 <= '1';
      via6522_clk4 <= '0';
    elsif rising_edge(clk_32M) then
      clk_16M_en <= '0';
      clk_8M_en <= '0';
      clk_4M_en <= '0';
      clk_2M_en <= '0';
      clk_2M_180_en <= '0';
      clk_1M_en <= '0';
      clk_1M_90_en <= '0';
      if sys_cycle(0) = '0' then
        clk_16M_en <= '1';
        if sys_cycle(1) = '0' then
          clk_8M_en <= '1';
          if sys_cycle(2) = '0' then
            clk_4M_en <= '1';
            if sys_cycle(3) = '0' then
              clk_2M_en <= '1';
              if sys_cycle(4) = '0' then
                clk_1M_en <= '1';
              end if;
            else
              clk_2M_180_en <= '1';
            end if;
          end if;
        end if;
      end if;
      if sys_cycle = "11000" then
        clk_1M_90_en <= '1';
      end if;
      sys_cycle <= sys_cycle + 1;
      -- clocks for 6522
      -- P2 must lead cpu_clk_en by 1 system clock
      -- - and is same frequency as cpu_clk but 50% duty cycle
      -- clk4 goes low on rising edge of P2
      if sys_cycle(3 downto 0) = "1111" then
        via6522_p2 <= not via6522_p2;
      end if;
      if sys_cycle(1) = '1' then
        via6522_clk4 <= not via6522_clk4;
      end if;
    end if;
  end process;

  -- fixed at 1MHz for now...
  cpu_clk_en <= clk_1M_en;

  -- some simple inversions
  reset_n <= not rst_32M;
  cpu_reset_n <= not (rst_32M or game_reset);
  cpu_we <= not cpu_rw_n;

  -- main chip-select logic

  -- RAM $0000-$3FFF (16KB) - mirrored $4000-$7FFF for 16K machines
  ram_cs <=       '1' when STD_MATCH(cpu_a, "0---------------") else '0';
  -- PAGED ROM $8000-$BFFF (16KB)
  paged_rom_cs <= '1' when STD_MATCH(cpu_a, "10--------------") else '0';
  -- MOS ROM $C000-$FFFF (16KB)
  mos_rom_cs <=   '1' when STD_MATCH(cpu_a, "11--------------") else '0';
  -- FRED $FC00-$FCFF
  fred_cs <=      '1' when STD_MATCH(cpu_a, X"FC"&"--------") else '0';
  -- JIM $FD00-$FDFF
  jim_cs <=       '1' when STD_MATCH(cpu_a, X"FD"&"--------") else '0';
  -- SHEILA $FE00-$FEFF
  sheila_cs <=    '1' when STD_MATCH(cpu_a, X"FE"&"--------") else '0';

  -- write-enables
  ram_we <= ram_cs and not cpu_rw_n;

  -- paged rom mux
  paged_rom_d <=  rom_3_d when paged_rom_r = "11" else
                  (others => '1');

  -- read mux
  cpu_d_i <=  ram_d when ram_cs = '1' else
              paged_rom_d when paged_rom_cs = '1' else
              fred_d when fred_cs = '1' else
              jim_d when jim_cs = '1' else
              sheila_d when sheila_cs = '1' else
              -- MOS ROM must be decoded *after* SHEILA
              mos_rom_d when mos_rom_cs = '1' else
              (others => '1');

  -- interrupt muxes
  cpu_nmi_n <= '1'; -- not used on basic system
  cpu_irq_n <= sysvia_irq_n;

  --
  --  FRED
  --
  BLK_FRED : block

    alias fred_a        : std_logic_vector(7 downto 0) is cpu_a(7 downto 0);

  begin

    teletext_cs <=  fred_cs when STD_MATCH(fred_a, "000100--") else '0';
    -- decode *AFTER* teletext_cs
    prestel_cs <=     fred_cs when STD_MATCH(fred_a, "0001----") else '0';
    ieee488_cs <=     fred_cs when STD_MATCH(fred_a, "00100---") else '0';
    acornexp_cs <=    fred_cs when STD_MATCH(fred_a, "00101---") else '0';
    cambridge_cs <=   fred_cs when STD_MATCH(fred_a, "0011----") else '0';
    winchester_cs <=  fred_cs when STD_MATCH(fred_a, "01000---") else '0';
    testhw_cs <=      fred_cs when STD_MATCH(fred_a, "1000----") else '0';
    userapp_cs <=     fred_cs when STD_MATCH(fred_a, "11------") else '0';
    -- decode *before* userapp_cs
    jimpage_cs <=     fred_cs when STD_MATCH(fred_a, "11111111") else '0';

    -- registers
    process (clk_32M, cpu_reset_n)
    begin
      if cpu_reset_n = '0' then
        jim_page_r <= (others => '0');
      elsif rising_edge(clk_32M) then
        if cpu_clk_en = '1' then
          if jimpage_cs = '1' then
            if cpu_rw_n = '0' then
              jim_page_r <= cpu_d_o;
            end if; -- cpu_rw_n
          end if; -- jimpage_cs
        end if; -- cpu_clk_en
      end if;
    end process;

    fred_d <= jim_page_r when jimpage_cs = '1' else 
              X"FF"; -- *MUST* return $FF

  end block BLK_FRED;

  --
  --  JIM
  --
  BLK_JIM : block
  begin

    jim_d <= X"FF"; -- *MUST* return $FF

  end block BLK_JIM;

  --
  --  SHEILA
  --
  BLK_SHEILA : block

    alias sheila_a      : std_logic_vector(7 downto 0) is cpu_a(7 downto 0);

    signal sysvia_d     : std_logic_vector(7 downto 0);
    signal sysvia_oe_n  : std_logic;

  begin

    crtc6845_cs <=  sheila_cs when STD_MATCH(sheila_a, "00000---") else '0';
    acia6850_cs <=  sheila_cs when STD_MATCH(sheila_a, "00001---") else '0';
    serialula_cs <= sheila_cs when STD_MATCH(sheila_a, "00010---") else '0';
    videoula_cs <=  sheila_cs when STD_MATCH(sheila_a, "0010----") else '0';
    pagedrom_cs  <= sheila_cs when STD_MATCH(sheila_a, "0011----") else '0';
    sysvia_cs <=    sheila_cs when STD_MATCH(sheila_a, "010-----") else '0';
    uservia_cs <=   sheila_cs when STD_MATCH(sheila_a, "011-----") else '0';
    fdc8271_cs <=   sheila_cs when STD_MATCH(sheila_a, "100-----") else '0';
    econet_cs <=    sheila_cs when STD_MATCH(sheila_a, "101-----") else '0';
    adc7002_cs <=   sheila_cs when STD_MATCH(sheila_a, "110-----") else '0';
    tubeula_cs <=   sheila_cs when STD_MATCH(sheila_a, "111-----") else '0';

    sheila_d <= X"00" when acia6850_cs = '1' else
                sysvia_d when sysvia_cs = '1' else
                X"FE"; -- *MUST* return $FE

    -- paged ROM process
    -- note this register is write-only
    process (clk_32M, cpu_reset_n)
    begin
      if cpu_reset_n = '0' then
      elsif rising_edge (clk_32M) then
        if cpu_clk_en = '1' then
          if pagedrom_cs = '1' then
            if cpu_rw_n = '0' then
              paged_rom_r <= cpu_d_o(paged_rom_r'range);
            end if; -- cpuo_rw_n
          end if; -- pagedrom_cs
        end if; -- cpu_clk_en
      end if;
    end process;

    -- keyboard scan process
    process (clk_32M, cpu_reset_n)
      variable auto_col : std_logic_vector(3 downto 0);
      variable col      : integer range 0 to 15;
    begin
      if cpu_reset_n = '0' then
        auto_col := (others => '0');
        col := 0;
      elsif rising_edge(clk_32M) then
        if clk_1M_en = '1' then
          kbd_int <= '0';
          -- autoscan only if kbd_we not asserted
          if kbd_we_n = '0' then
            col := conv_integer(kbd_col);
          else
            col := conv_integer(auto_col);
            auto_col := auto_col + 1;
          end if;
          if inputs_i(col).d(7 downto 1) /= "0000000" then
            -- generate interrupt? via CA2 of the system VIA
            kbd_int <= '1';
          end if;
        end if;
      end if;
      kbd_bit <= inputs_i(col).d(conv_integer(kbd_row));
    end process;

    -- the remainder of the bits *MUST* reflect the output
    sysvia_pa_i(6 downto 0) <= sysvia_pa_o(6 downto 0);

    sysvia_inst : entity work.M6522
      port map
      (
        I_RS              => cpu_a(3 downto 0),
        I_DATA            => cpu_d_o,
        O_DATA            => sysvia_d,
        O_DATA_OE_L       => sysvia_oe_n,

        I_RW_L            => cpu_rw_n,
        I_CS1             => sysvia_cs,
        I_CS2_L           => '0',

        O_IRQ_L           => sysvia_irq_n,

        -- port a
        I_CA1             => vsync_int,
        I_CA2             => kbd_int,
        O_CA2             => open,
        O_CA2_OE_L        => open,

        I_PA              => slow_databus_i,  -- incl. keyboard
        O_PA              => slow_databus_o,
        O_PA_OE_L         => sysvia_pa_oe_n,

        -- port b
        I_CB1             => '0', -- ADC end-of-conversion
        O_CB1             => open,
        O_CB1_OE_L        => open,

        I_CB2             => '1', -- light-pen strobe
        O_CB2             => open,
        O_CB2_OE_L        => open,

        I_PB              => "11111111",      -- speech, joystick fire (active low)
        O_PB              => sysvia_pb_o,     -- system latch
        O_PB_OE_L         => sysvia_pb_oe_n,

        I_P2_H            => via6522_p2,      -- high for phase 2 clock   ____----__
        RESET_L           => cpu_reset_n,
        ENA_4             => via6522_clk4,    -- 4x system clock (4MHZ)   _-_-_-_-_-
        CLK               => clk_32M
      );

    -- 74LS259 addressable latch (IC32)
    -- updated at 1MHz irrespective of CPU clock
    process (clk_32M, cpu_reset_n)
    begin
      if cpu_reset_n = '0' then
        addressable_latch <= (others => '0');
      elsif rising_edge(clk_32M) then
        if clk_1M_en = '1' then
          if sysvia_pb_oe_n(3 downto 0) /= "1111" then
            addressable_latch(conv_integer(sysvia_pb_o(2 downto 0))) <= sysvia_pb_o(3);
          end if;
        end if;
      end if;
    end process;

  sn76489_inst : entity work.sn76489
    generic map
    (
      AUDIO_RES   => 16
    )
    port map
    (
      clk					=> clk_32M,
      clk_en			=> clk_4M_en,
      reset				=> rst_32M,
                  
      d						=> slow_databus_o,
      ready				=> open,            -- tied to GND on schematic
      we_n				=> sound_we,
      ce_n				=> '0',             -- as per schematic

      audio_out		=> audio_d
    );

    -- hook up sound to output
    audio_o.clk <= clk_4M_en;
    audio_o.ldata <= audio_d;
    audio_o.rdata <= audio_d;

  end block BLK_SHEILA;

  ser_o <= NULL_TO_SERIAL;
  leds_o <= (others => '0');

  --
  --  COMPONENT INSTANTIATION
  --

  GEN_T65 : if BBC_USE_T65 generate
    cpu_inst : entity work.T65
      port map
      (
        Mode    		=> "00",	-- 6502
        Res_n   		=> cpu_reset_n,
        Enable  		=> cpu_clk_en,
        Clk     		=> clk_32M,
        Rdy     		=> '1',
        Abort_n 		=> '1',
        IRQ_n   		=> cpu_irq_n,
        NMI_n   		=> cpu_nmi_n,
        SO_n    		=> '1',
        R_W_n   		=> cpu_rw_n,
        Sync    		=> open,
        EF      		=> open,
        MF      		=> open,
        XF      		=> open,
        ML_n    		=> open,
        VP_n    		=> open,
        VDA     		=> open,
        VPA     		=> open,
        A       		=> cpu_a_ext,
        DI      		=> cpu_d_i,
        DO      		=> cpu_d_o
      );
  end generate GEN_T65;

  GEN_65XX : if BBC_USE_65XX generate
    BLK_65XX : block
      signal cpu_reset  : std_logic;
      signal cpu_we     : std_logic;
      signal cpu_d_o_u  : unsigned(7 downto 0);
      signal cpu_a_u    : unsigned(15 downto 0);
    begin
      cpu_reset <= not cpu_reset_n;
      cpu_inst : entity work.cpu65xx
        generic map
        (
          pipelineOpcode => false,
          pipelineAluMux => false,
          pipelineAluOut => false
        )
        port map
        (
          clk         => clk_32M,
          enable      => cpu_clk_en,
          reset       => cpu_reset,
          nmi_n       => cpu_nmi_n,
          irq_n       => cpu_irq_n,
          so_n        => '1',

          di          => unsigned(cpu_d_i),
          do          => cpu_d_o_u,
          addr        => cpu_a_u,
          we          => cpu_we,
          
          debugOpcode => open,
          debugPc     => open,
          debugA      => open,
          debugX      => open,
          debugY      => open,
          debugS      => open
        );
      cpu_rw_n <= not cpu_we;
      cpu_d_o <= std_logic_vector(cpu_d_o_u);
      cpu_a <= std_logic_vector(cpu_a_u);
    end block BLK_65XX;
  end generate GEN_65XX;

  BLK_VIDEO : block

    -- CRTC6545 signals
    signal crtc6845_clk       : std_logic;
    signal crtc6845_e         : std_logic;
    signal crtc6845_cs_n      : std_logic;
	  signal crtc6845_ra        : std_logic_vector(4 downto 0);
	  signal crtc6845_ma        : std_logic_vector(13 downto 0);
    signal crtc6845_disptmg   : std_logic;
    signal crtc6845_hsync     : std_logic;
    signal crtc6845_vsync     : std_logic;

    -- SAA5050 signals
    signal clk_6M_en          : std_logic;
    signal saa5050_d          : std_logic_vector(6 downto 0);
    signal saa5050_r          : std_logic;
    signal saa5050_g          : std_logic;
    signal saa5050_b          : std_logic;
		signal saa5050_de					: std_logic;

    -- video ULA signals
		signal ula_de							: std_logic;
		signal video_r				    : std_logic_vector(9 downto 0);
		signal video_g				    : std_logic_vector(9 downto 0);
		signal video_b				    : std_logic_vector(9 downto 0);

    signal video_de       		: std_logic;

  begin

    BLK_VIDEO_ULA : block

			signal control_r		: std_logic_vector(7 downto 0);
			alias flash_r				: std_logic is control_r(0);
			alias teletext_r		: std_logic is control_r(1);
			alias cpl_r					: std_logic_vector(1 downto 0) is control_r(3 downto 2);	-- 10/20/40/80
			alias clk_rate_r		: std_logic is control_r(4);                              -- 1/2MHz
			alias cursor_w_r		: std_logic_vector(1 downto 0) is control_r(6 downto 5);	-- 1/NA/2/4
			alias m_cursor_w_r	: std_logic is control_r(7);

      subtype phys_clr_t is std_logic_vector(3 downto 0);
      type palette_t is array (natural range <>) of phys_clr_t;
			signal palette_r		: palette_t(15 downto 0);
      -- physical colour mapping
      -- - bit 3 - flashing c and ~c
      -- - bit 2 - blue component
      -- - bit 1 - green component
      -- - bit 0 - red component
    begin

      -- registers
      process (clk_32M, cpu_reset_n)
      begin
        if cpu_reset_n = '0' then
					control_r <= (others => '0');
					palette_r <= (others => (others => '0'));
        elsif rising_edge(clk_32M) then
					if cpu_clk_en = '1' then
						if videoula_cs = '1' then
              if cpu_rw_n = '0' then
                case cpu_a(0) is
                  when '0' =>
                    control_r <= cpu_d_o;
                  when others =>
                    -- colours are inverted in the palette register for some reason
                    -- - see AUG 19.2.3
                    palette_r(conv_integer(cpu_d_o(7 downto 4))) <= 
                      cpu_d_o(3) & not cpu_d_o(2 downto 0);
                end case;
              end if; -- cpu_rw_n
						end if; -- videoula_cs
					end if; -- cpu_clk_en
        end if;
      end process;

      -- the CRTC6845 implementation is not synchronous!!!
      crtc6845_clk <= clk_1M_90_en when clk_rate_r = '0' else clk_2M_180_en;

			-- graphics data serialiser
			process (clk_32M, rst_32M)
				variable video_byte 	: std_logic_vector(7 downto 0) := (others => '0');
        variable v_mode       : std_logic_vector(2 downto 0);
        variable log_clr      : std_logic_vector(3 downto 0);
        variable phys_clr     : phys_clr_t;
			begin
			
        v_mode := clk_rate_r & cpl_r;

				if rst_32M = '1' then
					video_byte := (others => '0');
				elsif rising_edge(clk_32M) then
          
          if clk_rate_r = '0' then
            -- 6845 clk rate = 1MHz
						if clk_1M_en = '1' then
							video_byte := video_d;
						else
              case cpl_r is
                when "01" =>								  -- Mode 5, 1MHz 4ppb/2bpp
                  if clk_4M_en = '1' then
                    video_byte := video_byte(6 downto 4) & '1' & video_byte(2 downto 0) & '1';
                  end if;
                when "10" =>								  -- Mode 4,6 1MHz 8ppb/1bpp
                  if clk_8M_en = '1' then
                    video_byte := video_byte(6 downto 0) & '1';
                  end if;
                when others =>
                  null;
              end case; -- cpl_r
            end if; -- clk_1M_en
          else
            -- 6845 clk rate = 2MHz
            if clk_2M_en = '1' then
              video_byte := video_d;
            else
              case cpl_r is
                when "01" =>								-- Mode 2, 2MHz 2ppb/4bpp
                  if clk_4M_en = '1' then
                    video_byte := video_byte(6) & '1' & video_byte(4) & '1' & 
                                  video_byte(2) & '1' & video_byte(0) & '1';
                  end if;
                when "10" =>								-- Mode 1, 2MHz 4ppb/2bpp
                  if clk_8M_en = '1' then
                    video_byte := video_byte(6 downto 4) & '1' & video_byte(2 downto 0) & '1';
                  end if;
                when "11" =>			          -- Mode 0,3, 2MHz 8ppb/1bpp
									if clk_16M_en = '1' then
                  	video_byte := video_byte(6 downto 0) & '1';
									end if;
                when others =>
                  null;
              end case; -- cpl_r
            end if; -- clk_2M_en = '0'
          end if; -- clk_rate_r = '1'
				end if; -- rising_edge(clk_32M)

				-- assign RGB outputs
        log_clr := video_byte(7) & video_byte(5) & video_byte(3) & video_byte(1);
        -- bit 3 of the physical colour is the flashing bit
        phys_clr := palette_r(conv_integer(log_clr));
        if teletext_r = '1' then
          video_r <= (others => saa5050_r);
          video_g <= (others => saa5050_g);
          video_b <= (others => saa5050_b);
					video_de <= saa5050_de;
        else
          video_r <= (others => (flash_r and phys_clr(3)) xor phys_clr(0));
          video_g <= (others => (flash_r and phys_clr(3)) xor phys_clr(1));
          video_b <= (others => (flash_r and phys_clr(3)) xor phys_clr(2));
					video_de <= ula_de;
        end if;
			end process;

    end block BLK_VIDEO_ULA;

    -- enable output of the video ULA
    -- pipeline delay because of clock phasing
    process (clk_32M, rst_32M)
      variable de_r : std_logic_vector(7 downto 0);
      variable ra3_r : std_logic_vector(7 downto 0);
    begin
      if rst_32M = '1' then
        de_r := (others => '0');
      elsif rising_edge(clk_32M) then
        de_r := de_r(de_r'left-1 downto 0) & crtc6845_disptmg;
      end if;
      ula_de <= de_r(de_r'left) and not crtc6845_ra(3);
      saa5050_de <= de_r(de_r'left);
    end process;

    -- needs inverted CS
    crtc6845_cs_n <= not crtc6845_cs;
    crtc6845_e <= not cpu_clk_en;

    GEN_ROCKOLA_6845 : if BBC_USE_ROCKOLA_6845 generate

      crtc6845s_inst : crtc6845s
        port map
        (
          -- INPUT
          I_E         => crtc6845_e,
          I_DI        => cpu_d_o,
          I_RS        => cpu_a(0),
          I_RWn       => cpu_rw_n,
          I_CSn       => crtc6845_cs_n,
          I_CLK       => crtc6845_clk,
          I_RSTn      => cpu_reset_n,

          -- OUTPUT
          O_RA        => crtc6845_ra,
          O_MA        => crtc6845_ma,
          O_H_SYNC    => crtc6845_hsync,
          O_V_SYNC    => crtc6845_vsync,
          O_DISPTMG   => crtc6845_disptmg
        );
  
    end generate GEN_ROCKOLA_6845;

    GEN_OPENCORES_6845 : if BBC_USE_OC_6845 generate

      crtc6845s_inst : entity work.crtc6845
        port map
        (
          MA          => crtc6845_ma,
          RA          => crtc6845_ra,
          HSYNC       => crtc6845_hsync,
          VSYNC       => crtc6845_vsync,
          DE          => crtc6845_disptmg,
          CURSOR      => open,
          LPSTBn      => '1',
          E           => crtc6845_e,
          RS          => cpu_a(0),
          CSn         => crtc6845_cs_n,
          RW          => cpu_rw_n,
          DI          => cpu_d_o,
          DO          => open,
          RESETn      => cpu_reset_n,
          CLK         => crtc6845_clk,
          -- not standard
          REG_INIT    => '0',
          --
          Hend        => open,
          HS          => open,
          CHROW_CLK   => open,
          Vend        => open,
          SLadj       => open,
          H           => open,
          V           => open,
          CURSOR_ACTIVE => open,
          VERT_RST    => open
        );

    end generate GEN_OPENCORES_6845;

    -- interrupt set on negative edge of VSYNC
    -- according to the schematics, the VSYNC output (active high)
    --   from 6845 is connected directly to the CA1 input of the 6522
    --   - so the interrupt will happen at the _end_ of VSYNC
    vsync_int <= crtc6845_vsync;

    BLK_VIDADDR : block

      signal b  : std_logic_vector(4 downto 1);
      signal s  : std_logic_vector(4 downto 1);

    begin

      -- IC36/40/27
      b(1) <= not (c(0) and c(1) and crtc6845_ma(12));
      b(2) <= not (c(1) and b(3) and crtc6845_ma(12));
      b(3) <= c(0) nand crtc6845_ma(12);
      b(4) <= b(3) nand crtc6845_ma(12);

      -- IC39 (74LS283)
      s <= crtc6845_ma(11 downto 8) + b + 1;

      -- MA13=0 (hires), MA13=1 (teletext)
      video_a <=  s(4) & "1111" & crtc6845_ma(9 downto 0) when crtc6845_ma(13) = '1' else
                      s & crtc6845_ma(7 downto 0) & crtc6845_ra(2 downto 0);

    end block BLK_VIDADDR;

    -- generate 6M clock for SAA5050
		-- fudge for now - use 2 out of every 3 8M clocks
    process (clk_32M, rst_32M)
      variable timing_chain : std_logic_vector(7 downto 0);
    begin
      if rst_32M = '1' then
        timing_chain := "10101000";
      elsif rising_edge(clk_32M) then
				clk_6M_en <= timing_chain(timing_chain'left);
				timing_chain := timing_chain(timing_chain'left-1 downto 0) & timing_chain(timing_chain'left);
      end if;
    end process;

    -- bit 6 is gated by the teletext display enable bit
    saa5050_d <= (video_d(6) and crtc6845_disptmg) & video_d(5 downto 0);

    saa505x_inst : entity work.saa505x
      port map
      (
        clk				=> clk_32M,
        reset			=> rst_32M,

        si_i_n		=> '0',               -- tied low on schematic
        si_o			=> open,              -- not used
        data_n		=> '1',               -- tied high on schematic
        d					=> saa5050_d,
        dlim			=> '1',               -- tied high on schematic
        glr				=> crtc6845_hsync,
        dew				=> crtc6845_vsync,
        crs				=> '0',               -- to be implemented?
        bcs_n			=> '1',               -- tied high on schematic
        tlc_n			=> open,
        tr6				=> clk_6M_en,
        f1				=> clk_1M_en,
        y					=> open,              -- N/C on schematic
        b					=> saa5050_b,
        g					=> saa5050_g,
        r					=> saa5050_r,
        blan			=> open,              -- N/C on schematic
        lose			=> crtc6845_disptmg,
        po				=> '0',               -- tied low on schematic
        de				=> '1'                -- tied high on schematic
      );

    -- drive VGA outputs
    -- fudge for now
    video_o.clk <= clk_32M;
    video_o.hsync <= crtc6845_hsync;
    video_o.vsync <= crtc6845_vsync;
    video_o.rgb.r <= video_r when video_de = '1' else (others => '0');
    video_o.rgb.g <= video_g when video_de = '1' else (others => '0');
    video_o.rgb.b <= video_b when video_de = '1' else (others => '0');
    video_o.de <= video_de;
    
  end block BLK_VIDEO;

  --
  --  MEMORIES
  --

  mos_rom_inst : entity work.mos_rom
    port map
    (
      clock		    => clk_32M,
      address		  => cpu_a(13 downto 0),
      q		        => mos_rom_d
    );

  -- ROM 3
  basic_rom_inst : entity work.basic_rom
    port map
    (
      clock		    => clk_32M,
      address		  => cpu_a(13 downto 0),
      q		        => rom_3_d
    );

  -- RAM

  GEN_INTERNAL_RAM : if BBC_USE_INTERNAL_RAM generate

    dram_inst : entity work.dpram
      generic map
      (
        init_file => "dram.hex",
        numwords_a => 16384,
        widthad_a => 14
      )
      port map
      (
        clock_b				=> cpu_clk_en,
        address_b			=> cpu_a(13 downto 0),
        data_b				=> cpu_d_o,
        wren_b				=> ram_we,
        q_b						=> ram_d,

        clock_a				=> clk_32M,
        address_a			=> video_a(13 downto 0),
        data_a				=> (others => '0'),
        wren_a				=> '0',
        q_a						=> video_d
      );

  end generate GEN_INTERNAL_RAM;

  GEN_EXTERNAL_RAM : if not BBC_USE_INTERNAL_RAM generate

    process (clk_32M, rst_32M)
      variable ram_a  : std_logic_vector(14 downto 0);
    begin
      if rst_32M = '1' then
        null;
      elsif rising_edge(clk_32M) then
        if sys_cycle = X"4" then
          ram_a := cpu_a(ram_a'range);
          sram_o.cs <= ram_cs;
          sram_o.oe <= cpu_rw_n;
          sram_o.we <= ram_we;
        elsif sys_cycle = X"8" then
          ram_d <= sram_i.d(ram_d'range);
        elsif sys_cycle(3 downto 0) = "1100" then
          ram_a := video_a(ram_a'range);
          sram_o.cs <= '1';
          sram_o.oe <= '1';
          sram_o.we <= '0';
        elsif sys_cycle(3 downto 0) = "0000" then
          video_d <= sram_i.d(ram_d'range);
        end if;
        -- mask off high bit for 16K machines
        ram_a := (ram_a(14) and BBC_RAM_32K) & ram_a(13 downto 0);
        sram_o.a <= std_logic_vector(resize(unsigned(ram_a), sram_o.a'length));
      end if;
    end process;

    sram_o.d <= std_logic_vector(resize(unsigned(cpu_d_o), sram_o.d'length));
    sram_o.be <= std_logic_vector(to_unsigned(1, sram_o.be'length));

  end generate GEN_EXTERNAL_RAM;

end SYN;
