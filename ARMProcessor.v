`timescale 1ns / 1ps

module ARMProcessor(
	input clk,
	input reset,

	//Usado para escribir instrucciones en la memoria
	input write_ins,
	input [4:0] ins_address,
	input [31:0] ins,

	//Usado para obtener un dato de la memoria
	output wire [31:0] resultado_out
);
	 


wire [31:0] new_PC;
wire [31:0] pc_in;
wire sel_PC;
wire [31:0] cuatro = 1;
wire [31:0] pcPlusEight;
wire [31:0] immediate;

sumador pcMasOcho(
	.A(pc_in),
	.B(cuatro),
	.resultado(pcPlusEight)
);

wire [31:0] pcJump;

sumador pcMasOchoMasBranch(
	.A(pcPlusEight),
	.B(immediate),
	.resultado(pcJump)
);


Mux2x1 mux_PC (
    .port_select(sel_PC), 
    .dat1(pc_in), 
    .dat2(pcJump), 
    .data_out(new_PC)
    );
	 
wire [31:0] pc_out;

	 
PC_register PC(
    .clk(clk),
	 .reset(reset),
    .dir_in(new_PC), 
    .dir_out(pc_out)
);

sumador pcMasCuatro(
	.A(pc_out),
	.B(cuatro),
	.resultado(pc_in)
    );
	 
wire [31:0] intruccion;
	 
Memory instrucciones (
    .clk(clk), 
    .address(pc_out),
    .data_out(intruccion),
	 
	.write_ins(write_ins),
	.ins_address(ins_address),
	.ins(ins)
);

wire dirA_mux_select;
wire [1:0] imm_src;
wire reg_wr;
wire datB_mux_select;
wire mem_wr;
wire sel_WB;
wire datWB_select;
wire dirWB_mux_select;
wire [2:0] ALU_ctrl;

wire [3:0] ALU_flags;

Control nube_control (
	 .clk(clk),
    .cond(intruccion[31:28]), 
    .op(intruccion[27:26]), 
    .funct(intruccion[25:20]), 
    .sh(intruccion[6:5]), 
    .ALU_flags(ALU_flags), 
	 
	 .sel_B(datB_mux_select),
    .ALU_set(ALU_set), 
    .sel_PC(sel_PC),
    .sel_dirA(dirA_mux_select), 
    .imm_src(imm_src), 
    .reg_wr(reg_wr),
    .sel_dest(dirWB_mux_select), 
    .ALU_ctrl(ALU_ctrl)
    );
	 

wire [3:0] A;

	 
Mux2x1 dirA_mux (
    .port_select(dirA_mux_select), 
    .dat1(intruccion[15:12]), 
    .dat2(intruccion[19:16]), 
    .data_out(A)
    );
	 
	 
wire [3:0] WB;

Mux2x1 dirWB_mux (
    .port_select(dirWB_mux_select), 
    .dat1(intruccion[19:16]), 
    .dat2(intruccion[15:12]), 
    .data_out(WB)
    );
	 
wire [31:0] ALU_A;
wire [31:0] WB_data;
wire [31:0] datB;

Registers registros (
    .clk(clk), 
    .reg_write(reg_wr), 
    .dirA(A), 
    .dirB(intruccion[3:0]), 
    .dir_WR(WB), 
    .data_in(WB_data), 
    .datA(ALU_A), 
    .datB(datB),
	 .resultadoFinal(resultado_out)
    );
	
	 
RotImm extension(
    .immediate(intruccion[23:0]), 
    .imm_src(imm_src), 
    .data(immediate)
    );
	 
wire [31:0] ALU_B;
 
Mux2x1 datB_mux (
    .port_select(datB_mux_select), 
    .dat1(datB), 
    .dat2(immediate), 
    .data_out(ALU_B)
    );


ALU alu (
    .dat1(ALU_A), 
    .dat2(ALU_B), 
    .control(ALU_ctrl), 
    .set(ALU_set), 
    .Z(ALU_flags[0]), 
    .N(ALU_flags[1]), 
    .C(ALU_flags[2]), 
    .V(ALU_flags[3]), 
    .result(WB_data)
);


endmodule
