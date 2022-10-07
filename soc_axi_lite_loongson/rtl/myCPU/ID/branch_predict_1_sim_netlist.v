`include "defines.vh"
`timescale 1 ps / 1 ps

module branch_predict_1(
  input wire clk, rst,
  input wire [31:0]instrD,
  input wire [31:0]immD,
  input wire [31:0]pcD,
  input wire [31:0]pcM,
  input wire branchM, actual_takeM,

  output wire branchD,
  output wire pred_takeD);

  parameter k  = 4, t = 2, HISTORY_LENGTH = 2;

  localparam BHT_DEEPTH = 1 << k, PHT_DEEPTH1 = 1 << HISTORY_LENGTH, PHT_DEEPTH2 = 1 << t;

  reg [HISTORY_LENGTH - 1:0] BHT  [BHT_DEEPTH - 1:0];
  reg [1:0]   PHTs [PHT_DEEPTH1 - 1:0][PHT_DEEPTH2 - 1:0];
    
  assign branchD = (instrD[31: 26] == `EXE_BEQ)  |
                   (instrD[31: 26] == `EXE_BGTZ) |
                   (instrD[31: 26] == `EXE_BNE)  |
                   (instrD[31: 26] == `EXE_BLEZ) |
                   (instrD[31: 26] == `EXE_BRANCHS);
                   
  assign pred_takeD = PHTs[BHT[pcD[k + t + 1:t+2]]][pcD[t + 1:2]][1];
  
  wire [1:0] stateM;
  assign stateM = PHTs[BHT[pcM[k + t + 1:t+2]]][pcM[t + 1:2]];
  
  integer i, j;
  always @(posedge clk) begin
		if(rst)begin
      for(i=0;i < PHT_DEEPTH1;i=i+1)begin
        for(j=0;j < PHT_DEEPTH2;j=j+1)begin
          PHTs[i][j] <= 2'b00;
        end
      end
      for(i=0;i < BHT_DEEPTH;i=i+1)begin
        BHT[i] <= {HISTORY_LENGTH{1'b0}};
      end
    end
    else if(branchM) begin
      case(stateM)
      2'b00:
        if(actual_takeM) begin
          PHTs[BHT[pcM[k + t + 1:t+2]]][pcM[t + 1:2]] <= 2'b01;
        end
      2'b01:
        if(actual_takeM) begin
          PHTs[BHT[pcM[k + t + 1:t+2]]][pcM[t + 1:2]] <= 2'b10;
        end else begin
          PHTs[BHT[pcM[k + t + 1:t+2]]][pcM[t + 1:2]] <= 2'b00;
        end
      2'b10:
        if(actual_takeM) begin
          PHTs[BHT[pcM[k + t + 1:t+2]]][pcM[t + 1:2]] <= 2'b11;
        end else begin
          PHTs[BHT[pcM[k + t + 1:t+2]]][pcM[t + 1:2]] <= 2'b01;
        end
      2'b11:
        if(~actual_takeM) begin
          PHTs[BHT[pcM[k + t + 1:t+2]]][pcM[t + 1:2]] <= 2'b10;
        end
      endcase
      BHT[pcM[k + t + 1:t+2]] <= {BHT[pcM[k + t + 1:t+2]][HISTORY_LENGTH-2:0],actual_takeM};
    end
	end
  
endmodule