#pragma once
#ifndef SEG7_H_
#define SEG7_H_

/*
 * seg7.h
 *
 *  Created on: 23.11.16
 *      Author: Samuel Riedo & Pascal Roulin
 */

/** 
 * Initialize GPIOs for the 7-seg
 */
 void seg7_init();

/**
 * Display a value on the 7-seg
 */
void seg7_display_value (int value);

/**
 * Display a value on the 7-seg
 * If it's less than 100, put de dot between the numbers
 * if it's 100 or higher, only print the first two number without a dot
 */
void seg7_display_float(uint32_t counter);

/**
 * Print two value and a dot
 * @param1: decimal (uint32_t)
 * @param2: tens (uint32_t)
 * @param3: dot (bool)
 */
void print_value(uint32_t unit, uint32_t tenth, bool dot);

#endif /* SEG7_H_ */
