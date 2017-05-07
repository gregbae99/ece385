module State_Combiner ( input  [3:0][3:0]  	matrix,
								input  [23:0][9:0] 	State,
								input  [3:0] 			Block_X_Pos,
								input  [4:0]			Block_Y_Pos,
								input  [1:0] width, height, col, row,
								output logic [23:0][9:0] State_Out);
								
			logic [23:0][9:0] State_in;				
			
			assign State_Out = State_in;
			
			always_comb
			begin
				State_in = State;
				
				case (height)
					2'b00 : //width is 4
						State_in[Block_Y_Pos][Block_X_Pos -: 4] = matrix[row][col -:4] | State[Block_Y_Pos][Block_X_Pos -: 4];
					2'b01 : 
					case(width)
						2'b01 :
						begin
							State_in[Block_Y_Pos][Block_X_Pos -: 2] = matrix[row][col -: 2] | State[Block_Y_Pos][Block_X_Pos -: 2];
							State_in[Block_Y_Pos + 5'b11111][Block_X_Pos -: 2] = matrix[row + 2'b11][col -: 2] | State[Block_Y_Pos + 5'b11111][Block_X_Pos -: 2];
						end
						2'b10	:
						begin
							State_in[Block_Y_Pos][Block_X_Pos -: 3] = matrix[row][col -: 3] | State[Block_Y_Pos][Block_X_Pos -: 3];
							State_in[Block_Y_Pos + 5'b11111][Block_X_Pos -: 3] = matrix[row + 2'b11][col -: 3] | State[Block_Y_Pos + 5'b11111][Block_X_Pos -: 3];
						end
						default:;
					endcase
					2'b10 :
						begin
							State_in[Block_Y_Pos][Block_X_Pos -: 2] = matrix[row][col -: 2] | State[Block_Y_Pos][Block_X_Pos -: 2];
							State_in[Block_Y_Pos + 5'b11111][Block_X_Pos -: 2] = matrix[row + 2'b11][col -: 2] | State[Block_Y_Pos + 5'b11111][Block_X_Pos -: 2];
							State_in[Block_Y_Pos + 5'b11110][Block_X_Pos -: 2] = matrix[row + 2'b10][col -: 2] | State[Block_Y_Pos + 5'b11110][Block_X_Pos -: 2];
						end
					2'b11 : //width is 1
					begin
						State_in[Block_Y_Pos][Block_X_Pos] = matrix[row][col] | State[Block_Y_Pos][Block_X_Pos];
						State_in[Block_Y_Pos + 5'b11111][Block_X_Pos] = matrix[row + 2'b11][col] | State[Block_Y_Pos + 5'b11111][Block_X_Pos];
						State_in[Block_Y_Pos + 5'b11110][Block_X_Pos] = matrix[row + 2'b10][col] | State[Block_Y_Pos + 5'b11110][Block_X_Pos];
						State_in[Block_Y_Pos + 5'b11101][Block_X_Pos] = matrix[row + 2'b01][col] | State[Block_Y_Pos + 5'b11101][Block_X_Pos];			
					end
				endcase
			end
endmodule