#pragma once
#ifndef WHEEL_H_
#define WHEEL_H_

/*
 * wheel.h
 *
 *  Created on: 21.11.16
 *      Author: Samuel Riedo & Pascal Roulin
 */

enum state {INCR, DECR, NOP, PUSH};

/**
 * Return current state of wheel in state.
 */
extern enum state getWheelState();

/**
 * Initialise wheel.
 * This method shall be called prior any other.
 */
extern void initWheel();

#endif
