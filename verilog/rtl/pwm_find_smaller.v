`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/10/2021 02:39:36 PM
// Design Name: 
// Module Name: find_smaller
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

module pwm_find_smaller #(
  parameter Resolution = 16
) (
  input        [Resolution-1:0]   number_1,
  input        [Resolution-1:0]   number_2,
  output       [Resolution-1:0]   smaller_number,
  output       [Resolution-1:0]   larger_number
);

  assign smaller_number = (number_1 <= number_2) ? number_1 : number_2;
  assign larger_number  = (number_1 > number_2)  ? number_1 : number_2;

endmodule
