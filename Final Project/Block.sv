module Block1 (input      Clk, Reset, create_block, 
				  input    [2:0]     block,
				  input    [15:0] keycode, 
				  input    [23:0][9:0] State,
				  output logic [3:0][3:0] matrix_out,
				  output logic [3:0] X_Pos, 
				  output logic [4:0] Y_Pos, 
				  output logic [1:0] m_width, m_height, m_col, m_row,
				  output logic game_over, finish_block);
		
		logic [3:0][3:0] matrix;
		logic [1:0] counter, counter_in;
		logic [3:0] Block_X_Pos, Block_X_Pos_Next, x_change, ChangeX;
		logic [4:0] Block_Y_Pos, Block_Y_Pos_Next, Block_Y_Motion, y_change, ChangeY;
		logic rotated, changed, valid, bottom, start, change;
		logic [9:0] cycle, cycle_in;
				
		enum logic [3:0] {Start, Move, Up, Down, Left, Right, Done, Game_Over, Pause} state, next_state;
		
		assign X_Pos = Block_X_Pos;
		assign Y_Pos = Block_Y_Pos;
	
		Matrix 	 m1 (block, counter_in, rotated, m_width, m_height, m_col, m_row, x_change, y_change, matrix);
		Valid_Pos p1 (State, matrix, Block_X_Pos_Next + ChangeX + x_change, Block_Y_Pos_Next + ChangeY + y_change, m_col, m_row, m_width, m_height, valid);
		Valid_Pos p2 (State, matrix, Block_X_Pos_Next + x_change, Block_Y_Pos_Next+y_change + 5'b11111, m_col, m_row, m_width, m_height, bottom);
		Buffer_FF b (Clk, start, change);
		
		always_ff @ (posedge Clk)
		begin
			if (create_block || Reset)
			begin
				cycle <= 10'b0;
				counter <= 2'b0;
				Block_X_Pos <= 4'd6;
				Block_Y_Pos <= 5'd23;
				Block_Y_Motion <= 5'b11111;
				state <= Start;
				if(Reset)
					matrix_out <= 16'h0;
				else	
					matrix_out <= matrix;
			end
			else begin
				state <= next_state;
				cycle <= cycle_in;
				counter <= counter_in;
				Block_X_Pos <= Block_X_Pos_Next;
				Block_Y_Pos <= Block_Y_Pos_Next;
				matrix_out <= matrix;
			end
		end
		
		always_comb
		begin
			next_state = state;
			unique case (state)
				Start : 
				begin 
					if(create_block)
						next_state = Move;
					if (valid == 0)
						next_state = Game_Over;
				end
				Move : 
				begin 
					if (~bottom)
						next_state = Done;
					case (keycode)
						8'h1A : next_state = Up;
						8'h04 : next_state = Left;
						8'h07 : next_state = Right;
						8'h16 : next_state = Down;
					endcase
				end
				Up :
				begin
					if (~bottom)
						next_state = Done;
					else 
						next_state = Pause;
				end
				Left :
				begin
					if (~bottom)
						next_state = Done;
					else 
						next_state = Pause;
				end
				Right : 
				begin
					if (~bottom)
						next_state = Done;
					else 
						next_state = Pause;
				end
				Down : 
				begin
					if (~bottom)
						next_state = Done;
					else 
						next_state = Pause;
				end
				Pause :	
					if(change)
						next_state = Move;
				Done : next_state = Start;
			endcase
		end
		
		always_comb
		begin
			Block_X_Pos_Next = Block_X_Pos;
			Block_Y_Pos_Next = Block_Y_Pos;
			finish_block = 1'b0;
			game_over = 1'b0;
			rotated = 1'b0;
			changed = 1'b0;
			ChangeX = 4'b0;
			ChangeY = 5'b0;
			start = 1'b0;
			counter_in = counter;
			cycle_in = cycle;
			case (state)
				Move:
				begin
					cycle_in = cycle + 1'b1;
					if (cycle_in == 10'd100)
					begin
						ChangeY = Block_Y_Motion;
						if(valid)
							Block_Y_Pos_Next = Block_Y_Pos + Block_Y_Motion;
						cycle_in	= 10'd0;
					end
				end                    
				Up:
				begin
					counter_in = counter + 1'b1;
					rotated = 1'b1;
					if(valid == 0)
					begin
						rotated = 1'b0;
						counter_in = counter + 2'b11;
					end
					Block_X_Pos_Next = Block_X_Pos + x_change;
					Block_Y_Pos_Next = Block_Y_Pos + y_change;
					rotated = 1'b0;
				end
				Left:
				begin
					ChangeX = 1'b1;
					if(valid)
						Block_X_Pos_Next = Block_X_Pos + 1'b1;
				end
				Right:
				begin
					ChangeX = 4'b1111;
					if(valid)
						Block_X_Pos_Next = Block_X_Pos + 4'b1111; // minus 1
				end
				Down:
				begin
					ChangeY = 5'b11111;
					if(valid)
						Block_Y_Pos_Next = Block_Y_Pos + 5'b11111;
				end
				Pause:
					start = 1'b1;
				Done: finish_block = 1'b1;
				Game_Over: game_over = 1'b1;
			endcase
		end
endmodule

module Block2 (input      Clk, Reset, create_block, 
				  input    [2:0]     block,
				  input    [15:0] keycode, 
				  input    [23:0][9:0] State,
				  output logic [3:0][3:0] matrix_out,
				  output logic [3:0] X_Pos, 
				  output logic [4:0] Y_Pos, 
				  output logic [1:0] m_width, m_height, m_col, m_row,
				  output logic game_over, finish_block);
		
		logic [3:0][3:0] matrix;
		logic [1:0] counter, counter_in;
		logic [3:0] Block_X_Pos, Block_X_Pos_Next, x_change, ChangeX;
		logic [4:0] Block_Y_Pos, Block_Y_Pos_Next, Block_Y_Motion, y_change, ChangeY;
		logic rotated, changed, valid, bottom, start, change;
		logic [9:0] cycle, cycle_in;
				
		enum logic [3:0] {Start, Move, Up, Down, Left, Right, Done, Game_Over, Pause} state, next_state;
		
		assign X_Pos = Block_X_Pos;
		assign Y_Pos = Block_Y_Pos;
	
		Matrix 	 m1 (block, counter_in, rotated, m_width, m_height, m_col, m_row, x_change, y_change, matrix);
		Valid_Pos p1 (State, matrix, Block_X_Pos_Next + ChangeX + x_change, Block_Y_Pos_Next + ChangeY + y_change, m_col, m_row, m_width, m_height, valid);
		Valid_Pos p2 (State, matrix, Block_X_Pos_Next + x_change, Block_Y_Pos_Next+y_change + 5'b11111, m_col, m_row, m_width, m_height, bottom);
		Buffer_FF b (Clk, start, change);
		
		always_ff @ (posedge Clk)
		begin
			if (create_block || Reset)
			begin
				cycle <= 10'b0;
				counter <= 2'b0;
				Block_X_Pos <= 4'd6;
				Block_Y_Pos <= 5'd23;
				Block_Y_Motion <= 5'b11111;
				state <= Start;
				if(Reset)
					matrix_out <= 16'h0;
				else	
					matrix_out <= matrix;
			end
			else begin
				state <= next_state;
				cycle <= cycle_in;
				counter <= counter_in;
				Block_X_Pos <= Block_X_Pos_Next;
				Block_Y_Pos <= Block_Y_Pos_Next;
				matrix_out <= matrix;
			end
		end
		
		always_comb
		begin
			next_state = state;
			unique case (state)
				Start : 
				begin 
					if(create_block)
						next_state = Move;
					if (valid == 0)
						next_state = Game_Over;
				end
				Move : 
				begin 
					if (~bottom)
						next_state = Done;
					case (keycode)
						8'h52 : next_state = Up;
						8'h50 : next_state = Left;
						8'h4F : next_state = Right;
						8'h51 : next_state = Down;
					endcase
				end
				Up :
				begin
					if (~bottom)
						next_state = Done;
					else 
						next_state = Pause;
				end
				Left :
				begin
					if (~bottom)
						next_state = Done;
					else 
						next_state = Pause;
				end
				Right : 
				begin
					if (~bottom)
						next_state = Done;
					else 
						next_state = Pause;
				end
				Down : 
				begin
					if (~bottom)
						next_state = Done;
					else 
						next_state = Pause;
				end
				Pause :	
					if(change)
						next_state = Move;
				Done : next_state = Start;
			endcase
		end
		
		always_comb
		begin
			Block_X_Pos_Next = Block_X_Pos;
			Block_Y_Pos_Next = Block_Y_Pos;
			finish_block = 1'b0;
			game_over = 1'b0;
			rotated = 1'b0;
			changed = 1'b0;
			ChangeX = 4'b0;
			ChangeY = 5'b0;
			start = 1'b0;
			counter_in = counter;
			cycle_in = cycle;
			case (state)
				Move:
				begin
					cycle_in = cycle + 1'b1;
					if (cycle_in == 10'd100)
					begin
						ChangeY = Block_Y_Motion;
						if(valid)
							Block_Y_Pos_Next = Block_Y_Pos + Block_Y_Motion;
						cycle_in	= 10'd0;
					end
				end                    
				Up:
				begin
					counter_in = counter + 1'b1;
					rotated = 1'b1;
					if(valid == 0)
					begin
						rotated = 1'b0;
						counter_in = counter + 2'b11;
					end
					Block_X_Pos_Next = Block_X_Pos + x_change;
					Block_Y_Pos_Next = Block_Y_Pos + y_change;
					rotated = 1'b0;
				end
				Left:
				begin
					ChangeX = 1'b1;
					if(valid)
						Block_X_Pos_Next = Block_X_Pos + 1'b1;
				end
				Right:
				begin
					ChangeX = 4'b1111;
					if(valid)
						Block_X_Pos_Next = Block_X_Pos + 4'b1111; // minus 1
				end
				Down:
				begin
					ChangeY = 5'b11111;
					if(valid)
						Block_Y_Pos_Next = Block_Y_Pos + 5'b11111;
				end
				Pause:
					start = 1'b1;
				Done: finish_block = 1'b1;
				Game_Over: game_over = 1'b1;
			endcase
		end
endmodule

module Matrix (input [2:0] block,
					input [1:0] rotate,
					input 		rotated,
					output logic [1:0] width, height,
					output logic [1:0] col, row,
					output logic [3:0] X_Change, 
					output logic [4:0] Y_Change,  
					output logic [3:0][3:0] matrix);
		
		always_comb
		begin
			X_Change = 4'b0000;
			Y_Change = 5'b00000;
			case (block)
				3'b001: // i-block
				begin
					case (rotate)
						2'b00: 
						begin matrix = 16'h0F00;
								col = 2'b11;
								row = 2'b10;
								width = 2'b11;
								height = 2'b00;
								if(rotated)
								begin
									X_Change = 4'b0001;
									Y_Change = 5'b11111;
								end
						end
						2'b01: 
						begin matrix = 16'h2222;
								col = 2'b01;
								row = 2'b11;
								width = 2'b00;
								height = 2'b11;
								if(rotated)
								begin
									X_Change = 4'b1110;
									Y_Change = 5'b00001;
								end
						end
						2'b10: 
						begin matrix = 16'h00F0;
								col = 2'b11;
								row = 2'b01;
								width = 2'b11;
								height = 2'b00;
								if(rotated)
								begin
									X_Change = 4'b0001;
									Y_Change = 5'b00010;
								end
						end
						2'b11: 
						begin matrix = 16'h4444;
								col = 2'b10;
								row = 2'b11;
								width = 2'b00;
								height = 2'b11;
								if(rotated)
								begin
									X_Change = 4'b1111;
									Y_Change = 5'b00010;
								end
						end
					endcase
				end
				3'b010: // t-block
				begin
					case (rotate)
						2'b00: 
						begin 
							matrix = 16'h0e40;
							col = 2'b11;
							row = 2'b10;
							width = 2'b10;
							height = 2'b01;
							if(rotated)
							begin
								X_Change = 4'b0001;
								Y_Change = 5'b11111;
							end
						end
						2'b01: 
						begin matrix = 16'h4c40;
								col = 2'b11;
								row = 2'b11;
								width = 2'b01;
								height = 2'b10;
								if(rotated)
								begin
									X_Change = 4'b0000;
									Y_Change = 5'b00001;
								end	
						end
						2'b10: 
						begin matrix = 16'h4e00;
								col = 2'b11;
								row = 2'b11;
								width = 2'b10;
								height = 2'b01;
								if(rotated)
								begin
									X_Change = 4'b0000;
									Y_Change = 5'b00000;
								end
						end
						2'b11: 
						begin matrix = 16'h4640;
								col = 2'b10;
								row = 2'b11;
								width = 2'b01;
								height = 2'b10;
								if(rotated)
								begin
									X_Change = 4'b1111;
									Y_Change = 5'b00000;
								end
						end
					endcase
				end
				3'b011: // cube-block
				begin
					matrix = 16'hcc00;
					col = 2'b11;
					row = 2'b11;
					width = 2'b01;
					height = 2'b01;
					if(rotated)
					begin
						X_Change = 4'b0000;
						Y_Change = 5'b00000;
					end
				end
				3'b100: // L-block
				begin
					case (rotate)
						2'b00:
						begin matrix = 16'h0e80;
								col = 2'b11;
								row = 2'b10;
								width = 2'b10;
								height = 2'b01;
								if(rotated)
								begin
									X_Change = 4'b0001;
									Y_Change = 5'b11111;
								end
						end
						2'b01: 
						begin matrix = 16'hc440;
								col = 2'b11;
								row = 2'b11;
								width = 2'b01;
								height = 2'b10;
								if(rotated)
								begin	
									X_Change = 4'b0000;
									Y_Change = 5'b00001;
								end
						end
						2'b10: 
						begin matrix = 16'h2e00;
								col = 2'b11;
								row = 2'b11;
								width = 2'b10;
								height = 2'b01;
								if(rotated)
								begin
									X_Change = 4'b0000;
									Y_Change = 5'b00000;
								end
						end
						2'b11: 
						begin matrix = 16'h4460;
								col = 2'b10;
								row = 2'b11;
								width = 2'b01;
								height = 2'b10;
								if(rotated)
								begin
									X_Change = 4'b1111;
									Y_Change = 5'b00000;
								end
						end
					endcase
				end
				3'b101: // J-block
				begin
					case (rotate)
						2'b00: 
						begin matrix = 16'h0e20;
								col = 2'b11;
								row = 2'b10;
								width = 2'b10;
								height = 2'b01;
								if(rotated)
								begin
									X_Change = 4'b0001;
									Y_Change = 5'b11111;
								end
						end
						2'b01: 
						begin matrix = 16'h44c0;
								col = 2'b11;
								row = 2'b11;
								width = 2'b01;
								height = 2'b10;
								if(rotated)
								begin
									X_Change = 4'b0000;
									Y_Change = 5'b00001;
								end
						end
						2'b10: 
						begin matrix = 16'h8e00;
								col = 2'b11;
								row = 2'b11;
								width = 2'b10;
								height = 2'b01;
								if(rotated)
								begin
									X_Change = 4'b0000;
									Y_Change = 5'b00000;
								end
						end
						2'b11: 
						begin matrix = 16'h6440;
								col = 2'b10;
								row = 2'b11;
								width = 2'b01;
								height = 2'b10;
								if(rotated)
								begin
									X_Change = 4'b1111;
									Y_Change = 5'b00000;
								end
						end
					endcase
				end
				3'b110: // s-block
				begin
					case (rotate)
						2'b00: 
						begin matrix = 16'h06c0;
								col = 2'b11;
								row = 2'b10;
								width = 2'b10;
								height = 2'b01;
								if(rotated)
								begin
									X_Change = 4'b0001;
									Y_Change = 5'b11111;
								end
						end
						2'b01: 
						begin matrix = 16'h8c40;
								col = 2'b11;
								row = 2'b11;
								width = 2'b01;
								height = 2'b10;
								if(rotated)
								begin
									X_Change = 4'b0000;
									Y_Change = 5'b00001;
								end
						end
						2'b10: 
						begin matrix = 16'h6c00;
								col = 2'b11;
								row = 2'b11;
								width = 2'b10;
								height = 2'b01;
								if(rotated)
								begin
									X_Change = 4'b0000;
									Y_Change = 5'b00000;
								end
						end
						2'b11: 
						begin matrix = 16'h4620;
								col = 2'b10;
								row = 2'b11;
								width = 2'b01;
								height = 2'b10;
								if(rotated)
								begin
									X_Change = 4'b1111;
									Y_Change = 5'b00000;
								end
						end
					endcase
				end
				3'b111: // z-block
				begin
					case (rotate)
						2'b00: 
						begin matrix = 16'h0c60;
								col = 2'b11;
								row = 2'b10;
								width = 2'b10;
								height = 2'b01;
								if(rotated)
								begin
									X_Change = 4'b0001;
									Y_Change = 5'b11111;
								end
						end
						2'b01: 
						begin matrix = 16'h4c80;
								col = 2'b11;
								row = 2'b11;
								width = 2'b01;
								height = 2'b10;
								if(rotated)
								begin
									X_Change = 4'b0000;
									Y_Change = 5'b00001;
								end
						end
						2'b10: 
						begin matrix = 16'hc600;
								col = 2'b11;
								row = 2'b11;
								width = 2'b10;
								height = 2'b01;
								if(rotated)
								begin
									X_Change = 4'b0000;
									Y_Change = 5'b00000;
								end
						end
						2'b11: 
						begin matrix = 16'h2640;
								col = 2'b10;
								row = 2'b11;
								width = 2'b01;
								height = 2'b10;
								if(rotated)
								begin
									X_Change = 4'b1111;
									Y_Change = 5'b00000;
								end
						end
					endcase
				end
				default:
				begin
					col = 2'b11;
					row = 2'b11;
					width = 2'b00;
					height = 2'b00;
					X_Change = 4'b0000;
					Y_Change = 5'b00000;
					matrix = 16'b0;
				end
			endcase
		end
endmodule

							
		
					