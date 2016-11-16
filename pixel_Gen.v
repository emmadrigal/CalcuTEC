`timescale 1ns / 1ps
 
module pixel_Gen(
	
	input [9:0] mousex,
	input [9:0] mousey,
	input mouseclick,
	
	//Inputs from the sincronizer
    input pixel_tick,
	input wire [9:0] pixel_x, pixel_y,
	input wire video_on,
	
	input [6:0] aluresultado,
	
	//Salida de color segun el bit correspondiente
    output wire [7:0] rgb,
	 output wire [6:0] primernumero,
	 output wire [6:0] signo,
	 output wire [6:0] segundonumero
   );
   


// constant declaration

   localparam SymbolSize = 64 ; //Lenght of the side of the digit
   localparam expansionSize =  3;//Denotes log2(SymbolSize/8) it denotes how much bigger does the digit is on screen compared with the template, 1 is 1:1, 2 is 1:4, 3 is 1:16. From Verilog 2005 and on this can implemented as a function
	
	localparam ScoreSize = 32 ; //Lenght of the side of the digit
   localparam expansionScore =  2;//Denotes log2(DigitSize/8) 
	
	localparam TextSize = 16 ; //Lenght of the side of the digit
   localparam expansionText =  1;//Denotes log2(DigitSize/8)
	
   //Colors
   localparam white   = 8'b11111111;
   localparam blue    = 8'b11000000;
   localparam red     = 8'b00000111;
   localparam green   = 8'b00111000;
   localparam black   = 8'b00000000;
   localparam cyan    = 8'b11111000;
   localparam magenta = 8'b11000111;
   localparam yellow  = 8'b00111111;
   
//signal declaration
reg [7:0] rgb_reg;

//
reg [6:0] mostuno = 103;
reg [6:0] mostdos = 103;
reg [6:0] mosttre = 103;
reg [6:0] mostcua = 103;
reg [6:0] primervalor =102;
reg [6:0] segundovalor =102;
reg [6:0] signoaux = 102; 
reg [6:0] tercervalor = 102;
reg [6:0] cuartovalor = 102;


reg[2:0] turno = 1;
//Current character to be drawn
reg [7:0] Character;
//Used to determine the height of the current pixel in the caracter
reg [2:0] columnY;
//Used to read the current row of pixels in the character
wire [7:0] row;

//Module instatiation
Chars_rom CharacterRom(.character(Character),  .columnaY(columnY),   .data(row));

localparam cleanr = 560;
localparam cleant = 150;
localparam resultador = 150;
localparam resultadot= 70;
localparam Numerounor = 90;
localparam Numerounot = 150;

//Checks that for a given pixel in the screen if it should be written
always @(posedge pixel_tick) begin
	if (video_on) begin		
			if ((pixel_x >= Numerounor) && (pixel_x <= (Numerounor + 7*SymbolSize)) && (pixel_y >= Numerounot) && (pixel_y <= (Numerounot + SymbolSize))) begin
				columnY = (pixel_y - Numerounot) >> 3;//Includes Top position of the character and the expansion of the character 
				if (pixel_x <= (Numerounor + 1*SymbolSize)) begin// 
					Character = 1;//Character to be drawn 
					if(row[7-((pixel_x - (Numerounor + 0*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = blue;//Color to be drawn 
					else
						rgb_reg = black;//Otherwise it's black
				end
			
			else if ((pixel_x >= (Numerounor + 2*SymbolSize)) && (pixel_x <= (Numerounor + 3*SymbolSize))) begin// 
				Character = 2;//Character to be drawn 
				if(row[7-((pixel_x - (Numerounor + 1*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
					rgb_reg = blue;//Color to be drawn 
				else
					rgb_reg = black;//Otherwise it's black
			end
			
			else if ((pixel_x >= (Numerounor + 4*SymbolSize)) && (pixel_x <= (Numerounor + 5*SymbolSize))) begin// 
				Character = 3;//Character to be drawn 
				if(row[7-((pixel_x - (Numerounor + 2*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
					rgb_reg = blue;//Color to be drawn 
				else
					rgb_reg = black;//Otherwise it's black
			end
			
			else if ((pixel_x >= (Numerounor + 6*SymbolSize)) && (pixel_x <= (Numerounor + 7*SymbolSize))) begin// 
				Character = 96;//Character to be drawn 
				if(row[7-((pixel_x - (Numerounor + 3*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
					rgb_reg = blue;//Color to be drawn 
				else
					rgb_reg = black;//Otherwise it's black
			end
			end
			
			if ((pixel_x >= Numerounor) && (pixel_x <= (Numerounor + 7*SymbolSize)) && (pixel_y >= Numerounot + SymbolSize+25) && (pixel_y <= (Numerounot + 2*SymbolSize+25))) begin
				columnY = (pixel_y-2*Numerounot) >> 3;//Includes Top position of the character and the expansion of the character 
				if ((pixel_x <= (Numerounor + 1*SymbolSize))) begin// 
					Character = 4;//Character to be drawn 
					if(row[7-((pixel_x - (Numerounor + 0*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = blue;//Color to be drawn 
					else
						rgb_reg = black;//Otherwise it's black
				end
				
				else if ((pixel_x >= (Numerounor + 2*SymbolSize)) && (pixel_x <= (Numerounor + 3*SymbolSize))) begin// 
				Character = 5;//Character to be drawn 
				if(row[7-((pixel_x - (Numerounor + 1*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
					rgb_reg = blue;//Color to be drawn 
				else
					rgb_reg = black;//Otherwise it's black
			end
			
			else if ((pixel_x >= (Numerounor + 4*SymbolSize)) && (pixel_x <= (Numerounor + 5*SymbolSize))) begin// 
				Character = 6;//Character to be drawn 
				if(row[7-((pixel_x - (Numerounor + 2*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
					rgb_reg = blue;//Color to be drawn 
				else
					rgb_reg = black;//Otherwise it's black
			end
			
			else if ((pixel_x >= (Numerounor + 6*SymbolSize)) && (pixel_x <= (Numerounor + 7*SymbolSize))) begin// 
				Character = 97;//Character to be drawn 
				if(row[7-((pixel_x - (Numerounor + 3*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
					rgb_reg = blue;//Color to be drawn 
				else
					rgb_reg = black;//Otherwise it's black
			end
			
			end
			
			if ((pixel_x >= Numerounor) && (pixel_x <= (Numerounor + 7*SymbolSize)) && (pixel_y >= Numerounot + 2*SymbolSize+50) && (pixel_y <= (Numerounot + 3*SymbolSize+50))) begin
				columnY = (pixel_y - 200) >> 3;//Includes Top position of the character and the expansion of the character 
				if (pixel_x <= (Numerounor + 1*SymbolSize)) begin// 
					Character = 7;//Character to be drawn 
					if(row[7-((pixel_x - (Numerounor + 0*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = blue;//Color to be drawn 
					else
  					 rgb_reg = black;//Otherwise it's black
				end
				
				else if ((pixel_x >= (Numerounor + 2*SymbolSize)) && (pixel_x <= (Numerounor + 3*SymbolSize))) begin// 
					Character = 8;//Character to be drawn 
					if(row[7-((pixel_x - (Numerounor + 1*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = blue;//Color to be drawn 
					else
						rgb_reg = black;//Otherwise it's black
				end
			
				else if ((pixel_x >= (Numerounor + 4*SymbolSize)) && (pixel_x <= (Numerounor + 5*SymbolSize))) begin// 
					Character = 9;//Character to be drawn 
					if(row[7-((pixel_x - (Numerounor + 2*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = blue;//Color to be drawn 
					else
						rgb_reg = black;//Otherwise it's black
				end
			
				else if ((pixel_x >= (Numerounor + 6*SymbolSize)) && (pixel_x <= (Numerounor + 7*SymbolSize))) begin// 
					Character = 98;//Character to be drawn 
					if(row[7-((pixel_x - (Numerounor + 3*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = blue;//Color to be drawn 
					else
						rgb_reg = black;//Otherwise it's black
				end
					
			end
			
			if ((pixel_x >= Numerounor) && (pixel_x <= (Numerounor + 7*SymbolSize)) && (pixel_y >= Numerounot + 3*SymbolSize+75) && (pixel_y <= (Numerounot + 4*SymbolSize+75))) begin
				columnY = (pixel_y - 100) >> 3;//Includes Top position of the character and the expansion of the character 
				if (pixel_x <= (Numerounor + 1*SymbolSize)) begin// 
					Character = 0;//Character to be drawn 
					if(row[7-((pixel_x - (Numerounor + 0*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = blue;//Color to be drawn 
					else
						rgb_reg = black;//Otherwise it's black
				end
				
				else if ((pixel_x >= (Numerounor + 2*SymbolSize)) && (pixel_x <= (Numerounor + 3*SymbolSize))) begin// 
					Character = 99;//Character to be drawn 
					if(row[7-((pixel_x - (Numerounor + 1*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = blue;//Color to be drawn 
					else
						rgb_reg = black;//Otherwise it's black
				end
			
				else if ((pixel_x >= (Numerounor + 4*SymbolSize)) && (pixel_x <= (Numerounor + 5*SymbolSize))) begin// 
					Character = 100;//Character to be drawn 
					if(row[7-((pixel_x - (Numerounor + 2*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = blue;//Color to be drawn 
					else
						rgb_reg = black;//Otherwise it's black
				end
			
				else if ((pixel_x >= (Numerounor + 6*SymbolSize)) && (pixel_x <= (Numerounor + 7*SymbolSize))) begin// 
					Character = 101;//Character to be drawn 
					if(row[7-((pixel_x - (Numerounor + 3*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = blue;//Color to be drawn 
					else
						rgb_reg = black;//Otherwise it's black
				end
				
			end
			
			// dibujar la c de clear
			if ((pixel_x >= cleanr) && (pixel_x <= (cleanr + 7*SymbolSize)) && (pixel_y >= cleant) && (pixel_y <= (cleant + SymbolSize))) begin
				columnY = (pixel_y - cleant) >> 3;//Includes Top position of the character and the expansion of the character 
				if (pixel_x <= (cleanr + 1*SymbolSize)) begin// 
					Character = "C";//Character to be drawn 
					if(row[7-((pixel_x - (cleanr + 0*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = blue;//Color to be drawn 
					else
						rgb_reg = black;//Otherwise it's black
				end
			end
			
			//Draws the mouse cursor on the screen
			if ((pixel_x >= (mousex - 4)) && (pixel_x <=(mousex+4)) && (pixel_y >= (mousey - 4)) && (pixel_y <= (mousey + 4)) )begin// 
				Character = 94;//This is an arrow
				columnY = pixel_y - (mousey - 4);//Includes Top position of the character and the expansion of the character 
				if(row[7 -(pixel_x - (mousex - 4))])//Includes Left position of the character and the expansion of the character 
					rgb_reg = white;
			end	
			
			//decidir numero
			if ((mousex >= Numerounor) && (mousex <= (Numerounor + 1*SymbolSize)) && (mousey >= Numerounot) && (mousey <= (Numerounot + SymbolSize)) && mouseclick==1)begin
				if (turno == 1)begin
				mostcua = 1;
				primervalor = 1;
				turno = turno+1;
				end
				else if(turno == 3)begin
				mostcua = 1;
				tercervalor = 1;
				turno = turno+1;
				end
			end
			else if ((mousex >= (Numerounor + 2*SymbolSize)) && (mousex <= (Numerounor + 3*SymbolSize)) && (mousey >= Numerounot) && (mousey <= (Numerounot + SymbolSize)) && mouseclick==1)begin
				if (turno == 1)begin
				mostcua = 2;
				primervalor = 2;
				turno = turno+1;
				end
				else if(turno == 3)begin
				mostcua = 2;
				tercervalor = 2;
				turno = turno+1;
				end
			end
		   else  if ((mousex >= (Numerounor + 4*SymbolSize)) && (mousex <= (Numerounor + 5*SymbolSize)) && (mousey >= Numerounot) && (mousey <= (Numerounot + SymbolSize)) && mouseclick==1)begin
				if (turno == 1)begin
				mostcua = 3;
				primervalor = 3;
				turno = turno+1;
				end
				else if(turno == 3)begin
				mostcua = 3;
				tercervalor = 3;
				turno = turno+1;
				end
			end
			else if ((mousex >= Numerounor) && (mousex <= (Numerounor + 1*SymbolSize)) && (mousey >= Numerounot + SymbolSize+25) && (mousey <= (Numerounot + 2*SymbolSize+25)) && mouseclick==1)begin
				if (turno == 1)begin
				mostcua = 4;
				primervalor = 4;
				turno = turno+1;
				end
				else if(turno == 3)begin
				mostcua = 4;
				tercervalor = 4;
				turno = turno+1;
				end
			end
			else if ((mousex >= (Numerounor + 2*SymbolSize)) && (mousex <= (Numerounor + 3*SymbolSize)) && (mousey >= Numerounot + SymbolSize+25) && (mousey <= (Numerounot + 2*SymbolSize+25)) && mouseclick==1)begin
				if (turno == 1)begin
				mostcua = 5;
				primervalor = 5;
				turno = turno+1;
				end
				else if(turno == 3)begin
				mostcua = 5;
				tercervalor = 5;
				turno = turno+1;
				end
			end
			else if ((mousex >= (Numerounor + 4*SymbolSize)) && (mousex <= (Numerounor + 5*SymbolSize)) && (mousey >= Numerounot + SymbolSize+25) && (mousey <= (Numerounot + 2*SymbolSize+25)) && mouseclick==1)begin
				if (turno == 1)begin
				mostcua = 6;
				primervalor = 6;
				turno = turno+1;
				end
				else if(turno == 3)begin
				mostcua = 6;
				tercervalor = 6;
				turno = turno+1;
				end
			end 
			else if ((mousex >= Numerounor) && (mousex <= (Numerounor + 1*SymbolSize)) && (mousey >= Numerounot + 2*SymbolSize+50) && (mousey <= (Numerounot + 3*SymbolSize+50)) && mouseclick==1)begin
				if (turno == 1)begin
				mostcua = 7;
				primervalor = 7;
				turno = turno+1;
				end
				else if(turno == 3)begin
				mostcua = 7;
				tercervalor = 7;
				turno = turno+1;
				end
			end  
			else if ((mousex >= (Numerounor + 2*SymbolSize)) && (mousex <= (Numerounor + 3*SymbolSize)) && (mousey >= Numerounot + 2*SymbolSize+50) && (mousey <= (Numerounot + 3*SymbolSize+50)) && mouseclick==1)begin
				if (turno == 1)begin
				mostcua = 8;
				primervalor = 8;
				turno = turno+1;
				end
				else if(turno == 3)begin
				mostcua = 8;
				tercervalor = 8;
				turno = turno+1;
				end
			end  
			else if ((mousex >= (Numerounor + 4*SymbolSize)) && (mousex <= (Numerounor + 5*SymbolSize)) && (mousey >= Numerounot + 2*SymbolSize+50) && (mousey <= (Numerounot + 3*SymbolSize+50)) && mouseclick==1)begin
				if (turno == 1)begin
				mostcua = 9;
				primervalor = 9;
				turno = turno+1;
				end
				else if(turno == 3)begin
				mostcua = 9;
				tercervalor = 9;
				turno = turno+1;
				end
			end  
			else if ((mousex >= Numerounor) && (mousex <= (Numerounor + 1*SymbolSize)) && (mousey >= Numerounot + 3*SymbolSize+75) && (mousey <= (Numerounot + 4*SymbolSize+75)) && mouseclick==1)begin
				if (turno == 1)begin
				mostcua = 0;
				primervalor = 0;
				turno = turno+1;
				end
				else if(turno == 3)begin
				mostcua = 0;
				tercervalor = 0;
				turno = turno+1;
				end
			end   
			
			//decidir signo
			if ((mousex >= (Numerounor + 6*SymbolSize)) && (mousex <= (Numerounor + 7*SymbolSize)) && (mousey >= Numerounot + SymbolSize+25) && (mousey <= (Numerounot + 2*SymbolSize+25)) && mouseclick==1)begin
				if (turno == 2)begin
				mostcua = 97;
				signoaux = 97;
				turno = turno+1;
				end
			end
			else if ((mousex >= (Numerounor + 6*SymbolSize)) && (mousex <= (Numerounor + 7*SymbolSize)) && (mousey >= Numerounot + 2*SymbolSize+50) && (mousey <= (Numerounot + 3*SymbolSize+50)) && mouseclick==1)begin
				if (turno == 2)begin
				mostcua = 98;
				signoaux = 98;
				turno = turno+1;
				end
			end
			else if ((mousex >= (Numerounor + 2*SymbolSize)) && (mousex <= (Numerounor + 3*SymbolSize)) && (mousey >= Numerounot + 3*SymbolSize+75) && (mousey <= (Numerounot + 4*SymbolSize+75)) && mouseclick==1)begin
				if (turno == 2)begin
				mostcua = 99;
				signoaux = 99;
				turno = turno+1;
				end
			end
			else if ((mousex >= (Numerounor + 4*SymbolSize)) && (mousex <= (Numerounor + 5*SymbolSize)) && (mousey >= Numerounot + 3*SymbolSize+75) && (mousey <= (Numerounot + 4*SymbolSize+75)) && mouseclick==1)begin
				if (turno == 2)begin
				mostcua = 100;
				signoaux = 100;
				turno = turno+1;
				end
			end
			else if ((mousex >= (Numerounor + 6*SymbolSize)) && (mousex <= (Numerounor + 7*SymbolSize)) && (mousey >= Numerounot + 3*SymbolSize+75) && (mousey <= (Numerounot + 4*SymbolSize+75)) && mouseclick==1)begin
				if (turno == 2)begin
				mostcua = 101;
				signoaux = 101;
				turno = turno+1;
				end
			end
			//funcionalidad del =
			else if ((mousex >= (Numerounor + 6*SymbolSize)) && (mousex <= (Numerounor + 7*SymbolSize)) && (mousey >= Numerounot) && (mousey <= (Numerounot + SymbolSize)) && mouseclick==1)begin
				if (tercervalor != 103)begin
				mostcua = (aluresultado % 10);
				mosttre = (aluresultado%100)/10;
				end
				else begin
				mostcua = "E";
				end				
			end
			
			
			//Limpiar pantalla de numeros seleccionados
			if ((mousex >= cleanr) && (mousex <= (cleanr + 1*SymbolSize)) && (mousey >= cleant) && (mousey <= (cleant + SymbolSize))&& mouseclick==1) begin
				primervalor = 103;
				signoaux = 103;
				tercervalor = 103; 
				mostcua = 103; 
				mosttre = 103;
				turno = 1;
			end

			
			// dibujar lo seleccionado
			if ((pixel_x >= resultador) && (pixel_x <= (resultador + 7*SymbolSize)) && (pixel_y >= resultadot) && (pixel_y <= (resultadot + SymbolSize))) begin
				columnY = (pixel_y - resultadot) >> 3;//Includes Top position of the character and the expansion of the character 
				if (pixel_x <= (resultador + 1*SymbolSize)) begin// 
					Character = mostuno;//Character to be drawn 
					if(row[7-((pixel_x - (resultador + 0*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = blue;//Color to be drawn 
					else
						rgb_reg = black;//Otherwise it's black
				end
				
				else if ((pixel_x >= (resultador + 2*SymbolSize)) && (pixel_x <= (resultador + 3*SymbolSize))) begin// 
					Character = mostdos;//Character to be drawn 
					if(row[7-((pixel_x - (resultador + 1*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = blue;//Color to be drawn 
					else
						rgb_reg = black;//Otherwise it's black
				end
			
				else if ((pixel_x >= (resultador + 4*SymbolSize)) && (pixel_x <= (resultador + 5*SymbolSize))) begin// 
					Character = mosttre;//Character to be drawn 
					if(row[7-((pixel_x - (resultador + 2*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = blue;//Color to be drawn 
					else
						rgb_reg = black;//Otherwise it's black
				end
				else if ((pixel_x >= (resultador + 6*SymbolSize)) && (pixel_x <= (resultador + 7*SymbolSize))) begin// 
					Character = mostcua;//Character to be drawn 
					if(row[7-((pixel_x - (Numerounor + 3*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = blue;//Color to be drawn 
					else
						rgb_reg = black;//Otherwise it's black
				end			
			end
	end
	else
		rgb_reg = black;
	
end 

//output
assign rgb = rgb_reg;
assign primernumero = primervalor;
assign signo = signoaux;
assign segundonumero = tercervalor;
endmodule
