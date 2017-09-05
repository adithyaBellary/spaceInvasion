//-------------------------------------------------------------------------
//    Rocket.sv                                                            --
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


module  Rocket ( input         Reset, 
                             frame_clk,          // The clock indicating a new frame (~60Hz)
									  rocket1_disappear, rocket2_disappear, rocket3_disappear,
					input [7:0]   keycode,
					input [9:0]   BallX, BallY,
               output [9:0]  RocketX, RocketY, RocketX2, RocketY2, RocketX3, RocketY3 // Rocket coordinates and size
              );
    
    logic [9:0] Rocket_X_Pos, Rocket_X_Motion, Rocket_Y_Pos, Rocket_Y_Motion;
    logic [9:0] Rocket_X_Pos_in, Rocket_X_Motion_in, Rocket_Y_Pos_in, Rocket_Y_Motion_in;

    logic [9:0] Rocket_X2_Pos, Rocket_X2_Motion, Rocket_Y2_Pos, Rocket_Y2_Motion;
    logic [9:0] Rocket_X2_Pos_in, Rocket_X2_Motion_in, Rocket_Y2_Pos_in, Rocket_Y2_Motion_in;

    logic [9:0] Rocket_X3_Pos, Rocket_X3_Motion, Rocket_Y3_Pos, Rocket_Y3_Motion;
    logic [9:0] Rocket_X3_Pos_in, Rocket_X3_Motion_in, Rocket_Y3_Pos_in, Rocket_Y3_Motion_in;
	  
    parameter [9:0] Rocket_X_Center = 650;  // Center position on the X axis
    parameter [9:0] Rocket_Y_Center = 490;  // Center position on the Y axis
    parameter [9:0] Rocket_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Rocket_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Rocket_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Rocket_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Rocket_X_Step=0;      // Step size on the X axis
    parameter [9:0] Rocket_Y_Step=3;      // Step size on the Y axis

    parameter [9:0] Rocket_X2_Center = 650;  // Center position on the X axis
    parameter [9:0] Rocket_Y2_Center = 490;  // Center position on the Y axis
    parameter [9:0] Rocket_X2_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Rocket_X2_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Rocket_Y2_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Rocket_Y2_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Rocket_X2_Step=0;      // Step size on the X axis
    parameter [9:0] Rocket_Y2_Step=3;      // Step size on the Y axis
    
    parameter [9:0] Rocket_X3_Center = 650;  // Center position on the X axis
    parameter [9:0] Rocket_Y3_Center = 490;  // Center position on the Y axis
    parameter [9:0] Rocket_X3_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Rocket_X3_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Rocket_Y3_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Rocket_Y3_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Rocket_X3_Step=0;      // Step size on the X axis
    parameter [9:0] Rocket_Y3_Step=3;      // Step size on the Y axis
	 
	 assign RocketX = Rocket_X_Pos;
    assign RocketY = Rocket_Y_Pos;
    
	 assign RocketX2 = Rocket_X2_Pos;
    assign RocketY2 = Rocket_Y2_Pos;
    
	 assign RocketX3 = Rocket_X3_Pos;
    assign RocketY3 = Rocket_Y3_Pos;
    
	 
	 initial
	 begin
		Rocket_X_Pos = Rocket_X_Center;
		Rocket_Y_Pos = Rocket_Y_Center;
		Rocket_X2_Pos = Rocket_X2_Center;
		Rocket_Y2_Pos = Rocket_Y2_Center;
		Rocket_X3_Pos = Rocket_X3_Center;
		Rocket_Y3_Pos = Rocket_Y3_Center;
	end
	 
    always_ff @ (posedge frame_clk)
    begin
        if (Reset)
        begin
            Rocket_X_Pos <= Rocket_X_Center;
            Rocket_Y_Pos <= Rocket_Y_Center;
            Rocket_X_Motion <= 10'd0;
            Rocket_Y_Motion <= 10'd0;
				
            Rocket_X2_Pos <= Rocket_X2_Center;
            Rocket_Y2_Pos <= Rocket_Y2_Center;
            Rocket_X2_Motion <= 10'd0;
            Rocket_Y2_Motion <= 10'd0;
            
				Rocket_X3_Pos <= Rocket_X3_Center;
            Rocket_Y3_Pos <= Rocket_Y3_Center;
            Rocket_X3_Motion <= 10'd0;
            Rocket_Y3_Motion <= 10'd0;
				
        end
        else 
        begin
            Rocket_X_Pos <= Rocket_X_Pos_in;				//Set Rocket position and motion
            Rocket_Y_Pos <= Rocket_Y_Pos_in;
            Rocket_X_Motion <= Rocket_X_Motion_in;
            Rocket_Y_Motion <= Rocket_Y_Motion_in;

            Rocket_X2_Pos <= Rocket_X2_Pos_in;				//Set Rocket position and motion
            Rocket_Y2_Pos <= Rocket_Y2_Pos_in;
            Rocket_X2_Motion <= Rocket_X2_Motion_in;
            Rocket_Y2_Motion <= Rocket_Y2_Motion_in;

            Rocket_X3_Pos <= Rocket_X3_Pos_in;				//Set Rocket position and motion
            Rocket_Y3_Pos <= Rocket_Y3_Pos_in;
            Rocket_X3_Motion <= Rocket_X3_Motion_in;
            Rocket_Y3_Motion <= Rocket_Y3_Motion_in;
		  end
    end
    
    always_comb
    begin
        // By default, keep motion unchanged      
        // Update the Rocket's position with its motion
        Rocket_X_Pos_in = Rocket_X_Pos + Rocket_X_Motion;
        Rocket_Y_Pos_in = Rocket_Y_Pos + Rocket_Y_Motion;
		  Rocket_X_Motion_in = 10'b0;	//Set default motion to stop moving in X, continue previous Y motion
		  Rocket_Y_Motion_in = Rocket_Y_Motion;
		  //SPACE BAR = 0x2C;

		  if(rocket1_disappear == 1'b1)
		  begin
				Rocket_X_Pos_in = Rocket_X_Center;
				Rocket_Y_Pos_in = Rocket_Y_Center;
				Rocket_X_Motion_in = 10'b0;
				Rocket_Y_Motion_in = 10'b0;
		  end
			else if(keycode == 8'h2c) begin //UP
				Rocket_X_Pos_in = BallX;
				Rocket_Y_Pos_in = BallY;
				Rocket_X_Motion_in = 10'b0;		//Set opposite direction to zero to ensure no diagonal bouncing
				Rocket_Y_Motion_in = (~(Rocket_Y_Step) + 1'b1); //Because going up goes against the normal direction of the VGA monitor, must use 2's complement
			end
			
			else if ( Rocket_Y_Pos >= Rocket_Y_Max )  // Rocket is off the screen, set motion to zero until called again!
			begin
				Rocket_Y_Motion_in = 10'b0;
				//Rocket_X_Pos_in = Rocket_X_Center;
				//Rocket_Y_Pos_in = Rocket_Y_Center;
			end
		end
			
	always_comb
	begin

        Rocket_X2_Pos_in = Rocket_X2_Pos + Rocket_X2_Motion;
        Rocket_Y2_Pos_in = Rocket_Y2_Pos + Rocket_Y2_Motion;
		  Rocket_X2_Motion_in = 10'b0;	//Set default motion to stop moving in X, continue previous Y motion
		  Rocket_Y2_Motion_in = Rocket_Y2_Motion;

		  if(rocket2_disappear == 1'b1)
		  begin
				Rocket_X2_Pos_in = Rocket_X_Center;
				Rocket_Y2_Pos_in = Rocket_Y_Center;
				Rocket_X2_Motion_in = 10'b0;
				Rocket_Y2_Motion_in = 10'b0;
		  end
			else if(keycode == 8'h05) begin //UP
				Rocket_X2_Pos_in = BallX;
				Rocket_Y2_Pos_in = BallY;
				Rocket_X2_Motion_in = 10'b0;		//Set opposite direction to zero to ensure no diagonal bouncing
				Rocket_Y2_Motion_in = (~(Rocket_Y2_Step) + 1'b1); //Because going up goes against the normal direction of the VGA monitor, must use 2's complement
			end
			
			else if ( Rocket_Y2_Pos >= Rocket_Y2_Max )  // Rocket is off the screen, set motion to zero until called again!
			begin
				Rocket_Y2_Motion_in = 10'b0;
				//Rocket_X2_Pos_in = Rocket_X2_Center;
				//Rocket_Y2_Pos_in = Rocket_Y2_Center;
			end
		end
	always_comb
	begin
      Rocket_X3_Pos_in = Rocket_X3_Pos + Rocket_X3_Motion;
      Rocket_Y3_Pos_in = Rocket_Y3_Pos + Rocket_Y3_Motion;
		Rocket_X3_Motion_in = 10'b0;	//Set default motion to stop moving in X, continue previous Y motion
		Rocket_Y3_Motion_in = Rocket_Y3_Motion;
				
				
		  if(rocket3_disappear == 1'b1)
		  begin
				Rocket_X3_Pos_in = Rocket_X_Center;
				Rocket_Y3_Pos_in = Rocket_Y_Center;
				Rocket_X3_Motion_in = 10'b0;
				Rocket_Y3_Motion_in = 10'b0;
		  end				
		else if(keycode == 8'h19) begin //UP
				Rocket_X3_Pos_in = BallX;
				Rocket_Y3_Pos_in = BallY;
				Rocket_X3_Motion_in = 10'b0;		//Set opposite direction to zero to ensure no diagonal bouncing
				Rocket_Y3_Motion_in = (~(Rocket_Y3_Step) + 1'b1); //Because going up goes against the normal direction of the VGA monitor, must use 2's complement
			end
		else if ( Rocket_Y3_Pos >= Rocket_Y3_Max )  // Rocket is off the screen, set motion to zero until called again!
			begin
				Rocket_Y3_Motion_in = 10'b0;
				//Rocket_X3_Pos_in = Rocket_X3_Center;
				//Rocket_Y3_Pos_in = Rocket_Y3_Center;
			end
    end
    
endmodule
