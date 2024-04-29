`timescale 1ns / 1ps
module registerFile(
    input [63:0] WriteData,
    input [4:0] RS1,
    input [4:0] RS2,
    input [4:0] RD,
    input RegWrite,
    input clk,
    input reset,
    output reg [63:0] ReadData1,
    output reg [63:0] ReadData2
 );
//initialize and fill registers depending on index
reg [63:0] Registers [31:0];

integer i;
initial begin
    for (i = 0; i < 32; i = i + 1) begin
        Registers[i] = 64'd0;
    end
end

//then perform write/reset/reading

always @(posedge clk) begin
    if (RegWrite == 1) Registers[RD] = WriteData;
end 
always @(*) begin
    if (reset == 1) begin
        ReadData1 = 64'd0; ReadData2 = 64'd0; end
    else begin
        ReadData1 = Registers[RS1]; ReadData2 = Registers[RS2]; 
    end
end
endmodule