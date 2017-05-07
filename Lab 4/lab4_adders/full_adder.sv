// regular full_adder with inputs x and y, and carryin bit z.
// outputs the sum s as well as the carry out bit c.
module full_adder (input x, y, z, 
                   output s, c);
		
		assign s = x ^ y ^ z; // The sum should be an xor of x, y, and z.
		assign c = (x & y) | (y & z) | (x & z); // If 2 or more of the inputs are both 1, a carry out is necessary.
		
endmodule
