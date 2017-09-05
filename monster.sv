//-------------------------------------------------------------------------
//    Monster.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  03-03-2017                               --
//    Spring 2017 Distribution                                           --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  Monster ( input         Reset, 
                             frame_clk,          // The clock indicating a new frame (~60Hz)
					input [7:0]   keycode,
               input 		  is_dead, is_dead2, is_dead3, boss_dead, draw_level1, draw_level2, draw_level3, set_motion_1, set_motion_2, set_motion_3,
					output [9:0]  MonsterX, MonsterY, MonsterX2, MonsterY2, MonsterX3, MonsterY3, BossX, BossY // Monster coordinates and size
              );
    
    logic [9:0] Monster_X_Pos, Monster_X_Motion, Monster_Y_Pos, Monster_Y_Motion;
    logic [9:0] Monster_X_Pos_in, Monster_X_Motion_in, Monster_Y_Pos_in, Monster_Y_Motion_in;
    logic [9:0] Monster_X2_Pos, Monster_X2_Motion, Monster_Y2_Pos, Monster_Y2_Motion;
    logic [9:0] Monster_X2_Pos_in, Monster_X2_Motion_in, Monster_Y2_Pos_in, Monster_Y2_Motion_in;
    
	 logic [9:0] Monster_X3_Pos, Monster_X3_Motion, Monster_Y3_Pos, Monster_Y3_Motion;
    logic [9:0] Monster_X3_Pos_in, Monster_X3_Motion_in, Monster_Y3_Pos_in, Monster_Y3_Motion_in;
    
	 logic [9:0] Boss_X_Pos, Boss_X_Motion, Boss_Y_Pos, Boss_Y_Motion;
    logic [9:0] Boss_X_Pos_in, Boss_X_Motion_in, Boss_Y_Pos_in, Boss_Y_Motion_in;
    
	 
    parameter [9:0] Monster_X_Center = 400;  // Center position on the X axis
    parameter [9:0] Monster_Y_Center = 200;  // Center position on the Y axis
    parameter [9:0] Monster_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Monster_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Monster_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Monster_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Monster_X_Step=2;      // Step size on the X axis
    parameter [9:0] Monster_Y_Step=2;      // Step size on the Y axis

    parameter [9:0] Monster_X2_Center = 200;  // Center position on the X axis
    parameter [9:0] Monster_Y2_Center = 100;  // Center position on the Y axis
    parameter [9:0] Monster_X2_Step=1;      // Step size on the X axis
    parameter [9:0] Monster_Y2_Step=1;      // Step size on the Y axis

    parameter [9:0] Boss_X_Center = 320;  // Center position on the X axis
    parameter [9:0] Boss_Y_Center = 100;  // Center position on the Y axis
    parameter [9:0] Boss_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Boss_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Boss_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Boss_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Boss_X_Step=6;      // Step size on the X axis
    parameter [9:0] Boss_Y_Step=6;      // Step size on the Y axis

    parameter [9:0] Monster_X3_Center = 320;  // Center position on the X axis
    parameter [9:0] Monster_Y3_Center = 100;  // Center position on the Y axis
    parameter [9:0] Monster_X3_Step=2;      // Step size on the X axis
    parameter [9:0] Monster_Y3_Step=2;      // Step size on the Y axis


    
	 assign MonsterX = Monster_X_Pos;
    assign MonsterY = Monster_Y_Pos;
 	 
	 assign MonsterX2 = Monster_X2_Pos;
    assign MonsterY2 = Monster_Y2_Pos;
 	 
	 assign MonsterX3 = Monster_X3_Pos;
    assign MonsterY3 = Monster_Y3_Pos;
 	 
	 assign BossX = Boss_X_Pos;
	 assign BossY = Boss_Y_Pos;
	     
	 always_ff @ (posedge frame_clk)
    begin
        if (Reset)
        begin
            Monster_X_Pos <= Monster_X_Center;
            Monster_Y_Pos <= Monster_Y_Center;
            Monster_X_Motion <= 10'd0;
            Monster_Y_Motion <= 10'd0;
            
				Monster_X2_Pos <= Monster_X2_Center;
            Monster_Y2_Pos <= Monster_Y2_Center;
            Monster_X2_Motion <= 10'd0;
            Monster_Y2_Motion <= 10'd0;
				
				Monster_X3_Pos <= Monster_X3_Center;
            Monster_Y3_Pos <= Monster_Y3_Center;
            Monster_X3_Motion <= 10'd0;
            Monster_Y3_Motion <= 10'd0;            
				
				Boss_X_Pos <= Boss_X_Center;
            Boss_Y_Pos <= Boss_Y_Center;
            Boss_X_Motion <= 10'd0;
            Boss_Y_Motion <= 10'd0;

        end
        else 
        begin
            Monster_X_Pos <= Monster_X_Pos_in;				//Set Monster position and motion
            Monster_Y_Pos <= Monster_Y_Pos_in;
            Monster_X_Motion <= Monster_X_Motion_in;
            Monster_Y_Motion <= Monster_Y_Motion_in;

            Monster_X2_Pos <= Monster_X2_Pos_in;				//Set Monster position and motion
            Monster_Y2_Pos <= Monster_Y2_Pos_in;
            Monster_X2_Motion <= Monster_X2_Motion_in;
            Monster_Y2_Motion <= Monster_Y2_Motion_in;

            Monster_X3_Pos <= Monster_X3_Pos_in;				//Set Monster position and motion
            Monster_Y3_Pos <= Monster_Y3_Pos_in;
            Monster_X3_Motion <= Monster_X3_Motion_in;
            Monster_Y3_Motion <= Monster_Y3_Motion_in;

				Boss_X_Pos <= Boss_X_Pos_in;				//Set Monster position and motion
            Boss_Y_Pos <= Boss_Y_Pos_in;
            Boss_X_Motion <= Boss_X_Motion_in;
            Boss_Y_Motion <= Boss_Y_Motion_in;					
		  end
    end
/*    
	 initial 
	 begin
		  Monster_X_Pos = Monster_X_Center;
		  Monster_Y_Pos = Monster_Y_Center;
		  Monster_X2_Pos = Monster_X2_Center;
		  Monster_Y2_Pos = Monster_Y2_Center;
		  Monster_X_Motion = (~(Monster_X_Step) + 1'b1);
		  Monster_X2_Motion = (~(Monster_X2_Step) + 1'b1);

		  Boss_X_Pos = Boss_X_Center;
		  Boss_Y_Pos = Boss_Y_Center;
		  Boss_X_Motion = (~(Boss_X_Step) + 1'b1);

	 end
*/	 
    always_comb
    begin
        // By default, keep motion unchanged      
        // Update the Monster's position with its motion
		  Monster_X_Pos_in = Monster_X_Pos + Monster_X_Motion;
        Monster_Y_Pos_in = Monster_Y_Pos + Monster_Y_Motion;
		  Monster_Y_Motion_in = 10'b0;
		  Monster_X_Motion_in = Monster_X_Motion;
		if(draw_level1 == 1'b1) begin
        
		  if(set_motion_1 == 1'b1) begin
				Monster_X_Pos_in = Monster_X_Center;
				Monster_Y_Pos_in = Monster_Y_Center;
				Monster_Y_Motion_in = 10'b0;
				Monster_X_Motion_in = (~(Monster_X_Step) + 1'b1);
		  end
		  
		  else if(is_dead == 1'b1) 
		  begin
				Monster_X_Pos_in = 700;
				Monster_Y_Pos_in = 520;
				Monster_X_Motion_in = 10'b0;
		  end
		  
		  else if((Monster_X_Pos <= Monster_X_Min + 25) && is_dead == 1'b0)  // Monster is at the leftmost edge, BOUNCE!
				begin
				Monster_Y_Motion_in = 10'b0;						//Set opposite direction to zero to ensure no diagonal bouncing
				Monster_X_Motion_in = Monster_X_Step;  
				end
		  else if ( (Monster_X_Pos + 25 >= Monster_X_Max) && is_dead == 1'b0)  // Monster is at the rightmost edge, BOUNCE!
				begin
				Monster_Y_Motion_in = 10'b0;					//Set opposite direction to zero to ensure no diagonal bouncing
				Monster_X_Motion_in = (~(Monster_X_Step) + 1'b1);
				end
		end
		
		else begin
				Monster_X_Motion_in = 10'b0;
				Monster_Y_Motion_in = 10'b0;
				Monster_X_Pos_in = 700;
				Monster_Y_Pos_in = 520;
		end
    end

	 always_comb
    begin
		  // By default, keep motion unchanged      
        // Update the Monster's position with its motion
        Monster_X2_Pos_in = Monster_X2_Pos + Monster_X2_Motion;
        Monster_Y2_Pos_in = Monster_Y2_Pos + Monster_Y2_Motion;
		  Monster_Y2_Motion_in = 10'b0;
		  Monster_X2_Motion_in = Monster_X2_Motion;
		if(draw_level1 == 1'b1) begin
      
			if(set_motion_1 == 1'b1) begin
				Monster_X2_Pos_in = Monster_X2_Center;
				Monster_Y2_Pos_in = Monster_Y2_Center;
				Monster_Y2_Motion_in = 10'b0;
				Monster_X2_Motion_in = (~(Monster_X2_Step) + 1'b1);
		   end
		
		
		  else if(is_dead2 == 1'b1) 
		  begin
				Monster_X2_Pos_in = 700;
				Monster_Y2_Pos_in = 520;
				Monster_X2_Motion_in = 10'b0;
		  end
		  
		  else if((Monster_X2_Pos <= Monster_X_Min + 25) && is_dead2 == 1'b0)  // Monster is at the leftmost edge, BOUNCE!
				begin
				Monster_Y2_Motion_in = 10'b0;						//Set opposite direction to zero to ensure no diagonal bouncing
				Monster_X2_Motion_in = Monster_X2_Step;  
				end
		  else if ( (Monster_X2_Pos + 25 >= Monster_X_Max) && is_dead2 == 1'b0)  // Monster is at the rightmost edge, BOUNCE!
				begin
				Monster_Y2_Motion_in = 10'b0;					//Set opposite direction to zero to ensure no diagonal bouncing
				Monster_X2_Motion_in = (~(Monster_X2_Step) + 1'b1);
				end
	    end
		 else begin
				Monster_X2_Motion_in = 10'b0;
				Monster_Y2_Motion_in = 10'b0;
				Monster_X2_Pos_in = 700;
				Monster_Y2_Pos_in = 520;
		end
    end

    always_comb
    begin
		  // By default, keep motion unchanged      
        // Update the Monster's position with its motion
        Boss_X_Pos_in = Boss_X_Pos + Boss_X_Motion;
        Boss_Y_Pos_in = Boss_Y_Pos + Boss_Y_Motion;
		  Boss_Y_Motion_in = 10'b0;
		  Boss_X_Motion_in = Boss_X_Motion;
		if(draw_level3 == 1'b1) begin
      
		  if(set_motion_3 == 1'b1) begin
				Boss_X_Pos_in = Boss_X_Center;
				Boss_Y_Pos_in = Boss_Y_Center;
				Boss_Y_Motion_in = 10'b0;
				Boss_X_Motion_in = (~(Boss_X_Step) + 1'b1);
		  end
		
		  else if(boss_dead == 1'b1) 
		  begin
				Boss_X_Pos_in = 700;
				Boss_Y_Pos_in = 520;
				Boss_X_Motion_in = 10'b0;
		  end
		  
		  else if((Boss_X_Pos <= Boss_X_Min + 30) && boss_dead == 1'b0)  // Monster is at the leftmost edge, BOUNCE!
				begin
				Boss_Y_Motion_in = 10'b0;						//Set opposite direction to zero to ensure no diagonal bouncing
				Boss_X_Motion_in = Boss_X_Step;  
				end
		  else if ( (Boss_X_Pos + 30 >= Boss_X_Max) && boss_dead == 1'b0)  // Monster is at the rightmost edge, BOUNCE!
				begin
				Boss_Y_Motion_in = 10'b0;					//Set opposite direction to zero to ensure no diagonal bouncing
				Boss_X_Motion_in = (~(Boss_X_Step) + 1'b1);
				end
		end
		else begin
				Boss_X_Motion_in = 10'b0;
				Boss_Y_Motion_in = 10'b0;
				Boss_X_Pos_in = 700;
				Boss_Y_Pos_in = 520;
		end
	 end

//3rd Monster
    
always_comb
    begin
        // By default, keep motion unchanged      
        // Update the Monster's position with its motion
		  Monster_X3_Pos_in = Monster_X3_Pos + Monster_X3_Motion;
        Monster_Y3_Pos_in = Monster_Y3_Pos + Monster_Y3_Motion;
		  Monster_Y3_Motion_in = Monster_Y3_Motion;
		  Monster_X3_Motion_in = Monster_X3_Motion;
		if(draw_level2 == 1'b1) begin
        
		  if(set_motion_2 == 1'b1) begin
				Monster_X3_Pos_in = Monster_X3_Center;
				Monster_Y3_Pos_in = Monster_Y3_Center;
				Monster_Y3_Motion_in = (~(Monster_Y3_Step) + 1'b1);
				Monster_X3_Motion_in = (~(Monster_X3_Step) + 1'b1);
		  end
		  
		  else if(is_dead3 == 1'b1) 
		  begin
				Monster_X3_Pos_in = 700;
				Monster_Y3_Pos_in = 520;
				Monster_X3_Motion_in = 10'b0;
		  end
		  
		  else if((Monster_X3_Pos <= Monster_X_Min + 15) && is_dead3 == 1'b0)  // Monster is at the leftmost edge, BOUNCE!
				begin
				Monster_Y3_Motion_in = Monster_Y3_Motion;					//Set opposite direction to zero to ensure no diagonal bouncing
				Monster_X3_Motion_in = Monster_X3_Step;  
				end
		  else if ( (Monster_X3_Pos + 15 >= Monster_X_Max) && is_dead3 == 1'b0)  // Monster is at the rightmost edge, BOUNCE!
				begin
				Monster_Y3_Motion_in = Monster_Y3_Motion;					//Set opposite direction to zero to ensure no diagonal bouncing
				Monster_X3_Motion_in = (~(Monster_X3_Step) + 1'b1);
				end
		  else if( (Monster_Y3_Pos + 15 >= Monster_Y_Max)  && is_dead3 == 1'b0)   // Ball is at the bottom edge, BOUNCE!
            begin
				Monster_X3_Motion_in = Monster_X3_Motion;    //Set opposite direction to zero to ensure no diagonal bouncing
				Monster_Y3_Motion_in = (~(Monster_Y3_Step) + 1'b1);  // 2's complement.
				end
		  else if ( (Monster_Y3_Pos <= Monster_Y_Min + 15) && is_dead3 == 1'b0)  // Ball is at the top edge, BOUNCE!
				begin
				Monster_X3_Motion_in = Monster_X3_Motion;					//Set opposite direction to zero to ensure no diagonal bouncing
				Monster_Y3_Motion_in = Monster_Y3_Step;
				end

		end
		
		else begin
				Monster_X3_Motion_in = 10'b0;
				Monster_Y3_Motion_in = 10'b0;
				Monster_X3_Pos_in = 700;
				Monster_Y3_Pos_in = 520;
		end
    end

    
endmodule
