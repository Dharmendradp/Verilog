//instantiation example
// ripple carry adder using t flipflop

module ripple_carry_counter(q,clk,rst);
input clk,rst;
output [3:0]q;

t_ff tff0(q[0],clk,rst);
t_ff tff1(q[1],q[0],rst);
t_ff tff2(q[2],q[1],rst);
t_ff tff3(q[3],q[2],rst);

endmodule  

// t flipflop

module t_ff(q,clk,rst);
input clk,rst;
output q;
wire d;

d_ff dff0(q,d,clk,rst);
not n1(d,q);

endmodule 

module d_ff(q,d,clk,rst) ;
input d,clk,rst;
output reg q;

always@(posedge rst or negedge clk)
begin
if(rst)
 q = 1'b0;   // dff with synch reset
else 
 q = d	;
end

initial 
$monitor ($time,"Input D =%d",d);
endmodule 


