//-------------------------------------------------------------------------
//    Ball.sv                                                            --
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


module  ball ( input         Reset, 
                             frame_clk,          // The clock indicating a new frame (~60Hz)
									  spaceship_disappear,
									  set_motion_1,
					input [7:0]   keycode,
               output [9:0]  BallX, BallY // Ball coordinates and size
              );
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion;
    logic [9:0] Ball_X_Pos_in, Ball_X_Motion_in, Ball_Y_Pos_in, Ball_Y_Motion_in;
     
    parameter [9:0] Ball_X_Center=380;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=350;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=5;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=5;      // Step size on the Y axis
    //parameter [9:0] Ball_Size=50;        // Ball size
    
    assign BallX = Ball_X_Pos;
    assign BallY = Ball_Y_Pos;
    //assign BallS = Ball_Size;
    
    always_ff @ (posedge frame_clk)
    begin
        if (Reset)
        begin
            Ball_X_Pos <= Ball_X_Center;
            Ball_Y_Pos <= Ball_Y_Center;
            Ball_X_Motion <= 10'd0;
            Ball_Y_Motion <= 10'd0;
        end
        else 
        begin
            Ball_X_Pos <= Ball_X_Pos_in;				//Set ball position and motion
            Ball_Y_Pos <= Ball_Y_Pos_in;
            Ball_X_Motion <= Ball_X_Motion_in;
            Ball_Y_Motion <= Ball_Y_Motion_in;
        end
    end
    
    always_comb
    begin
        // By default, keep motion unchanged      
        // Update the ball's position with its motion
        Ball_X_Pos_in = Ball_X_Pos + Ball_X_Motion;
        Ball_Y_Pos_in = Ball_Y_Pos + Ball_Y_Motion;
			if(set_motion_1 == 1'b1)
			begin
				Ball_X_Pos_in = Ball_X_Center;
				Ball_Y_Pos_in = Ball_Y_Center;
				Ball_X_Motion_in = 10'h00;
				Ball_Y_Motion_in = 10'h00;
			end

		  	//A = x04;
			//S = x16;
			//D = x07;
			//W = x1A;
		  if(spaceship_disappear == 1'b1)
		  begin
				Ball_X_Motion_in = 10'b0;
				Ball_Y_Motion_in = 10'b0;
				Ball_X_Pos_in = 720;
				Ball_Y_Pos_in = 540;
		  end
		  else if(keycode == 8'h1A && spaceship_disappear == 1'b0) begin //UP
				Ball_X_Motion_in = 10'b0;		//Set opposite direction to zero to ensure no diagonal bouncing
				Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1); //Because going up goes against the normal direction of the VGA monitor, must use 2's complement
				end
		  else if(keycode == 8'h04 && spaceship_disappear == 1'b0) begin //LEFT
				Ball_Y_Motion_in = 10'b0;		//Set opposite direction to zero to ensure no diagonal bouncing
				Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1); //Because going left goes against the normal direction of the VGA monitor, must use 2's complement
				end
		  else if(keycode == 8'h07 && spaceship_disappear == 1'b0) begin //RIGHT
				Ball_Y_Motion_in = 10'b0;		//Set opposite direction to zero to ensure no diagonal bouncing
				Ball_X_Motion_in = Ball_X_Step;
				end
		  else if(keycode == 8'h16 && spaceship_disappear == 1'b0) begin //DOWN
				Ball_X_Motion_in = 10'b0;		//Set opposite direction to zero to ensure no diagonal bouncing
				Ball_Y_Motion_in = Ball_Y_Step;
				end
			else begin
				Ball_X_Motion_in = 10'b0;	//Set default motion to stop moving
				Ball_Y_Motion_in = 10'b0;
	  		end

        // Be careful when using comparators with "logic" datatype becuase compiler treats 
        //   both sides of the operator UNSIGNED numbers. (unless with further type casting)
        // e.g. Ball_Y_Pos - Ball_Size <= Ball_Y_Min 
        // If Ball_Y_Pos is 0, then Ball_Y_Pos - Ball_Size will not be -4, but rather a large positive number.
        if( (Ball_Y_Pos + 32 >= Ball_Y_Max) && spaceship_disappear == 1'b0)   // Ball is at the bottom edge, BOUNCE!
            begin
				Ball_X_Motion_in = 10'b0;    //Set opposite direction to zero to ensure no diagonal bouncing
				Ball_Y_Motion_in = (~(Ball_Y_Step) + 1'b1);  // 2's complement.
				end
		  else if ( (Ball_Y_Pos <= Ball_Y_Min + 32) && spaceship_disappear == 1'b0)  // Ball is at the top edge, BOUNCE!
				begin
				Ball_X_Motion_in = 10'b0;					//Set opposite direction to zero to ensure no diagonal bouncing
				Ball_Y_Motion_in = Ball_Y_Step;
				end
		  else if((Ball_X_Pos <= Ball_X_Min + 32) && spaceship_disappear == 1'b0)  // Ball is at the leftmost edge, BOUNCE!
				begin
				Ball_Y_Motion_in = 10'b0;						//Set opposite direction to zero to ensure no diagonal bouncing
				Ball_X_Motion_in = Ball_X_Step;  
				end
		  else if ( (Ball_X_Pos + 32 >= Ball_X_Max) && spaceship_disappear == 1'b0)  // Ball is at the rightmost edge, BOUNCE!
				begin
				Ball_Y_Motion_in = 10'b0;					//Set opposite direction to zero to ensure no diagonal bouncing
				Ball_X_Motion_in = (~(Ball_X_Step) + 1'b1);
				end
        
    end
    
endmodule
