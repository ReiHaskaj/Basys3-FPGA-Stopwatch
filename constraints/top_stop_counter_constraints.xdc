#Clock signal
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

#Button_Right / reset
set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports Button_Right]

#Button_Mid / capture
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports Button_Mid]

#LED Start / Start
set_property -dict { PACKAGE_PIN L1   IOSTANDARD LVCMOS33 } [get_ports LED_Start]

#Anode
set_property -dict { PACKAGE_PIN U2   IOSTANDARD LVCMOS33 } [get_ports {Anode[0]}]
set_property -dict { PACKAGE_PIN U4   IOSTANDARD LVCMOS33 } [get_ports {Anode[1]}]
set_property -dict { PACKAGE_PIN V4   IOSTANDARD LVCMOS33 } [get_ports {Anode[2]}]
set_property -dict { PACKAGE_PIN W4   IOSTANDARD LVCMOS33 } [get_ports {Anode[3]}]

#Segment
set_property -dict { PACKAGE_PIN W7   IOSTANDARD LVCMOS33 } [get_ports {Segment[0]}]
set_property -dict { PACKAGE_PIN W6   IOSTANDARD LVCMOS33 } [get_ports {Segment[1]}]
set_property -dict { PACKAGE_PIN U8   IOSTANDARD LVCMOS33 } [get_ports {Segment[2]}]
set_property -dict { PACKAGE_PIN V8   IOSTANDARD LVCMOS33 } [get_ports {Segment[3]}]
set_property -dict { PACKAGE_PIN U5   IOSTANDARD LVCMOS33 } [get_ports {Segment[4]}]
set_property -dict { PACKAGE_PIN V5   IOSTANDARD LVCMOS33 } [get_ports {Segment[5]}]
set_property -dict { PACKAGE_PIN U7   IOSTANDARD LVCMOS33 } [get_ports {Segment[6]}]

set_property -dict { PACKAGE_PIN V7   IOSTANDARD LVCMOS33 } [get_ports dp]