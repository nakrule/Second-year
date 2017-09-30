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
#include <am335x_gpio.h>

void led_init() {
	// initialize gpio 1 module
	am335x_gpio_init(AM335X_GPIO1);
	// configure gpio pins as output
	am335x_gpio_setup_pin
		(AM335X_GPIO1, 12, AM335X_GPIO_PIN_OUT, AM335X_GPIO_PULL_NONE);
	am335x_gpio_setup_pin
		(AM335X_GPIO1, 13, AM335X_GPIO_PIN_OUT, AM335X_GPIO_PULL_NONE);
	am335x_gpio_setup_pin
		(AM335X_GPIO1, 14, AM335X_GPIO_PIN_OUT, AM335X_GPIO_PULL_NONE);
}

uint32_t led_get_state() {
	uint32_t state = am335x_gpio_get_states (AM335X_GPIO1);
	return (state >> 12) & 0x7;
}

void led_set_state(uint32_t state) {
	am335x_gpio_change_states(AM335X_GPIO1, (~state & 0x7) << 12, false);
	am335x_gpio_change_states(AM335X_GPIO1, ( state & 0x7) << 12, true);
}
