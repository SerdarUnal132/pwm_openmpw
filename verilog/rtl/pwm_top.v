// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

//`default_nettype none
/*
 *-------------------------------------------------------------
 *
 * user_proj_example
 *
 * This is an example of a (trivially simple) user project,
 * showing how the user project can connect to the logic
 * analyzer, the wishbone bus, and the I/O pads.
 *
 * This project generates an integer count, which is output
 * on the user area GPIO pads (digital output only).  The
 * wishbone connection allows the project to be controlled
 * (start and stop) from the management SoC program.
 *
 * See the testbenches in directory "mprj_counter" for the
 * example programs that drive this user project.  The three
 * testbenches are "io_ports", "la_test1", and "la_test2".
 *
 *-------------------------------------------------------------
 */
//`define MPRJ_IO_PADS 38

module 
pwm_top #(
    parameter BITS   = 32,
    parameter NumPWM = 4
)(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input          wb_clk_i,
    input          wb_rst_i,
    input          wbs_stb_i,
    input          wbs_cyc_i,
    input          wbs_we_i,
    input [3:0]    wbs_sel_i,
    input [31:0]   wbs_dat_i,
    input [31:0]   wbs_adr_i,
    output         wbs_ack_o,
    output [31:0]  wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // IRQ
    output [2:0] irq
);
    //wire clk;
    //wire rst;

    wire [31:0] rdata [NumPWM-1:0]; 
    wire [31:0] wdata;
    wire [NumPWM-1:0] cio_pwm;
    wire [NumPWM-1:0] ready;
    wire [NumPWM-1:0] pwm_select;
    wire [NumPWM-1:0] valid_select;

    wire valid;
    wire [31:0] la_write;

    // WB MI A
    assign valid = wbs_cyc_i && wbs_stb_i; 
    assign wbs_dat_o = rdata[pwm_select];
    assign wdata = wbs_dat_i;

    // IO
    assign io_out = cio_pwm;
    assign io_oeb = {(`MPRJ_IO_PADS-1){rst}};

    // IRQ
    assign irq = 3'b000;	// Unused

    // LA
    assign la_data_out = {{(128-NumPWM){1'b0}}, cio_pwm};
    
    assign wbs_ack_o = | ready;
    assign pwm_select = wbs_adr_i[7:6];

    assign valid_select = (pwm_select == 0) ? 4'b0001 :
                          ((pwm_select == 1) ? 4'b0010 :
                          ((pwm_select == 2) ? 4'b0100 :
                          ((pwm_select == 3) ? 4'b1000 : 4'b0000)));
     
    genvar i;
    for (i = 0; i < NumPWM; i = i+1) begin
        pwm #(
            .BITS      (BITS)
        ) pwm_insts (
            .clk_i     (wb_clk_i),
            .rst_ni    (!wb_rst_i),
            .ready_o   (ready[i]),
            .valid_i   (valid && valid_select[i]),
            .rdata_o   (rdata[i]),
            .wdata_i   (wbs_dat_i),
            .we_i      (wbs_we_i),
            .addr_i    (wbs_adr_i),
//          .la_write  (la_write),
//          .la_input  (la_data_in[63:32]),
            // Generic IO
            .cio_pwm_o (cio_pwm[i])
        );
    end
    

endmodule
