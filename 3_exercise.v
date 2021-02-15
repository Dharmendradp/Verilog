module mux2_1_using_buff(out,in1,s,in0);
input in1,s,in0;
output out;
//reg out;
bufif1 #(1:2:3, 3:4:5, 5:6:7) b2(out,in1,s);
bufif0 #(1:2:3, 3:4:5, 5:6:7)b1(out,in0,s);

endmodule

module test();
reg IN1,IN0,S;
wire OUT;

mux2_1_using_buff m1(.in1(IN1),.in0(IN0),.s(S),.out(OUT));

initial begin
$monitor("@%0gns in1 = %b, in0= %b, S = %b, ---- out = %b",$time,IN1,IN0,S,OUT);
#100 $finish;
end
initial begin
IN1 = 0; IN0= 0; S=0;
#1 IN1 = 0; IN0= 1; S=0;
#1 IN1 = 1; IN0= 0; S=0;
#1 IN1 = 1; IN0= 1; S=0;
#2
#1 IN1 = 0; IN0= 0; S=1;
#1 IN1 = 0; IN0= 1; S=1;
#1 IN1 = 1; IN0= 0; S=1;
#1 IN1 = 1; IN0= 1; S=1;
end
endmodule
