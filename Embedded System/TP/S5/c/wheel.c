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
#include "wheel.h"

int a=0, b=0;
enum state lastState = NOP;

void initWheel() {
	// initialize gpio 0, 1 & 2
	am335x_gpio_init(AM335X_GPIO0);
	am335x_gpio_init(AM335X_GPIO1);
	am335x_gpio_init(AM335X_GPIO2);

	// configure gpio pins as inputs
	//A of the encoder
	am335x_gpio_setup_pin(AM335X_GPIO2, 1, AM335X_GPIO_PIN_IN, AM335X_GPIO_PULL_NONE);
	//B of the encoder
	am335x_gpio_setup_pin(AM335X_GPIO1, 29, AM335X_GPIO_PIN_IN, AM335X_GPIO_PULL_NONE);
	//reset of the encoder
	am335x_gpio_setup_pin(AM335X_GPIO0, 2, AM335X_GPIO_PIN_IN, AM335X_GPIO_PULL_NONE);
	return;
}

enum state getWheelState() {
	enum state myState = NOP;
	// refresh wheel values
	int reset = am335x_gpio_get_state(AM335X_GPIO0, 2);		// 0 when pressed
	int cha = am335x_gpio_get_state(AM335X_GPIO2, 1);
	int chb = am335x_gpio_get_state(AM335X_GPIO1, 29);

	// reset
	if (reset == 0) {
		myState = PUSH;
	}
	else {
		// Check if a changed is state
		if (a != cha) {
			if (lastState == NOP){
				lastState = INCR;
			}
		}

		// Check if b changed is state
		if (b != chb) {
			if (lastState == NOP){
				lastState = DECR;
			}
		}

		// Nothing happened
		if ((cha == chb) && (lastState != NOP)) {
			myState = lastState;
			lastState = NOP;
			a = cha;
			b = chb;
		}

	}
	return myState;
}
