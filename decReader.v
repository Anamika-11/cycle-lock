`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.11.2019 12:34:26
// Design Name: 
// Module Name: decReader
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

  `define m 264
  `define n 435
module decReader();
    integer file,stat,i;
    integer outfile;
    reg [7:0] mat[0:`m*`n-1];
    initial
        begin
            file=$fopen("testfilec.mem","r");
                        i=0;
            while (! $feof(file))
                begin
                    stat=$fscanf(file,"%d\n",mat[i]);
                            i=i+1;
                end
            $fclose(file);
             for(i=0;i<`m;i=i+1) 
                begin  
                    $display("face[i]=%d",mat[i]);
                end
        end
    reg [7:0] mat1[0:`m-1][0:`n-1];
    integer r;
    integer p;
    initial begin
        r=0;
        for(r=0;r<`m;r=r+1) begin
            for(p=0;p<`n;p=p+1) begin
                mat1[r][p]=mat[`m*r+p];
            end
         end       
    end        
    reg [7:0] gradx[0:`m-3][0:`n-3];
    reg [7:0] grady[0:`m-3][0:`n-3];
    reg [7:0] gradf[0:`m-3][0:`n-3];
    reg [7:0] avg[0:`m-5][0:`n-5];
    reg [7:0] sobelx[0:2][0:2];
    reg [7:0] sobely[0:2][0:2];
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
    integer k;
    //sobel filter
    initial begin
    for(k=0;k<`m-2;k=k+1) begin: a1
        for(i0=0;i0<`n-2;i0=i0+1) begin: a2
  
            gradx[k][i0]=sobelx[0][0]*mat1[k][i0]+sobelx[1][0]*mat1[k+1][i0]+sobelx[2][0]*mat1[k+2][i0]+sobelx[0][1]*mat1[k][i0+1]+sobelx[1][1]*mat1[k+1][i0+1]+sobelx[1][2]*mat1[k+1][i0+2]+sobelx[2][0]*mat1[k+2][i0]+sobelx[2][1]*mat1[k+2][i0+1]+sobelx[2][2]*mat1[k+2][i0+2];
        
        end 
     end
   end   
   
   initial begin
    for(k=0;k<`m-2;k=k+1) begin: a3
        for(i=0;i<`n-2;i=i+1) begin: a4
            
            grady[k][i]=sobely[0][0]*mat1[k][i]+sobely[1][0]*mat1[k+1][i]+sobely[2][0]*mat1[k+2][i]+sobely[0][1]*mat1[k][i+1]+sobely[1][1]*mat1[k+1][i+1]+sobely[1][2]*mat1[k+1][i+2]+sobely[2][0]*mat1[k+2][i]+sobely[2][1]*mat1[k+2][i+1]+sobely[2][2]*mat1[k+2][i+2];
        
        end 
     end
   end   
   
   //adding both gradients
   initial begin
    for(k=0;k<`m-2;k=k+1) begin: a6
        for(i=0;i<`n-2;i=i+1) begin: a7
                
            gradf[k][i]=(gradx[k][i]+grady[k][i])/2;
        end 
     end
end
   
   //average
   initial begin
    for(k=0;k<`m-4;k=k+1) begin: a8
        for(i=0;i<`n-4;i=i+1) begin: a9
            
           avg[k][i]=(gradf[k][i]+gradf[k][i+1]+gradf[k][i+2]+gradf[k+1][i]+gradf[k+1][i+1]+gradf[k+1][i+2]+gradf[k+2][i]+gradf[k+2][i+1]+gradf[k+2][i+2])/9;
           if(avg[k][i]<89) 
                avg[k][i]=0;
            else
                avg[k][i]=1;
                
        end 
      
     end
   end  
   //erosing
//   integer u=0;
//   initial begin
//    for(k=0;k<`m-4;k=k+1) begin: a12
//        for(i=0;i<`n-4;i=i+1) begin: a13
//            u=(avg[k-1][i-1]& avg[k][i-1]&avg[k+1][i-1]&avg[k-1][i]&avg[k+1][i]&avg[k-1][i+1]&avg[k][i+1]&avg[k+1][i+1]);
//            if(u==0)
//                avg[k][i]=0;
        
//        end 
//     end
//   end    
initial begin 
            outfile=$fopen("/home/2018csb1089/CL/file.txt","w");
            for(k=0;k<`m-4;k=k+1) begin: a10
                for(i=0;i<`n-4;i=i+1) begin: a11
                    $fwrite(outfile," ",avg[k][i]);
                end  
                $fwrite(outfile,"\n");  
     end
     $fclose(outfile);
  end   
  
  
endmodule
