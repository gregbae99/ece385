// Main.c - makes LEDG0 on DE2-115 board blink if NIOS II is set up correctly
// for ECE 385 - University of Illinois - Electrical and Computer Engineering
// Author: Zuofu Cheng

int main()
{
	int i = 0;
	volatile unsigned int *LED_PIO = (unsigned int*)0x0040;  //pointer for LED PIO block
	volatile unsigned int *SW_PIO = (unsigned int*)0x0030;   //pointer for Switch PIO block
	volatile unsigned int *PUSH_PIO = (unsigned int*)0x0020; //pointer for Push Key PIO block

	unsigned int accumulator = 0;
	int pressed = 0;
	*LED_PIO = 0; //clear all LEDs
	while ( (1+1) != 3) //infinite loop
	{
		if (*PUSH_PIO == 0x2) //Checks if reset button has been pressed
			accumulator = 0;
		else if (*PUSH_PIO == 0x1 && pressed == 0) //Checks if accumulate button has been pressed
		{
			accumulator += *SW_PIO; //Add switches
			if (accumulator > 255)  //Check for overflow
				accumulator -= 256;
			pressed = 1;            //Makes sure accumulates once per press
		}
		if (*PUSH_PIO != 0x1)       //Checks if button is not pressed anymore
			pressed = 0;
		for (i = 0; i < 30000; i++);
		*LED_PIO |= accumulator;
		for (i = 0; i < 30000; i++); //software delay
		*LED_PIO &= ~accumulator;
	}
	return 1; //never gets here
}
