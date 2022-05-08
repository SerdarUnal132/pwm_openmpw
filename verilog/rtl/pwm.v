`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2021 11:05:36 AM
// Design Name: 
// Module Name: pwm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module pwm #(
    parameter BITS = 32
) (
  input             clk_i,
  input             rst_ni,
  // Bus Interface
  input             valid_i,
  input             we_i,
  input  [BITS-1:0] addr_i,
  input  [BITS-1:0] wdata_i,
//  input  [BITS-1:0] la_write,
//  input  [BITS-1:0] la_input,
  output            ready_o,
  output [BITS-1:0] rdata_o,
  // Generic IO
  output            cio_pwm_o
);

  localparam     Resolution = 32;
  localparam     NRegisters = 16;
  localparam     RegAw = 8;
  localparam     RegDw = 32; // Shall be matched with TL_DW
  localparam     RegBw = RegDw/8;
  localparam     IDLE = 3'b000;
  localparam     STANDARD = 3'b001;
  localparam     BLINK = 3'b010;
  localparam     HEARTBEAT = 3'b011;

  reg  [3:0]                       enable_pwm;

  // Standard Mode Setup
  wire  [Resolution-1:0]          threshold_counter_standard;
  wire  [Resolution-1:0]          period_counter_standard;
  wire  [Resolution-1:0]          step_standard;
  
  // Blink Mode Setup
  wire  [Resolution-1:0]          threshold_counter_blink_1;
  wire  [Resolution-1:0]          threshold_counter_blink_2;
  wire  [Resolution-1:0]          period_counter_blink_1;
  wire  [Resolution-1:0]          period_counter_blink_2; 
  wire  [Resolution-1:0]          step_blink; 
  wire  [Resolution-1:0]          switch_counter_blink;
  
  // Heartbeat Mode Setup
  wire  [Resolution-1:0]          threshold_counter_heartbeat_1;
  wire  [Resolution-1:0]          threshold_counter_heartbeat_2;
  wire  [Resolution-1:0]          period_counter_heartbeat;
  wire  [Resolution-1:0]          step_heartbeat;
  wire  [Resolution-1:0]          increment_step_heartbeat;

  wire [2:0]                      state_select;
  wire                            output_wire_standard;
  wire                            output_wire_blink;
  wire                            output_wire_heartbeat;
  wire                            inversion;
  reg                             cio_pwm_o_reg;
  reg                             cio_pwm_o_reg_before_inversion;
  
  // Register interface
  reg  [RegDw-1:0] rdata_q;
  reg              ready_q;
  
  assign rdata_o = rdata_q;
  assign ready_o = ready_q;

  // Register file
  reg   [RegDw-1:0] register_file      [NRegisters-1:0];
  wire  [3:0]       addr_register_file;
  
  
  assign cio_pwm_o = cio_pwm_o_reg;
  
  // General
  assign addr_register_file = addr_i[7:0] >> 2;
  assign state_select       = register_file[0][2:0];
  assign inversion          = register_file[1][0];
  
  // Standard Mode Setup
  assign threshold_counter_standard    = register_file[2];
  assign period_counter_standard       = register_file[3];
  assign step_standard                 = register_file[4];
  
  // Blink Mode Setup
  assign threshold_counter_blink_1     = register_file[5];
  assign threshold_counter_blink_2     = register_file[6];
  assign period_counter_blink_1        = register_file[7];
  assign period_counter_blink_2        = register_file[8]; 
  assign step_blink                    = register_file[9]; 
  assign switch_counter_blink          = register_file[10];
  
  // Heartbeat Mode Setup
  assign threshold_counter_heartbeat_1 = register_file[11];
  assign threshold_counter_heartbeat_2 = register_file[12];
  assign period_counter_heartbeat      = register_file[13];
  assign step_heartbeat                = register_file[14];
  assign increment_step_heartbeat      = register_file[15];
  
  integer k;
  
  always @(posedge clk_i) begin
    if (rst_ni == 0) begin
      for (k = 0; k < NRegisters; k = k + 1) register_file[k] <= 0;  
      ready_q <= 0;
    end else begin
      ready_q <= 1'b0;
      if (valid_i && !ready_q) begin
        ready_q <= 1'b1;
        if (we_i) begin
          register_file[addr_register_file] <= wdata_i;
          rdata_q = rdata_q;
        end else begin
          register_file[addr_register_file] <= register_file[addr_register_file];
          rdata_q <= register_file[addr_register_file];
        end
      end
      
    end
  end
  
  
  
  pwm_standard_mode #(
    .Resolution          (Resolution)
  ) standard_mode_pwm (  
    .clk_i               (clk_i),
    .rst_ni              (rst_ni & enable_pwm[STANDARD]),
    .threshold_counter   (threshold_counter_standard),
    .period_counter      (period_counter_standard),
    .step                (step_standard),
    .pwm_signal          (output_wire_standard)
  );
  
  pwm_blink_mode #(
    .Resolution          (Resolution)
  ) blink_mode_pwm (
    .clk_i               (clk_i),
    .rst_ni              (rst_ni & enable_pwm[BLINK]),
    .threshold_counter_1 (threshold_counter_blink_1),
    .threshold_counter_2 (threshold_counter_blink_2),
    .period_counter_1    (period_counter_blink_1),
    .period_counter_2    (period_counter_blink_2),
    .step                (step_blink),
    .switch_counter      (switch_counter_blink),
    .pwm_signal          (output_wire_blink)
  );
  
  pwm_heartbeat_mode #(
    .Resolution          (Resolution)
  ) heartbeat_mode_pwm (
    .clk_i               (clk_i),
    .rst_ni              (rst_ni & enable_pwm[HEARTBEAT]),
    .threshold_counter_1 (threshold_counter_heartbeat_1),
    .threshold_counter_2 (threshold_counter_heartbeat_2),
    .period_counter      (period_counter_heartbeat),
    .step                (step_heartbeat),
    .increment_step      (increment_step_heartbeat),
    .pwm_signal          (output_wire_heartbeat)
  );

  always @(posedge clk_i) begin
    if (rst_ni == 0) begin
      cio_pwm_o_reg <= 0;
    end else begin
      cio_pwm_o_reg <= cio_pwm_o_reg_before_inversion ^ inversion;
    end
  end
    
  always @(posedge clk_i) begin
    if (rst_ni == 0) begin
      cio_pwm_o_reg_before_inversion     <= 0;
      enable_pwm                         <= 4'b0000;
    end else begin
      case (state_select)
        IDLE: begin    // Idle mode
          cio_pwm_o_reg_before_inversion <= 0;
          enable_pwm                     <= 4'b0000;
        end
        STANDARD: begin   // Standard mode
          cio_pwm_o_reg_before_inversion <= output_wire_standard;
          enable_pwm                     <= 4'b0010;
        end
        BLINK: begin    // Blink mode
          cio_pwm_o_reg_before_inversion <= output_wire_blink;
          enable_pwm                     <= 4'b0100;
        end
        HEARTBEAT: begin  // Heartbeat mode
          cio_pwm_o_reg_before_inversion <= output_wire_heartbeat;
          enable_pwm                     <= 4'b1000;
        end
        default: begin
          cio_pwm_o_reg_before_inversion <= 0;
          enable_pwm                     <= 4'b0000;
        end
      endcase
    end
  end    
  
endmodule