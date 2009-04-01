# TCL File Generated by Component Editor 8.1
# Thu Apr 02 00:25:50 EST 2009
# DO NOT MODIFY


# +-----------------------------------
# | 
# | lpc_spi "lpc_spi" v1.0
# | null 2009.04.02.00:25:50
# | 
# | 
# | E:/markm/pace/pacedev.net/sw/src/platform/coco3-becker/lpc_emu/ip/lpc_spi/lpc_spi.vhd
# | 
# |    ./lpc_spi.vhd syn, sim
# | 
# +-----------------------------------


# +-----------------------------------
# | module lpc_spi
# | 
set_module_property DESCRIPTION ""
set_module_property NAME lpc_spi
set_module_property VERSION 1.0
set_module_property GROUP PACE
set_module_property DISPLAY_NAME lpc_spi
set_module_property LIBRARIES {ieee.std_logic_1164.all ieee.numeric_std.all std.standard.all}
set_module_property TOP_LEVEL_HDL_FILE lpc_spi.vhd
set_module_property TOP_LEVEL_HDL_MODULE lpc_spi_controller
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
# | 
# +-----------------------------------

# +-----------------------------------
# | files
# | 
add_file lpc_spi.vhd {SYNTHESIS SIMULATION}
# | 
# +-----------------------------------

# +-----------------------------------
# | parameters
# | 
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point clock_reset
# | 
add_interface clock_reset clock end
set_interface_property clock_reset ptfSchematicName ""

add_interface_port clock_reset clk clk Input 1
add_interface_port clock_reset reset reset Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point avalon_slave_0
# | 
add_interface avalon_slave_0 avalon end
set_interface_property avalon_slave_0 addressAlignment DYNAMIC
set_interface_property avalon_slave_0 addressSpan 64
set_interface_property avalon_slave_0 bridgesToMaster ""
set_interface_property avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0 holdTime 0
set_interface_property avalon_slave_0 isMemoryDevice false
set_interface_property avalon_slave_0 isNonVolatileStorage false
set_interface_property avalon_slave_0 linewrapBursts false
set_interface_property avalon_slave_0 maximumPendingReadTransactions 0
set_interface_property avalon_slave_0 minimumUninterruptedRunLength 1
set_interface_property avalon_slave_0 printableDevice false
set_interface_property avalon_slave_0 readLatency 0
set_interface_property avalon_slave_0 readWaitTime 1
set_interface_property avalon_slave_0 setupTime 0
set_interface_property avalon_slave_0 timingUnits Cycles
set_interface_property avalon_slave_0 writeWaitTime 0

set_interface_property avalon_slave_0 ASSOCIATED_CLOCK clock_reset

add_interface_port avalon_slave_0 chipselect chipselect Input 1
add_interface_port avalon_slave_0 a address Input 4
add_interface_port avalon_slave_0 di writedata Input 32
add_interface_port avalon_slave_0 do readdata Output 32
add_interface_port avalon_slave_0 rd read Input 1
add_interface_port avalon_slave_0 wr write Input 1
add_interface_port avalon_slave_0 waitrequest_n waitrequest_n Output 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point conduit_end
# | 
add_interface conduit_end conduit end

set_interface_property conduit_end ASSOCIATED_CLOCK clock_reset

add_interface_port conduit_end spi_miso export Input 1
add_interface_port conduit_end spi_mosi export Output 1
add_interface_port conduit_end spi_ss export Output 1
add_interface_port conduit_end spi_clk export Output 1
# | 
# +-----------------------------------
