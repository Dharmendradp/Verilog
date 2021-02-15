/////////  operators ///////////
module oper(a,b,sum,sub,div,mul,mod,l_and,l_or,l_not,eq,neq,ceq,nceq,bor,band,bnot,bxor,bxnor,Rand,Ror,Rxor,rs,ls,ars,als,con1,con2,con3,rep1,rep2,rep3);
input [3:0] a,b;
output [3:0]sum,sub,div,mul,mod,l_and,l_or,l_not,eq,neq,ceq,nceq,bor,band,bnot,bxor,bxnor,Rand,Ror,Rxor,rs,ls,ars,als;
output [15:0]con1,con2,con3,rep1,rep2,rep3;	

/// arith operators ////
assign sum = a + b;
assign sub = a - b;
assign div = a / b;
assign mul = a * b;
assign mod = a % b;

/// logical operators ////
assign l_and= a && b;
assign l_and = a || b;
assign l_not = ! b;

//// equality opr ////
assign eq = (a == b);
assign neq = (a != b);
assign ceq = (a === b);
assign nceq = (a !== b);

//// bitwise opr /////
assign bor = (a | b);
assign band = (a & b);
assign bnot = ~a;
assign bxor = (a ^ b);
assign bxnor = (a ~^ b);

///// reduction opr //// 

assign Rand = &b;
assign Ror= |b;
assign Rxor = ^b;

///// shift oper /// 

assign rs = a >> 2;
assign ls = a << 2;
assign ars = a >>> 2;
assign als = a <<< 2;

///// concatenation operator //// 

assign con1 = {a,b};
assign con2 = {a[0],b[2]};
assign con3 = {a[1],b[3],2'b10};

///// replication operator //// 

assign rep1 = { 2{a} };
assign rep2 = { {2{a}}, {2{b[2]}}};
assign rep3 = { {2{a}}, {2{b}}, 2'b11 };

endmodule

 

module test;

reg [3:0] a,b;
wire [3:0]sum,sub,div,mul,mod,l_and,l_or,l_not,eq,neq,ceq,nceq,bor,band,bnot,bxor,bxnor,Rand,Ror,Rxor,rs,ls,ars,als;	
wire [11:0]con1,con2,con3,rep1,rep2,rep3;	
oper op1(a,b,sum,sub,div,mul,mod,l_and,l_or,l_not,eq,neq,ceq,nceq,bor,band,bnot,bxor,bxnor,Rand,Ror,Rxor,rs,ls,ars,als,con1,con2,con3,rep1,rep2,rep3);

initial begin
//$monitor("@%0gns a= %d, b= %d,---- sum = %d sub = %d div = %d mul = %d mod = %d, l_and = %d, l_or = %d, l_not = %d \n",$time,a,b,sum,sub,div,mul,mod,l_and,l_or,l_not);

$monitor("@%0gns a= %b, b= %b\n sum = %b, sub = %b, div = %b, mul = %b, mod = %b\n l_and = %b, l_or = %b, l_not = %b\n eq = %b, neq = %b, ceq = %b, nceq = %b\n bor = %b, band = %b, bnot = %b, bxor = %b, bxnor = %b\n Rand = %b, Ror = %b, Rxor = %b\n rs = %b, ls = %b, ars = %b, als = %b\n con1 = %0b, con2 = %0b, con3 = %0b\n rep1 = %0b,rep2 = %0b,rep3 = %0b",$time,a,b,sum,sub,div,mul,mod,l_and,l_or,l_not,eq,neq,ceq,nceq,bor,band,bnot,bxor,bxnor,Rand,Ror,Rxor,rs,ls,ars,als,con1,con2,con3,rep1,rep2,rep3);
#100 $finish;
end

initial begin
a = 4'd6; b =4'd8;
#2 a = 4'd3; b =4'd2;
#2 a = 4'd4; b =4'd2;
#2 a = 4'd8; b =4'd8;
#2 a = 4'd5; b =4'd7;
#2 a = 4'dx; b =4'dx;
#2 a = 4'dx; b =4'd0;
#2 a = 4'dz; b =4'dx;
#2 a = 4'd0; b =4'dz;
#2 a = 4'dz; b =4'dz;
end
endmodule

