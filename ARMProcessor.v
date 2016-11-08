`timescale 1ns / 1ps

module ARMProcessor(
input clk,

output mem_out
    );
	 

	 
wire [31:0] pc_out;
wire [31:0] pc_in;
	 
PC_register PC(
    .clk(clk), 
    .dir_in(pc_in), 
    .dir_out(pc_out)
);

wire [31:0] cuatro = 4;

sumador sum(
	.A(pc_out),
	.B(cuatro),
	.resultado(pc_in)
    );
	 
wire [31:0] intruccion;
	 
Memory instrucciones (
    .clk(clk), 
    .address(pc_out),
    .data_out(intruccion)
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
    .cond(intruccion[31:28]), 
    .op(intruccion[27:26]), 
    .funct(intruccion[25:21]), 
    .sh(intruccion[6:5]), 
    .ALU_flags(ALU_flags), 
	 
    .ALU_set(ALU_set), 
    .sel_PC(sel_PC), //Falta
    .sel_dirA(dirA_mux_select), 
    .imm_src(imm_src), 
    .reg_wr(reg_wr), 
    .sel_B(datB_mux_select), 
    .mem_wr(mem_wr), 
    .sel_WB(datWB_select), 
    .sel_dest(dirWB_mux_select), 
    .ALU_ctrl(ALU_ctrl)
    );
	 

wire [4:0] A;

	 
Mux2x1 dirA_mux (
    .port_select(dirA_mux_select), 
    .dat1(intruccion[15:12]), 
    .dat2(intruccion[19:16]), 
    .data_out(A)
    );
	 
	 
wire [4:0] WB;

Mux2x1 dirWB_mux (
    .port_select(dirWB_mux_select), 
    .dat1(intruccion[19:16]), 
    .dat2(intruccion[15:12]), 
    .data_out(WB)
    );
	 
wire [4:0] ALU_A;
wire [31:0] WB_data;

Registers registros (
    .clk(clk), 
    .reg_write(reg_wr), 
    .dirA(A), 
    .dirB(intruccion[3:0]), 
    .dir_WR(WB), 
    .data_in(WB_data), 
    .datA(ALU_A), 
    .datB(datB)
    );
	 
wire [31:0] immediate;
	 
RotImm extension(
    .immediate(intruccion[23:0]), 
    .imm_src(imm_src), 
    .data(immediate)
    );
	 
wire [4:0] ALU_B;
 
Mux2x1 datB_mux (
    .port_select(datB_mux_select), 
    .dat1(datB), 
    .dat2(immediate), 
    .data_out(ALU_B)
    );

wire [31:0] result;

ALU alu (
    .dat1(ALU_A), 
    .dat2(ALU_B), 
    .control(ALU_ctrl), 
    .set(ALU_set), 
    .Z(ALU_flags[0]), 
    .N(ALU_flags[1]), 
    .C(ALU_flags[2]), 
    .V(ALU_flags[3]), 
    .result(result)
);

wire [31:0] mem_out;

Memory datos(
    .clk(clk), 
    .address(result), 
    .data(datB), 
    .we(mem_wr), 
    .data_out(mem_out)
    );

Mux2x1 datWB (
    .port_select(datWB_select), 
    .dat1(result), 
    .dat2(mem_out), 
    .data_out(WB_data)
    );

endmodule
