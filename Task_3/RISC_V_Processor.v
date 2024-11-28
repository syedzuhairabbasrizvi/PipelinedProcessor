`timescale 1ns / 1ps

module RISC_V_Processor(
    input reset,
    input clk,
    output reg [31:0] Instruction, IFID_Instruction,
    output reg [4:0] rs1, rs2, rd, IDEX_rs1, IDEX_rs2, EM_RD, MW_RD,
    output reg [63:0] Write_Data_for_Reg, ReadData1, ReadData2, Imm_Data, 
    output reg [63:0] b, Result, 
    output reg [63:0] Read_Data_from_Mem,
    output reg stall,
    output reg flush,
    output reg [6:0] opcode,
    output reg IDEX_MemRead, EM_MemRead,
    output reg Branch, EM_Branch, MemRead, MemWrite, MemtoReg, RegWrite, 
    output reg [1:0] ALUOp,
    output reg [3:0] Operation,
    output reg [63:0] PC_In,
    output reg [63:0] PC_Out, IFID_PC_Out, IDEX_ReadData1, IDEX_ReadData2, IDEX_Imm,
    Out_2, EM_Adder2Out, EM_Result, EM_WriteData,
    MW_Read_Data_from_Mem,
    output reg final_branch,
    output reg [3:0] IDEX_Funct,
    output reg EM_addermuxselect,
    output reg [1:0] ForwardA, Forwardb
    
    );
//to do: inspect mux_selector + addermuxselect
wire [63:0] Imm_Data;
wire [63:0] PC_In;
wire [63:0] PC_Out;
wire [6:0] opcode;
wire [2:0] funct3;
wire [6:0] funct7;
wire Branch;
wire MemRead;
wire MemtoReg;
wire MemWrite;
wire ALUSrc;
wire RegWrite;
wire [1:0] ALUOp;
wire [3:0] Funct;
wire [3:0] Operation;
wire Zero;
wire [63:0] Out_1;
wire [63:0] Out_2;
wire Mux_Selector;
wire BLT;
wire [63:0] b;
wire stall;
wire flush;

wire [63:0] IFID_PC_Out;
wire [31:0] Instruction;
wire [31:0] IFID_Instruction;

wire IDEX_Branch, IDEX_MemRead, IDEX_MemWrite, IDEX_MemtoReg, IDEX_RegWrite, IDEX_ALUSrc,
EM_Branch, EM_MemRead, EM_MemWrite, EM_MemtoReg, EM_RegWrite, EM_Zero,
MW_MemtoReg, MW_RegWrite, PC_Write, IFID_Write, IDEX_MuxOut, EM_addermuxselect;

wire [1:0] IDEX_ALUOp, ForwardA, ForwardB;
wire [3:0] IDEX_Funct;
wire [4:0] IDEX_rs1, IDEX_rs2, IDEX_rd, EM_RD, MW_RD;

wire [63:0] IDEX_PC_Out, IDEX_ReadData1, IDEX_ReadData2, IDEX_Imm,
            EM_Adder2Out, EM_Result, EM_WriteData, MW_Result, MW_Read_Data_from_Mem,
            mux1out, mux2out, mux3out;

wire final_branch;
FlushPipeline FP(final_branch, flush);

Hazard_Detection_Unit HDU(rs1, rs2, IDEX_rd, IDEX_MemRead, stall); // .IFID_Write(IFID_Write), .PC_Write(PC_Write), .IDEX_MuxOut(IDEX_MuxOut), 

wire [63:0] F1_1, F2_1;
wire [4:0] rs1, rs2, rd;
wire [63:0] ReadData1, ReadData2, Result;
wire [63:0] Read_Data_from_Mem;
wire [63:0] Write_Data_for_Reg;
//assign Mux_Selector = (Zero&(Funct==4'b0000 | Funct==4'b1000)) | (BLT&(Funct==4'b0100 | Funct==4'b1100));

Adder add_1(PC_Out, 64'd4, Out_1);
mux_2_1 mux2(final_branch, Out_1, EM_Adder2Out, PC_In);
Program_Counter PC(clk, reset, stall, PC_In, PC_Out);
Instruction_Memory IM(PC_Out, Instruction);
IFID ifid(clk, reset, stall, flush, Instruction, PC_Out, IFID_Instruction, IFID_PC_Out);

instruction_parser IP(IFID_Instruction, opcode, rd, funct3, rs1, rs2, funct7);
imm_gen IDE(IFID_Instruction, Imm_Data);
Control_Unit CU(opcode, stall, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp);
registerFile Regs(Write_Data_for_Reg, rs1, rs2, MW_RD, MW_RegWrite, clk, reset, ReadData1, ReadData2);
assign Funct = {IFID_Instruction[30], funct3};           //add complement bit to funct for ALU control

IDEX idex(clk, reset, flush, Branch, MemRead, MemWrite, MemtoReg, RegWrite, ALUSrc, ALUOp,
        Funct, rs1, rs2, rd, IFID_PC_Out, ReadData1, ReadData2, Imm_Data,
        IDEX_Branch, IDEX_MemRead, IDEX_MemWrite, IDEX_MemtoReg, IDEX_RegWrite, IDEX_ALUSrc,
        IDEX_ALUOp, IDEX_Funct, IDEX_rs1, IDEX_rs2, IDEX_rd,
        IDEX_PC_Out, IDEX_ReadData1, IDEX_ReadData2, IDEX_Imm);

Adder add_2(IDEX_PC_Out, IDEX_Imm*2, Out_2);
ALU_Control AC(IDEX_ALUOp, IDEX_Funct, Operation);

mux_3_1 f1(IDEX_ReadData1, Write_Data_for_Reg, EM_Result, ForwardA, F1_1);
mux_3_1 f2(IDEX_ReadData2, Write_Data_for_Reg, EM_Result, ForwardB, F2_1);
mux_2_1 f3(IDEX_ALUSrc, F2_1, IDEX_Imm, b);
ALU alu(F1_1, b, Operation, Result, Zero, BLT);

EXMEM EM(clk, reset, flush, IDEX_Branch, IDEX_MemRead, IDEX_MemWrite, IDEX_MemtoReg, IDEX_RegWrite,
        Zero, Mux_Selector, IDEX_rd, Out_2, Result, F2_1, 
        EM_Branch, EM_MemRead, EM_MemWrite, EM_MemtoReg, EM_RegWrite, EM_Zero, EM_addermuxselect, EM_RD, EM_Adder2Out, EM_Result, EM_WriteData);
assign final_branch = EM_Branch && EM_addermuxselect;
Data_Memory DM(EM_Result, EM_WriteData, clk, EM_MemWrite, EM_MemRead, Read_Data_from_Mem);
MEMWB MW(clk, reset, EM_MemtoReg, EM_RegWrite, EM_RD, EM_Result, Read_Data_from_Mem, 
        MW_MemtoReg, MW_RegWrite, MW_RD, MW_Result, MW_Read_Data_from_Mem);

mux_2_1 mux3(MW_MemtoReg, MW_Result, MW_Read_Data_from_Mem, Write_Data_for_Reg);

ForwardingUnit FU(IDEX_rs1, IDEX_rs2, EM_RD, MW_RD, MW_RegWrite, EM_RegWrite, ForwardA, ForwardB);

Branch_Unit BU(IDEX_Funct,IDEX_ReadData1,b,Mux_Selector);

//assign Instruction_Address = PC_Out;
//assign Mem_Address = Result;
//assign a = ReadData1;
//to do: integrate threebyonemux with m1, m2 (readdatas) and hope for the best
endmodule
