/***************************************************************************/
/* File: pwm_task_logic.v */
/* Description: This module contains the core of the pwm functionality. */
/* The clock_divide and duty_cycle inputs are used in conjunction with */
/* a counter to determine how long the pwm output stays high and low. */
/* The output is 1 bit. */
/***************************************************************************/
module pwm_task_logic
(
clk,
pwm_enable,
resetn, 
clock_divide,
duty_cycle,
pwm_out
);
//Inputs
input clk; //Input Clock to be divided
input [13:0] clock_divide; //Clock Divide value
input [13:0] duty_cycle; //Duty Cycle vale
input pwm_enable; //Enable signal
input resetn; //Reset
//Outputs
output pwm_out; //PWM output
//Signal Declarations 
reg [13:0] counter; //PWM Internal Counter
reg pwm_out; //PWM output

//Start Main Code 
always @(posedge clk or negedge resetn) //PWM Counter Process
begin
if (~resetn)begin
counter <= 0;
end
else if(pwm_enable)begin
if (counter >= clock_divide-1)begin
counter <= 0;
end
else begin 
counter <= counter + 1;
end
end
else begin
counter <= counter; 
end
end

always @(posedge clk or negedge resetn) //PWM Comparitor
begin
   if (~resetn)
      begin
         pwm_out <= 0;
      end
   else if(pwm_enable)
      begin
           if (counter > (clock_divide - duty_cycle))
               begin
               pwm_out <= 1'b1;
               end		
			  else 
               begin
                 if (counter == 0)
                     pwm_out <= 0;
                 else
                     pwm_out <= pwm_out;
                 end
       end
    else 
      begin
         pwm_out <= 1'b0;
      end
end

endmodule
