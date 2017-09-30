/**
* Main method, generate a snake on the 7 segments display following a 8 path.
*/
public void snake () {

	int table[] = {SEGA, SEGB, SEGG, SEGE, 
	SEGD, SEGC, SEDG, SEGF, 0}; 			// LED addresses
	int i = 0;								// Current led

	while(1) {
		if (table[i]=0)
		i=0;								// Go to table's start
		switchleds(i);						// Turn led on
		sleep();	
		switchleds(i);						// Turn led off
		sleep();
		i++;
	}
}