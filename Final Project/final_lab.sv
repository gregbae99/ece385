module final_lab( input               CLOCK_50,
						input        [3:0]  KEY,
						output 		 [7:0]  LEDG,
						output 		 [17:0] LEDR,
						output logic [6:0]  HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7,
						// VGA Interface 
						output logic [7:0]  VGA_R,        //VGA Red
												  VGA_G,        //VGA Green
												  VGA_B,        //VGA Blue
						output logic        VGA_CLK,      //VGA Clock
												  VGA_SYNC_N,   //VGA Sync signal
												  VGA_BLANK_N,  //VGA Blank signal
												  VGA_VS,       //VGA virtical sync signal
												  VGA_HS,       //VGA horizontal sync signal
						// CY7C67200 Interface
						inout  wire  [15:0] OTG_DATA,     //CY7C67200 Data bus 16 Bits
						output logic [1:0]  OTG_ADDR,     //CY7C67200 Address 2 Bits
						output logic        OTG_CS_N,     //CY7C67200 Chip Select
												  OTG_RD_N,     //CY7C67200 Read
												  OTG_WR_N,     //CY7C67200 Write
												  OTG_RST_N,    //CY7C67200 Reset
						input               OTG_INT,      //CY7C67200 Interrupt
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
												  DRAM_CLK      //SDRAM Clock
                  );
    
    logic Reset_h, Clk, Single, Multi, AI;
    logic [15:0] keycode;
    
    assign Clk = CLOCK_50;
    assign {Reset_h} = ~(KEY[0]);  // The push buttons are active low
	 assign {Single} = ~(KEY[3]);
	 assign {Multi} = ~(KEY[2]);
	 assign {Game_Reset} = ~(KEY[1]);
    
	 //Data Transfer for Keycode
    logic [1:0] hpi_addr;
    logic [15:0] hpi_data_in, hpi_data_out;
    logic hpi_r, hpi_w, hpi_cs;
	 
	 //Data Transfer for Game
	 logic [1:0] game_state; //(0, 1, 2) => (start, play, end)
	 logic [2:0] next_block1, next_block2;
	 
	 //Game Data
	 logic [23:0][9:0] State1;
	 logic [23:0][9:0] State2;
	 logic multi, gameover;
	 logic [23:0] Score1, Score2;
	 logic [23:0][9:0] Show_State1;
	 logic [23:0][9:0] Show_State2;
	 logic [23:0][9:0] New_State1;
	 logic [23:0][9:0] New_State2;
	 logic [3:0]     X_Pos1;
	 logic [4:0]     Y_Pos1;
	 logic [2:0] Next1, Next2, Curr1, Curr2;
	 logic [1:0]		 player1, player2;
	 logic game_over1, game_over2;
	 logic finish_block1, create_block1, finish_block2, create_block2;
	 logic created1, created2, start_single, start_multi;
	 
	 //VGA
	 logic [9:0] X_POS, Y_POS;
    
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
     
     nios_system nios_system(
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
                             .sdram_out_clk(DRAM_CLK),
                             .keycode_export(keycode),  
                             .otg_hpi_address_export(hpi_addr),
                             .otg_hpi_data_in_port(hpi_data_in),
                             .otg_hpi_data_out_port(hpi_data_out),
                             .otg_hpi_cs_export(hpi_cs),
                             .otg_hpi_r_export(hpi_r),
                             .otg_hpi_w_export(hpi_w),
									  .next_block1_export(next_block1),
									  .next_block2_export(next_block2),
									  .game_state_export(game_state)
    );
    
    VGA_controller vga_controller_instance(
							.*,
							.Reset(Reset_h),
							.DrawX(X_POS),
							.DrawY(Y_POS)
	 );
    
    color_mapper color_instance(
							.Clk(Clk), .Reset(Game_Reset), .multi(multi), .gameover(gameover), .win1(game_over2), .win2(game_over1),
							.Next1(Next1), .Next2(Next2), .Show_State1(Show_State1), .Show_State2(Show_State2),
							.State1(State1), .State2(State2), .player1(player1), .player2(player2), .Score1(Score1), .Score2(Score2),
							.New_State1(New_State1), .New_State2(New_State2), .DrawX(X_POS), .DrawY(Y_POS), .*
	 );
	 
	 Tetris game (
							.Clk(Clk), .Reset(Game_Reset), .Single(Single), .Multi(Multi), .create_block1(create_block1), .create_block2(create_block2),
							.Curr1(Curr1), .Curr2(Curr2), .keycode(keycode), .State1(State1), .State2(State2), .Score1(Score1), .Score2(Score2),
							.Show_State1(Show_State1), .Show_State2(Show_State2), 
							.game_state(game_state), .game_over1(game_over1), .game_over2(game_over2), .game_over(gameover), .multi(multi),
							.finish_block1(finish_block1), .finish_block2(finish_block2), .player1(player1), .player2(player2), .created1(created1), .created2(created2),
							.X_Pos1(X_Pos1), .Y_Pos1(Y_Pos1)
	 );
	 
	 
	 
    HexDriver hex_inst_0 ({2'b0, Single, Single}, HEX0);
	 
	 HexDriver hex_inst_2 ({2'b0, Multi, 1'b0}, HEX2);
	 
	always_ff @ (posedge Clk)
	begin
//		if(Game_Reset)
//		begin
//			Curr1 <= 3'b0;
//			Curr2 <= 3'b0;
//			Next1 <= 3'b0;
//			Next2 <= 3'b0;
//			create_block1 <= 1'b0;
//			create_block2 <= 1'b0;
//			State1 <= 240'b0;
//			State2 <= 240'b0;
//		end
//		else
//		begin
			if (Single)
			begin	
				Curr1 <= next_block1;
				
				Next1 <= next_block1;
				create_block1 <= 1'b1;
			end
			else if(Multi)
			begin
				Curr1 <= next_block1;
				Curr2 <= next_block2;
				
				Next1 <= next_block1;
				Next2 <= next_block2;
				{create_block1, create_block2} <= 2'b11;
			end
			if(finish_block1 && finish_block2)
			begin
				Curr1 <= Next1;
				Curr2 <= Next2;

				State1 <= Show_State1;				
				State2 <= Show_State2;
				
				Next1 <= next_block1;
				Next2 <= next_block2;
				{create_block1, create_block2} <= 2'b11;
			end
			else if(finish_block1)
			begin
				Curr1 <= Next1;
				
				State1 <= Show_State1;
				
				Next1 <= next_block1;
				create_block1 <= 1'b1;
			end
			else if(finish_block2)
			begin
				Curr2 <= Next2;
			
				State2 <= Show_State2;

				Next2 <= next_block2;
				create_block2 <= 1'b1;
			end

			State1 <= New_State1;
			State2 <= New_State2;
			
			if (create_block1)
				create_block1 <= ~created1;
			if (create_block2)
				create_block2 <= ~created2;
//		end
	end
    
endmodule
