`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.11.2019 18:19:38
// Design Name: 
// Module Name: reader
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

module reader( output reg [15:0] dataout);
reg [7:0] mem[0:15];
initial begin
    $readmemh("sample.mem",mem);
end    
integer i;
    initial begin 
    for(i=0;i<16;i=i+1)  begin          
        dataout[i]<=mem[i];
     end 
    end
endmodule
