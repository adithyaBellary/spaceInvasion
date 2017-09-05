module ColorTable( 	
				input logic [7:0] color,
				output logic [7:0] _Red, _Green, _Blue
);

	logic [7:0] R, G, B;

/*
	0 = '0xFF69B4' = HOT PINK
	1 = '0x000000' = BLACK
	2 = '0xDADAFF' = LIGHT GRAY
	3 = '0xFF0000' = RED
	4 = '0x006DFF' = BABY BLUE
	5 = '0xE85C00' = ORANGE
	6 = '0xE5E800' = YELLOW
	7 = '0x00031A' = Background black
	8 = '0x000F2E' = Background navy blue
	9 = '0x01254E' = Background middle blue
	10 = '0x001437' = Background upper middle blue
	11 = '0x001E4B' = Background other blue
	12 = 0x495251 = Dark Grey
	13 = '0x9C9E73' = Olive Green
	14 = '0xF000FF' = Bright Majenta
	15 = '0x00FF07' = Green
	16 = '0x403F56' = Darker Grey
	17 = '0x212036' = The Dark Knight
	18 = '0xE3B181' = Dusty Orange
	19 = '0x111010' = The Dark Knight Rises
	20 = '0x3B3944' = Batman Begin
	21 = '0xE8D7A4' = Sandy Cheeks
	22 = '0xD9CAAE' = Paper Bag
	23 = '0xB98F5C' = Hershey
	24 = '0xC87958' = Coral
	25 = '0x985C3E' = Dark Chocolate
	26 = '0x625F55' = Charcoal
	27 = '0x949087' = Pencil Lead
	28 = '0x105772' = Poseidon
	29 = '0xF1ACDA' = Hubba Bubba 
	30 = '0x247BAA' = The Other Poseidon
	31 = '0xF7D0EA' = Pastel Pink
	32 = '0x2CE8FE' = Aquamarine
	33 = '0x0091F3' = Illini Blue
	34 = '0x01136A' = Purpleberry
	'', , , , , , , , , , , , , , , , , , , , , , 
*/	
	
	always_comb
	begin
	
		unique case(color)
		
			8'h00:
			begin
				R = 8'hFF;
				G = 8'h69;
				B = 8'hB4;
			end
	
			8'h01:
			begin
				R = 8'h00;
				G = 8'h00;
				B = 8'h00;	
			end

			8'h02: 
			begin
				R = 8'hDA;
				G = 8'hDA;
				B = 8'hFF;
			end

			8'h03: 
			begin
				R = 8'hFF;
				G = 8'h00;
				B = 8'h00;
			end

			8'h04: 
			begin
				R = 8'h00;
				G = 8'h6D;
				B = 8'hFF;
			end

			8'h05: 
			begin
				R = 8'hE8;
				G = 8'h5C;
				B = 8'h00;
			end
			
			8'h06: 
			begin
				R = 8'hE8;
				G = 8'hE5;
				B = 8'h00;
			end
			
			8'h07:
			begin
				R = 8'h00;
				G = 8'h03;
				B = 8'h1A;
			end

			8'h08:
			begin
				R = 8'h00;
				G = 8'h0F;
				B = 8'h2E;
			end
			
			8'h09:
			begin
				R = 8'h01;
				G = 8'h25;
				B = 8'h4E;
			end

			8'h0A:
			begin
				R = 8'h00;
				G = 8'h14;
				B = 8'h37;
			end

			8'h0B:
			begin
				R = 8'h00;
				G = 8'h1E;
				B = 8'h4B;
			end
			
			8'h0C:
			begin
				R = 8'h49;
				G = 8'h52;
				B = 8'h51;
			end
			
			8'h0D:
			begin
				R = 8'h9C;
				G = 8'h9E;
				B = 8'h73;
			end
			
			8'h0E:
			begin
				R = 8'hF0;
				G = 8'h00;
				B = 8'hFF;
			end
			
			8'h0F:
			begin
				R = 8'h00;
				G = 8'hFF;
				B = 8'h07;
			end
			
			8'h10:
			begin
				R = 8'h40;
				G = 8'h3F;
				B = 8'h56;
			end
			
			8'h11:
			begin
				R = 8'h21;
				G = 8'h20;
				B = 8'h36;
			end
			
			8'h12:
			begin
				R = 8'hE3;
				G = 8'hB1;
				B = 8'h81;
			end
			
			8'h13:
			begin
				R = 8'h11;
				G = 8'h10;
				B = 8'h10;
			end
			
			8'h14:
			begin
				R = 8'h3B;
				G = 8'h39;
				B = 8'h44;
			end
			
			8'h15:
			begin
				R = 8'hE8;
				G = 8'hD7;
				B = 8'hA4;
			end
			
			8'h16:
			begin
				R = 8'hD9;
				G = 8'hCA;
				B = 8'hAE;
			end
			8'h17:
			begin
				R = 8'hB9;
				G = 8'h8F;
				B = 8'h5C;
			end
			8'h18:
			begin
				R = 8'hC8;
				G = 8'h79;
				B = 8'h58;
			end
			8'h19:
			begin
				R = 8'h98;
				G = 8'h5C;
				B = 8'h3E;
			end
			8'h1A:
			begin
				R = 8'h62;
				G = 8'h5F;
				B = 8'h55;
			end
			
			8'h1B:
			begin
				R = 8'h94;
				G = 8'h90;
				B = 8'h87;
			end
			
			8'h1C:
			begin
				R = 8'h10;
				G = 8'h57;
				B = 8'h72;
			end
			
			8'h1D:
			begin
				R = 8'hF1;
				G = 8'hAC;
				B = 8'hDA;
			end
			
			8'h1E:
			begin
				R = 8'h24;
				G = 8'h7B;
				B = 8'hAA;
			end
			
			8'h1F:
			begin
				R = 8'hF7;
				G = 8'hD0;
				B = 8'hEA;
			end
			
			8'h20:
			begin
				R = 8'h2C;
				G = 8'hE8;
				B = 8'hFE;
			end
			
			8'h21:
			begin
				R = 8'h00;
				G = 8'h91;
				B = 8'hF3;
			end
			
			8'h22:
			begin
				R = 8'h01;
				G = 8'h13;
				B = 8'h6A;
			end

			default:
			begin
				R = 8'hFF;
				G = 8'hFF;
				B = 8'hFF;
			end
		endcase
	
	end
	assign _Red = R;
	assign _Green = G;
	assign _Blue = B;
	
endmodule
