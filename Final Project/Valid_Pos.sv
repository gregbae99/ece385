module Valid_Pos (input    [23:0][9:0] State,
						input 	[3:0][3:0] matrix,
						input 	[3:0] Block_X_Pos,
						input 	[4:0] Block_Y_Pos,
						input		[1:0] col, row, width, height,
						output logic	valid);
	
	always_comb
	begin 
		valid = 1'b1;
		if (Block_X_Pos <= 4'd9 && Block_X_Pos + (~width + 1'b1) >= 4'b0 && Block_Y_Pos <= 5'd23 && Block_Y_Pos + (~height + 1'b1) >= 5'b0)
		begin	
			case(height)
				2'b00 : //width is 4
				begin
					if (matrix[row][col -:4] & State[Block_Y_Pos][Block_X_Pos -: 4] == 0)
						valid = 1'b1;
					else
						valid = 1'b0;
				end
				2'b01 : 
					case(width)
						2'b01 :
						begin
							if ((matrix[row][col -: 2] & State[Block_Y_Pos][Block_X_Pos -: 2] == 0)
								&& (matrix[row + 2'b11][col -: 2] & State[Block_Y_Pos + 5'b11111][Block_X_Pos -: 2] == 0))
									valid = 1'b1;
							else
								valid = 1'b0;
						end
						2'b10	:
						begin
							if ((matrix[row][col -: 3] & State[Block_Y_Pos][Block_X_Pos -: 3] == 0)
								&& (matrix[row + 2'b11][col -: 3] & State[Block_Y_Pos + 5'b11111][Block_X_Pos -: 3] == 0))
									valid = 1'b1;
							else
								valid = 1'b0;
						end
						default:;
					endcase
				2'b10 :
				begin
					if ((matrix[row][col -: 2] & State[Block_Y_Pos][Block_X_Pos -: 2] == 0)
						&& (matrix[row + 2'b11][col -: 2] & State[Block_Y_Pos + 5'b11111][Block_X_Pos -: 2] == 0)
						&& (matrix[row + 2'b10][col -: 2] & State[Block_Y_Pos + 5'b11110][Block_X_Pos -: 2] == 0))
							valid = 1'b1;
					else
						valid = 1'b0;
				end
				2'b11 : //width is 1
				begin
					if ((matrix[row][col] & State[Block_Y_Pos][Block_X_Pos] == 0)
								&& (matrix[row + 2'b11][col] & State[Block_Y_Pos + 5'b11111][Block_X_Pos] == 0)
								&& (matrix[row + 2'b10][col] & State[Block_Y_Pos + 5'b11110][Block_X_Pos] == 0)
								&& (matrix[row + 2'b01][col] & State[Block_Y_Pos + 5'b11101][Block_X_Pos] == 0))
									valid = 1'b1;
					else
						valid = 1'b0;
				end
			endcase
		end
		else
			valid = 1'b0;
	end
endmodule