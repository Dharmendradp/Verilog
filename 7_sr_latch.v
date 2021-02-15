module SR_latch(qbar,q,s,r);
input s,r;
output qbar,q;


nand n1(q,s,q);
nand n2(qbar,r,q);
initial begin
//$dumpfile ("new1.vcd");
//$dumpvars();
#200 $finish;
end
endmodule
/*
module tb_sr_latch;
reg set,reset;
wire qbar,q;

SR_latch s1(qbar,q,~set,~reset);

initial
begin
$monitor($time, " set = %0b, reset = %0b,q = %0b\n",set,reset,q);
set =0;
reset = 0;

#5 reset =1;
#5 reset = 1;
#5 set = 1;
$dumpfile ("new.vcd");
$dumpvars();
#50 $finish;
end
endmodule */
