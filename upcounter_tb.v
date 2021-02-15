module upcounter_testbench();
reg clk, reset;
wire [3:0] counter;

up_counter dut(clk, reset, counter);
initial begin 
clk=0;
forever #5 clk=~clk;
end
initial begin
reset=1;
#20;
reset=0;
end

initial begin
$dumpfile("dump.vcd");
$dumpvars();

#200 $finish();
end

endmodule 
