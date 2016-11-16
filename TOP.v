`timescale 1ns / 1ps

module TOP(
//inputs
	input clk,reset,

//inout
	inout wire ps2d, ps2c,
	
//outputs
	output wire [7:0] RGB,	
	output hsync,
	output vsync
    );
	 
wire [9:0] px_reg;
wire [9:0] py_reg;
wire mouseclick2;

// signal declaration
wire video_on, pixel_tick;
wire enable;

//Screen position
wire [9:0] pixel_x, pixel_y;

//Controlador del mouse
mouse_led mouse (
    .clk(clk), 
    .reset(reset), 
    .ps2d(ps2d), 
    .ps2c(ps2c), 
    .px_reg(px_reg), 
    .py_reg(py_reg), 
    .mouseclick(mouseclick2)
    );

//syncronizador
vga_sync sincronizar (
    .clk(clk), 
    .hsync(hsync), 
    .vsync(vsync), 
    .video_on(video_on), 
    .p_tick(pixel_tick), 
    .pixel_x(pixel_x), 
    .pixel_y(pixel_y)
    );

//controlador del vga
pixel_Gen pixels (
    .mousex(px_reg), 
    .mousey(py_reg), 
	 .mouseclick(mouseclick2),
    .pixel_tick(pixel_tick), 
    .pixel_x(pixel_x), 
    .pixel_y(pixel_y), 
    .video_on(video_on), 
	 .aluresultado(29),
    .rgb(RGB),
	 .primernumero(primernumero), 
    .signo(signo), 
    .segundonumero(segundonumero)
    );

endmodule
