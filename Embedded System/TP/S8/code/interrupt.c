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

#include "interrupt.h"

// Method implemented in ASM
extern void ASMInterruptionInitialization(void (*)(enum interrupt_vector));

struct interruptionVector {                                               // Vector table entry
  interruptHandler handler;
  void* param;
};

static struct interruptionVector interruptionVectorTable[INT_NB_VECTORS]; // Vector table

/**
 * Called when an interrupt occurs. If there is an handler for the interruption's vector,
 * call this handler. Else, print an error message et freeze the program.
 */
void interruptionHandler(enum interrupt_vectors vector) {
  if (vector < INT_NB_VECTORS) {
    struct interruptionVector* handler = &interruptionVectorTable[vector];
    if (handler->handler != 0) {
      handler->handler(vector, handler->param);
    } else {
      printf("Error 404 - Interrupt handler for vector %d not found", vector);
      for (;;)
        ;
    }
  } else {
    printf("Black hole for vector %d", vector);
    for (;;)
      ;
  }
}

extern void interruptionInitialization() {
  ASMInterruptionInitialization(&interruptionHandler);
  memset(interruptionVectorTable, 0, sizeof(interruptionVectorTable)); // Fill vector table with 0
  interruptEnable();
}

extern int interruptionAttach(enum interrupt_vectors vector,
    interruptHandler function, void* param) {
  int status = -1;
  if (vector < INT_NB_VECTORS) {
    struct interruptionVector* handler = &interruptionVectorTable[vector];
    if (handler->handler == 0) {                            	       	// Test if there is already
      handler->handler = function;                                    // an handler for this
      handler->param = param;                                         // interrupt vector
      status = 0;
    }
  }
  return status;
}

extern void interruptionDetach(enum interrupt_vectors vector) {
  if (vector < INT_NB_VECTORS) {
    interruptionVectorTable[vector].handler = 0;
  }
}
