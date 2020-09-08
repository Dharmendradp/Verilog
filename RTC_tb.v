module RTC_tb();
 // Inputs
    reg clock;
    reg reset;

    // Outputs
    wire [3:0] seconds_l;
    wire [3:0] seconds_m;
    wire [3:0] minutes_m;
    wire [3:0] minutes_l;
    wire [3:0] hours_l;
    wire [3:0] hours_m;
    wire [6:0] SEC_L;
    wire [6:0] SEC_M;
    wire [6:0] MIN_L;
    wire [6:0] MIN_M;
    wire [6:0] HRS_L;
    wire [6:0] HRS_M;

RTC R1(.clk(clock),.rst(reset),.sec_l(SEC_L),.sec_m(SEC_M),.min_l(MIN_L),.min_m(MIN_M),
.hrs_l(HRS_L),.hrs_m(HRS_M),.seconds_l(seconds_l),.seconds_m(seconds_m),.minutes_l(minutes_l),
.minutes_m(minutes_m),.hours_l(hours_l),.hours_m(hours_m));

initial 
   
    clock = 1'b0;
    always#250 clock = ~clock;  //for Every 0.5 sec toggle 
    
    initial 
    begin
        reset = 1;
        // Wait 100 ns for reset to finish
        #100;
        reset = 0;  
    end
 endmodule    

module RTC(input clk,rst, output [6:0]sec_l,[6:0]sec_m,[6:0]min_l,[6:0]min_m,[6:0]hrs_l,[6:0]hrs_m,[3:0]seconds_l,
[3:0]seconds_m,[3:0]minutes_l,[3:0]minutes_m,[3:0]hours_l,[3:0]hours_m);

wire [3:0]w1,w2,w3,w4,w5,w6;

assign w1 = seconds_l;
assign w2 = seconds_m;
assign w3 = minutes_l;
assign w4 = minutes_m;
assign w5 = hours_l;
assign w6 = hours_m;

count c1(.Clk_1sec(clk),.reset(rst),.seconds_l(seconds_l),.seconds_m(seconds_m),.minutes_l(minutes_l),.minutes_m(minutes_m),.hours_l(hours_l),.hours_m(hours_m));
segment7 s0(.bcd(w1),.seg(sec_l));
segment7 s1(.bcd(w2),.seg(sec_m));
segment7 s2(.bcd(w3),.seg(min_l));
segment7 s3(.bcd(w4),.seg(min_m));
segment7 s4(.bcd(w5),.seg(hrs_l));
segment7 s5(.bcd(w6),.seg(hrs_m));

endmodule


module count(Clk_1sec,reset,seconds_l,seconds_m,minutes_l,minutes_m,hours_l,hours_m);
//Clock with 1 Hz frequency & active high reset

// Inputs to counting operation
    input Clk_1sec;  
    input reset;
// Outputs of counting operation
    output [3:0] seconds_l;
    output [3:0] seconds_m;
    output [3:0] minutes_l;
    output [3:0] minutes_m;
    output [3:0] hours_l;
    output [3:0] hours_m;
//Internal variables.
    reg [3:0] seconds_l;
    reg [3:0] seconds_m;
    reg [3:0] minutes_l;
    reg [3:0] minutes_m;
    reg [3:0] hours_l; 
    reg [3:0] hours_m;

//Execute the always blocks when the Clock or reset inputs are 
//changing from 0 to 1(positive edge of the signal)
always @(posedge(Clk_1sec) or posedge(reset))
    begin
        if(reset == 1'b1) begin  //check for active high reset.
            //reset the time.
            seconds_l = 0;
            minutes_l = 0;
            hours_l = 0;
            seconds_m = 0;
            minutes_m = 0;
            hours_m = 0;  end
        else if(Clk_1sec == 1'b1) begin  //at the beginning of each second
            seconds_l = seconds_l + 1; //increment sec_l
            if(seconds_l == 10) begin //check for max value of seconds_l
                seconds_l = 0;  //reset seconds_l
                seconds_m = seconds_m + 1; //increment seconds_m
                if(seconds_m == 6) begin //check for max value of sec_m
                    seconds_m = 0;  //reset seconds_m
                    minutes_l = minutes_l + 1;  //increment minutes_l
                    if(minutes_l ==  10) begin  //check for max value of minutes_l
                        minutes_l = 0; //reset minutes_l
                        minutes_m = minutes_m + 1; //increment minutes_m
                       if(minutes_m ==  6) begin  //check for max value of minutes_m
                          minutes_m = 0; //reset minutes_m
                          hours_l = hours_l + 1; //increment hours_l
                          if(hours_l ==  10) begin  //check for max value of hours_l
                             hours_l = 0; //reset hours_l
                             hours_m = hours_m + 1; //increment hours_m
                               /*if(hours_m == 2)begin
                                 if(hours_l == 4)begin
                                    hours_m = 0;    
                                    hours_l = 0; end */                                                
                                 if(hours_m == 2) begin  //check for max value of hours
                                hours_m = 0; //reset hours_l
                                hours_l = 0;
                                minutes_m = 0;
                                minutes_l = 0;
                                seconds_m = 0;      
                                seconds_l = seconds_l + 1; //increment seconds_l
                            end
                         end
                      end
                   end 
                end
            end     
        end
    end     
endmodule

module segment7(bcd,seg);
     
     //Declare inputs,outputs and internal variables.
     input [3:0] bcd;
     output [6:0] seg;
     reg [6:0] seg;

//always block for converting bcd digit into 7 segment format
    always @(bcd)
    begin
        case (bcd) //case statement
            0 : seg = 7'b0000001;
            1 : seg = 7'b1001111;
            2 : seg = 7'b0010010;
            3 : seg = 7'b0000110;
            4 : seg = 7'b1001100;
            5 : seg = 7'b0100100;
            6 : seg = 7'b0100000;
            7 : seg = 7'b0001111;
            8 : seg = 7'b0000000;
            9 : seg = 7'b0000100;
            //switch off 7 segment character when the bcd digit is not a decimal number.
            default : seg = 7'b1111111; 
        endcase
    end
    
endmodule
