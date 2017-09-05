module CollisionDetection (
	input [9:0] RocketX, RocketY, RocketX2, RocketY2, RocketX3, RocketY3, MonsterX, MonsterY, MonsterX2, MonsterY2, MonsterX3, MonsterY3, SpaceshipX, SpaceshipY, BossX, BossY,
	input draw_game_over,
	output is_dead, is_dead2, is_dead3, draw_explosion, draw_explosion2, rocket1_disappear, rocket2_disappear, rocket3_disappear, spaceship_disappear, boss_dead
); 



always_comb
begin

//First collision detection (Rocket1 v. Monster1)

	if((RocketX + 8 <= (MonsterX+25)) && ((RocketX - 8) >= (MonsterX - 25)) && (RocketY - 10 >= (MonsterY-25)) && (RocketY+10 <= (MonsterY + 25)))
	begin 
		draw_explosion = 1'b1;
		is_dead = 1'b1;
		is_dead2 = 1'b0;
		is_dead3 = 1'b0;
		rocket1_disappear = 1'b1;
		rocket2_disappear = 1'b0;
		rocket3_disappear = 1'b0;
		spaceship_disappear = 1'b0;
		draw_explosion2 = 1'b0;
		boss_dead = 1'b0;
	end
	else if((RocketX2 + 8 <= (MonsterX+25)) && ((RocketX2 - 8) >= (MonsterX - 25)) && (RocketY2 - 10 >= (MonsterY-25)) && (RocketY2+10 <= (MonsterY + 25)))
	begin 
		draw_explosion = 1'b1;
		is_dead = 1'b1;
		is_dead2 = 1'b0;
		is_dead3 = 1'b0;
		rocket1_disappear = 1'b0;
		rocket2_disappear = 1'b1;
		rocket3_disappear = 1'b0;
		spaceship_disappear = 1'b0;
		draw_explosion2 = 1'b0;
		boss_dead = 1'b0;
	end
	else if((RocketX3 + 8 <= (MonsterX+25)) && ((RocketX3 - 8) >= (MonsterX - 25)) && (RocketY3 - 10 >= (MonsterY-25)) && (RocketY3+10 <= (MonsterY + 25)))
	begin 
		draw_explosion = 1'b1;
		is_dead = 1'b1;
		is_dead2 = 1'b0;
		is_dead3 = 1'b0;
		rocket1_disappear = 1'b0;
		rocket2_disappear = 1'b0;
		rocket3_disappear = 1'b1;
		spaceship_disappear = 1'b0;
		draw_explosion2 = 1'b0;
		boss_dead = 1'b0;
	end

	
//Collision for second monster	
	
	else if((RocketX + 8 <= (MonsterX2+25)) && ((RocketX - 8) >= (MonsterX2 - 25)) && (RocketY - 10 >= (MonsterY2-25)) && (RocketY+10 <= (MonsterY2 + 25)))
	begin 
		draw_explosion = 1'b1;
		is_dead = 1'b0;
		is_dead2 = 1'b1;
		is_dead3 = 1'b0;
		rocket1_disappear = 1'b1;
		rocket2_disappear = 1'b0;
		rocket3_disappear = 1'b0;
		spaceship_disappear = 1'b0;
		draw_explosion2 = 1'b0;
		boss_dead = 1'b0;
	end
	else if((RocketX2 + 8 <= (MonsterX2+25)) && ((RocketX2 - 8) >= (MonsterX2 - 25)) && (RocketY2 - 10 >= (MonsterY2-25)) && (RocketY2+10 <= (MonsterY2 + 25)))
	begin
		draw_explosion = 1'b1;
		is_dead = 1'b0;
		is_dead2 = 1'b1;
		is_dead3 = 1'b0;
		rocket1_disappear = 1'b0;
		rocket2_disappear = 1'b1;
		rocket3_disappear = 1'b0;
		spaceship_disappear = 1'b0;
		draw_explosion2 = 1'b0;
		boss_dead = 1'b0;
	end
	else if((RocketX3 + 8 <= (MonsterX2+25)) && ((RocketX3 - 8) >= (MonsterX2 - 25)) && (RocketY3 - 10 >= (MonsterY2-25)) && (RocketY3+10 <= (MonsterY2 + 25)))
	begin 
		draw_explosion = 1'b1;
		is_dead = 1'b0;
		is_dead2 = 1'b1;
		is_dead3 = 1'b0;
		rocket1_disappear = 1'b0;
		rocket2_disappear = 1'b0;
		rocket3_disappear = 1'b1;
		spaceship_disappear = 1'b0;
		draw_explosion2 = 1'b0;
		boss_dead = 1'b0;
	end
	else if(
	(((SpaceshipX + 32) <= MonsterX2) && ((SpaceshipX + 32) >= (MonsterX2 - 25)) && ((SpaceshipY + 32) <= MonsterY2) && (SpaceshipY+32 >= MonsterY2-25)) ||
	
	(((SpaceshipX - 32) <= MonsterX2+25) && ((SpaceshipX - 32) >= MonsterX2) && ((SpaceshipY + 32) <= MonsterY2) && (SpaceshipY+32 >= MonsterY2-25)) ||
	
	(((SpaceshipX + 32) <= MonsterX2) && ((SpaceshipX + 32) >= (MonsterX2 - 25)) && ((SpaceshipY - 32) >= MonsterY2) && (SpaceshipY-32 <= MonsterY2+25)) ||
	
	(((SpaceshipX - 32) <= MonsterX2+25) && ((SpaceshipX - 32) >= MonsterX2) && ((SpaceshipY - 32) <= MonsterY2+25) && (SpaceshipY-32 >= MonsterY2)) ||
	
	((SpaceshipX - 32 <= MonsterX2 + 25) && (SpaceshipX - 32 >= MonsterX2-25) && (SpaceshipY-32 <= MonsterY2-25) && (SpaceshipY+32 >= MonsterY2+25)) ||
	
	((SpaceshipX + 32 <= MonsterX2 + 25) && (SpaceshipX + 32 >= MonsterX2-25) && (SpaceshipY-32 <= MonsterY2-25) && (SpaceshipY+32 >= MonsterY2+25)) ||
	
	((SpaceshipY-32 <= MonsterY2+25) && (SpaceshipY-32 >= MonsterY2-25) && (SpaceshipX+32 >= MonsterX2+25) && (SpaceshipX-32 <= MonsterX2-25)) ||
	
	((SpaceshipY+32 <= MonsterY2+25) && (SpaceshipY+32 >= MonsterY2-25) && (SpaceshipX+32 >= MonsterX2+25) && (SpaceshipX-32 <= MonsterX2-25))
	
	)
	begin
		draw_explosion = 1'b0;
		is_dead = 1'b0;
		is_dead2 = 1'b0;
		is_dead3 = 1'b0;
		rocket1_disappear = 1'b0;
		rocket2_disappear = 1'b0;
		rocket3_disappear = 1'b0;
		spaceship_disappear = 1'b1;
		draw_explosion2 = 1'b1;
		boss_dead = 1'b0;
	end
	
	else if(
	(((SpaceshipX + 32) <= MonsterX) && ((SpaceshipX + 32) >= (MonsterX - 25)) && ((SpaceshipY + 32) <= MonsterY) && (SpaceshipY+32 >= MonsterY-25)) ||
	
	(((SpaceshipX - 32) <= MonsterX+25) && ((SpaceshipX - 32) >= MonsterX) && ((SpaceshipY + 32) <= MonsterY) && (SpaceshipY+32 >= MonsterY-25)) ||
	
	(((SpaceshipX + 32) <= MonsterX) && ((SpaceshipX + 32) >= (MonsterX - 25)) && ((SpaceshipY - 32) >= MonsterY) && (SpaceshipY-32 <= MonsterY+25)) ||
	
	(((SpaceshipX - 32) <= MonsterX+25) && ((SpaceshipX - 32) >= MonsterX) && ((SpaceshipY - 32) <= MonsterY+25) && (SpaceshipY-32 >= MonsterY)) ||
	
	((SpaceshipX - 32 <= MonsterX + 25) && (SpaceshipX - 32 >= MonsterX-25) && (SpaceshipY-32 <= MonsterY-25) && (SpaceshipY+32 >= MonsterY+25)) ||
	
	((SpaceshipX + 32 <= MonsterX + 25) && (SpaceshipX + 32 >= MonsterX-25) && (SpaceshipY-32 <= MonsterY-25) && (SpaceshipY+32 >= MonsterY+25)) ||
	
	((SpaceshipY-32 <= MonsterY+25) && (SpaceshipY-32 >= MonsterY-25) && (SpaceshipX+32 >= MonsterX+25) && (SpaceshipX-32 <= MonsterX-25)) ||
	
	((SpaceshipY+32 <= MonsterY+25) && (SpaceshipY+32 >= MonsterY-25) && (SpaceshipX+32 >= MonsterX+25) && (SpaceshipX-32 <= MonsterX-25))
		
	)
	begin
		draw_explosion = 1'b0;
		is_dead = 1'b0;
		is_dead2 = 1'b0;
		is_dead3 = 1'b0;
		rocket1_disappear = 1'b0;
		rocket2_disappear = 1'b0;
		rocket3_disappear = 1'b0;
		spaceship_disappear = 1'b1;
		draw_explosion2 = 1'b1;
		boss_dead = 1'b0;
	end

//start of 3rd monster collision	
	
	else if((RocketX + 8 <= (MonsterX3+15)) && ((RocketX - 8) >= (MonsterX3 - 15)) && (RocketY - 10 >= (MonsterY3-15)) && (RocketY+10 <= (MonsterY3 + 15)))
	begin 
		draw_explosion = 1'b1;
		is_dead = 1'b0;
		is_dead2 = 1'b0;
		is_dead3 = 1'b1;
		rocket1_disappear = 1'b1;
		rocket2_disappear = 1'b0;
		rocket3_disappear = 1'b0;
		spaceship_disappear = 1'b0;
		draw_explosion2 = 1'b0;
		boss_dead = 1'b0;
	end
	else if((RocketX2 + 8 <= (MonsterX3+15)) && ((RocketX2 - 8) >= (MonsterX3 - 15)) && (RocketY2 - 10 >= (MonsterY3-15)) && (RocketY2+10 <= (MonsterY3 + 15)))
	begin 
		draw_explosion = 1'b1;
		is_dead = 1'b0;
		is_dead2 = 1'b0;
		is_dead3 = 1'b1;
		rocket1_disappear = 1'b0;
		rocket2_disappear = 1'b1;
		rocket3_disappear = 1'b0;
		spaceship_disappear = 1'b0;
		draw_explosion2 = 1'b0;
		boss_dead = 1'b0;
	end
	else if((RocketX3 + 8 <= (MonsterX3+15)) && ((RocketX3 - 8) >= (MonsterX3 - 15)) && (RocketY3 - 10 >= (MonsterY3-15)) && (RocketY3+10 <= (MonsterY3 + 15)))
	begin 
		draw_explosion = 1'b1;
		is_dead = 1'b0;
		is_dead2 = 1'b0;
		is_dead3 = 1'b1;
		rocket1_disappear = 1'b0;
		rocket2_disappear = 1'b0;
		rocket3_disappear = 1'b1;
		spaceship_disappear = 1'b0;
		draw_explosion2 = 1'b0;
		boss_dead = 1'b0;
	end

else if(
	(((SpaceshipX + 32) <= MonsterX3) && ((SpaceshipX + 32) >= (MonsterX3 - 15)) && ((SpaceshipY + 32) <= MonsterY3) && (SpaceshipY+32 >= MonsterY3-15)) ||
	
	(((SpaceshipX - 32) <= MonsterX3+15) && ((SpaceshipX - 32) >= MonsterX3) && ((SpaceshipY + 32) <= MonsterY3) && (SpaceshipY+32 >= MonsterY3-15)) ||
	
	(((SpaceshipX + 32) <= MonsterX3) && ((SpaceshipX + 32) >= (MonsterX3 - 15)) && ((SpaceshipY - 32) >= MonsterY3) && (SpaceshipY-32 <= MonsterY3+15)) ||
	
	(((SpaceshipX - 32) <= MonsterX3+15) && ((SpaceshipX - 32) >= MonsterX3) && ((SpaceshipY - 32) <= MonsterY3+15) && (SpaceshipY-32 >= MonsterY3)) ||
	
	((SpaceshipX - 32 <= MonsterX3 + 15) && (SpaceshipX - 32 >= MonsterX3-15) && (SpaceshipY-32 <= MonsterY3-15) && (SpaceshipY+32 >= MonsterY3+15)) ||
	
	((SpaceshipX + 32 <= MonsterX3 + 15) && (SpaceshipX + 32 >= MonsterX3-15) && (SpaceshipY-32 <= MonsterY3-15) && (SpaceshipY+32 >= MonsterY3+15)) ||
	
	((SpaceshipY-32 <= MonsterY3+15) && (SpaceshipY-32 >= MonsterY3-15) && (SpaceshipX+32 >= MonsterX3+15) && (SpaceshipX-32 <= MonsterX3-15)) ||
	
	((SpaceshipY+32 <= MonsterY3+15) && (SpaceshipY+32 >= MonsterY3-15) && (SpaceshipX+32 >= MonsterX3+15) && (SpaceshipX-32 <= MonsterX3-15))
		
	)
	begin
		draw_explosion = 1'b0;
		is_dead = 1'b0;
		is_dead2 = 1'b0;
		is_dead3 = 1'b0;
		rocket1_disappear = 1'b0;
		rocket2_disappear = 1'b0;
		rocket3_disappear = 1'b0;
		spaceship_disappear = 1'b1;
		draw_explosion2 = 1'b1;
		boss_dead = 1'b0;
	end





	
//Start of boss collision detection	
	else if((RocketX + 8 <= (BossX+30)) && ((RocketX - 8) >= (BossX - 30)) && (RocketY - 10 >= (BossY-30)) && (RocketY+10 <= (BossY + 30)))
	begin
		draw_explosion = 1'b1;
		is_dead = 1'b0;
		is_dead2 = 1'b0;
		is_dead3 = 1'b0;
		rocket1_disappear = 1'b1;
		rocket2_disappear = 1'b0;
		rocket3_disappear = 1'b0;
		spaceship_disappear = 1'b0;
		draw_explosion2 = 1'b0;
		boss_dead = 1'b0;
	end
	else if((RocketX2 + 8 <= (BossX+30)) && ((RocketX2 - 8) >= (BossX - 30)) && (RocketY2 - 10 >= (BossY-30)) && (RocketY2+10 <= (BossY + 30)))
	begin 
		draw_explosion = 1'b1;
		is_dead = 1'b0;
		is_dead2 = 1'b0;
		is_dead3 = 1'b0;
		rocket1_disappear = 1'b0;
		rocket2_disappear = 1'b1;
		rocket3_disappear = 1'b0;
		spaceship_disappear = 1'b0;
		draw_explosion2 = 1'b0;
		boss_dead = 1'b0;
	end
	else if((RocketX3 + 8 <= (BossX+30)) && ((RocketX3 - 8) >= (BossX - 30)) && (RocketY3 - 10 >= (BossY-30)) && (RocketY3+10 <= (BossY + 30)))
	begin 
		draw_explosion = 1'b1;
		is_dead = 1'b0;
		is_dead2 = 1'b0;
		is_dead3 = 1'b0;
		rocket1_disappear = 1'b0;
		rocket2_disappear = 1'b0;
		rocket3_disappear = 1'b1;
		spaceship_disappear = 1'b0;
		draw_explosion2 = 1'b0;
		boss_dead = 1'b0;
	end
	
	else if(
	(((SpaceshipX + 32) <= BossX) && ((SpaceshipX + 32) >= (BossX - 30)) && ((SpaceshipY + 32) <= BossY) && (SpaceshipY+32 >= BossY-30)) ||
	
	(((SpaceshipX - 32) <= BossX+30) && ((SpaceshipX - 32) >= BossX) && ((SpaceshipY + 32) <= BossY) && (SpaceshipY+32 >= BossY-30)) ||
	
	(((SpaceshipX + 32) <= BossX) && ((SpaceshipX + 32) >= (BossX - 30)) && ((SpaceshipY - 32) >= BossY) && (SpaceshipY-32 <= BossY+30)) ||
	
	(((SpaceshipX - 32) <= BossX+30) && ((SpaceshipX - 32) >= BossX) && ((SpaceshipY - 32) <= BossY+30) && (SpaceshipY-32 >= BossY)) ||
	
	((SpaceshipX - 32 <= BossX + 30) && (SpaceshipX - 32 >= BossX-30) && (SpaceshipY-32 <= BossY-30) && (SpaceshipY+32 >= BossY+30)) ||
	
	((SpaceshipX + 32 <= BossX + 30) && (SpaceshipX + 32 >= BossX-30) && (SpaceshipY-32 <= BossY-30) && (SpaceshipY+32 >= BossY+30)) ||
	
	((SpaceshipY-32 <= BossY+30) && (SpaceshipY-32 >= BossY-30) && (SpaceshipX+32 >= BossX+30) && (SpaceshipX-32 <= BossX-30)) ||
	
	((SpaceshipY+32 <= BossY+30) && (SpaceshipY+32 >= BossY-30) && (SpaceshipX+32 >= BossX+30) && (SpaceshipX-32 <= BossX-30)) && draw_game_over == 1'b0
		
	)
	begin
		draw_explosion = 1'b0;
		is_dead = 1'b0;
		is_dead2 = 1'b0;
		is_dead3 = 1'b0;
		rocket1_disappear = 1'b0;
		rocket2_disappear = 1'b0;
		rocket3_disappear = 1'b0;
		spaceship_disappear = 1'b1;
		draw_explosion2 = 1'b1;
		boss_dead = 1'b0;
	end
		
	else
	begin
		draw_explosion = 1'b0;
		is_dead = 1'b0;
		is_dead2 = 1'b0;
		is_dead3 = 1'b0;		
		rocket1_disappear = 1'b0;
		rocket2_disappear = 1'b0;
		rocket3_disappear = 1'b0;
		spaceship_disappear = 1'b0;
		draw_explosion2 = 1'b0;
		boss_dead = 1'b0;
	end

end

endmodule
