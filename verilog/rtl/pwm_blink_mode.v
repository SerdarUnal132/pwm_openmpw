`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2021 11:17:06 AM
// Design Name: 
// Module Name: blink_mode
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


module pwm_blink_mode #(
  parameter Resolution = 16
) (
  input                        clk_i,
  input                        rst_ni,
  input       [Resolution-1:0] threshold_counter_1,
  input       [Resolution-1:0] threshold_counter_2,
  input       [Resolution-1:0] period_counter_1,
  input       [Resolution-1:0] period_counter_2,
  input       [Resolution-1:0] step,
  input       [Resolution-1:0] switch_counter,
  output                       pwm_signal
);

  reg                  output_reg;
  reg [Resolution-1:0] counter;
  reg [Resolution-1:0] threshold_counter;
  reg [Resolution-1:0] period_counter;
  
  pwm_standard_mode #(
    .Resolution(Resolution)
  ) standard_mode_pwm (
    .clk_i              (clk_i),
    .rst_ni             (rst_ni),
    .threshold_counter  (threshold_counter),
    .period_counter     (period_counter),
    .step               (step),
    .pwm_signal         (pwm_signal)
  );
  
  always @(posedge clk_i) begin
    if (rst_ni == 0) begin
      counter           <= 0;
      threshold_counter <= 0;
      period_counter    <= 0;
    end else begin
      if (counter < switch_counter) begin
        counter           <= counter + 1;
        threshold_counter <= threshold_counter_1;
        period_counter    <= period_counter_1;
      end else if (counter >= switch_counter && counter < 2 * switch_counter) begin
        counter           <= counter + 1;
        threshold_counter <= threshold_counter_2;
        period_counter    <= period_counter_2;
      end else begin
        counter           <= 0;
        threshold_counter <= 0;
        period_counter    <= 0;     
      end
    end
        
        
  end
    
  
endmodule

