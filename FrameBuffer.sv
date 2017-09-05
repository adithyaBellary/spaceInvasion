module FrameBuffer (
	input [4:0] spaceship, rocket, rocket2, rocket3, monster, monster2, monster3, boss,
	input [7:0] background,	
	input Clk, spaceship_on, rocket_on, rocket_on2, rocket_on3, monster_on, monster_on2, monster_on3, explosion_on, explosion_on2, boss_on, draw_game_over, draw_start,
	output logic [7:0] color
);

	always_comb
	begin
		if(spaceship_on == 1'b1 && spaceship != 5'h00) begin
			color = spaceship;
		end
		else if(rocket_on == 1'b1 && rocket != 5'h00) begin
			color = rocket;
		end
		else if(rocket_on2 == 1'b1 && rocket2 != 5'h00) begin
			color = rocket2;
		end
		else if(rocket_on3 == 1'b1 && rocket3 != 5'h00) begin
			color = rocket3;
		end
		else if(explosion_on == 1'b1 && draw_game_over != 1'b1 && draw_start != 1'b1) begin
			color = 6;
		end
		else if( explosion_on2 == 1'b1 && draw_game_over != 1'b1 && draw_start != 1'b1) begin
			color = 3;
		end
		else if(monster_on == 1'b1 && monster != 5'h00) begin
			color = monster;
		end
		else if(monster_on2 == 1'b1 && monster2 != 5'h00) begin
			color = monster2;
		end
		else if(monster_on3 == 1'b1 && monster3 != 5'h00) begin
			color = monster3;
		end
		else if(boss_on == 1'b1 && boss != 5'h00) begin
			color = boss;
		end
		else begin
			color = background;
		end
	end
	
endmodule
	