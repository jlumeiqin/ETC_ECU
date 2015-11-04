`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/06/26 18:47:28
// Design Name: 
// Module Name: MPC_PWM_TOP
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


module MPC_PWM_TOP(
input clk,
input rst,
input start,
input [3:0]VAUXP,
input [3:0]VAUXN,
output pwm_out,
output [1:0] flag
    );
 wire [15:0] MEASURED_AUX1,MEASURED_AUX2;
    ////////////////////////////////////////////////////////////AD_evoke
    ug480 mytest(
          .DCLK(clk), // Clock input for DRP
          .RESET(~rst),
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
     
///////////////////////////////////////////////////////////////////////////////controler evoke

wire start_c;
wire done;
wire idle,ready;
integer i=0;

///////////////////////////////////////////////////////////////////////////////////justify the first time
always @(posedge clk)
begin
if(done)
begin
if(i==0)
i<=i+1;
end

end
assign start_c=(i==0)?start:done;

wire [15:0] u_out;


 Compult my_controlller(
               .ap_clk(clk),
               .ap_rst(~rst),
               .ap_start(start_c),
               .ap_done(done),
               .ap_idle(idle),
               .ap_ready(ready),
               .y_in_V(MEASURED_AUX1),
               .ref_in_V(MEASURED_AUX2),
               .ap_return(u_out)
       );




    
    //////////////////////////////////////////////////////PWM_evoke
   wire [15:0] duty;
   assign duty=(u_out[15]==1)?{1'b0,~u_out[14:0]+1}:u_out;
   assign flag=(u_out[15]==1)? 2'b01:2'b10;
   
    pwm_task_logic my_test_pwm
        (
        .clk(clk),
        .pwm_enable(1'b1),
        .resetn(~rst), 
        .clock_divide(14'd30000),
        .duty_cycle(duty),
        .pwm_out(pwm_out)
        );

endmodule
