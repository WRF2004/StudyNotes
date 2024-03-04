module Execute (
	 input clk,
	 input reset,
    input [31:0] e_instr,
    input [31:0] ext_imm32e,
    input [31:0] FW_e_d1,
    input [31:0] FW_e_d2,
	 input [31:0] e_out,
    
    output [31:0] e_aluout,
    output [31:0] e_DMinput,
	 output [31:0] em_out,
	 output busy,
	 output start
	 );
    wire [31:0] e_v1;
    wire [31:0] e_v2;
	 wire [31:0] hi, lo; 
    wire Bsel;
    wire cin;
	 wire HIw, LOw, mh, ml;
    wire aluop, yu;
	 wire [1:0] cmp;
	 wire [2:0] way;
    wire lui;
    wire add, jal;
    assign e_v1 = FW_e_d1;
    assign e_v2 = (Bsel == 0) ? FW_e_d2 : ext_imm32e;
    assign e_DMinput = FW_e_d2;
	 assign em_out = (jal == 1) ? e_out : (mh == 1) ? hi : (ml == 1) ? lo : e_aluout;
	 
	 MD e_md (
    .clk(clk), 
    .reset(reset), 
    .w1(e_v1), 
    .w2(e_v2), 
    .HIw(HIw), 
    .LOw(LOw), 
    .way(way), 
    .start(start), 
    .busy(busy), 
    .hi(hi), 
    .lo(lo)
    );
	 
    Controller e_ctrl (
	 .mh(mh),
	 .ml(ml),
	 .LOw(LOw),
	 .HIw(HIw),
	 .start(start),
	 .way(way),
    .instr(e_instr), 
    .Bsel(Bsel),
    .cin(cin),
    .aluop(aluop),
    .lui(lui),
    .add(add),
	 .yu(yu),
	 .cmp(cmp),
	 .jal(jal)
    );

    ALU alu_inst (
	.add(add),
	.yu(yu),
	.cmp(cmp),
    .w1(e_v1), 
    .w2(e_v2), 
    .cin(cin), 
    .aluop(aluop), 
    .lui(lui), 
    .aluout(e_aluout)
    );
    
endmodule