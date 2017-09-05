module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
			// This is the amount of time represented by #1 
timeprecision 1ns;

	 logic Reset, Clk, spaceship_disappear, draw_explosion;
	 logic [9:0] MONSTER_X, MONSTER_X2, MONSTER_Y, MONSTER_Y2, MONSTER_X3, MONSTER_Y3;
	 logic [7:0] keycode;
	 logic draw_level1, draw_level2, draw_level3, draw_victory, draw_game_over, draw_start, set_motion_1, set_motion_2, set_motion_3;


StateMachine state (
	.*
);

always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end
	
initial begin: CLOCK_INITIALIZATION
    Clk = 0;
end 


initial begin: Test_Vector
	/*
				draw_start = 1'b0;
			draw_level1 = 1'b0;
			draw_level2 = 1'b0;
			draw_level3 = 1'b0;
			draw_game_over = 1'b0;
			draw_victory = 1'b0;
			set_motion_1 = 1'b0;
			set_motion_2 = 1'b0;
			set_motion_3 = 1'b0;
			*/
#2 Reset = 0;
#2 Reset = 1;
#2 Reset = 0;
#2 keycode = 8'h00;
#2 draw_explosion = 1'b0;

#2	keycode = 8'h2C;

#2	keycode = 8'h00;


//Kill first monster
#2 draw_explosion = 1'b1;

#2 draw_explosion = 1'b0;

#2 draw_explosion = 1'b1;

#2 draw_explosion = 1'b0;

//Now in level 2
#2 draw_explosion = 1'b1;

#2 draw_explosion = 1'b0;

//Boss level
#2 draw_explosion = 1'b1;

#2 draw_explosion = 1'b0;

#2 draw_explosion = 1'b1;

#2 draw_explosion = 1'b0;

#2 draw_explosion = 1'b1;

#2 draw_explosion = 1'b0;
	
end


endmodule
