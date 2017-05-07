module carry_lookahead_adder
(
    input   logic[15:0]     A, // A input value (16-bit)
    input   logic[15:0]     B, // B input value (16-bit)
    output  logic[15:0]     Sum, // Sum of A and B (16-bit)
    output  logic           CO // carryout bit
);

    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
	  
	  	logic c1, c2, c3; // create variables for the carry bits
		logic p0, p1, p2, p3; // create variables for the propagate bits
		logic g0, g1, g2, g3; // create variables for the generate bits
	  
	   // hierarchy of the 4-bit carry lookahead adders. First carryin input is 0.
		carry_lookahead_adder_4 CLA0(.A(A[3:0]), .B(B[3:0]), .C_in(0), .Sum(Sum[3:0]), .P(p0), .G(g0));
		carry_lookahead_adder_4 CLA1(.A(A[7:4]), .B(B[7:4]), .C_in(c1), .Sum(Sum[7:4]), .P(p1), .G(g1));
		carry_lookahead_adder_4 CLA2(.A(A[11:8]), .B(B[11:8]), .C_in(c2), .Sum(Sum[11:8]), .P(p2), .G(g2));
		carry_lookahead_adder_4 CLA3(.A(A[15:12]), .B(B[15:12]), .C_in(c3), .Sum(Sum[15:12]), .P(p3), .G(g3));
     
		always_comb //logic for carry bits
		begin
		   // calculate the carry bits using the propagate and generate outputs to replace the carryin bit.
			c1 = (0 & p0) | g0; 
			c2 = (0 & p0 & p1) | (g0 & p1) | g1;
			c3 = (0 & p0 & p1 & p2) | (g0 & p1 & p2) | (g1 & p2) | g2;
			CO = (0 & p0 & p1 & p2 & p3) | (g0 & p1 & p2 & p3) | (g1 & p2 & p3) | (g2 & p3) | g3;	
		end
		
endmodule
