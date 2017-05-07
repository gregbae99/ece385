module carry_lookahead_adder_4
(
    input   logic[3:0]     A, // A value input (4-bit)
    input   logic[3:0]     B, // B input value (4-bit)
	 input 	logic 			C_in, // carryin bit
    output  logic[3:0]     Sum, // Sum of A and B (4-bit)
    output  logic          P, // Propagate bit
	 output 	logic				G // Generate bit
);

	
	logic c1, c2, c3; // create variables for the carry bits
	logic [3:0] p; // create variables for the propagate bits
	logic [3:0] g; // create variables for the generate bits
	
	assign p = A | B;
	assign g = A & B;
	
	always_comb
	begin
			// calculate the carry bits using the propagate and generate outputs to replace the carryin bit.
			c1 = (C_in & p[0]) | g[0];
			c2 = (C_in & p[0] & p[1]) | (g[0] & p[1]) | g[1];
			c3 = (C_in & p[0] & p[1] & p[2]) | (g[0] & p[1] & p[2]) | (g[1] & p[2]) | g[2];
			// CO = (C_in & P) + G
			P = (p[0] & p[1] & p[2] & p[3]);
			G = (g[0] & p[1] & p[2] & p[3]) | (g[1] & p[2] & p[3]) | (g[2] & p[3]) | g[3];
	end
	
	//Group of 4-bit adders for carry lookahead adder
	full_adder FA0(.x(A[0]), .y(B[0]), .z(C_in),.s(Sum[0]));
	full_adder FA1(.x(A[1]), .y(B[1]), .z(c1),.s(Sum[1]));
	full_adder FA2(.x(A[2]), .y(B[2]), .z(c2),.s(Sum[2]));
	full_adder FA3(.x(A[3]), .y(B[3]), .z(c3),.s(Sum[3]));

endmodule
