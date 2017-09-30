#pragma once
#ifndef LED_H
#define LED_H

#include <stdint.h>

/**
 * method to initialize the resoures of the LED
 * this method shall be called prior any other.
 */
extern void led_init();

/**
 * method to get state of the 3 LED.
 *
 * @return state of the 3 LED
 *	   	(bit0 <=> led1, bit1 <=> led2, bit2 <=> led3)
 *         	(bit=1 --> led on, bit=0 --> led off)
 */
extern uint32_t led_get_state();

/**
 * method to set state of the 3 LED.
 *
 * @param states of the 3 LED
 *		(bit0 <=> led1, bit1 <=> led2, bit2 <=> led3)
 *              (bit=1 --> led on, bit=0 --> led off)
 */
extern void led_set_state(uint32_t state);
#endif
