`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/06/22 09:51:34
// Design Name: 
// Module Name: XADC_test
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


module XADC_test(
input clk,
input RESET,
input [3:0] VAUXP, VAUXN,
output [15:0]     MEASURED_AUX1,,
output [15:0]     MEASURED_AUX2

    );
    
 wire [15:0]     MEASURED_AUX2;
 
 ug480 mytest(
      .DCLK(clk), // Clock input for DRP
      .RESET(RESET),
      .VAUXP(VAUXP), 
      .VAUXN(VAUXN),  // Auxiliary analog channel inputs
      .VP(1'b0),
      .VN(1'b0),// Dedicated and Hardwired Analog Input Pair
     
      .MEASURED_TEMP(), 
      .MEASURED_VCCINT(), 
      .MEASURED_VCCAUX(), 
      .MEASURED_VCCBRAM(),
      .MEASURED_AUX0(), 
      .MEASURED_AUX1(MEASURED_AUX1), 
      .MEASURED_AUX2(MEASURED_AUX2), 
      .MEASURED_AUX3(),
 
      .ALM(),
      .CHANNEL(),       
      .OT(),
      .EOC(),
      .EOS()
     );
 
 always @(posedge clk)
 begin
    if (MEASURED_AUX2<16'h4000)
        led<=4'b0001;
    else if ((MEASURED_AUX2>16'h4000) && (MEASURED_AUX2<16'h8000))
       led<=4'b0010;
     else if ((MEASURED_AUX2>16'h8000) && (MEASURED_AUX2<16'hC000))
        led<=4'b0100;
     else if(MEASURED_AUX2>16'hC000)
        led<=4'b1000; 
       
 end
 
endmodule
