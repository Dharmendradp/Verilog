/*module operators(y,a,b,c);
input a,b,c;
output [2:0]y;

assign y[0] =  ~a;  //  ~ is a unary operator, a is the operand
assign y[1] = a && b; //  ?? is a binary operator, a and b are operands
assign y[2] = c ? a : b; // ?: is a ternary operator, a,b,c are operands
endmodule
*/

///////// Number Specification & display format specifiers /////////////////
/* module num1;
reg [11:0]e;
reg [7:0]b;
integer a,c,d,f;
integer real_no_decimal_format,real_no_sceintific_format;

initial begin
 a = 'hz??;
 b = -'b1000_1000;
 c = 'ox??;
 d = -'d25;
//#5 $stop;
 e= -12'h325;
 f = "stringfortheone";
real_no_sceintific_format = 'h3e10;
real_no_decimal_format = 2.2031; 
end

initial begin 
$display ("a = %h",a);
$display ("b = %b \nc = %o",b,c);
$monitor ("a = %h \nb = %b \nc = %o \nd = %d \ne = %h  \nf = %s",a,b,c,d,e,f);
$display("@%gns real number(scientific format) =  %0e",$time,real_no_sceintific_format);
$display("@%gns real number(decimal format) =  %0f",$time,real_no_decimal_format);

#10 $finish;
end
endmodule

*/

///////// nets representation ////////

/*
module nets(out,in1,in2,ctrl);
input in1,in2,ctrl;
output out;
trireg out;    // trireg
wire in1,in2,ctrl;
reg [2:0]b,a,c;  /// vector declaration 
integer counter;
real delta;
time save_time;

bufif0 b1(out,in1,ctrl);   
bufif1 b2(out,in2,ctrl);

initial begin
a = 3'b100;
b = 3'b101;
c = 3'b110;
counter = -112354; 

$display("value of integer counter = %d",counter);
$display("value of registors a,b,c = %b %b %b",a,b,c);
end

initial fork
//save_time = $time;       // decalaring time

delta = 66.12;
#10 delta = 3e6;

#15 delta  = 2.0345;
$monitor ("@ %gns value of delta = %f",$time,delta); 

// $monitor("current time : @ %gns",save_time);  // display current simulation time
join


initial
begin
#20 counter = delta;
$monitor("value of integer counter after assigning delta value = %f",counter);
$dumpfile("myfile.vcd");
$dumpvars;
#50 $finish;
end
endmodule
*/

///////////////  arrays & Memories & parameter ////////////////////
/*
module Arrays #(parameter const_line = 5);   // parameter doclaration

integer count[0:7]; // an array of 8 count variables
                    // can give any representation count[7:0]  or count[0:7]
reg bool[31:0];  // array of 32 bool reg variables,each of 1 bit reg type
time save_ti[2:101]; // arrays of 100 time variables
reg [3:0]port_id[0:15]; // array of 16 port ids, each of 4 bit widinteger i;
integer i;

reg memr1[0:1024]; //memory memr1 with 1k 1-bit each
reg [7:0]memr2[0:1024]; //memory memr2 with 1k 1-byte each


initial 
begin
$display("5th element of array of count variables => %d",count[5]);
port_id[6] = 'b11110101010011100011; 
port_id[4] = 'b100100100; 
$display("3rd element of array of port_ids => %d",port_id[3]);
$display("6th element of array of port_id=> %b",port_id[6]);
$display("4th element of array of port_id=> %b",port_id[4]);

memr2[511] = 'd25;       // fetches 1 byte of memr2 whose address is 511
$display("byte of adress 511 of memory2 => %d",memr2[511]);


for(i=0;i<16;i=i+1) 
$display("array of port_id [%0d] => %b",i,port_id[i]);
#10 $finish;

end
endmodule
*/

/*
module parameter_ex #(parameter N=2) (input[(N-1):0]a,b, output[(N-1):0]sum, output cout);
assign { cout,sum } = a + b;
endmodule    
*/


///////////////// string ///////////
/*module string1;
reg [8*64:1]arr; // declared a variable with is 64 byte wide
reg [16*64:1]arr2; // declared a variable with 64 word wide
initial begin
 arr = "hello welcome to the semiconductor domain"; // string stored in a variable
 arr2 = "republic day";
 $display("%s ",arr);
 $display("\"%0s \"",arr2);
end
endmodule
*/


/////////// compiler directives ///////////
/*module comp_dir;
`define word_size 32;
`define S $stop; // define an alias  , $stop will be substituted whenever S appears in the program

`define word_r reg[31:0]; // define a frequently used text string
//`include "new.v"

endmodule
*/

/////////////////////// exercise ////////////////////////////

/* module Exercise1;   
//reg [7:0]a;
//
`define MEM_SIZE 1024

integer a;            
reg [15:0]hex;       
reg [3:0]neg = -4'd2;
reg [3:0]neg_num;
integer hex_num;

initial begin
a = 'd256789;
hex = 'hx;
neg_num = ~neg;
neg_num =neg_num + 1;
hex_num = 'h1234;

//$display("%b_%b_%b_%b_%b",a[19:16],a[15:12],a[11:8],a[7:4],a[3:0]);
//$display("%h",hex);
//$display("negative 2 in decimal %b",neg);
//$display("negative number after 2's compliment = %b",neg_num);
//$display("%h",hex_num);

end

initial begin
$display ("this is a string Displaying the %% sign");
$display ("out = in1 + in2");
$display ("Please ring a bell \\007");
$display ("this is a backslash \\ character\\n");
$display("The maximum memory size is %h",`MEM_SIZE);

end
endmodule
*/

/*module top;
  integer x,a,b,c,d;
  
  initial begin
   x=101;
    a=x%10; //3
    b=(x-a)/10;//24
    c=b%10; //4
    d=(b-c)/10; //2
    
    $write("%d",d);
    $write("_");
    $write("%d",c);
    $write("_");
    $write("%d",a);
    
  end
endmodule
*/
