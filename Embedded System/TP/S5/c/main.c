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
#include <stdint.h>
#include "wheel.h"
#include "buttons.h"
#include "leds.h"
#include "seg7.h"
#include "dmtimer1.h"

#define flag1 (1<<0)    //  1 = 00 0001
#define flag2 (1<<1)    //  2 = 00 0010
#define flag3 (1<<2)    //  3 = 00 0100
#define frequency 24000000			// Beagle Bone frequency

// ----------------------------------------------------------------------------
// local method implementation...
// ----------------------------------------------------------------------------

static void chrono() {
	printf("sw1 pressed\n");
	led_set_state(1);
	bool push = false;            			        				  // start/stop
	bool pushChanged = false;  										 				// started/stopped
	uint32_t buttonsStates = 0;

	uint32_t counter = 0;
	uint64_t elapse = 0;

	uint32_t st = dmtimer1_get_counter();
	while((buttonsStates & flag3) == 0){       					 // while sw3 not pushed
		// refresh counter when timer overflow
		if (counter >= 999) {
			elapse = 0;
		}

		uint32_t delta = 0;
		uint32_t sp = 0;
		do {
			sp = dmtimer1_get_counter();
			delta = sp-st;
		} while (delta < 24000);
		st = sp;

		enum state wheelState = getWheelState();
		if (wheelState == PUSH){
			if (!pushChanged) {
				push = !push;
				pushChanged = true;
			}
		}
		else {
			pushChanged = false;
		}

		if (push) {
			delta = 0;
		}

		elapse+=delta;
		counter = (elapse/(frequency/10));
		printf("%lu\n", counter);
		seg7_display_float(counter);
		buttonsStates = buttons_get_state();
	}
}

static void timer() {
	printf("sw2 pressed\n");
	led_set_state(2);
	uint32_t counter = 500;								    			 			// 10 sec
	bool push = false;                    				 	 			// start/stop
	bool pushChanged = false;             					  		// started/stopped
	uint32_t buttonsStates = 0;
	uint64_t elapse = counter * (frequency/10);
	uint32_t st = dmtimer1_get_counter();
	while((buttonsStates & flag3) == false){        			// while sw3 not pushed
		buttonsStates = buttons_get_state();
		enum state wheelState = getWheelState();
		seg7_display_float(counter);

		if (wheelState == PUSH) {
			if (!pushChanged) {
				push = !push;
				pushChanged = true;
			}
		}

		else {
			pushChanged = false;
			if (!push) {
				if (counter <= 1) {
					counter = 0;
				}
				else {
					uint32_t delta = 0;
					uint32_t sp = 0;
					do {
						sp = dmtimer1_get_counter();
						delta = sp-st;
					} while (delta < 24000);
					st = sp;

					if (push) {
						delta = 0;
					}

					elapse-=delta;
					counter = (elapse/(frequency/10));
					printf("%lu\n", counter);
					seg7_display_float(counter);
				}
			}
			else {
				st = dmtimer1_get_counter();
				if(wheelState == INCR){
          if (counter <999) {
            counter+=10;
            seg7_display_float(counter);
            elapse = counter * (frequency/10);
          }
				}
				else if (wheelState == DECR) {
          if (counter >1) {
            counter-=10;
            seg7_display_float(counter);
            elapse = counter * (frequency/10);
          }
				}
      }
		}
	}
}

// ----------------------------------------------------------------------------
// main program...
// ----------------------------------------------------------------------------

int main() {

	initWheel();
	buttons_init();
	led_init();
	seg7_init();
	dmtimer1_init();

	// application...
	uint32_t buttonsStates = 0;

	while(true) {
		buttonsStates = buttons_get_state();                // actualize buttons state

		if ((buttonsStates & flag1) != 0) {                 // sw1 pushed
			chrono();
		}

		if (buttonsStates & flag2) {                        // sw2 pushed
			timer();
		}

		if (buttonsStates & flag3) {

			// Reset
			led_set_state(0);													 				// turn off all led
			printf("sw3 pressed\n");
		}
	}
	return 0;
}
