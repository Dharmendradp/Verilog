`timescale 1ns/1ps
module halfaddr_tb();
reg [1:0]a,b;
wire sum,carry;

HalfAddr DUT(.a(a),.b(b),.sum(sum),.carry(carry));

//always@(*) 
// begin
//{a,b,sum,carry} =  1'b0;

/*  case(a,b)
    begin 
     00 : sum=0,carry =0;
     
     01 : sum=1,carry =0;
     10 : sum=1,carry =0;
     11 : sum=0,carry =1;
    default: 1'bz;
end 
 endcase */
initial begin
// Initialize Inputs
a = 0;
b = 0;
// Wait 100 ns for global reset to finish
#10.5;

a = 1;
b = 0;
#20;
 a = 1;
 b = 1;
#30;
 a = 0;
 b = 1;

end

initial 
  $monitor("input a=%0b, b =%0b, output sum =%0b, carry= %0b",a,b,sum,carry);

initial begin 
   $dumpfile("dump.vcd");
   $dumpvars;
#100 $finish();
end 

endmodule 


