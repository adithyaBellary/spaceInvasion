//-------------------------------------------------------------------------
//      lab7_usb.sv                                                      --
//      Christine Chen                                                   --
//      Fall 2014                                                        --
//                                                                       --
//      Fall 2014 Distribution                                           --
//                                                                       --
//      For use with ECE 385 Lab 7                                       --
//      UIUC ECE Department                                              --
//-------------------------------------------------------------------------


module lab8( input               CLOCK_50,
             input        [3:0]  KEY,          //bit 0 is set up as Reset
             output logic [6:0]  HEX0, HEX1,
             // VGA Interface 
             output logic [7:0]  VGA_R,        //VGA Red
                                 VGA_G,        //VGA Green
                                 VGA_B,        //VGA Blue
             output logic        VGA_CLK,      //VGA Clock
                                 VGA_SYNC_N,   //VGA Sync signal
                                 VGA_BLANK_N,  //VGA Blank signal
                                 VGA_VS,       //VGA vertical sync signal
                                 VGA_HS,       //VGA horizontal sync signal
             // CY7C67200 Interface
             inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
				 
             output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
             output logic        OTG_CS_N,     //CY7C67200 Chip Select
                                 OTG_RD_N,     //CY7C67200 Write
                                 OTG_WR_N,     //CY7C67200 Read
                                 OTG_RST_N,    //CY7C67200 Reset
											
             
             // SDRAM Interface for Nios II Software
             output logic [12:0] DRAM_ADDR,    //SDRAM Address 13 Bits
             inout  wire  [31:0] DRAM_DQ,      //SDRAM Data 32 Bits
             output logic [1:0]  DRAM_BA,      //SDRAM Bank Address 2 Bits
             output logic [3:0]  DRAM_DQM,     //SDRAM Data Mast 4 Bits
             output logic        DRAM_RAS_N,   //SDRAM Row Address Strobe
                                 DRAM_CAS_N,   //SDRAM Column Address Strobe
                                 DRAM_CKE,     //SDRAM Clock Enable
                                 DRAM_WE_N,    //SDRAM Write Enable
                                 DRAM_CS_N,    //SDRAM Chip Select
                                 DRAM_CLK,      //SDRAM Clock
											
             output logic [19:0] SRAM_ADDR,    //SDRAM Address 13 Bits
             inout  wire  [15:0] SRAM_DQ,      //SDRAM Data 32 Bits

             output logic        SRAM_UB_N,   //SDRAM Row Address Strobe
                                 SRAM_LB_N,   //SDRAM Column Address Strobe
                                 SRAM_CE_N,     //SDRAM Clock Enable
                                 SRAM_OE_N,    //SDRAM Write Enable
                                 SRAM_WE_N    //SDRAM Chip Select
				);
    
    logic Reset_h, Clk;
    logic [15:0] keycode;
    
    assign Clk = CLOCK_50;
    assign {Reset_h} = ~(KEY[0]);  // The push buttons are active low
	 
	 assign SRAM_UB_N = 1'b0;
	 assign SRAM_LB_N = 1'b0;
	 assign SRAM_CE_N = 1'b0;
	 assign SRAM_OE_N = 1'b0;
	 assign SRAM_WE_N = 1'b1;
    
    logic [1:0] hpi_addr;
    logic [15:0] hpi_data_in, hpi_data_out;
    logic hpi_r, hpi_w,hpi_cs;
	 logic [9:0] BALL_X, BALL_Y, ROCKET_X, ROCKET_Y, MONSTER_X, MONSTER_Y, MONSTER_X2, MONSTER_Y2, ROCKET_X2, ROCKET_Y2, ROCKET_X3, ROCKET_Y3, BOSS_X, BOSS_Y, MONSTER_X3, MONSTER_Y3; 
	 logic [9:0] DRAW_X, DRAW_Y;
	 logic [4:0] spaceship_out, rocket_out, monster_out, monster2_out, boss_out;
	 logic [4095:0] spaceship_read_addr;
	 logic [319:0] rocket_read_addr;
	 logic [2499:0] monster_read_addr;
	 logic [899:0] monster2_read_addr;
	 logic [3599:0] boss_read_addr;
	 logic spaceship_on, rocket_on, monster_on, explosion_on, explosion_on2, rocket_on2, rocket_on3, monster_on2, monster_on3, is_dead, is_dead2, is_dead3, is_dead4, is_dead5;
	 logic boss_dead, boss_on;
	 logic [7:0] color;
	 logic rocket1_disappear, rocket2_disappear, rocket3_disappear, spaceship_disappear;
	 logic draw_level1, draw_level2, draw_level3, draw_victory, draw_game_over, draw_start, set_motion_1, set_motion_2, set_motion_3;
	 logic [3:0] score;
     
    // Interface between NIOS II and EZ-OTG chip
    hpi_io_intf hpi_io_inst(
                            .Clk(Clk),
                            .Reset(Reset_h),
                            // signals connected to NIOS II
                            .from_sw_address(hpi_addr),
                            .from_sw_data_in(hpi_data_in),
                            .from_sw_data_out(hpi_data_out),
                            .from_sw_r(hpi_r),
                            .from_sw_w(hpi_w),
                            .from_sw_cs(hpi_cs),
                            // signals connected to EZ-OTG chip
                            .OTG_DATA(OTG_DATA),    
                            .OTG_ADDR(OTG_ADDR),    
                            .OTG_RD_N(OTG_RD_N),    
                            .OTG_WR_N(OTG_WR_N),    
                            .OTG_CS_N(OTG_CS_N),    
                            .OTG_RST_N(OTG_RST_N)
    );
     
     //The connections for nios_system might be named different depending on how you set up Qsys
     lab8_soc nios_system(
                             .clk_clk(Clk),         
                             .reset_reset_n(KEY[0]),   
                             .sdram_wire_addr(DRAM_ADDR), 
                             .sdram_wire_ba(DRAM_BA),   
                             .sdram_wire_cas_n(DRAM_CAS_N),
                             .sdram_wire_cke(DRAM_CKE),  
                             .sdram_wire_cs_n(DRAM_CS_N), 
                             .sdram_wire_dq(DRAM_DQ),   
                             .sdram_wire_dqm(DRAM_DQM),  
                             .sdram_wire_ras_n(DRAM_RAS_N),
                             .sdram_wire_we_n(DRAM_WE_N), 
                             .sdram_clk_clk(DRAM_CLK),
                             .keycode_export(keycode),  
                             .otg_hpi_address_export(hpi_addr),
                             .otg_hpi_data_in_port(hpi_data_in),
                             .otg_hpi_data_out_port(hpi_data_out),
                             .otg_hpi_cs_export(hpi_cs),
                             .otg_hpi_r_export(hpi_r),
                             .otg_hpi_w_export(hpi_w)
    );
    
    //Fill in the connections for the rest of the modules 
    VGA_controller vga_controller_instance(
		.Clk(CLOCK_50),
		.Reset(~KEY[2]),       // reset signal; Must use inverted key because keys are active low
		.VGA_HS(VGA_HS),      // Horizontal sync pulse.  Active low
		.VGA_VS(VGA_VS),      // Vertical sync pulse.  Active low
		.VGA_CLK(VGA_CLK),     // 25 MHz VGA clock output
		.VGA_BLANK_N(VGA_BLANK_N), // Blanking interval indicator.  Active low.
		.VGA_SYNC_N(VGA_SYNC_N),  // Composite Sync signal.  Active low.  We don't use it in this lab,
                             // but the video DAC on the DE2 board requires an input for it.
		.DrawX(DRAW_X),       // horizontal coordinate
		.DrawY(DRAW_Y)        // vertical coordinate
    );
   
    ball ball_instance(
		.Reset(~KEY[2]), 					//Must use inverted key because keys are active low
		.frame_clk(VGA_VS),          // The clock indicating a new frame (~60Hz)
		.BallX(BALL_X), 
		.BallY(BALL_Y), 
		.spaceship_disappear(spaceship_disappear),
		//.BallS(size_doesnt_matter),
		.keycode(keycode[7:0]),
		.set_motion_1(set_motion_1)
	 );
    
    color_mapper color_instance(
		.color(color),
		.VGA_R(VGA_R), 
		.VGA_G(VGA_G), 
		.VGA_B(VGA_B)
	 );
	 
	 frameROM spaceship1(
      .read_address(spaceship_read_addr),
		.Clk(VGA_CLK),
		.data_Out(spaceship_out)
	 );
	 
	 monster2ROM monster2(
      .read_address(monster2_read_addr),
		.Clk(VGA_CLK),
		.data_Out(monster2_out)
	 );
	 
	 rocketROM rocket_rom1(
      .read_address(rocket_read_addr),
		.Clk(VGA_CLK),
		.data_Out(rocket_out)
	 );
	 
	 monsterROM monster_rom1 (
		.read_address(monster_read_addr),
		.Clk(VGA_CLK),
		.data_Out(monster_out)
	 );

	 bossROM boss1 (
		.read_address(boss_read_addr),
		.Clk(VGA_CLK),
		.data_Out(boss_out)
	 );
	 
	 FrameBuffer frameBuffer(
		.spaceship_on(spaceship_on),
		.rocket_on(rocket_on),
		.rocket_on2(rocket_on2),
		.rocket_on3(rocket_on3),
		.monster_on(monster_on),
		.monster_on2(monster_on2),
		.monster_on3(monster_on3),
		.boss_on(boss_on),
		.explosion_on(explosion_on),
		.explosion_on2(explosion_on2),
		.rocket(rocket_out),
		.rocket2(rocket_out),
		.rocket3(rocket_out),
		.monster(monster_out),
		.monster2(monster_out),
		.monster3(monster2_out),
		.spaceship(spaceship_out),
		.boss(boss_out),
		.background(SRAM_DQ[7:0]),
		.Clk(VGA_VS),
		.color(color),
		.draw_game_over(draw_game_over),
		.draw_start(draw_start)
	 );
	 
	 DrawEngine drawEngine1 (
		.DrawX(DRAW_X),
		.DrawY(DRAW_Y),
		.RocketX(ROCKET_X),
		.RocketY(ROCKET_Y),
		.RocketX2(ROCKET_X2),
		.RocketY2(ROCKET_Y2),
		.RocketX3(ROCKET_X3),
		.RocketY3(ROCKET_Y3),
		.SpaceshipX(BALL_X),
		.SpaceshipY(BALL_Y),
		.MonsterX(MONSTER_X),
		.MonsterY(MONSTER_Y),
		.MonsterX2(MONSTER_X2),
		.MonsterY2(MONSTER_Y2),
		.MonsterX3(MONSTER_X3),
		.MonsterY3(MONSTER_Y3),
		.BossX(BOSS_X),
		.BossY(BOSS_Y),
		.output_address_spaceship(spaceship_read_addr),
		.output_address_rocket(rocket_read_addr),
		.output_address_monster(monster_read_addr),
		.output_address_monster2(monster2_read_addr),
		.background_address(SRAM_ADDR),
		.output_address_boss(boss_read_addr),
		.draw_spaceship(spaceship_on),
		.draw_rocket(rocket_on),
		.draw_rocket2(rocket_on2),
		.draw_rocket3(rocket_on3),
		.draw_monster(monster_on),
		.draw_monster2(monster_on2),
		.draw_monster3(monster_on3),
		.draw_boss(boss_on),
		.draw_level1(draw_level1),
		.draw_level2(draw_level2),
		.draw_level3(draw_level3),
		.draw_victory(draw_victory),
		.draw_game_over(draw_game_over),
		.draw_start(draw_start)
	 );
	 
	 Rocket rocket1 (
	   .Reset(~KEY[2]), 
      .frame_clk(VGA_VS),          // The clock indicating a new frame (~60Hz)
		.keycode(keycode[7:0]),
		.rocket1_disappear(rocket1_disappear),
		.rocket2_disappear(rocket2_disappear),
		.rocket3_disappear(rocket3_disappear),
		.BallX(BALL_X), 
		.BallY(BALL_Y),
		.RocketX(ROCKET_X),
		.RocketY(ROCKET_Y),
		.RocketX2(ROCKET_X2),
		.RocketY2(ROCKET_Y2),
		.RocketX3(ROCKET_X3),
		.RocketY3(ROCKET_Y3)
	 );

	 
	 Monster monster1 (
	   .Reset(~KEY[2]), 
      .frame_clk(VGA_VS),          // The clock indicating a new frame (~60Hz
		.keycode(keycode[7:0]),
      .MonsterX(MONSTER_X),
		.MonsterY(MONSTER_Y),
		.MonsterX2(MONSTER_X2),
		.MonsterY2(MONSTER_Y2),
		.MonsterX3(MONSTER_X3),
		.MonsterY3(MONSTER_Y3),
		.is_dead(is_dead),
		.is_dead2(is_dead2),
		.is_dead3(is_dead3),
		.boss_dead(boss_dead),
		.BossX(BOSS_X),
		.BossY(BOSS_Y),
		.draw_level1(draw_level1),
		.draw_level2(draw_level2),
		.draw_level3(draw_level3),
		.set_motion_1(set_motion_1),
		.set_motion_2(set_motion_2),
		.set_motion_3(set_motion_3)
	 );
    
	 CollisionDetection detect1 (
		.RocketX(ROCKET_X),
		.RocketY(ROCKET_Y),
		.RocketX2(ROCKET_X2),
		.RocketY2(ROCKET_Y2),
		.RocketX3(ROCKET_X3),
		.RocketY3(ROCKET_Y3),
		.MonsterX(MONSTER_X),
		.MonsterY(MONSTER_Y),
		.MonsterX2(MONSTER_X2),
		.MonsterY2(MONSTER_Y2),
		.MonsterX3(MONSTER_X3),
		.MonsterY3(MONSTER_Y3),
		.SpaceshipX(BALL_X),
		.SpaceshipY(BALL_Y),
		.BossX(BOSS_X),
		.BossY(BOSS_Y),
		.is_dead(is_dead),
		.is_dead2(is_dead2),
		.is_dead3(is_dead3),
		.boss_dead(boss_dead),
		.draw_explosion(explosion_on),
		.draw_explosion2(explosion_on2),
		.rocket1_disappear(rocket1_disappear),
		.rocket2_disappear(rocket2_disappear),
		.rocket3_disappear(rocket3_disappear),
		.spaceship_disappear(spaceship_disappear),
		.draw_game_over(draw_game_over)
	 );

	 StateMachine statemachine1 (
		.Reset(~KEY[2]), 
		.Clk(VGA_VS), 
		.spaceship_disappear(spaceship_disappear), 
		.keycode(keycode[7:0]),
		.draw_level1(draw_level1),
		.draw_level2(draw_level2), 
		.draw_level3(draw_level3),
		.draw_victory(draw_victory), 
		.draw_game_over(draw_game_over),
		.draw_start(draw_start),
		.set_motion_1(set_motion_1),
		.set_motion_2(set_motion_2),
		.set_motion_3(set_motion_3),
		.draw_explosion(explosion_on)
	 );
	 
	 Score score1 (
		.draw_explosion(explosion_on),
		.Clk(VGA_VS),
		.score(score),
		.Reset(~KEY[2])
	 );
	 
    HexDriver hex_inst_0 (score, HEX0);
    HexDriver hex_inst_1 (draw_start, HEX1);
    
endmodule
