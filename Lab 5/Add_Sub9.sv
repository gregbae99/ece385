module add_sub9 (input  [7:0] A, B,	// values to be operated
				 input 		  fn,			// 2s complement function indicator
				 output [8:0] S);			// output

	logic [7:0] c;					// carry bits
	logic [7:0] BB;				// 2s complement B values
	logic 		A8, BB8;			// extend bits

	assign BB = (B ^ {8{fn}});	// calculates 2s complement based on fn
	assign A8 = A[7];				// extend bit
	assign BB8 = BB[7];

	// ripple carry adders with extend bit
	full_adder FA0(.x(A[0]), .y(BB[0]), .z(fn), .s(S[0]), .c(c[0]));
	full_adder FA1(.x(A[1]), .y(BB[1]), .z(c[0]), .s(S[1]), .c(c[1]));
	full_adder FA2(.x(A[2]), .y(BB[2]), .z(c[1]), .s(S[2]), .c(c[2]));
	full_adder FA3(.x(A[3]), .y(BB[3]), .z(c[2]), .s(S[3]), .c(c[3]));
	full_adder FA4(.x(A[4]), .y(BB[4]), .z(c[3]), .s(S[4]), .c(c[4]));
	full_adder FA5(.x(A[5]), .y(BB[5]), .z(c[4]), .s(S[5]), .c(c[5]));
	full_adder FA6(.x(A[6]), .y(BB[6]), .z(c[5]), .s(S[6]), .c(c[6]));
	full_adder FA7(.x(A[7]), .y(BB[7]), .z(c[6]), .s(S[7]), .c(c[7]));
	full_adder FA8(.x(A8), .y(BB8), .z(c[7]), .s(S[8]), .c());
	
endmodule
