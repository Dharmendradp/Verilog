module clock_divider(clock,reset,clock_out);

input clock;
input reset;
output clock_out;

reg [1:0] register1;
wire [1:0] next_reg;
reg clock_track;

always @ (posedge clock or posedge reset)
begin
  if(reset)
    begin
     register1 <= 0;
     clock_track <= ~clock_track;
    end
  else
    register1 <= next_reg;
end

assign next_reg = register1 + 1;
assign clock_out = clock_track;

endmodule

module testbench();
reg clk, reset;
wire clock_out;

clock_divider dut(clk, reset, clock_out);

initial begin 
clk=0;
forever #5 clk=~clk;
end

initial begin
reset=1;
#40;
reset=0;
#120
reset=1;
end

initial begin
$dumpfile("dump_2.vcd");
$dumpvars();

#300 $finish();
end

endmodule 
