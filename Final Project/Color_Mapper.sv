module  color_mapper (input		          Clk, Reset, multi, gameover, win1, win2,
							 input        [2:0]   Next1, Next2,
							 input        [23:0][9:0] Show_State1,
							 input        [23:0][9:0] Show_State2,
							 input        [23:0][9:0] State1,
							 input        [23:0][9:0] State2,
							 input        [1:0]   player1, player2,
						    input        [9:0]   DrawX, DrawY,         // Coordinates of current drawing pixel
                      output logic [23:0] Score1, Score2,
							 output logic [23:0][9:0] New_State1,
							 output logic [23:0][9:0] New_State2,
							 output logic [7:0]   VGA_R, VGA_G, VGA_B); // VGA RGB output

    //Set Values
	 logic [9:0] Score_X_Pos1, Score_Y_Pos1, Score_X_Size1, Score_Y_Size1;
	 logic [9:0] Board_X_Pos1, Board_Y_Pos1, Board_X_Size1, Board_Y_Size1;
	 logic [9:0] Grid_X_Pos1, Grid_X_Size1, Grid_Y_Pos1, Grid_Y_Size1;
	 logic [9:0] Header_X_Pos1, Header_Y_Pos1, Header_X_Size1, Header_Y_Size1;
	 logic [9:0] NB_X_Pos1, NB_Y_Pos1, NB_Size1;
	 logic       Rows_Cleared1;
	 
	 logic [9:0] Score_X_Pos2, Score_Y_Pos2, Score_X_Size2, Score_Y_Size2;
	 logic [9:0] Board_X_Pos2, Board_Y_Pos2, Board_X_Size2, Board_Y_Size2;
	 logic [9:0] Grid_X_Pos2, Grid_Y_Pos2, Grid_X_Size2, Grid_Y_Size2;
	 logic [9:0] Header_X_Pos2, Header_Y_Pos2, Header_X_Size2, Header_Y_Size2;
	 logic [9:0] NB_X_Pos2, NB_Y_Pos2, NB_Size2;
	 logic       Rows_Cleared2;
	 
	 logic [1439:0] Header_pixel_map1, Header_pixel_map2, Score_pixel_map1, Score_pixel_map2;
	 logic [287:0][119:0] Board_pixel_map1;
	 logic [287:0][119:0] Board_pixel_map2;
	 logic [291:0][123:0] Grid_pixel_map1;
	 logic [291:0][123:0] Grid_pixel_map2;
	 logic [3135:0] NB_pixel_map1, NB_pixel_map2, NB_background_map1, NB_background_map2;
	  
	 //Board Display
	 logic [7:0]   Red, Green, Blue;
	 logic [2:0]	Color;
	 logic         board1_on, board2_on, score1_on, score2_on, next1_on, next2_on, header1_on, header2_on, grid1_on, grid2_on;
	 
	 //Modules
	 Header1 h1(game_over, win1, multi, player1, Header_X_Pos1, Header_X_Size1, Header_Y_Pos1, Header_Y_Size1, Header_pixel_map1);
	 Header2 h2(game_over, win2, multi, player2, Header_X_Pos2, Header_X_Size2, Header_Y_Pos2, Header_Y_Size2, Header_pixel_map2);
	
	 Score s1(Clk, Reset, Rows_Cleared1, Score1);
	 Score s2(Clk, Reset, Rows_Cleared2, Score2);

	 Score_Header1 sh1(Score1, player1, Score_X_Pos1, Score_X_Size1, Score_Y_Pos1, Score_Y_Size1, Score_pixel_map1);
	 Score_Header2 sh2(Score2, player2, Score_X_Pos2, Score_X_Size2, Score_Y_Pos2, Score_Y_Size2, Score_pixel_map2);
    
	 Next_Block1 nb1(Next1, NB_X_Pos1, NB_Y_Pos1, NB_Size1, NB_pixel_map1, NB_background_map1);
	 Next_Block2 nb2(Next2, NB_X_Pos2, NB_Y_Pos2, NB_Size2, NB_pixel_map2, NB_background_map2);
	
	 Game_Checker g1(State1, Rows_Cleared1, New_State1);
	 Game_Checker g2(State2, Rows_Cleared2, New_State2);
	 
	 Grid1 gd1(Grid_X_Pos1, Grid_X_Size1, Grid_Y_Pos1, Grid_Y_Size1, Grid_pixel_map1);
	 Grid2 gd2(Grid_X_Pos2, Grid_X_Size2, Grid_Y_Pos2, Grid_Y_Size2, Grid_pixel_map2);
	 
	 Board1 b1(Reset, Show_State1, Board_X_Pos1, Board_X_Size1, Board_Y_Pos1, Board_Y_Size1, Board_pixel_map1);
	 Board2 b2(Reset, Show_State2, Board_X_Pos2, Board_X_Size2, Board_Y_Pos2, Board_Y_Size2, Board_pixel_map2);

	 ColorDriver c1(Color, {Red, Green, Blue});
	 
	 //VGA Colors
    assign VGA_R = Red;
    assign VGA_G = Green;
    assign VGA_B = Blue;
    
    // Compute whether the pixel corresponds to Game or background
    always_comb
    begin : Tetris_on_proc
		board1_on = 1'b0; 
		board2_on = 1'b0; 
		score1_on = 1'b0;
		score2_on = 1'b0; 
		next1_on = 1'b0; 
		next2_on = 1'b0; 
		header1_on = 1'b0; 
		header2_on = 1'b0;
		grid1_on = 1'b0;
		grid2_on = 1'b0;
		if (DrawX >= Score_X_Pos1 && DrawX <= Score_X_Pos1 + Score_X_Size1 && DrawY >= Score_Y_Pos1 && DrawY <= Score_Y_Pos1 + Score_Y_Size1)
			score1_on = 1'b1;
		else if (DrawX >= Score_X_Pos2 && DrawX <= Score_X_Pos2 + Score_X_Size1 && DrawY >= Score_Y_Pos2 && DrawY <= Score_Y_Pos2 + Score_Y_Size1)
			score2_on = 1'b1;
		else if (DrawX >= Grid_X_Pos1 && DrawX < Grid_X_Pos1 + Grid_X_Size1 && DrawY >= Grid_Y_Pos1 && DrawY < Grid_Y_Pos1 + Grid_Y_Size1)
		begin
			grid1_on = 1'b1;
			if (DrawX >= Board_X_Pos1 && DrawX < Board_X_Pos1 + Board_X_Size1 && DrawY >= Board_Y_Pos1 && DrawY < Board_Y_Pos1 + Board_Y_Size1)
			begin
				grid1_on = 1'b0;
				board1_on = 1'b1;
			end
		end
		else if (DrawX >= Grid_X_Pos2 && DrawX < Grid_X_Pos2 + Grid_X_Size1 && DrawY >= Grid_Y_Pos2 && DrawY < Grid_Y_Pos1 + Grid_Y_Size1)
		begin
			grid2_on = 1'b1;
			if (DrawX >= Board_X_Pos2 && DrawX < Board_X_Pos2 + Board_X_Size1 && DrawY >= Board_Y_Pos2 && DrawY < Board_Y_Pos1 + Board_Y_Size1)
			begin
				grid2_on = 1'b0;
				board2_on = 1'b1;
			end
		end
		else if (DrawX >= NB_X_Pos1 && DrawX <= NB_X_Pos1 + NB_Size1 && DrawY >= NB_Y_Pos1 && DrawY <= NB_Y_Pos1 + NB_Size1)
			next1_on = 1'b1;
		else if (DrawX >= NB_X_Pos2 && DrawX <= NB_X_Pos2 + NB_Size1 && DrawY >= NB_Y_Pos2 && DrawY <= NB_Y_Pos2 + NB_Size1)
			next2_on = 1'b1;
		else if (DrawX >= Header_X_Pos1 && DrawX <= Header_X_Pos1 + Header_X_Size1 && DrawY >= Header_Y_Pos1 && DrawY <= Header_Y_Pos1 + Header_Y_Size1)
			header1_on = 1'b1;
		else if (DrawX >= Header_X_Pos2 && DrawX <= Header_X_Pos2 + Header_X_Size1 && DrawY >= Header_Y_Pos2 && DrawY <= Header_Y_Pos2 + Header_Y_Size1)
			header2_on = 1'b1;
		else
			board1_on = 1'b0; 
    end
    
    // Assign color based on ball_on signal
    always_comb
    begin : RGB_Display
			if (board1_on)
			begin
				if (Board_pixel_map1[287-(DrawY-Board_Y_Pos1)][119-(DrawX-Board_X_Pos1)])
					Color = 3'b001;
				else if (Show_State1[(287-(DrawY-Board_Y_Pos1))/12][(119-(DrawX-Board_X_Pos1))/12])
					Color = 3'b010;
				else Color = 3'b111;
			end
			else if (board2_on)
			begin
				if (Board_pixel_map2[287-(DrawY-Board_Y_Pos2)][119-(DrawX-Board_X_Pos2)])
					Color = 3'b001;
				else if (Show_State2[(287-(DrawY-Board_Y_Pos2))/12][(119-(DrawX-Board_X_Pos2))/12])
					Color = 3'b010;
				else Color = 3'b111;
			end
			else if (grid1_on)
			begin
				if (Grid_pixel_map1[291-(DrawY-Grid_Y_Pos1)][123-(DrawX-Grid_X_Pos1)])
					Color = 3'b100;
				else Color = 3'b111;
			end
			else if (grid2_on)
			begin
				if (Grid_pixel_map2[291-(DrawY-Grid_Y_Pos2)][123-(DrawX-Grid_X_Pos2)])
					Color = 3'b100;
				else Color = 3'b111;
			end
			else if (score1_on)
			begin
				if (Score_pixel_map1[(12 - (DrawY-Score_Y_Pos1))*Score_X_Size1 + (120 - (DrawX-Score_X_Pos1))])
					Color = 3'b111;
				else Color = 3'b000;
			end
			else if (score2_on)
			begin
				if (Score_pixel_map2[(12 - (DrawY-Score_Y_Pos2))*Score_X_Size1 + (120 - (DrawX-Score_X_Pos2))])
					Color = 3'b111;
				else Color = 3'b000;
			end
			else if (next1_on)
			begin
				if (NB_pixel_map1[(56 - (DrawY-NB_Y_Pos1))*NB_Size1 + (56 - (DrawX-NB_X_Pos1))])
					Color = 3'b001;
				else if (NB_background_map1[(56 - (DrawY-NB_Y_Pos1))*NB_Size1 + (56 - (DrawX-NB_X_Pos1))])
					Color = 3'b111;
				else Color = 3'b100;
			end
			else if (next2_on)
			begin
				if (NB_pixel_map2[(56 - (DrawY-NB_Y_Pos2))*NB_Size1 + (56 - (DrawX-NB_X_Pos2))])
					Color = 3'b001;
				else if (NB_background_map2[(56 - (DrawY-NB_Y_Pos2))*NB_Size1 + (56 - (DrawX-NB_X_Pos2))])
					Color = 3'b111;
				else Color = 3'b100;
			end
			else if (header1_on)
			begin
				if (Header_pixel_map1[(12 - (DrawY-Header_Y_Pos1))*Header_X_Size1 + (120 - (DrawX-Header_X_Pos1))])
					Color = 3'b111;
				else Color = 3'b000;
			end
			else if (header2_on)
			begin
				if (Header_pixel_map2[(12 - (DrawY-Header_Y_Pos2))*Header_X_Size1 + (120 - (DrawX-Header_X_Pos2))])
					Color = 3'b111;
				else Color = 3'b000;
			end
			else Color = 3'b000;
    end 
    
endmodule
