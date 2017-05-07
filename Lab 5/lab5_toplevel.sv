module lab5_toplevel
(
	input	logic		Clk,	// input clock 50MHz
	input	logic		Reset,	//asynchronous reset signal (button 0)
	input 	logic 		ClearA_LoadB,	//button 2
	input 	logic 		Run, //button 3
	input	logic [7:0]	S, //switches

	output 	logic 		X,	//extend bit (green LED)
	output 	logic [7:0]	Aval,	//output A
						Bval,	//output B
	output	logic [6:0]	AhexU, //hex display
						AhexL,	
						BhexU,	//hex display
						BhexL
);

	logic [8:0]	XA;	// X bit with A
	logic [7:0]	A, B;	// output A and B
	logic Reset_SH, ClearA_LoadB_SH, Run_SH;	// synchronized high for each button signal
	logic A_Out;	// output of A shift register
	logic Add, Sub, Clr_Ld, Shift_XAB;	// output of control unit

	// performs the 2's complement add operation with extend bit.
	add_sub9 Bit_Adder
	(
		.A (A),
		.B (S),
		.fn (Sub),
		.S (XA)
	);
	// D flipflop for the X extend bit.
	Dreg Reg_X
	(
		.Clk (Clk),
		.Load (Add | Sub),				// Loads only in run state when adding or subtracting
		.Reset (Reset_SH | Clr_Ld),	// resets when reset or clearA_LoadB button is pressed
		.D (XA[8]),
		.Q (X)
	);
	// 8 bit shift register
	reg_8 Reg_A
	(
		.Clk (Clk),
		.Reset (Reset_SH | Clr_Ld), // resets when reset or clearA_LoadB button is pressed
		.Shift_In (X),					// arithmetic shift from extend bit
		.Load (Add | Sub),			// Loads only in run state when adding or subtracting
		.Shift_En (Shift_XAB),
		.D (XA[7:0]),
		.Shift_Out (A_Out),			// shifts into B register
		.D_Out (A)
	);
	// 8 bit shift register
	reg_8 Reg_B
	(
		.Clk (Clk),
		.Reset (Reset_SH),			// reset when reset button is pressed
		.Shift_In (A_Out),			// shifts in from A register
		.Load (Clr_Ld),
		.Shift_En (Shift_XAB),
		.D (S),
		.Shift_Out (),
		.D_Out (B)
	);
	// control unit that takes button inputs and provides instructions
	control Controller
	(
		.Clk (Clk),
		.Reset (Reset_SH),
		.ClearA_LoadB (ClearA_LoadB_SH),
		.Run (Run_SH),
		.M (B[0]),						// lowest bit of B
		.Shift_XAB (Shift_XAB),
		.Clr_Ld (Clr_Ld),
		.Add (Add),
		.Sub (Sub)
	);
	// hexadecimal display converter
	HexDriver AhexU_inst
	(
		.In0 (A[7:4]),
		.Out0 (AhexU)
	);

	HexDriver AhexL_inst
	(
		.In0 (A[3:0]),
		.Out0 (AhexL)
	);

	HexDriver BhexU_inst
	(
		.In0 (B[7:4]),
		.Out0 (BhexU)
	);

	HexDriver BhexL_inst
	(
		.In0 (B[3:0]),
		.Out0 (BhexL)
	);

	assign Aval = A;	// combinational logic for Aval output
	assign Bval = B;  // combinational logic for Bval output

	//synchronizer for the button inputs
	sync button_sync[2:0]
	(
		Clk,
		{~Reset, ~ClearA_LoadB, ~Run},
		{Reset_SH, ClearA_LoadB_SH, Run_SH}
	);

endmodule
