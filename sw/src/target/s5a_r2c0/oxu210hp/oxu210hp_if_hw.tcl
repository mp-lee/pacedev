# TCL File Generated by Component Editor 9.1sp2
# Tue Nov 09 11:17:26 EST 2010
# DO NOT MODIFY


# +-----------------------------------
# | 
# | oxu210hp_if "oxu210hp_if" v1.0
# | Virtual Logic 2010.11.09.11:17:26
# | OXU210HP USB Interface
# | 
# | E:/work/s5a/sw/S5A-sw-MF2/src/ep4c/oxu210hp/oxu210hp_if.vhd
# | 
# |    ./oxu210hp_if.vhd syn, sim
# | 
# +-----------------------------------

# +-----------------------------------
# | request TCL package from ACDS 9.1
# | 
package require -exact sopc 9.1
# | 
# +-----------------------------------

# +-----------------------------------
# | module oxu210hp_if
# | 
set_module_property DESCRIPTION "OXU210HP USB Interface"
set_module_property NAME oxu210hp_if
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property GROUP S5A
set_module_property AUTHOR "Virtual Logic"
set_module_property DISPLAY_NAME oxu210hp_if
set_module_property TOP_LEVEL_HDL_FILE oxu210hp_if.vhd
set_module_property TOP_LEVEL_HDL_MODULE oxu210hp_if
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL TRUE
# | 
# +-----------------------------------

# +-----------------------------------
# | files
# | 
add_file oxu210hp_if.vhd {SYNTHESIS SIMULATION}
# | 
# +-----------------------------------

# +-----------------------------------
# | parameters
# | 
# | 
# +-----------------------------------

# +-----------------------------------
# | display items
# | 
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point s0
# | 
add_interface s0 avalon end
set_interface_property s0 addressAlignment DYNAMIC
set_interface_property s0 associatedClock clock_sink
set_interface_property s0 burstOnBurstBoundariesOnly false
set_interface_property s0 explicitAddressSpan 0
set_interface_property s0 holdTime 0
set_interface_property s0 isMemoryDevice false
set_interface_property s0 isNonVolatileStorage false
set_interface_property s0 linewrapBursts false
set_interface_property s0 maximumPendingReadTransactions 0
set_interface_property s0 printableDevice false
set_interface_property s0 readLatency 0
set_interface_property s0 readWaitTime 1
set_interface_property s0 setupTime 0
set_interface_property s0 timingUnits Cycles
set_interface_property s0 writeWaitTime 0

set_interface_property s0 ASSOCIATED_CLOCK clock_sink
set_interface_property s0 ENABLED true

add_interface_port s0 avs_s0_address address Input 16
add_interface_port s0 avs_s0_readdata readdata Output 32
add_interface_port s0 avs_s0_writedata writedata Input 32
add_interface_port s0 avs_s0_chipselect chipselect Input 1
add_interface_port s0 avs_s0_read read Input 1
add_interface_port s0 avs_s0_write write Input 1
add_interface_port s0 avs_s0_byteenable byteenable Input 4
add_interface_port s0 avs_s0_waitrequest waitrequest Output 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point conduit_end_0
# | 
add_interface conduit_end_0 conduit end

set_interface_property conduit_end_0 ENABLED true

add_interface_port conduit_end_0 coe_uh_reset_n export Output 1
add_interface_port conduit_end_0 coe_uh_a export Output 16
add_interface_port conduit_end_0 coe_uh_d export Bidir 32
add_interface_port conduit_end_0 coe_uh_cs_n export Output 1
add_interface_port conduit_end_0 coe_uh_rd_n export Output 1
add_interface_port conduit_end_0 coe_uh_wr_n export Output 1
add_interface_port conduit_end_0 coe_uh_be export Output 4
add_interface_port conduit_end_0 coe_uh_int_n export Input 1
add_interface_port conduit_end_0 coe_uh_dreq export Input 2
add_interface_port conduit_end_0 coe_uh_dack export Output 2
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point clock_sink
# | 
add_interface clock_sink clock end

set_interface_property clock_sink ENABLED true

add_interface_port clock_sink nios_clk clk Input 1
add_interface_port clock_sink nios_rst reset Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point irq_s0
# | 
add_interface irq_s0 interrupt end
set_interface_property irq_s0 associatedAddressablePoint s0

set_interface_property irq_s0 ASSOCIATED_CLOCK clock_sink
set_interface_property irq_s0 ENABLED true

add_interface_port irq_s0 avs_s0_irq irq Output 1
# | 
# +-----------------------------------