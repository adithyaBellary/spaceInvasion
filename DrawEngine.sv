/*	Define collision detection here
		Determine where to draw the sprites
		draw to frame buffer
*/

module DrawEngine (
	input [9:0] DrawX, DrawY, SpaceshipX, SpaceshipY, RocketX, RocketY, RocketX2, RocketY2, RocketX3, RocketY3, MonsterX, MonsterY, MonsterX2, MonsterY2, MonsterX3, MonsterY3, BossX, BossY,
	input draw_level1, draw_level2, draw_level3, draw_victory, draw_game_over, draw_start,
	output logic [4095:0] output_address_spaceship,
	output logic [319:0] output_address_rocket,
	output logic [2499:0] output_address_monster,
	output logic [899:0] output_address_monster2,
	output logic [3599:0] output_address_boss,
	output logic draw_spaceship, draw_rocket, draw_rocket2, draw_rocket3, draw_monster, draw_monster2, draw_monster3, draw_boss,
	output logic [19:0] background_address
);

	logic [9:0] dX, dY;
	logic [19:0] backgroundX, backgroundY;
	
	assign backgroundX = DrawX;
	assign backgroundY = DrawY;

	//Determine when to draw which sprite
	always_comb
	begin
		
//Draw sprites	
	if (((DrawX + 32 >= SpaceshipX) && (DrawX <= (SpaceshipX + 32)) && (DrawY + 32 >= SpaceshipY) && (DrawY <= (SpaceshipY + 32))) && (draw_level1 == 1'b1 || draw_level2 == 1'b1 || draw_level3 == 1'b1))
	begin	
		draw_spaceship = 1'b1;
		draw_rocket = 1'b0;
		draw_rocket2 = 1'b0;
		draw_rocket3 = 1'b0;
		draw_monster = 1'b0;
		draw_monster2 = 1'b0;
		draw_monster3 = 1'b0;
		draw_boss = 1'b0;
	end
	else if(((DrawX + 8 >= RocketX) && (DrawX <= (RocketX + 8)) && (DrawY + 10 >= RocketY) && (DrawY <= (RocketY + 10))) && (draw_level1 == 1'b1 || draw_level2 == 1'b1 || draw_level3 == 1'b1))
	begin	
		draw_rocket = 1'b1;
		draw_rocket2 = 1'b0;
		draw_rocket3 = 1'b0;
		draw_spaceship = 1'b0;
		draw_monster = 1'b0;
		draw_monster2 = 1'b0;
		draw_monster3 = 1'b0;
		draw_boss = 1'b0;
	end
	else if(((DrawX + 8 >= RocketX2) && (DrawX <= (RocketX2 + 8)) && (DrawY + 10 >= RocketY2) && (DrawY <= (RocketY2 + 10))) && (draw_level1 == 1'b1 || draw_level2 == 1'b1 || draw_level3 == 1'b1) )
	begin	
		draw_rocket = 1'b0;
		draw_rocket2 = 1'b1;
		draw_rocket3 = 1'b0;
		draw_spaceship = 1'b0;
		draw_monster = 1'b0;
		draw_monster2 = 1'b0;
		draw_monster3 = 1'b0;
		draw_boss = 1'b0;
	end
	else if(((DrawX + 8 >= RocketX3) && (DrawX <= (RocketX3 + 8)) && (DrawY + 10 >= RocketY3) && (DrawY <= (RocketY3 + 10))) && (draw_level1 == 1'b1 || draw_level2 == 1'b1 || draw_level3 == 1'b1))
	begin	
		draw_rocket = 1'b0;
		draw_rocket2 = 1'b0;
		draw_rocket3 = 1'b1;
		draw_spaceship = 1'b0;
		draw_monster = 1'b0;
		draw_monster2 = 1'b0;
		draw_monster3 = 1'b0;
		draw_boss = 1'b0;
	end	
	else if(((DrawX + 25 >= MonsterX) && (DrawX <= (MonsterX + 25)) && (DrawY + 25 >= MonsterY) && (DrawY <= (MonsterY + 25))) && (draw_level1 == 1'b1))
	begin	
		draw_monster = 1'b1;
		draw_monster2 = 1'b0;
		draw_monster3 = 1'b0;
		draw_rocket = 1'b0;
		draw_rocket2 = 1'b0;
		draw_rocket3 = 1'b0;
		draw_spaceship = 1'b0;
		draw_boss = 1'b0;
	end
	else if(((DrawX + 25 >= MonsterX2) && (DrawX <= (MonsterX2 + 25)) && (DrawY + 25 >= MonsterY2) && (DrawY <= (MonsterY2 + 25))) && (draw_level1 == 1'b1))
	begin	
		draw_monster = 1'b0;
		draw_monster2 = 1'b1;
		draw_monster3 = 1'b0;
		draw_rocket = 1'b0;
		draw_rocket2 = 1'b0;
		draw_rocket3 = 1'b0;
		draw_spaceship = 1'b0;
		draw_boss = 1'b0;
	end

	else if(((DrawX + 15 >= MonsterX3) && (DrawX <= (MonsterX3 + 15)) && (DrawY + 15 >= MonsterY3) && (DrawY <= (MonsterY3 + 15))) && (draw_level2 == 1'b1))
	begin	
		draw_monster = 1'b0;
		draw_monster2 = 1'b0;
		draw_monster3 = 1'b1;
		draw_rocket = 1'b0;
		draw_rocket2 = 1'b0;
		draw_rocket3 = 1'b0;
		draw_spaceship = 1'b0;
		draw_boss = 1'b0;
	end

	
	else if(((DrawX + 30 >= BossX) && (DrawX <= (BossX + 30)) && (DrawY + 30 >= BossY) && (DrawY <= (BossY + 30))) && (draw_level3 == 1'b1))
	begin	
		draw_monster = 1'b0;
		draw_monster2 = 1'b0;
		draw_monster3 = 1'b0;
		draw_rocket = 1'b0;
		draw_rocket2 = 1'b0;
		draw_rocket3 = 1'b0;
		draw_spaceship = 1'b0;
		draw_boss = 1'b1;
	end
		
	else begin
		draw_spaceship = 1'b0;
		draw_rocket = 1'b0;
		draw_rocket2 = 1'b0;
		draw_rocket3 = 1'b0;
		draw_monster = 1'b0;
		draw_monster2 = 1'b0;
		draw_monster3 = 1'b0;
		draw_boss = 1'b0;
	end
	end

	always_comb
	begin
		if(draw_start == 1'b1)
		begin
			dX = 10'h0;
			dY = 10'h0;
			output_address_spaceship = 10'h00;
			output_address_rocket = 10'h00;
			output_address_monster = 10'h00;
			output_address_monster2 = 10'h00;
			output_address_boss = 10'h00;
			background_address = 20'h4B000 + backgroundX + (backgroundY * 20'h280);
		end
		else if(draw_victory == 1'b1)
		begin
			dX = 10'h0;
			dY = 10'h0;
			output_address_spaceship = 10'h00;
			output_address_rocket = 10'h00;
			output_address_monster = 10'h00;
			output_address_monster2 = 10'h00;
			output_address_boss = 10'h00;
			background_address = 20'h96000 + backgroundX + (backgroundY * 20'h280);	//change once we know the addressing
		end
		
		else if(draw_game_over == 1'b1)
		begin
			dX = 10'h0;
			dY = 10'h0;
			output_address_spaceship = 10'h00;
			output_address_rocket = 10'h00;
			output_address_monster = 10'h00;
			output_address_monster2 = 10'h00;
			output_address_boss = 10'h00;
			background_address = 20'h96000 + backgroundX + (backgroundY * 20'h280); //change once we know addressing
		end
		
   	else if (draw_spaceship == 1'b1)
		begin
			//Actually draw out the spaceship
			 dX = DrawX - (SpaceshipX - 10'h20);
			 dY = DrawY - (SpaceshipY - 10'h20);
			 output_address_spaceship = dX + (dY * 10'h40);
			 output_address_rocket = 10'h00;
			 output_address_monster = 10'h00;
			 output_address_monster2 = 10'h00;
			 output_address_boss = 10'h00;
			 background_address = backgroundX + (backgroundY * 20'h280);
		end
		
		else if(draw_rocket == 1'b1)
		begin
			dX = DrawX - (RocketX - 10'h08);
			dY = DrawY - (RocketY - 10'h0A);
			output_address_rocket = dX + (dY * 10'h10);
			output_address_spaceship = 10'h00;
			output_address_monster = 10'h00;
			output_address_monster2 = 10'h00;
			output_address_boss = 10'h00;
			background_address = backgroundX + (backgroundY * 20'h280);
		end
		else if(draw_rocket2 == 1'b1)
		begin
			dX = DrawX - (RocketX2 - 10'h08);
			dY = DrawY - (RocketY2 - 10'h0A);
			output_address_rocket = dX + (dY * 10'h10);
			output_address_spaceship = 10'h00;
			output_address_monster = 10'h00;
			output_address_monster2 = 10'h00;
			output_address_boss = 10'h00;
			background_address = backgroundX + (backgroundY * 20'h280);
		end
		else if(draw_rocket3 == 1'b1)
		begin
			dX = DrawX - (RocketX3 - 10'h08);
			dY = DrawY - (RocketY3 - 10'h0A);
			output_address_rocket = dX + (dY * 10'h10);
			output_address_spaceship = 10'h00;
			output_address_monster = 10'h00;
			output_address_monster2 = 10'h00;
			output_address_boss = 10'h00;
			background_address = backgroundX + (backgroundY * 20'h280);
		end

		else if(draw_monster == 1'b1)
		begin
			dX = DrawX - (MonsterX - 10'h19);
			dY = DrawY - (MonsterY - 10'h19);
			output_address_rocket = 10'h00;
			output_address_spaceship = 10'h00;
			output_address_monster = dX + (dY * 10'h32);
			output_address_monster2 = 10'h00;
			output_address_boss = 10'h00;
			background_address = backgroundX + (backgroundY * 20'h280);
		end
				
		else if(draw_monster2 == 1'b1)
		begin
			dX = DrawX - (MonsterX2 - 10'h19);
			dY = DrawY - (MonsterY2 - 10'h19);
			output_address_rocket = 10'h00;
			output_address_spaceship = 10'h00;
			output_address_monster = dX + (dY * 10'h32);
			output_address_monster2 = 10'h00;
			output_address_boss = 10'h00;
			background_address = backgroundX + (backgroundY * 20'h280);
		end
		else if(draw_monster3 == 1'b1)
		begin
			dX = DrawX - (MonsterX3 - 10'h0F);
			dY = DrawY - (MonsterY3 - 10'h0F);
			output_address_rocket = 10'h00;
			output_address_spaceship = 10'h00;
			output_address_monster = 10'h00;
			output_address_monster2 = dX + (dY * 10'h1E);
			output_address_boss = 10'h00;
			background_address = backgroundX + (backgroundY * 20'h280);
		end
		
		
		else if(draw_boss == 1'b1)
		begin
			dX = DrawX - (BossX - 10'h1E);
			dY = DrawY - (BossY - 10'h1E);
			output_address_rocket = 10'h00;
			output_address_spaceship = 10'h00;
			output_address_monster = 10'h00;
			output_address_monster2 = 10'h00;
			output_address_boss = dX + (dY * 10'h3C);
			background_address = backgroundX + (backgroundY * 20'h280);
		end
		else begin
			 dX = 10'h0;
			 dY = 10'h0;
			 output_address_spaceship = 10'h00;
			 output_address_rocket = 10'h00;
			 output_address_monster = 10'h00;
			 output_address_monster2 = 10'h00;
			 output_address_boss = 10'h00;
			 background_address = backgroundX + (backgroundY * 20'h280);
		end
	end

endmodule
