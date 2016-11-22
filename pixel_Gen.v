`timescale 1ns / 1ps
 
module pixel_Gen(
	
	input [9:0] mousex,
	input [9:0] mousey,
	
	//Inputs from the sincronizer
   input pixel_tick,
	input wire [9:0] pixel_x, pixel_y,
	input wire video_on,
	
	//que dibujar en la pantalla
	input [6:0]dibujar,
	
	//funcion a dibujar
	input [6:0] signo,
	
	
	//Salida de color segun el bit correspondiente
    output wire [7:0] rgb
   );
   


// constant declaration

   localparam SymbolSize = 64 ; //Lenght of the side of the digit
   localparam expansionSize =  3;//Denotes log2(SymbolSize/8) it denotes how much bigger does the digit is on screen compared with the template, 1 is 1:1, 2 is 1:4, 3 is 1:16. From Verilog 2005 and on this can implemented as a function
		
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
localparam signor = 30;
localparam signot = 70;
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
			
			
			
			//dibujar el signo seleccionado
			if ((pixel_x >= signor) && (pixel_x <= (signo + SymbolSize)) && (pixel_y >= signot) && (pixel_y <= (signot + SymbolSize))) begin
				columnY = (pixel_y - signot) >> 3;//Includes Top position of the character and the expansion of the character 
				if (pixel_x <= (signor + 1*SymbolSize)) begin// 
					Character = signo;//Character to be drawn 
					if(row[7-((pixel_x - (signor + 0*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = blue;//Color to be drawn 
					else
						rgb_reg = black;//Otherwise it's black
				end			
			end
			
			// dibujar el numero seleccionado
			if ((pixel_x >= resultador) && (pixel_x <= (resultador + 7*SymbolSize)) && (pixel_y >= resultadot) && (pixel_y <= (resultadot + SymbolSize))) begin
				columnY = (pixel_y - resultadot) >> 3;//Includes Top position of the character and the expansion of the character 
				if (pixel_x <= (resultador + 1*SymbolSize)) begin// 
					Character = (dibujar%10000)/1000;//Character to be drawn 
					if(row[7-((pixel_x - (resultador + 0*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = blue;//Color to be drawn 
					else
						rgb_reg = black;//Otherwise it's black
				end
				
				else if ((pixel_x >= (resultador + 2*SymbolSize)) && (pixel_x <= (resultador + 3*SymbolSize))) begin// 
					Character = (dibujar%1000)/100;//Character to be drawn 
					if(row[7-((pixel_x - (resultador + 1*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = blue;//Color to be drawn 
					else
						rgb_reg = black;//Otherwise it's black
				end
			
				else if ((pixel_x >= (resultador + 4*SymbolSize)) && (pixel_x <= (resultador + 5*SymbolSize))) begin// 
					Character = (dibujar%100)/10;//Character to be drawn 
					if(row[7-((pixel_x - (resultador + 2*SymbolSize)) >> 3)])//Includes Left position of the character and the expansion of the character 
						rgb_reg = blue;//Color to be drawn 
					else
						rgb_reg = black;//Otherwise it's black
				end
				else if ((pixel_x >= (resultador + 6*SymbolSize)) && (pixel_x <= (resultador + 7*SymbolSize))) begin// 
					Character = (dibujar%10);//Character to be drawn 
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
endmodule
