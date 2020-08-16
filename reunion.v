`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2019 22:14:04
// Design Name: 
// Module Name: reunion
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

//Module for matching the hex values of 2 given barcodes with same size :)
module reunion(input clk,output reg ans);  
 reg [127:0] mem2[0:1957];
    reg [127:0] mem1[0:1957];
    initial begin
        $readmemh("sample.mem",mem1);
         $readmemh("test.mem",mem2);
    end    
  initial begin
       assign ans=1;
  end
    integer e;
   always @( e)
    begin
    //for(e=0;e<1958;e=e+1) begin
  //       $display("%h",mem1[e]);
         // $display("%h",mem2[e]);
         if(mem1[e]!==mem2[e]) begin
            ans=0;
         end 
         e=e+1;  
    //end  
   end     
endmodule
