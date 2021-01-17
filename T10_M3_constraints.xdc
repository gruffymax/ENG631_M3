# Team 10 - 762102 872403

# Clock signal
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports i_C100MHz]

# defining clock signal, period is in ns: name must be different from port, waveform 50:50 duty cycle and assign to same entity port
create_clock -add -period 10.000 -name C100MHz_pin -waveform {0.000 5.000} [get_ports i_C100MHz]

#LEDs
set_property -dict { PACKAGE_PIN P1   IOSTANDARD LVCMOS33 } [get_ports {o_led[0]}]
set_property -dict { PACKAGE_PIN L1   IOSTANDARD LVCMOS33 } [get_ports {o_led[1]}]

# Buttons
#BTNC - centre button
set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports i_Reset]
set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports i_start]


#Switches
set_property -dict { PACKAGE_PIN R2   IOSTANDARD LVCMOS33 } [get_ports i_sw15]
set_property -dict { PACKAGE_PIN T1   IOSTANDARD LVCMOS33 } [get_ports i_sw14]
set_property -dict { PACKAGE_PIN U1   IOSTANDARD LVCMOS33 } [get_ports i_sw13]
set_property -dict { PACKAGE_PIN W2   IOSTANDARD LVCMOS33 } [get_ports i_sw12]


#7 seg display
#CA
set_property -dict { PACKAGE_PIN W7    IOSTANDARD LVCMOS33 } [get_ports {o_SegmentCathodes[0]}]
#CB
set_property -dict { PACKAGE_PIN W6    IOSTANDARD LVCMOS33 } [get_ports {o_SegmentCathodes[1]}]
#CC
set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS33 } [get_ports {o_SegmentCathodes[2]}]
#CD
set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports {o_SegmentCathodes[3]}]
#CE
set_property -dict { PACKAGE_PIN U5    IOSTANDARD LVCMOS33 } [get_ports {o_SegmentCathodes[4]}]
#CF
set_property -dict { PACKAGE_PIN V5    IOSTANDARD LVCMOS33 } [get_ports {o_SegmentCathodes[5]}]
#CG
set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports {o_SegmentCathodes[6]}]

#AN0
set_property -dict { PACKAGE_PIN U2    IOSTANDARD LVCMOS33 } [get_ports {o_SegmentAnodes[0]}]
#AN1
set_property -dict { PACKAGE_PIN U4    IOSTANDARD LVCMOS33 } [get_ports {o_SegmentAnodes[1]}]
#AN2
set_property -dict { PACKAGE_PIN V4    IOSTANDARD LVCMOS33 } [get_ports {o_SegmentAnodes[2]}]
#AN3
set_property -dict { PACKAGE_PIN W4    IOSTANDARD LVCMOS33 } [get_ports {o_SegmentAnodes[3]}]

# Bitstream configuration
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
