`include "timescale.v"

`define TB_TOP tb_vic20
module `TB_TOP;

reg fpga_rst;

//
//  CLOCK GENERATION
//

reg     ref_clk;
initial
begin
  ref_clk = 1'b0;
end

  // clock1 - 40MHz
always
  #125.5 ref_clk = ~ref_clk;

// inputs

wire [0:3]    clk;
assign clk[0] = ref_clk;
assign clk[1] = ref_clk;

// outputs
wire [9:0]    red;
wire [9:0]    green;
wire [9:0]    blue;
wire          hsync;
wire          vsync;

// Main simulation loop
reg           debug1;
reg           debug2;
reg           clk_cpu;
reg [23:0]    ad;

initial
begin
  // initialise simulation environment

  // reset processor for a few clocks 
  fpga_rst = 1'b1;
  repeat (30) @(posedge ref_clk);
  fpga_rst = 1'b0;

  // wait a bit
  repeat (500) @(posedge ref_clk);

  repeat (10) @(posedge ref_clk);

  $stop;

end

PACE pace_1
(
	// clocks and resets
  .clk             (clk),
  .test_button     (1'b0),
  .reset           (fpga_rst),

  // game I/O
  //.ps2clk          (1'b0),
  //.ps2data         (1'b0),
  .dip             (8'h00),
	//.jamma						: in JAMMAInputsType;

  // external RAM
  //.sram_addr       : out std_logic_vector(23 downto 0);
  //.sram_data       : inout std_logic_vector(7 downto 0);
  //.sram_cs         : out std_logic;
  //.sram_oe         : out std_logic;
  //.sram_we         : out std_logic;

  // VGA video
	//.vga_clk					: out std_logic;
  .red             (red),
  .green           (green),
  .blue            (blue),
	//.lcm_data				:	out std_logic_vector(9 downto 0);
  .hsync           (hsync),
  .vsync           (vsync),

  // composite video
  //.BW_CVBS         : out std_logic_vector(1 downto 0);
  //.GS_CVBS         : out std_logic_vector(7 downto 0);

  // sound
  //.snd_clk         : out std_logic;
  //.snd_data        : out std_logic_vector(7 downto 0);

  // SPI (flash)
  //.spi_clk         : out std_logic;
  //.spi_mode        : out std_logic;
  //.spi_sel         : out std_logic;
  .spi_din         (1'b0),
  //.spi_dout        : out std_logic;

  // serial
  //.ser_tx          : out std_logic;
  .ser_rx          (1'b0)

  // debug
  //.leds            : out std_logic_vector(7 downto 0)
);

endmodule
