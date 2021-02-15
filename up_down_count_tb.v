module tb_counter;

    // Inputs
    reg Clk;
    reg reset;
    reg UpOrDown;

    // Outputs
    wire [3:0] Count;

    // Instantiate the Unit Under Test (UUT)
    upordown_counter uut (
        .Clk(Clk), 
        .reset(reset), 
        .UpOrDown(UpOrDown), 
        .Count(Count)
    );

//Generate clock with 10 ns clk period.
    initial Clk = 0;
    always #5 Clk = ~Clk;
    
    initial begin
        // Apply Inputs
        reset = 0;
        UpOrDown = 0;
        #300;
        UpOrDown = 1;
      #300;
        reset = 1;
        UpOrDown = 0;
        #100;
        reset = 0;  
    end
      
endmodule
