# TCL File Generated by Component Editor 8.1
# Tue Jul 07 12:20:05 EST 2009
# DO NOT MODIFY


# +-----------------------------------
# | 
# | avalon_i2c_master_top "avalon_i2c_master_top" v1.0
# | Virtual Logic Pty Ltd 2009.07.07.12:20:05
# | Opencores I2C Master
# | 
# | D:/work/S5A/sw/S5A-sw-MFP/i2c_controller/avalon_i2c_master_top.vhd
# | 
# |    ./avalon_i2c_master_top.vhd syn, sim
# |    ./i2c_master_bit_ctrl.vhd syn, sim
# |    ./i2c_master_byte_ctrl.vhd syn, sim
# |    ./i2c_master_top.vhd syn, sim
# | 
# +-----------------------------------


# +-----------------------------------
# | module avalon_i2c_master_top
# | 
set_module_property DESCRIPTION "Opencores I2C Master"
set_module_property NAME avalon_i2c_master_top
set_module_property VERSION 1.0
set_module_property GROUP PACE
set_module_property AUTHOR "Virtual Logic Pty Ltd"
set_module_property DISPLAY_NAME avalon_i2c_master_top
set_module_property LIBRARIES {ieee.std_logic_1164.all ieee.numeric_std.all std.standard.all}
set_module_property TOP_LEVEL_HDL_FILE avalon_i2c_master_top.vhd
set_module_property TOP_LEVEL_HDL_MODULE avalon_i2c_master_top
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE false
# | 
# +-----------------------------------

# +-----------------------------------
# | files
# | 
add_file avalon_i2c_master_top.vhd {SYNTHESIS SIMULATION}
add_file i2c_master_bit_ctrl.vhd {SYNTHESIS SIMULATION}
add_file i2c_master_byte_ctrl.vhd {SYNTHESIS SIMULATION}
add_file i2c_master_top.vhd {SYNTHESIS SIMULATION}
# | 
# +-----------------------------------

# +-----------------------------------
# | parameters
# | 
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point clockreset
# | 
add_interface clockreset clock end
set_interface_property clockreset ptfSchematicName ""

add_interface_port clockreset csi_clockreset_clk clk Input 1
add_interface_port clockreset csi_clockreset_reset reset Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point conduit_end_0
# | 
add_interface conduit_end_0 conduit end

set_interface_property conduit_end_0 ASSOCIATED_CLOCK clockreset

add_interface_port conduit_end_0 coe_arst_arst_i export Input 1
add_interface_port conduit_end_0 coe_i2c_scl_pad_i export Input 1
add_interface_port conduit_end_0 coe_i2c_scl_pad_o export Output 1
add_interface_port conduit_end_0 coe_i2c_scl_padoen_o export Output 1
add_interface_port conduit_end_0 coe_i2c_sda_pad_i export Input 1
add_interface_port conduit_end_0 coe_i2c_sda_pad_o export Output 1
add_interface_port conduit_end_0 coe_i2c_sda_padoen_o export Output 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point s1
# | 
add_interface s1 avalon end
set_interface_property s1 addressAlignment DYNAMIC
set_interface_property s1 addressSpan 8
set_interface_property s1 bridgesToMaster ""
set_interface_property s1 burstOnBurstBoundariesOnly false
set_interface_property s1 holdTime 0
set_interface_property s1 isMemoryDevice false
set_interface_property s1 isNonVolatileStorage false
set_interface_property s1 linewrapBursts false
set_interface_property s1 maximumPendingReadTransactions 0
set_interface_property s1 minimumUninterruptedRunLength 1
set_interface_property s1 printableDevice false
set_interface_property s1 readLatency 0
set_interface_property s1 readWaitTime 1
set_interface_property s1 setupTime 0
set_interface_property s1 timingUnits Cycles
set_interface_property s1 writeWaitTime 0

set_interface_property s1 ASSOCIATED_CLOCK clockreset

add_interface_port s1 avs_s1_address address Input 3
add_interface_port s1 avs_s1_writedata writedata Input 8
add_interface_port s1 avs_s1_readdata readdata Output 8
add_interface_port s1 avs_s1_write write Input 1
add_interface_port s1 avs_s1_chipselect chipselect Input 1
add_interface_port s1 avs_s1_waitrequest_n waitrequest_n Output 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point irq1
# | 
add_interface irq1 interrupt end
set_interface_property irq1 associatedAddressablePoint s1

set_interface_property irq1 ASSOCIATED_CLOCK clockreset

add_interface_port irq1 ins_irq1_irq irq Output 1
# | 
# +-----------------------------------
