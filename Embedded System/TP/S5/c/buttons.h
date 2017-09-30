#pragma once
#ifndef BUTTONS_H
#define BUTTONS_H

/*
 * buttons.h
 *
 *  Created on: 23.11.16
 *      Author: Samuel Riedo & Pascal Roulin
 */

#include <stdint.h>

/**
 * Initialize buttons.
 * This method shall be called prior any other.
 */
extern void buttons_init();

/**
 * method to get state of the 3 press buttons.
 *
 * @return states of the 3 press buttons
 *		(bit0 <=> sw1, bit1 <=> sw2, bit2 <=> sw3)
 *         	(bit=1 --> button pressed, bit=0 --> button released)
 */
extern uint32_t buttons_get_state();

#endif
