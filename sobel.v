`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.11.2019 12:45:16
// Design Name: 
// Module Name: sobel
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
`define m 4

module sobel();

    integer p,r,c;
    integer file,stat,out,i,g,e;
    reg [7:0] mat[0:`m-1][0:`m-1];
    initial
        begin
            file=$fopen("sample.mem","r");
                        g=0;
            while(! $feof(file))
                begin
                i=0;
            while (! $feof(file))
                begin
                    stat=$fscanf(file,"%d\n",mat[g][i]);
                            i=i+1;
                end
                g=g+1;
                end
            $fclose(file);
            e=0;
            for(e=0;e<`m;e=e+1) 
                begin  
                    $display("face[i]=%d",mat[e][0]);
                end
        end
    reg [6:0] gradx[0:`m-3][0:`m-3];
    reg [6:0] grady[0:`m-3][0:`m-3];
    reg [6:0] sobelx[0:2][0:2];
    reg [6:0] sobely[0:2][0:2];
    initial begin
     sobelx[0][0]=-1;
     sobelx[0][1]=-2;
     sobelx[0][2]=-1;
     sobelx[1][0]=0;
     sobelx[1][1]=0;
     sobelx[1][2]=0;
     sobelx[2][0]=1;
     sobelx[2][1]=2;
     sobelx[2][2]=1;
     sobely[0][0]=-1;
     sobely[0][1]=0;
     sobely[0][2]=1;
     sobely[1][0]=-2;
     sobely[1][1]=0;
     sobely[1][2]=2;
     sobely[2][0]=-1;
     sobely[2][1]=0;
     sobely[2][2]=1;
    end
    integer i0;
    integer j;
    integer k;
    initial begin
    for(k=0;k<`m-4;k=k+1) begin: a1
        for(i0=0;i0<`m-4;i0=i0+1) begin: a2
            
            gradx[k][i0]=sobelx[0][0]*mat[k][i0]+sobelx[1][0]*mat[k+1][i0]+sobelx[2][0]*mat[k+2][i0]+sobelx[0][1]*mat[k][i0+1]+sobelx[1][1]*mat[k+1][i0+1]+sobelx[1][2]*mat[k+1][i0+2]+sobelx[2][0]*mat[k+2][i0]+sobelx[2][1]*mat[k+2][i+1]+sobelx[2][2]*mat[k+2][i+2];
        
        end 
     end
   end   
   
   initial begin
    for(k=0;k<`m-4;k=k+1) begin: a3
        for(i=0;i<`m-4;i=i+1) begin: a4
            
            grady[k][i]=sobely[0][0]*mat[k][i]+sobely[1][0]*mat[k+1][i]+sobely[2][0]*mat[k+2][i]+sobely[0][1]*mat[k][i+1]+sobely[1][1]*mat[k+1][i+1]+sobely[1][2]*mat[k+1][i+2]+sobely[2][0]*mat[k+2][i]+sobely[2][1]*mat[k+2][i+1]+sobely[2][2]*mat[k+2][i+2];
        
        end 
     end
   end   
endmodule
