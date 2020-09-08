module uart1 (Reset,Tx_Clock,ld_Tx_Data,Tx_Data,Tx_Enable,Tx_Out,Tx_Empty,Rx_Clock,uld_Rx_Data,Rx_Data,Rx_Enable,Rx_In,Rx_Empty);

// Port declarations
input  Reset,Tx_Clock,ld_Tx_Data,Tx_Enable,Rx_Clock,uld_Rx_Data,Rx_Enable,Rx_In;
input  [7:0] Tx_Data;
output Tx_Out,Tx_Empty,Rx_Empty;
output [7:0] Rx_Data;        

// Internal Variables 
reg [7:0]Tx_Reg;
reg Tx_Empty,Tx_over_run,Tx_Out;
reg [3:0]Tx_count;
reg [7:0]Rx_Reg;
reg [7:0]Rx_Data;
reg [3:0]Rx_sample_count;
reg [3:0]Rx_count;  
reg Rx_Frame_Err,Rx_over_run,Rx_Empty,Rx_R1,Rx_R2,Rx_Busy;

// UART Receiver Logic
always @ (posedge Rx_Clock or posedge Reset)
if (Reset) begin
  Rx_Reg        <= 0; 
  Rx_Data       <= 0;
  Rx_sample_count <= 0;
  Rx_count        <= 0;
  Rx_Frame_Err  <= 0;
  Rx_over_run   <= 0;
  Rx_Empty      <= 1;
  Rx_R1         <= 1;
  Rx_R2         <= 1;
  Rx_Busy       <= 0;
end 
else 
  begin
  // Synchronize the asynch signal
  Rx_R1 <= Rx_In;
  Rx_R2 <= Rx_R1;
  // Uload the rx data
  if (uld_Rx_Data) begin
    Rx_Data  <= Rx_Reg;
    Rx_Empty <= 1;
  end
  // Receive data only when rx is enabled
  if (Rx_Enable) begin
    // Check if just received start of frame
    if (!Rx_Busy && !Rx_R2) begin
      Rx_Busy       <= 1;
      Rx_sample_count <= 1;
      Rx_count        <= 0;
    end
    // Start of frame detected, Proceed with rest of data
    if (Rx_Busy) begin
       Rx_sample_count <= Rx_sample_count + 1;
       // Logic to sample at middle of data
       if (Rx_sample_count == 7) begin
          if ((Rx_R2 == 1) && (Rx_count == 0)) begin
            Rx_Busy <= 0;
          end else begin
            Rx_count <= Rx_count + 1; 
            // Start storing the rx data
            if (Rx_count > 0 && Rx_count < 9) begin
              Rx_Reg[Rx_count - 1] <= Rx_R2;
            end
            if (Rx_count == 9) begin
               Rx_Busy <= 0;
               // Check if End of frame received correctly
               if (Rx_R2 == 0) begin
                 Rx_Frame_Err <= 1;
               end else begin
                 Rx_Empty     <= 0;
                 Rx_Frame_Err <= 0;
                 // Check if last rx data was not unloaded,
                 Rx_over_run  <= (Rx_Empty) ? 0 : 1;
               end
            end
          end
       end 
    end 
  end
  if (!Rx_Enable) begin
    Rx_Busy <= 0;
  end
end

// UART Transmitter Logic
always @ (posedge Tx_Clock or posedge Reset)
if (Reset) begin
  Tx_Reg        <= 0;
  Tx_Empty      <= 1;
  Tx_over_run   <= 0;
  Tx_Out        <= 1;
  Tx_count        <= 0;
end else begin
   if (ld_Tx_Data) begin
      if (!Tx_Empty) begin
        Tx_over_run <= 0;
      end else begin
        Tx_Reg   <= Tx_Data;
        Tx_Empty <= 0;
      end
   end
   if (Tx_Enable && !Tx_Empty) begin
     Tx_count <= Tx_count + 1;
     if (Tx_count == 0) begin
       Tx_Out <= 0;
     end
     if (Tx_count > 0 && Tx_count < 9) begin
        Tx_Out <= Tx_Reg[Tx_count -1];
     end
     if (Tx_count == 9) begin
       Tx_Out <= 1;
       Tx_count <= 0;
       Tx_Empty <= 1;
     end
   end
   if (!Tx_Enable) begin
     Tx_count <= 0;
   end
end

endmodule


