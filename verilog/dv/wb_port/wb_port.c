/*
 * SPDX-FileCopyrightText: 2020 Efabless Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 * SPDX-License-Identifier: Apache-2.0
 */

// This include is relative to $CARAVEL_PATH (see Makefile)
#include <defs.h>
#include <stub.c>
#include "../register_map.h"

/*
	Wishbone Test:
		- Configures MPRJ lower 8-IO pins as outputs
		- Checks counter value through the wishbone port
*/

void main()
{

	/* 
	IO Control Registers
	| DM     | VTRIP | SLOW  | AN_POL | AN_SEL | AN_EN | MOD_SEL | INP_DIS | HOLDH | OEB_N | MGMT_EN |
	| 3-bits | 1-bit | 1-bit | 1-bit  | 1-bit  | 1-bit | 1-bit   | 1-bit   | 1-bit | 1-bit | 1-bit   |
	Output: 0000_0110_0000_1110  (0x1808) = GPIO_MODE_USER_STD_OUTPUT
	| DM     | VTRIP | SLOW  | AN_POL | AN_SEL | AN_EN | MOD_SEL | INP_DIS | HOLDH | OEB_N | MGMT_EN |
	| 110    | 0     | 0     | 0      | 0      | 0     | 0       | 1       | 0     | 0     | 0       |
	
	 
	Input: 0000_0001_0000_1111 (0x0402) = GPIO_MODE_USER_STD_INPUT_NOPULL
	| DM     | VTRIP | SLOW  | AN_POL | AN_SEL | AN_EN | MOD_SEL | INP_DIS | HOLDH | OEB_N | MGMT_EN |
	| 001    | 0     | 0     | 0      | 0      | 0     | 0       | 0       | 0     | 1     | 0       |
	*/
    reg_wb_enable = 1;
	/* Set up the housekeeping SPI to be connected internally so	*/
	/* that external pin changes don't affect it.			*/

    reg_spi_enable = 1;
	// reg_spimaster_config = 0xa002;	// Enable, prescaler = 2,
                                        // connect to housekeeping SPI

	// Connect the housekeeping SPI to the SPI master
	// so that the CSB line is not left floating.  This allows
	// all of the GPIO pins to be used for user functions.

    reg_mprj_io_31 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_30 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_29 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_28 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_27 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_26 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_25 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_24 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_23 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_22 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_21 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_20 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_19 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_18 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_17 = GPIO_MODE_MGMT_STD_OUTPUT;
    reg_mprj_io_16 = GPIO_MODE_MGMT_STD_OUTPUT;

    reg_mprj_io_15 = GPIO_MODE_USER_STD_OUT_MONITORED;
    reg_mprj_io_14 = GPIO_MODE_USER_STD_OUT_MONITORED;
    reg_mprj_io_13 = GPIO_MODE_USER_STD_OUT_MONITORED;
    reg_mprj_io_12 = GPIO_MODE_USER_STD_OUT_MONITORED;
    reg_mprj_io_11 = GPIO_MODE_USER_STD_OUT_MONITORED;
    reg_mprj_io_10 = GPIO_MODE_USER_STD_OUT_MONITORED;
    reg_mprj_io_9  = GPIO_MODE_USER_STD_OUT_MONITORED;
    reg_mprj_io_8  = GPIO_MODE_USER_STD_OUT_MONITORED;
    reg_mprj_io_7  = GPIO_MODE_USER_STD_OUT_MONITORED;
    reg_mprj_io_6  = GPIO_MODE_USER_STD_OUT_MONITORED;
    reg_mprj_io_5  = GPIO_MODE_USER_STD_OUT_MONITORED;
    reg_mprj_io_4  = GPIO_MODE_USER_STD_OUT_MONITORED;
    reg_mprj_io_3  = GPIO_MODE_USER_STD_OUT_MONITORED;
    reg_mprj_io_2  = GPIO_MODE_USER_STD_OUT_MONITORED;
    reg_mprj_io_1  = GPIO_MODE_USER_STD_OUT_MONITORED;
    reg_mprj_io_0  = GPIO_MODE_USER_STD_OUT_MONITORED;

    
     /* Apply configuration */
    reg_mprj_xfer = 1;
    while (reg_mprj_xfer == 1);

    reg_la0_oenb = reg_la0_iena = 0x00000000;    // [31:0]
	reg_la1_oenb = reg_la1_iena = 0xFFFFFFFF;    // [63:32]
	reg_la2_oenb = reg_la2_iena = 0xFFFFFFFE;    // [95:64]
	reg_la3_oenb = reg_la3_iena = 0xFFFFFFFF;    // [127:96]
	
    // Flag start of the test
	// reg_mprj_datal = 0xAB600000;

    reg_la2_data = 0x00000002;
    reg_la2_data = 0x00000000;

    

    // reg_mprj_slave = 0x2B3D;

    // PWM0
    
    reg_pwm0_state_select =                  PWM_HEARTBEAT;
    reg_pwm0_inversion =                     PWM_INVERT_DISABLE;
    reg_pwm0_threshold_counter_standard =    0x00000000;
    reg_pwm0_period_counter_standard =       0x00000000;
    reg_pwm0_step_standard =                 0x00000000;
    reg_pwm0_threshold_counter_blink_1 =     0x00000000;
    reg_pwm0_threshold_counter_blink_2 =     0x00000000;
    reg_pwm0_period_counter_blink_1 =        0x00000000;
    reg_pwm0_period_counter_blink_2 =        0x00000000;
    reg_pwm0_step_blink =                    0x00000000;
    reg_pwm0_switch_counter_blink =          0x00000000;
    reg_pwm0_threshold_counter_heartbeat_1 = 0x00000FA0;
    reg_pwm0_threshold_counter_heartbeat_2 = 0x00004E20;
    reg_pwm0_period_counter_heartbeat =      0x00009C40;
    reg_pwm0_step_heartbeat =                0x00000001;
    reg_pwm0_increment_step_heartbeat =      0x00000FA0;
	
	// PWM1
    
    reg_pwm1_state_select =                  PWM_BLINK;
    reg_pwm1_inversion =                     PWM_INVERT_DISABLE;
    reg_pwm1_threshold_counter_standard =    0x00000000;
    reg_pwm1_period_counter_standard =       0x00000000;
    reg_pwm1_step_standard =                 0x00000000;
    reg_pwm1_threshold_counter_blink_1 =     0x00000FA0;
    reg_pwm1_threshold_counter_blink_2 =     0x00004E20;
    reg_pwm1_period_counter_blink_1 =        0x00009C40;
    reg_pwm1_period_counter_blink_2 =        0x00009C40;
    reg_pwm1_step_blink =                    0x00000001;
    reg_pwm1_switch_counter_blink =          0x00013880;
    reg_pwm1_threshold_counter_heartbeat_1 = 0x00000064;
    reg_pwm1_threshold_counter_heartbeat_2 = 0x00030958;
    reg_pwm1_period_counter_heartbeat =      0x00030D40;
    reg_pwm1_step_heartbeat =                0x00000001;
    reg_pwm1_increment_step_heartbeat =      0x0000015E;
	
	// PWM2
    
    reg_pwm2_state_select =                  PWM_STANDARD;
    reg_pwm2_inversion =                     PWM_INVERT_DISABLE;
    reg_pwm2_threshold_counter_standard =    0x00004E20;
    reg_pwm2_period_counter_standard =       0x00009C40;
    reg_pwm2_step_standard =                 0x00000001;
    reg_pwm2_threshold_counter_blink_1 =     0x00000000;
    reg_pwm2_threshold_counter_blink_2 =     0x00000000;
    reg_pwm2_period_counter_blink_1 =        0x00000000;
    reg_pwm2_period_counter_blink_2 =        0x00000000;
    reg_pwm2_step_blink =                    0x00000000;
    reg_pwm2_switch_counter_blink =          0x00000000;
    reg_pwm2_threshold_counter_heartbeat_1 = 0x00000064;
    reg_pwm2_threshold_counter_heartbeat_2 = 0x00030958;
    reg_pwm2_period_counter_heartbeat =      0x00030D40;
    reg_pwm2_step_heartbeat =                0x00000001;
    reg_pwm2_increment_step_heartbeat =      0x0000015E;
	
	// PWM3
    
    reg_pwm3_state_select =                  PWM_STANDARD;
    reg_pwm3_inversion =                     PWM_INVERT_DISABLE;
    reg_pwm3_threshold_counter_standard =    0x00004E20;
    reg_pwm3_period_counter_standard =       0x000186A0;
    reg_pwm3_step_standard =                 0x00000001;
    reg_pwm3_threshold_counter_blink_1 =     0x00000000;
    reg_pwm3_threshold_counter_blink_2 =     0x00000000;
    reg_pwm3_period_counter_blink_1 =        0x00000000;
    reg_pwm3_period_counter_blink_2 =        0x00000000;
    reg_pwm3_step_blink =                    0x00000000;
    reg_pwm3_switch_counter_blink =          0x00000000;
    reg_pwm3_threshold_counter_heartbeat_1 = 0x00000064;
    reg_pwm3_threshold_counter_heartbeat_2 = 0x00030958;
    reg_pwm3_period_counter_heartbeat =      0x00030D40;
    reg_pwm3_step_heartbeat =                0x00000001;
    reg_pwm3_increment_step_heartbeat =      0x0000015E;
    
    //reg_mprj_datal = 0xAB610000;
    
}
