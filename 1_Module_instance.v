module top;
IS is1();
endmodule

module IS;
initial begin
$display ("--IS module-- dsdf");
end
MEM mem1();
SC sc1();
Xbar xbar1();
endmodule

module MEM;
initial begin
$display ("--MEM module--\teff");
end
endmodule

module SC;
initial begin
$display ("--SC module--\ndfweffw");
end
endmodule

module Xbar;
initial begin
$display ("--Xbar module--");
end
endmodule


