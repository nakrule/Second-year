/**
 * Copyright 2016 University of Applied Sciences Western Switzerland / Fribourg
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * Project:	HEIA-FR / Embedded Systems 1 Laboratory
 *
 * Abstract:	Introduction to device driver development in C
 *
 * Purpose:	Demo program implementing a basic timer and countdown
 *		application, which is based on the AM335x DMTimer1 timer.
 *
 * Author: 	Samuel Riedo & Pascal Roulin
 * Date: 	23.11.16
 */

#include <stdio.h>
#include <stdbool.h>
#include <am335x_gpio.h>
#include "seg7.h"


// GPIO2: pin to select a 7 seg and dots
	#define Sel1	(1<<2)
	#define Sel2	(1<<3)
	#define DP1		(1<<4)
	#define DP2		(1<<5)
	#define GPIO2_ALL	(Sel1 | Sel2| DP1 | DP2)

// GPIO0: 1 pin for each segment
	#define SEG_A		(1<<4)
	#define SEG_B		(1<<5)
	#define SEG_C		(1<<14)
	#define SEG_D		(1<<22)
	#define SEG_E		(1<<23)
	#define SEG_F		(1<<26)
	#define SEG_G		(1<<27)
	#define GPIO0_ALL	(SEG_A | SEG_B | SEG_C | SEG_D | SEG_E | SEG_F | SEG_G)

// Array to turn on segments to print 0-F
static const uint32_t seg7[] = {
		(SEG_A + SEG_B + SEG_C + SEG_D + SEG_E + SEG_F), 				 // 0
		(SEG_B + SEG_C), 							 	 												 // 1
    (SEG_A + SEG_B + SEG_E + SEG_D + SEG_G),		 						 // 2
    (SEG_A + SEG_B + SEG_C + SEG_D + SEG_G),		 						 // 3
    (SEG_B + SEG_C + SEG_F + SEG_G),				 								 // 4
    (SEG_A + SEG_C + SEG_D + SEG_F + SEG_G 	),							 // 5
    (SEG_A + SEG_C + SEG_D + SEG_E + SEG_F + SEG_G), 	    	 // 6
    (SEG_A + SEG_B + SEG_C),																 // 7
    (SEG_A + SEG_B + SEG_C + SEG_D + SEG_E + SEG_F + SEG_G), // 8
    (SEG_A + SEG_B + SEG_C + SEG_D + SEG_F + SEG_G),		 		 // 9
    (SEG_A + SEG_B + SEG_C + SEG_E + SEG_F + SEG_G),				 // A
    (SEG_C + SEG_D + SEG_E + SEG_F + SEG_G),				  			 // b
    (SEG_A + SEG_D + SEG_E + SEG_F),												 // C
    (SEG_B + SEG_C + SEG_D + SEG_E +         SEG_G),		 		 // d
    (SEG_A + SEG_D + SEG_E + SEG_F + SEG_G),				 				 // E
    (SEG_A + SEG_E + SEG_F + SEG_G),												 // F
    (0),
};

// -----------------------------------------------------------------------------
// implementation of public methods
// -----------------------------------------------------------------------------

void seg7_init() {
	// initialize gpio 0 and 2
	am335x_gpio_init(AM335X_GPIO0);
	am335x_gpio_init(AM335X_GPIO2);

	// configure each pins for the 2 GPIO
	am335x_gpio_setup_pin(AM335X_GPIO2,  2, AM335X_GPIO_PIN_OUT, AM335X_GPIO_PULL_NONE);
	am335x_gpio_setup_pin(AM335X_GPIO2,  3, AM335X_GPIO_PIN_OUT, AM335X_GPIO_PULL_NONE);
	am335x_gpio_setup_pin(AM335X_GPIO2,  4, AM335X_GPIO_PIN_OUT, AM335X_GPIO_PULL_NONE);
	am335x_gpio_setup_pin(AM335X_GPIO2,  5, AM335X_GPIO_PIN_OUT, AM335X_GPIO_PULL_NONE);

	am335x_gpio_setup_pin(AM335X_GPIO0,  4, AM335X_GPIO_PIN_OUT, AM335X_GPIO_PULL_NONE);
	am335x_gpio_setup_pin(AM335X_GPIO0,  5, AM335X_GPIO_PIN_OUT, AM335X_GPIO_PULL_NONE);
	am335x_gpio_setup_pin(AM335X_GPIO0, 14, AM335X_GPIO_PIN_OUT, AM335X_GPIO_PULL_NONE);
	am335x_gpio_setup_pin(AM335X_GPIO0, 22, AM335X_GPIO_PIN_OUT, AM335X_GPIO_PULL_NONE);
	am335x_gpio_setup_pin(AM335X_GPIO0, 23, AM335X_GPIO_PIN_OUT, AM335X_GPIO_PULL_NONE);
	am335x_gpio_setup_pin(AM335X_GPIO0, 26, AM335X_GPIO_PIN_OUT, AM335X_GPIO_PULL_NONE);
	am335x_gpio_setup_pin(AM335X_GPIO0, 27, AM335X_GPIO_PIN_OUT, AM335X_GPIO_PULL_NONE);

	// switch off all pins
	am335x_gpio_change_states(AM335X_GPIO0, GPIO0_ALL, false);
	am335x_gpio_change_states(AM335X_GPIO2, GPIO2_ALL, false);
}

// -----------------------------------------------------------------------------

void seg7_display_value (int value) {
	// Determine if the dot is needed, if the value is negative
	bool dot = false;
	if (value <0) {
		dot = true;
		value = -value;
	}
	//	Calcuate the value of the units and tenths
	int unit = value % 10;
	int tenth = (value / 10) % 10;

	// Print the units on the 7-seg
	am335x_gpio_change_states(AM335X_GPIO0, seg7[unit], true);
	am335x_gpio_change_states(AM335X_GPIO2, Sel2, true);
	// Temporisation on this 7-seg to write correctly the value
	for (int i=0;i<100;i++);
	am335x_gpio_change_states(AM335X_GPIO2, Sel2, false);
	am335x_gpio_change_states(AM335X_GPIO0, GPIO0_ALL, false);

	// Printing the tenths on the 7-seg
	am335x_gpio_change_states(AM335X_GPIO0, seg7[tenth], true);
	am335x_gpio_change_states(AM335X_GPIO2, Sel1, true);

	// Turning on the dot if needed
	if (dot) {
		am335x_gpio_change_states(AM335X_GPIO2, DP1, true);
	}
	// Temporisation on this 7-seg to write correctly the value
	for (int i=0;i<100;i++);

	am335x_gpio_change_states(AM335X_GPIO2, Sel1, false);
	am335x_gpio_change_states(AM335X_GPIO0, GPIO0_ALL, false);
	am335x_gpio_change_states(AM335X_GPIO2, DP1, false);
}

void seg7_display_float(uint32_t value) {
	if (value < 100){
		uint32_t afterDot = value % 10;
		uint32_t beforeDot = value / 10;
		print_value(afterDot, beforeDot, true);
	}
	else{
		value = value / 10;
		uint32_t afterDot = value % 10;
		uint32_t beforeDot = value / 10;
		print_value(afterDot, beforeDot, false);
	}
}

void print_value(uint32_t unit, uint32_t tenth, bool dot) {
		// Print the units on the 7-seg
		am335x_gpio_change_states(AM335X_GPIO0, seg7[unit], true);
		am335x_gpio_change_states(AM335X_GPIO2, Sel2, true);
		// Temporisation on this 7-seg to write correctly the value
		for (int i=0;i<100;i++);
		am335x_gpio_change_states(AM335X_GPIO2, Sel2, false);
		am335x_gpio_change_states(AM335X_GPIO0, GPIO0_ALL, false);

		// Printing the tenths on the 7-seg
		am335x_gpio_change_states(AM335X_GPIO0, seg7[tenth], true);
		am335x_gpio_change_states(AM335X_GPIO2, Sel1, true);

		// Turning on the dot if needed
		if (dot) {
			am335x_gpio_change_states(AM335X_GPIO2, DP2, true);
		}

		// Temporisation on this 7-seg to write correctly the value
		for (int i=0;i<100;i++);

		am335x_gpio_change_states(AM335X_GPIO2, Sel1, false);
		am335x_gpio_change_states(AM335X_GPIO0, GPIO0_ALL, false);
		am335x_gpio_change_states(AM335X_GPIO2, DP2, false);
}
