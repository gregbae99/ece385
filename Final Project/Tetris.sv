module Tetris (input     				    Clk, Reset, Single, Multi, create_block1, create_block2,
				   input        [2:0]       Curr1, Curr2,
					input        [15:0]      keycode,
				   input        [23:0][9:0] State1,
					input        [23:0][9:0] State2,
				   input        [23:0]      Score1, Score2,
				   output logic [23:0][9:0] Show_State1,
					output logic [23:0][9:0] Show_State2,
				   output logic [1:0]		 game_state, 
					output logic             game_over1, game_over2, finish_block1, finish_block2, game_over, multi, created1, created2,
					output logic [1:0]       player1, player2,
					output logic [3:0]       X_Pos1,
					output logic [4:0]       Y_Pos1
					);

		logic [3:0][3:0]  matrix1, matrix2; //matrix 1
		logic [3:0] X_Pos2;
		logic [4:0] Y_Pos2;
		logic [1:0] width1, height1, col1, row1;
		logic [1:0] width2, height2, col2, row2;
		logic [1:0] game_state_in, player1_in, player2_in;
		logic [23:0][9:0] Show_State1_in;
		logic [23:0][9:0] Show_State2_in;
		logic start_block1, start_block2, finish_block1_in, finish_block2_in;
		logic multi_in;
		
		enum logic [2:0] {Start, Single_Reset, Single_Play, Multi_Reset, Multi_1, Multi_2, Multi_Both, Game_Over} state, next_state;
		
		Block1 b1 (Clk, Reset, start_block1, Curr1, keycode, State1, matrix1, X_Pos1, Y_Pos1, width1, height1, col1, row1, game_over1, finish_block1_in);
		Block2 b2 (Clk, Reset, start_block2, Curr2, keycode, State2, matrix2, X_Pos2, Y_Pos2, width2, height2, col2, row2, game_over2, finish_block2_in);		
		State_Combiner c1 (matrix1, State1, X_Pos1, Y_Pos1, width1, height1, col1, row1, Show_State1_in);
		State_Combiner c2 (matrix2, State2, X_Pos2, Y_Pos2, width2, height2, col2, row2, Show_State2_in);
		
		always_ff @ (posedge Clk)
		begin
			if(Reset)
			begin		
				game_state <= 2'b0;
				player1 <= 2'b0;
				player2 <= 2'b0;
				multi <= 1'b0;
				state <= Start;
				Show_State1 <= 240'b0;
				Show_State2 <= 240'b0;
				finish_block1 <= 1'b0;
				finish_block2 <= 1'b0;
			end
			else
			begin
				state <= next_state;
				game_state <= game_state_in;
				if(multi != 0)
					multi <= multi;
				else
					multi <= multi_in;
				if(player1 != 0)
					player1 <= player1;
				else
					player1 <= player1_in;
				if(player2 != 0)
					player2 <= player2;
				else
					player2 <= player2_in;
				Show_State1 <= Show_State1_in;
				Show_State2 <= Show_State2_in;
				finish_block1 <= finish_block1_in;
				finish_block2 <= finish_block2_in;
			end
		end
		
		always_comb
		begin
			start_block1 = 1'b0;
			start_block2 = 1'b0;
			next_state = state;
			unique case (state)
				Start : 
				begin
					if (Single)
						next_state = Single_Reset;
					else if (Multi)
						next_state = Multi_Reset;
				end
				Single_Reset :
				begin
					if (game_over1)
						next_state = Game_Over;
					else if (create_block1)
					begin
						next_state = Single_Play;
						start_block1 = 1'b1;
					end
				end
				Single_Play : 
				begin
					if (game_over1)
						next_state = Game_Over;
					else if (finish_block1)
						next_state = Single_Reset;
				end
				Multi_Reset :
				begin
					if (game_over1 || game_over2)
						next_state = Game_Over;
					else if (create_block1 && create_block2)
					begin
						start_block1 = 1'b1;
						start_block2 = 1'b1;
						next_state = Multi_Both;
					end
					else if (create_block1)
					begin
						start_block1 = 1'b1;
						next_state = Multi_1;
					end
					else if (create_block2)
					begin
						start_block2 = 1'b1;
						next_state = Multi_2;
					end
				end
				Multi_1 :
				begin
					if (game_over1 || game_over2)
						next_state = Game_Over;
					else if (create_block2)
						next_state = Multi_Both;
					else if (finish_block1)
						next_state = Multi_Reset;
				end
				Multi_2 :
				begin
					if (game_over1 || game_over2)
						next_state = Game_Over;
					else if (create_block1)
						next_state = Multi_Both;
					else if (finish_block2)
						next_state = Multi_Reset;
				end
				Multi_Both :
				begin
					if (game_over1 || game_over2)
						next_state = Game_Over;
					else if (finish_block1 && finish_block2)
						next_state = Multi_Reset;
					else if (finish_block1)
						next_state = Multi_2;
					else if (finish_block2)
						next_state = Multi_1;
				end
			endcase
		end
		
		always_comb
		begin
			game_over = 1'b0;
			game_state_in = 2'b0;
			multi_in = 1'b0;
			player1_in = 2'b0;
			player2_in = 2'b0;
			created1 = 1'b0;
			created2 = 1'b0;
			case (state)
				Start :
				begin
					game_state_in = 2'b01;
					multi_in = 1'b0;
					player1_in = 2'b0;
					player2_in = 2'b0;
				end
				Single_Reset :
				begin
					game_state_in = 2'b01;
					multi_in = 1'b0;
					player1_in = 2'b01;
					player2_in = 2'b0;
				end
				Single_Play :
				begin
					created1 = 1'b1;
					game_state_in = 2'b01;
					multi_in = 1'b0;
					player1_in = 2'b01;
					player2_in = 2'b0;
				end
				Multi_Reset :
				begin
					game_state_in = 2'b01;
					multi_in = 1'b1;
					player1_in = 2'b01;
					player2_in = 2'b10;
				end
				Multi_1 :
				begin
					game_state_in = 2'b01;
					created1 = 1'b1;
					multi_in = 1'b1;
					player1_in = 2'b01;
					player2_in = 2'b10;
				end
				Multi_2 :
				begin
					game_state_in = 2'b01;
					created2 = 1'b1;
					multi_in = 1'b1;
					player1_in = 2'b01;
					player2_in = 2'b10;
				end
				Multi_Both :
				begin
					game_state_in = 2'b01;
					created1 = 1'b1;
					created2 = 1'b1;
					multi_in = 1'b1;
					player1_in = 2'b01;
					player2_in = 2'b10;
				end
				Game_Over :
				begin
					game_state_in = 2'b10;
					game_over = 1'b1;
				end
			endcase
		end
endmodule