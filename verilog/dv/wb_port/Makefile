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
#
# SPDX-License-Identifier: Apache-2.0


 
PWDD := $(shell pwd)
BLOCKS := $(shell basename $(PWDD))

# ---- Include Partitioned Makefiles ----

CONFIG = caravel_user_project

export MCW_ROOT=/home/serdar/Desktop/pwm/pwm_openmpw/mgmt_core_wrapper
include $(MCW_ROOT)/verilog/dv/make/env.makefile
include $(MCW_ROOT)/verilog/dv/make/var.makefile
include $(MCW_ROOT)/verilog/dv/make/cpu.makefile
include $(MCW_ROOT)/verilog/dv/make/sim.makefile


#all:
#	iverilog -g2005-sv -DWFDUMP -DFUNCTIONAL -DSIM -DGL \
		-I /home/serdar/pdks/sky130A \
		-I /home/serdar/Desktop/pwm/pwm_openmpw/caravel/verilog/dv/caravel \
		-I /home/serdar/Desktop/pwm/pwm_openmpw/caravel/verilog/rtl \
		-I /home/serdar/Desktop/pwm/pwm_openmpw/caravel/verilog \
		-I ../ \
		-I ../../../mgmt_core_wrapper/verilog \
		-I ../../../mgmt_core_wrapper/verilog/rtl \
		-I ../../../verilog/rtl \
		-I ../../../verilog/gl \
		-I ../../../verilog wb_port_tb.v -o wb_port.vvp

#clean:
#	rm -f *.elf *.hex *.bin *.vvp *.vcd *.log