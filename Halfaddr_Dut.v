// DUT
`timescale 1ns/1ps
module HalfAddr(input [1:0]a,b, output sum,carry);
xor (sum,a,b);
and (carry,a,b);
endmodule
