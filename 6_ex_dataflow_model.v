///// mux //////
// Modu1e 4-to-1 mu1tip1exer using data f1ow. 1ogic equation
/*
module mux4_1 (out, i0, i1, i2, i3, s1, s0);

output out;
input i0, i1, i2, i3;
input s1, s0;

//Logic equation for out

//assign out = (~s1 & ~s0 & i0) | (~s1 & s0 & i1) | (s1 & ~s0 & i2) | (s1 & s0 & i3) ;

// method 2 conditional operator

assign out = s1 ? ( s0 ? i3 : i2):(s0 ? i1 : i0);

endmodule
*/

// 4-bit full adder by using dataflow statements

module fulladd4 (sum, c_out, a, b, c_in) ;

// I/O port declarations
output [3:0] sum;
output c_out;
input [3:0] a, b;
input c_in;
// Specify the function of a full adder
assign {c_out, sum} = a + b + c_in;

endmodule










