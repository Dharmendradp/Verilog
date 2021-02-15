module stimulus;
reg [3:0] REG_IN;
reg CLK;
wire [3:0]REG_OUT;	

shiftreg sr1(.reg_out(REG_OUT),.reg_in(REG_IN),.clock(CLK));

stimulus.REG_IN, stimulus.CLK, stimulus.REG_OUT

/*initial
begin
$display("%m",REG_IN);
$display("%m",REG_OUT);
end*/
endmodule

module shiftreg(reg_out,reg_in,clock);
input clock;
input [3:0]reg_in;
output [3:0]reg_out;

endmodule

