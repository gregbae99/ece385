module Row (input        [9:0]         State,
			   output logic [11:0][119:0] pixel_map);
		
		logic [9:0][4:0]   font;
		logic [9:0][143:0] pixel_font;
		logic [11:0][119:0] pixel_map_in;
		
		assign pixel_map = pixel_map_in;
		
		FontDriver fonts0 (font[0], pixel_font[0]);
		FontDriver fonts1 (font[1], pixel_font[1]);
		FontDriver fonts2 (font[2], pixel_font[2]);
		FontDriver fonts3 (font[3], pixel_font[3]);
		FontDriver fonts4 (font[4], pixel_font[4]);
		FontDriver fonts5 (font[5], pixel_font[5]);
		FontDriver fonts6 (font[6], pixel_font[6]);
		FontDriver fonts7 (font[7], pixel_font[7]);
		FontDriver fonts8 (font[8], pixel_font[8]);
		FontDriver fonts9 (font[9], pixel_font[9]);
		
		always_comb
		begin
			font[0] = State[9] ? 5'b11101 : 5'b11111;
			font[1] = State[8] ? 5'b11101 : 5'b11111;
			font[2] = State[7] ? 5'b11101 : 5'b11111;
			font[3] = State[6] ? 5'b11101 : 5'b11111;
			font[4] = State[5] ? 5'b11101 : 5'b11111;
			font[5] = State[4] ? 5'b11101 : 5'b11111;
			font[6] = State[3] ? 5'b11101 : 5'b11111;
			font[7] = State[2] ? 5'b11101 : 5'b11111;
			font[8] = State[1] ? 5'b11101 : 5'b11111;
			font[9] = State[0] ? 5'b11101 : 5'b11111;
			
			pixel_map_in[11][119:0] = {pixel_font[0][143:132], pixel_font[1][143:132], pixel_font[2][143:132], pixel_font[3][143:132], pixel_font[4][143:132], pixel_font[5][143:132], pixel_font[6][143:132], pixel_font[7][143:132], pixel_font[8][143:132], pixel_font[9][143:132]};
			pixel_map_in[10][119:0] = {pixel_font[0][131:120], pixel_font[1][131:120], pixel_font[2][131:120], pixel_font[3][131:120], pixel_font[4][131:120], pixel_font[5][131:120], pixel_font[6][131:120], pixel_font[7][131:120], pixel_font[8][131:120], pixel_font[9][131:120]};
			pixel_map_in[9][119:0] = {pixel_font[0][119:108], pixel_font[1][119:108], pixel_font[2][119:108], pixel_font[3][119:108], pixel_font[4][119:108], pixel_font[5][119:108], pixel_font[6][119:108], pixel_font[7][119:108], pixel_font[8][119:108], pixel_font[9][119:108]};
			pixel_map_in[8][119:0] = {pixel_font[0][107:96], pixel_font[1][107:96], pixel_font[2][107:96], pixel_font[3][107:96], pixel_font[4][107:96], pixel_font[5][107:96], pixel_font[6][107:96], pixel_font[7][107:96], pixel_font[8][107:96], pixel_font[9][107:96]};
			pixel_map_in[7][119:0] = {pixel_font[0][95:84], pixel_font[1][95:84], pixel_font[2][95:84], pixel_font[3][95:84], pixel_font[4][95:84], pixel_font[5][95:84], pixel_font[6][95:84], pixel_font[7][95:84], pixel_font[8][95:84], pixel_font[9][95:84]};
			pixel_map_in[6][119:0] = {pixel_font[0][83:72], pixel_font[1][83:72], pixel_font[2][83:72], pixel_font[3][83:72], pixel_font[4][83:72], pixel_font[5][83:72], pixel_font[6][83:72], pixel_font[7][83:72], pixel_font[8][83:72], pixel_font[9][83:72]};
			pixel_map_in[5][119:0] = {pixel_font[0][71:60], pixel_font[1][71:60], pixel_font[2][71:60], pixel_font[3][71:60], pixel_font[4][71:60], pixel_font[5][71:60], pixel_font[6][71:60], pixel_font[7][71:60], pixel_font[8][71:60], pixel_font[9][71:60]};
			pixel_map_in[4][119:0] = {pixel_font[0][59:48], pixel_font[1][59:48], pixel_font[2][59:48], pixel_font[3][59:48], pixel_font[4][59:48], pixel_font[5][59:48], pixel_font[6][59:48], pixel_font[7][59:48], pixel_font[8][59:48], pixel_font[9][59:48]};
			pixel_map_in[3][119:0] = {pixel_font[0][47:36], pixel_font[1][47:36], pixel_font[2][47:36], pixel_font[3][47:36], pixel_font[4][47:36], pixel_font[5][47:36], pixel_font[6][47:36], pixel_font[7][47:36], pixel_font[8][47:36], pixel_font[9][47:36]};
			pixel_map_in[2][119:0] = {pixel_font[0][35:24], pixel_font[1][35:24], pixel_font[2][35:24], pixel_font[3][35:24], pixel_font[4][35:24], pixel_font[5][35:24], pixel_font[6][35:24], pixel_font[7][35:24], pixel_font[8][35:24], pixel_font[9][35:24]};
			pixel_map_in[1][119:0] = {pixel_font[0][23:12], pixel_font[1][23:12], pixel_font[2][23:12], pixel_font[3][23:12], pixel_font[4][23:12], pixel_font[5][23:12], pixel_font[6][23:12], pixel_font[7][23:12], pixel_font[8][23:12], pixel_font[9][23:12]};
			pixel_map_in[0][119:0] = {pixel_font[0][11:0], pixel_font[1][11:0], pixel_font[2][11:0], pixel_font[3][11:0], pixel_font[4][11:0], pixel_font[5][11:0], pixel_font[6][11:0], pixel_font[7][11:0], pixel_font[8][11:0], pixel_font[9][11:0]};
		end	
endmodule

module Board1 (input                       Reset,
				  input        [23:0][9:0]    State,
				  output logic [9:0]          X_Pos, X_Size, Y_Pos, Y_Size,
				  output logic [287:0][119:0] pixel_map);
			
			logic [9:0]			 X_Pos_in;
			
			parameter [9:0]	 X_Size_in = 120;
			parameter [9:0]	 Y_Size_in = 288;
			parameter [9:0]	 Y_Pos_in = 114;
			
			Row row23 (State[23], pixel_map[287:276]);
			Row row22 (State[22], pixel_map[275:264]);
			Row row21 (State[21], pixel_map[263:252]);
			Row row20 (State[20], pixel_map[251:240]);
			Row row19 (State[19], pixel_map[239:228]);
			Row row18 (State[18], pixel_map[227:216]);
			Row row17 (State[17], pixel_map[215:204]);
			Row row16 (State[16], pixel_map[203:192]);
			Row row15 (State[15], pixel_map[191:180]);
			Row row14 (State[14], pixel_map[179:168]);
			Row row13 (State[13], pixel_map[167:156]);
			Row row12 (State[12], pixel_map[155:144]);
			Row row11 (State[11], pixel_map[143:132]);
			Row row10 (State[10], pixel_map[131:120]);
			Row row9 (State[9], pixel_map[119:108]);
			Row row8 (State[8], pixel_map[107:96]);
			Row row7 (State[7], pixel_map[95:84]);
			Row row6 (State[6], pixel_map[83:72]);
			Row row5 (State[5], pixel_map[71:60]);
			Row row4 (State[4], pixel_map[59:48]);
			Row row3 (State[3], pixel_map[47:36]);
			Row row2 (State[2], pixel_map[35:24]);
			Row row1 (State[1], pixel_map[23:12]);
			Row row0 (State[0], pixel_map[11:0]);
			
			assign X_Size = X_Size_in;
			assign Y_Size = Y_Size_in;
			assign X_Pos = X_Pos_in;
			assign Y_Pos = Y_Pos_in;
	
			assign X_Pos_in = 10'd101;
			
endmodule

module Board2 (input                       Reset,
				  input        [23:0][9:0]    State,
				  output logic [9:0]          X_Pos, X_Size, Y_Pos, Y_Size,
				  output logic [287:0][119:0] pixel_map);
			
			logic [9:0]			 X_Pos_in;
			
			parameter [9:0]	 X_Size_in = 120;
			parameter [9:0]	 Y_Size_in = 288;
			parameter [9:0]	 Y_Pos_in = 114;
			
			Row row23 (State[23], pixel_map[287:276]);
			Row row22 (State[22], pixel_map[275:264]);
			Row row21 (State[21], pixel_map[263:252]);
			Row row20 (State[20], pixel_map[251:240]);
			Row row19 (State[19], pixel_map[239:228]);
			Row row18 (State[18], pixel_map[227:216]);
			Row row17 (State[17], pixel_map[215:204]);
			Row row16 (State[16], pixel_map[203:192]);
			Row row15 (State[15], pixel_map[191:180]);
			Row row14 (State[14], pixel_map[179:168]);
			Row row13 (State[13], pixel_map[167:156]);
			Row row12 (State[12], pixel_map[155:144]);
			Row row11 (State[11], pixel_map[143:132]);
			Row row10 (State[10], pixel_map[131:120]);
			Row row9 (State[9], pixel_map[119:108]);
			Row row8 (State[8], pixel_map[107:96]);
			Row row7 (State[7], pixel_map[95:84]);
			Row row6 (State[6], pixel_map[83:72]);
			Row row5 (State[5], pixel_map[71:60]);
			Row row4 (State[4], pixel_map[59:48]);
			Row row3 (State[3], pixel_map[47:36]);
			Row row2 (State[2], pixel_map[35:24]);
			Row row1 (State[1], pixel_map[23:12]);
			Row row0 (State[0], pixel_map[11:0]);
			
			assign X_Size = X_Size_in;
			assign Y_Size = Y_Size_in;
			assign X_Pos = X_Pos_in;
			assign Y_Pos = Y_Pos_in;
	
			assign X_Pos_in = 10'd421;
			
endmodule