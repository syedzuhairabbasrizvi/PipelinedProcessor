`timescale 1ns / 1ps
module Data_Memory(
    input [63:0] Mem_Addr,
    input [63:0] Write_Data,
    input clk,
    input MemWrite,
    input MemRead,
    output reg [63:0] Read_Data
);
//64 memory addresses, 8 bit each
reg [7:0] Data_Mem [63:0];
integer i;
//fill addresses with dummy values
initial begin
    for (i = 0; i < 64; i = i + 1) begin
        Data_Mem[i] = 8'd0 + i;
    end
end

//write on memory in posedge of clock and if signal is on
always @(posedge clk) begin
    if (MemWrite == 1) begin
        Data_Mem[Mem_Addr] = Write_Data[7:0];
        Data_Mem[Mem_Addr+1] = Write_Data[15:8];
        Data_Mem[Mem_Addr+2] = Write_Data[23:16];
        Data_Mem[Mem_Addr+3] = Write_Data[31:24];
        Data_Mem[Mem_Addr+4] = Write_Data[39:32];
        Data_Mem[Mem_Addr+5] = Write_Data[47:40];
        Data_Mem[Mem_Addr+6] = Write_Data[53:48];
        Data_Mem[Mem_Addr+7] = Write_Data[63:56];
    end
end

//then read from memory if signal is on
always @(*) begin
    if (MemRead == 1) begin
        Read_Data <= {Data_Mem[Mem_Addr+7], Data_Mem[Mem_Addr+6],
                    Data_Mem[Mem_Addr+5], Data_Mem[Mem_Addr+4],
                    Data_Mem[Mem_Addr+3], Data_Mem[Mem_Addr+2],
                    Data_Mem[Mem_Addr+1], Data_Mem[Mem_Addr]};
    end
end
endmodule
