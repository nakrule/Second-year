#pragma once
#ifndef DMTIMER1_H_
#define DMTIMER1_H_

#include <stdint.h>

/**
 * Initialize 1ms timer
 */
void dmtimer1_init();

/**
 * Return timer value as int
 */
uint32_t dmtimer1_get_counter();

#endif /* DMTIMER1_H_ */
