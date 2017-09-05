//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Modified by Po-Han Huang  03-03-2017                               --
//                                                                       --
//    Spring 2017 Distribution                                           --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input [7:0] color,
							  output logic [7:0] VGA_R, VGA_G, VGA_B // VGA RGB output
                     );
    
    
    //logic sprite_on, rocket_on, monster_on, destroy_on;
    logic [7:0] Red, Green, Blue;//, spriteRed, spriteBlue, spriteGreen, sprite;
    
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;

	 ColorTable 	Color	(
				.color(color),
				._Red(Red),
				._Green(Green),
				._Blue(Blue)
	);


endmodule
