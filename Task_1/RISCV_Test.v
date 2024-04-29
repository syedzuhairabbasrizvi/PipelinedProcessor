`timescale 1ns / 1ps

module RISCV_Test();

reg reset;
reg clk;
wire [63:0] Instruction_Address; //PCOut
wire [31:0] Instruction;
wire [4:0] rs1, rs2, rd;
wire [63:0] Write_Data_for_Reg, ReadData1, ReadData2, Imm_Data; 
wire [63:0] a;
wire [63:0] b, Result; 
wire [63:0] Mem_Address; //Result
wire [63:0] Read_Data_from_Mem;

RISC_V_Processor riscv(reset, clk, Instruction_Address, Instruction, rs1, rs2, rd, Write_Data_for_Reg, ReadData1, ReadData2, Imm_Data, a, b, Result, Mem_Address, Read_Data_from_Mem);

initial begin
clk = 1'b0; reset = 1'b0;
#20 reset = 1'b0;
#160 reset = 1'b1;
#20 reset = 1'b0;
end
always
    #20 clk = ~clk;

endmodule