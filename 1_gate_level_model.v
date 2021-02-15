/*
module basic_gate;
wire in1,in2,in3,out,ctrl;

// basic gate instantiation
and a1(out,in1,in2);
or o1(out,in1,in2);
nand n1(out,in1,in2);
nor n2(out,in1,in2);
xor x1(out,in1,in2);
xnor x2(out,in1,in2);

// 3 input gates
or o2(out,in1,in2,in2);
nand n3(out,in1,in2,in3);

/// buf and not gate instantiation
not (out,in1);
buf (out,in1);

//Instantiation of bufif gates.
bufif1 bif1 (out, in, ctrl) ;
bufif0 bif0 (out, in, ctrl) ;

//Instantiation of notif gates
notif1 nif1 (out, in, ctrl) ;
notif0 nif0 (out, in, ctrl) ;
$finish;
endmodule
*/

///// 4 to 1 mux dut using gate-level modeling

/*
module mux4_1 (out,i0,i1,i2,i3,s0,s1);

output out;
input i0,i1,i2,i3;
input s0,s1;

wire n0,n1;
wire o1,o2,o3,o4;

not ns0(n0,s0);
not ns1(n1,s1);

and a1(o1,n0,n1,i0);
and a2(o2,n0,s1,i1);
and a3(o3,s0,n1,i2);
and a4(o4,s0,s1,i3);

or (out,o1,o2,o3,o4);

endmodule

///////// 4 to 1 mux testbench using gatelevel modeling
module tb_mux4_1;

wire OUT;
reg I0,I1,I2,I3,S0,S1;

mux4_1 mx(.i0(I0),.i1(I1),.i2(I2),.i3(I3),.s0(S0),.s1(S1),.out(OUT));

initial begin

///// set input lines

I0= 1;I1= 0;I2= 1;I3= 0; 
#1 $display("I0 = %b, I1 =%b, I2 = %b, I3 =%b",I0,I1,I2,I3);

S0=0;  S1=0;
#1 $display("S0 = %b, S1 =%b, Output = %b",S0,S1,OUT);
S0=0;  S1=1;
#1 $display("S0 = %b, S1 =%b, Output = %b",S0,S1,OUT);
S0=1;  S1=0;
#1 $display("S0 = %b, S1 =%b, Output = %b",S0,S1,OUT);
S0=1;  S1=1;
#1 $display("S0 = %b, S1 =%b, Output = %b",S0,S1,OUT);

end
endmodule    
*/

 //////// 1 -bit full adder using gate level modeling ///////////////
/*
module f_addr_1bit (sum,cout,a,b,cin);

input a,b,cin; 
output sum,cout;
wire s1,c1,s2;

xor (s1,a,b);
and (c1,a,b);
xor (sum,cin,s1);
and (s2,s1,cin);
xor (cout,c1,s2);

endmodule

///////////  4bit ripple carry adder using 1 bit full adder //////////
module ripple_carry_addr_4bit(SUM,COUT,A,B,CIN);

input [3:0]A,B;
input CIN;
output [3:0]SUM;
output COUT;
wire C1,C2,C3;	

f_addr_1bit RPA1(.sum(SUM[0]),.cout(C1),.a(A[0]),.b(B[0]),.cin(CIN));
f_addr_1bit RPA2(.sum(SUM[1]),.cout(C2),.a(A[1]),.b(B[1]),.cin(C1));
f_addr_1bit RPA3(.sum(SUM[2]),.cout(C3),.a(A[2]),.b(B[2]),.cin(C2));
f_addr_1bit RPA4(.sum(SUM[3]),.cout(COUT),.a(A[3]),.b(B[3]),.cin(C3));

endmodule

//////////////   stimulus for 4 bit ripple carry adder //////////////

module tb_ripple_carr_addr();

reg  [3:0]AA,BB;
reg CI;
wire [3:0]Sum;
wire CO;

// module instantiation
ripple_carry_addr_4bit rpl1(.SUM(Sum),.COUT(CO),.A(AA),.B(BB),.CIN(CI));

// display function
initial 
 begin
$monitor("@%g ns A= %b, B= %b, Cin= %b,----- output Sum = %b \n ",$time,AA,BB,CI,Sum);
#100 $finish;
end

// stimulus input
initial
begin     
	AA =4'd0; BB = 4'd0; CI =1'b0;
#5 AA =4'd5; BB = 4'd2; 
#5 AA =4'd3; BB = 4'd6; 
#5 AA =4'd1; BB = 4'd9; 
#5 AA =4'd2; BB = 4'd12; 
#5 AA =4'd3; BB = 4'd10; 
#5 AA =4'd4; BB = 4'd02; 
#5 AA =4'd5; BB = 4'd05; CI=1'b1; 
#5 AA =4'd6; BB = 4'd07; 
#5 AA =4'd3; BB = 4'd3;

end 
endmodule
*/
//////////////////// Gate Delays ///////////////

/////////////// Rise fall and turn-off delays //////

// 1 delay specified => value used for all transitions
// 2 delays specified => refers to rise and fall delay
// 3 delays specified => refers to rise, fall and turnoff delay
// if no delay specified => default value is zero

/*
module delays();
wire 	out,in1,in2,control;

and #(5)(out,in1,in2); // 5ns delay for all trans.
or #(3,4)(out,in1,in2); // rise=2ns, fall=4ns delay
bufif0 #(3,2,6)(out,in1,control); //rise=3ns, fall=2ns, turn-off=6ns delay

///////// min/typ/max value of each rise,fall and turnoff delay //////////

xor #(3:4:5)(out,in1,in2); //min=3, typ=4,max=5 delay for all trans. 
nor #(1:2:3, 2:3:4)(out,in1,in2); //min=1, typ=2,max=3 delay for rise delay and so on
notif1 #(3:4:5, 1:2:3, 4:5:6)(out,in1,in2); // min,max,& typ value specified for rise fall & turn off delay 
endmodule  */

/////////////// delay example ////////////

// Define a simple combination module called D
module D (out, a, b, c);
// 1/0 port declarations
output out;
input a,b,c;
// Internal nets
wire e;
// Instantiate primitive gates to build the circuit
and #(5) a1 (e, a, b); //Delay of 5 on gate a1
or #(4) o1(out, e,c); //Delay of 4 on gate 01
endmodule

// Stimu1us (top-1eve1 modu1e)
module stimulus();
// Dec1are variab1es
reg A, B, C;
wire OUT;
// Instantiate the modu1e D
D d1( OUT, A, B, C);
// Stimu1ate the inputs. Finish the simu1ation at 40 time units
initial begin 
$monitor("@%gns A= %b, B= %b, C= %b,----- out = %b \n ",$time,A,B,C,OUT);
#30 $finish;
end

initial begin
 A= 1'b0; B= 1'b0; C= 1'b0;
#10 A= 1'b1; B= 1'b1; C= 1'b1;
#10 A= 1'b1; B= 1'b0; C= 1'b0;
end
endmodule 
