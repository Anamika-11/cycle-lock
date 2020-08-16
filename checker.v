`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2019 18:58:48
// Design Name: 
// Module Name: checker
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


module checker(output reg ans);
    wire [15:0] sample;
    wire [15:0] test;
    reader r(sample);
    reader2 r2(test);
    initial begin
       assign ans=1;
    end
    integer e;
   initial
    begin
    for(e=0;e<16;e=e+1) begin
         if(sample[e]!==test[e]) begin
            assign ans=0;
         end   
    end  
   end       
endmodule
