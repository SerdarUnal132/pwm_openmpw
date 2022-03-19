# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0

set ::env(PDK) "sky130A"
set ::env(STD_CELL_LIBRARY) "sky130_fd_sc_hd"

set script_dir [file dirname [file normalize [info script]]]

set ::env(DESIGN_NAME) pwm_top

set ::env(VERILOG_FILES) "\
	$::env(CARAVEL_ROOT)/verilog/rtl/defines.v \
	$script_dir/../../verilog/rtl/pwm_top.v \
	$script_dir/../../verilog/rtl/pwm.v \
	$script_dir/../../verilog/rtl/pwm_blink_mode.v \
	$script_dir/../../verilog/rtl/pwm_standard_mode.v \
	$script_dir/../../verilog/rtl/pwm_heartbeat_mode.v \
	$script_dir/../../verilog/rtl/pwm_find_smaller.v"

set ::env(CLOCK_PORT) "wb_clk_i"
set ::env(CLOCK_NET) "pwm.clk_i"
set ::env(CLOCK_PERIOD) "38"

set ::env(BASE_SDC_FILE) {/home/serdar/Desktop/pwm/pwm_openmpw/openlane/pwm/base.sdc}

set ::env(FP_PIN_ORDER_CFG) $script_dir/pin_order.cfg

# Maximum layer used for routing is metal 4.
# This is because this macro will be inserted in a top level (user_project_wrapper) 
# where the PDN is planned on metal 5. So, to avoid having shorts between routes
# in this macro and the top level metal 5 stripes, we have to restrict routes to metal4.  
# 
# set ::env(GLB_RT_MAXLAYER) 5

set ::env(RT_MAX_LAYER) {met4}

# You can draw more power domains if you need to 
set ::env(VDD_NETS) [list {vccd1}]
set ::env(GND_NETS) [list {vssd1}]




##################################################################
# Flow Control
##################################################################
set ::env(RUN_ROUTING_DETAILED) 1
# If you're going to use multiple power domains, then disable cvc run.
set ::env(RUN_CVC) 1

##################################################################
# Synthesis
##################################################################
set ::env(SYNTH_STRATEGY) {AREA 1}
set ::env(SYNTH_MAX_FANOUT) 3

##################################################################
# Floorplanning
##################################################################
set ::env(FP_SIZING) absolute
set ::env(DIE_AREA) "0 0 1600 700"
set ::env(FP_CORE_UTIL) 35
set ::env(DESIGN_IS_CORE) 0
set ::env(FP_PDN_VPITCH) 100

##################################################################
# Placement
##################################################################
set ::env(PL_BASIC_PLACEMENT) 0
set ::env(PL_TARGET_DENSITY) 0.30
set ::env(PL_TIME_DRIVEN) 0
set ::env(PL_ROUTABILITY_DRIVEN) 1
set ::env(PL_MAX_DISPLACEMENT_X) 600
set ::env(PL_MAX_DISPLACEMENT_Y) 400
set ::env(CELL_PAD) 4
set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_SETUP_MAX_BUFFER_PERCENT) 30
set ::env(PL_RESIZER_HOLD_MAX_BUFFER_PERCENT) 70
set ::env(PL_RESIZER_ALLOW_SETUP_VIOS) 1
set ::env(PL_RESIZER_HOLD_SLACK_MARGIN) 0.2
set ::env(PL_RESIZER_MAX_WIRE_LENGTH) 300

##################################################################
# CTS
##################################################################
set ::env(CTS_TARGET_SKEW) 150
set ::env(CTS_TOLERANCE) 25
set ::env(CTS_CLK_BUFFER_LIST) "sky130_fd_sc_hd__clkbuf_4 sky130_fd_sc_hd__clkbuf_8"
set ::env(CTS_SINK_CLUSTERING_SIZE) "16"
set ::env(CLOCK_BUFFER_FANOUT) "8"

##################################################################
# Optimization
##################################################################


##################################################################
# Global Routing
##################################################################
set ::env(GLB_RT_ANT_ITERS) 10
set ::env(GLOBAL_ROUTER) fastroute
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(GLB_RESIZER_ALLOW_SETUP_VIOS) 1
set ::env(GLB_RESIZER_HOLD_SLACK_MARGIN) 1.7
set ::env(GLB_RESIZER_HOLD_MAX_BUFFER_PERCENT) 75

##################################################################
# Antenna Diodes Insertion
##################################################################
set ::env(DIODE_PADDING) 2
set ::env(DIODE_INSERTION_STRATEGY) 3

##################################################################
# LEC
##################################################################

##################################################################
# Detailed Routing
##################################################################
set ::env(DRT_OPT_ITERS) 45
set ::env(ROUTING_CORES) 8
set ::env(DETAILED_ROUTER) tritonroute

##################################################################
# RC Extraction
##################################################################

##################################################################
# STA
##################################################################

##################################################################
# GDSII Streaming
##################################################################

##################################################################
# Physical Verification
##################################################################
