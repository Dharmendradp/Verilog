/// simple clock generator // 

module clk_gen(clk,a);
output reg clk,a;
//reg rst;


/*initial
begin
#8 rst <= 1'b0;
#16 rst <= 1'b1;
#22 rst <= 1'b0;
#50 $finish;
end*/

/*always @(rst)
if(~rst) 
 begin 
 clk <= 1'b0;
 #2 clk <= ~clk;  // toggle clock at every half cycle, clock period = 4ns
 end
else
clk <= 1'b0;
*/


initial begin
 a =1'b0; 
 end

always@(a)
begin
a = ~a;
//a <= ~a;
$display("@%gns --- value of a is = %d ---- ",$time,a);
end
endmodule




///// mux 2_1 using case ///////
/*
module mux_21 ( a,b,c,d,sel0,sel1,y );
input a,b,c,d;
input sel0,sel1;
output reg y;

always @( * )
begin
case({sel0,sel1})
  2'b00: y = a;
  2'b01: y = b;
  2'b10: y = c;
 // 2'b11: y = d;
  default y=d;
endcase
end
endmodule

module tb;
reg a,b,c,d;
reg sel0,sel1;
wire y;

mux_21 m1(a,b,c,d,sel0,sel1,y);


initial begin
 $monitor("@%gns %0b %0b: a=%0b,b=%0b,c=%0b,d=%0b  y = %d",$time,sel0,sel1,a,b,c,d,y);
#100 $finish;
end

initial 
begin
    repeat(16)
      begin
     #0 a = $random();
      b = $random();
      c = $random();
      d = $random();
    #5;      // after 5ns random value will be assigned & again repeating till 16 count      
     end
end
initial
 begin
  repeat(4)
   begin
   sel0 = $random();
   sel1 = $random();
   #5;
   end 
 end

endmodule
*/
//////////////// subroutine -Task & functions (error code) ///////////////

/*module simple_task(input wire [7:0]celsius,output reg [7:0]fahrenheit);

initial 
//celsius = 10;
#1;
convert (celsius, fahrenheit); // Calling the task “convert”

task convert( input [7:0]celsius, output [7:0]fahrenheit);
      
     begin
     fahrenheit = (9/5)*celsius;
     end
endtask

endmodule


module tb_simple_task();
reg [7:0]celsius;
wire [7:0]fahrenheit;

simple_task smp1(celsius, fahrenheit);


initial begin
 $monitor("@%gns celsius = %d, fahrenheit = %d",$time,celsius,fahrenheit);
#100 $finish;
end

initial 
begin
    repeat(16)
      begin
     celsius = $urandom();
     end
end

endmodule  */

//////////////////// function (bug in code) //////////////////////

/*module simple_function();
reg [7:0]celsius;
real fahrenheit;
initial begin
celsius = 10;
fahrenheit = convert(celsius); // Calling the function“convert”
$display("------- cels = %d, fah = %g",celsius,fahrenheit);
end
function convert(input [7:0] celsius_t);
begin
convert = (9/5)*celsius_t;
end
endfunction
endmodule
*/


