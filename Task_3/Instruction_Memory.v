`timescale 1ns / 1ps

module Instruction_Memory(
    input [63:0] Inst_Address,
    output reg [31:0] Instruction
    );
//160 memory addresses, 8 bit each
reg [7:0] inst_mem [199:0];
reg [7:0] Inst_Memory [19:0];
//fill addresses with dummy values

initial begin
//{Inst_Memory[19], Inst_Memory[18], Inst_Memory[17], Inst_Memory[16]} = 32'b00000000001001001001010010010011;
{Inst_Memory[19], Inst_Memory[18], Inst_Memory[17], Inst_Memory[16]} = 32'b11111110100101011000100011100011;
Inst_Memory[15] = 8'b00000010;
Inst_Memory[14] = 8'b10010101;
Inst_Memory[13] = 8'b00110100;
Inst_Memory[12] = 8'b00100011;
Inst_Memory[11] = 8'b00000000;
Inst_Memory[10] = 8'b00010100;
Inst_Memory[9] = 8'b10000100;
Inst_Memory[8] = 8'b10010011;
Inst_Memory[7] = 8'b00000000;
Inst_Memory[6] = 8'b10011010;
Inst_Memory[5] = 8'b10000100;
Inst_Memory[4] = 8'b10110011;
Inst_Memory[3] = 8'b00000010;
Inst_Memory[2] = 8'b10000101;
Inst_Memory[1] = 8'b00110100;
Inst_Memory[0] = 8'b10000011;
end

initial begin
/*
to do: make a check for seeing if the swaps were successful
*/

{inst_mem[183], inst_mem[182], inst_mem[181], inst_mem[180]} = 32'b00000000000000000000000000010011;
//checker
{inst_mem[179], inst_mem[178], inst_mem[177], inst_mem[176]} = 32'b00000010100001010011001010000011;
{inst_mem[175], inst_mem[174], inst_mem[173], inst_mem[172]} = 32'b00000010000001010011001010000011;
{inst_mem[171], inst_mem[170], inst_mem[169], inst_mem[168]} = 32'b00000001100001010011001010000011;
{inst_mem[167], inst_mem[166], inst_mem[165], inst_mem[164]} = 32'b00000001000001010011001010000011;
{inst_mem[163], inst_mem[162], inst_mem[161], inst_mem[160]} = 32'b00000000100001010011001010000011;
//loopcheck
{inst_mem[159], inst_mem[158], inst_mem[157], inst_mem[156]} = 32'b11111010101100101100111011100011;
{inst_mem[155], inst_mem[154], inst_mem[153], inst_mem[152]} = 32'b00000000000100101000001010010011;
//swap
{inst_mem[151], inst_mem[150], inst_mem[149], inst_mem[148]} = 32'b11111100101100110100101011100011;
{inst_mem[147], inst_mem[146], inst_mem[145], inst_mem[144]} = 32'b00000000000100110000001100010011;
{inst_mem[143], inst_mem[142], inst_mem[141], inst_mem[140]} = 32'b00000000000000111011111000000011;
{inst_mem[139], inst_mem[138], inst_mem[137], inst_mem[136]} = 32'b00000001110011101011000000100011;
{inst_mem[135], inst_mem[134], inst_mem[133], inst_mem[132]} = 32'b00000001111000111011000000100011;
//loop2
{inst_mem[131], inst_mem[130], inst_mem[129], inst_mem[128]} = 32'b00000000000000000000110001100011;
{inst_mem[127], inst_mem[126], inst_mem[125], inst_mem[124]} = 32'b11111110101100110100011011100011;
{inst_mem[123], inst_mem[122], inst_mem[121], inst_mem[120]} = 32'b00000000000100110000001100010011;
{inst_mem[119], inst_mem[118], inst_mem[117], inst_mem[116]} = 32'b00000001111011100100100001100011;
{inst_mem[115], inst_mem[114], inst_mem[113], inst_mem[112]} = 32'b00000000000011101011111100000011;
{inst_mem[111], inst_mem[110], inst_mem[109], inst_mem[108]} = 32'b00000000101011101000111010110011;
{inst_mem[107], inst_mem[106], inst_mem[105], inst_mem[104]} = 32'b00000000001100110001111010010011;
//loop
{inst_mem[103], inst_mem[102], inst_mem[101], inst_mem[100]} = 32'b00000000000000111011111000000011;
{inst_mem[99], inst_mem[98], inst_mem[97], inst_mem[96]} = 32'b00000000101000111000001110110011;
{inst_mem[95], inst_mem[94], inst_mem[93], inst_mem[92]} = 32'b00000000001100101001001110010011;
{inst_mem[91], inst_mem[90], inst_mem[89], inst_mem[88]} = 32'b00000000000000101000001100010011;
//bubble
{inst_mem[87], inst_mem[86], inst_mem[85], inst_mem[84]} = 32'b00000000000000000000001010010011;
{inst_mem[83], inst_mem[82], inst_mem[81], inst_mem[80]} = 32'b00000100000001011000101001100011;
{inst_mem[79], inst_mem[78], inst_mem[77], inst_mem[76]} = 32'b00000100000000101000110001100011;
{inst_mem[75], inst_mem[74], inst_mem[73], inst_mem[72]} = 32'b00000000000001010011001010000011;
//sw batch
{inst_mem[71], inst_mem[70], inst_mem[69], inst_mem[68]} = 32'b00000011111001010011000000100011;
{inst_mem[67], inst_mem[66], inst_mem[65], inst_mem[64]} = 32'b00000001110101010011110000100011;
{inst_mem[63], inst_mem[62], inst_mem[61], inst_mem[60]} = 32'b00000000011101010011100000100011;
{inst_mem[59], inst_mem[58], inst_mem[57], inst_mem[56]} = 32'b00000000011001010011010000100011;
{inst_mem[55], inst_mem[54], inst_mem[53], inst_mem[52]} = 32'b00000000010101010011000000100011;
//addi batch
{inst_mem[51], inst_mem[50], inst_mem[49], inst_mem[48]} = 32'b00000000010101011000010110010011;

{inst_mem[47], inst_mem[46], inst_mem[45], inst_mem[44]} = 32'b00000000010111110000111100010011;
{inst_mem[43], inst_mem[42], inst_mem[41], inst_mem[40]} = 32'b00000000010011101000111010010011;
{inst_mem[39], inst_mem[38], inst_mem[37], inst_mem[36]} = 32'b00000000001100111000001110010011;
{inst_mem[35], inst_mem[34], inst_mem[33], inst_mem[32]} = 32'b00000000001000110000001100010011;
{inst_mem[31], inst_mem[30], inst_mem[29], inst_mem[28]} = 32'b00000000000100101000001010010011;

//{inst_mem[47], inst_mem[46], inst_mem[45], inst_mem[44]} = 32'b00000000000100101000001010010011;
//{inst_mem[43], inst_mem[42], inst_mem[41], inst_mem[40]} = 32'b00000000001000110000001100010011;
//{inst_mem[39], inst_mem[38], inst_mem[37], inst_mem[36]} = 32'b00000000001100111000001110010011;
//{inst_mem[35], inst_mem[34], inst_mem[33], inst_mem[32]} = 32'b00000000010011101000111010010011;
//{inst_mem[31], inst_mem[30], inst_mem[29], inst_mem[28]} = 32'b00000000010111110000111100010011;
//filler instructions
{inst_mem[27], inst_mem[26], inst_mem[25], inst_mem[24]} = 32'b00000000101001010000010100010011;
{inst_mem[23], inst_mem[22], inst_mem[21], inst_mem[20]} = 32'b00000000000000000000000000010011;
{inst_mem[19], inst_mem[18], inst_mem[17], inst_mem[16]} = 32'b00000000000000000000000000010011;
{inst_mem[15], inst_mem[14], inst_mem[13], inst_mem[12]} = 32'b00000000000000000000000000010011;
{inst_mem[11], inst_mem[10], inst_mem[9], inst_mem[8]} = 32'b00000000000000000000000000010011;
{inst_mem[7], inst_mem[6], inst_mem[5], inst_mem[4]} = 32'b00000000000000000000000000010011;
{inst_mem[3], inst_mem[2], inst_mem[1], inst_mem[0]} = 32'b00000000000000000000000000010011;
end

/*
from start to end of program, unlike binary version
5f0f13
4e8e93
338393
230313
128293
558593
553023
653223
753423
1d53623
1e53823
53283
4028c63
4058a63
293
28313
229393
a383b3
3be03
231e93
ae8eb3
ebf03
1ee4863
130313
feb346e3
c63
1e3b023
1ceb023
3be03
130313
fcb34ae3
128293
fab2cee3
*/
/*
11111010101100101100111011100011;
00000000000100101000001010010011;
11111100101100110100101011100011;
00000000000100110000001100010011;
00000000000000111011111000000011;
00000001110011101011000000100011;
00000001111000111011000000100011;
00000000000000000000110001100011;
11111110101100110100011011100011;
00000000000100110000001100010011;
00000001111011100100100001100011;
00000000000011101011111100000011;
00000000101011101000111010110011;
00000000001000110001111010010011;
00000000000000111011111000000011;
00000000101000111000001110110011;
00000000001000101001001110010011;
00000000000000101000001100010011;
00000000000000000000001010010011;
00000100000001011000101001100011;
00000100000000101000110001100011;
00000000000001010011001010000011;
00000001111001010011100000100011;
00000001110101010011011000100011;
00000000011101010011010000100011;
00000000011001010011001000100011;
00000000010101010011000000100011;
00000000010101011000010110010011;
00000000000100101000001010010011;
00000000001000110000001100010011;
00000000001100111000001110010011;
00000000010011101000111010010011;
00000000010111110000111100010011;
*/
/*
28addi x30, x30, 5
32addi x29, x29, 4
36addi x7, x7, 3
40addi x6, x6, 2
44addi x5, x5, 1
48addi x11, x11, 5 #len
52sw x5, 0(x10) #put in the int array
56sw x6, 8(x10) 
60sw x7, 16(x10)
64sw x29, 24(x10)
68sw x30, 32(x10)
bubble:
72lw x5, 0(x10) #check for null array or zero len
76beq x5, x0, exit
80beq x11, x0, exit
84addi x5, x0, 0 #i = 0
loop:
88addi x6, x5, 0 #j = i
92slli x7, x5, 2 #get a[i]
96add x7, x7, x10
100lw x28, 0(x7)
loop2:
104slli x29, x6, 2 #get a[j]
108add x29, x29, x10
112lw x30, 0(x29)d
116blt x28, x30, swap #if a[i]<a[j], swap
120addi x6, x6, 1 #else j++
124blt x6, x11, loop2 #if j==len check if i==len else loop2
128beq x0, x0, loopcheck
swap:
132sw x30, 0(x7) #perform swap
136sw x28, 0(x29)
140lw x28, 0(x7) #reload swapped a[i]
144addi x6, x6, 1 #j++
148blt x6, x11, loop2 #if j==len check if i==len else loop2
loopcheck:
152addi x5, x5, 1 #i++
156blt x5, x11, loop #if i==len return else loop
exit:
*/

/*
I format: 000000101000 01010 011 01001 0000011

           imm         rs1   f3   rd     opcode
ld x9, 40(x10)
add x9, x21, x9
addi x9, x9, 1
sd x9, 40(x10)
beq x0, x0, 0

-16 -> 111111110000
SB format: 1111111 00000 00000 000 00001 

1111111 01011 01001 100 10001 1100011 for blt
R format: 0000000 01001 10101 000 01001 0110011
           funct7  rs2  rs1  f3   rd     opcode

I format: 000000000001 01001 000 01001 0010011
           imm         rs1   f3   rd     opcode

S format: 0000001 01001 01010 011 01000 0100011
           imm     rs2  rs1  f3   imm    opcode

*/
//slice instruction and get from memory
/*
always @(Inst_Address) begin
    Instruction[31:24] <= Inst_Memory[Inst_Address+64'd3];
    Instruction[23:16] <= Inst_Memory[Inst_Address+64'd2];
    Instruction[15:8] <= Inst_Memory[Inst_Address+64'd1];
    Instruction[7:0] <= Inst_Memory[Inst_Address];
end
*/

always @(Inst_Address) begin
    Instruction[31:24] <= inst_mem[Inst_Address+64'd3];
    Instruction[23:16] <= inst_mem[Inst_Address+64'd2];
    Instruction[15:8] <= inst_mem[Inst_Address+64'd1];
    Instruction[7:0] <= inst_mem[Inst_Address];
    
end

endmodule
