/**
 * Copyright 2017 University of Applied Sciences Western Switzerland / Fribourg
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
 * Project:	HEIA-FR / Embedded Systems 2 Laboratory
 *
 * Abstract: 	Interrupt handling demo and test program
 *
 * Purpose:	Main module to demonstrate and to test the ARM Cortex-A8 
 *              low level interrupt handling.
 *
 * Author: 	Samuel Riedo & Pascal Roulin
 * Date: 	7.03.17
 */

#include "exception.h"
#include "interrupt.h"

/**
 * Called by init1_handler when an interrupt with an unknow vector occurs.
 * Display interrupt vector and interrupt parameter in minicom.
 * If exception is interrupt prefetch, freeze the cpu with an infinite loop.
 */
void exceptionHandler(enum interrupt_vectors vector, void* param) {

  printf("ARM Exception with vector %d and param %s\n", vector, (char*) param);
  if (vector == INT_PREFETCH) {
    for (;;)
      ;                    // infinite loop when prefetch exception
  }
}

void exceptionInitialization() {
  interruptionAttach(INT_UNDEF, exceptionHandler, "undefined instruction");
  interruptionAttach(INT_SVC, exceptionHandler, "software interrupt");
  interruptionAttach(INT_PREFETCH, exceptionHandler, "prefetch abort");
  interruptionAttach(INT_DATA, exceptionHandler, "data abort");
}
