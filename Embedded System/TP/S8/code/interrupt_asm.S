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
 * Project:	HEIA-FR / Embedded Systems 2 Laboratory
 *
 * Purpose: ARM assembler library using to get/print the registers, silicon ID and main ID.
 *
 * Author: 	Samuel Riedo / Pascal Roulin
 * Date: 	7.03.17
 */

/* Export public symbols */
.global ASMInterruptionInitialization, interruptEnable, interruptDisable

#define AM335X_VECTOR_BASE_ADDR 0x40300000 // L3 OCMC memory address
// stack = 8kiB for each mode
#define irqStackTop (AM335X_VECTOR_BASE_ADDR+0x2000)
#define svcStackTop (AM335X_VECTOR_BASE_ADDR+0x6000)
#define abtStackTop (AM335X_VECTOR_BASE_ADDR+0x8000)
#define undStackTop (AM335X_VECTOR_BASE_ADDR+0x10000)


/* Constants declaration */


/* Initialized variables declation */
.data					                                                 			// Initialized variables
.align	8                                                       		// declaration

/*
* This macro prepare the system before the interruption handler
*/
.macro myMacro offset, vector
	sub lr,lr,#\offset
	stmfd sp!,{r0-r12,lr}
	ldr r0, =\vector
	ldr r1,=AM335X_VECTOR_BASE_ADDR
	ldr r1,[r1]
	add r1,#\offset
	ldr r2, interruptHandler
	blx r2
	ldmfd sp!,{r0-r12,pc}^
.endm

interruptVectorStart:                                              	// interrupt vector
	b resetHandler
	b undefined_handler
	b software_handler
	b prefetch_handler
	b data_handler
	b reserved_handler
	b irq_handler

resetHandler: 			b resetHandler
undefined_handler: 		myMacro 0,0
software_handler: 		myMacro 0,1
prefetch_handler: 		Mymacro 4,2
data_handler: 			Mymacro 4,3
reserved_handler: 		b reserved_handler
irq_handler: 			myMacro 4,4

interruptHandler: .long 0
interruptVectorEnd:

/* Uninitialized variables declation */
.bss
.align	8

/* Implementation of assembler functions and methods */
.text						                                                   	// Program start



interruptEnable:
	mrs r0, cpsr
	bic r0, #0x80                                                   	// bic = and not
	msr cpsr, r0
	bx lr

interruptDisable:
	mrs r0, cpsr
	orr r0, r0, #0x80
	msr cpsr, r0
	bx lr

ASMInterruptionInitialization:
	push {lr}
	msr cpsr_c, #0xd2					                                        // Switch to IRQ mode, interrupt desactivated
	ldr sp,=irqStackTop				                                        // Define sp for IRQ
	msr cpsr_c, #0xd7					                                        // Switch to Abort mode
	ldr sp,=abtStackTop				                                        // Define sp for Abort
	msr cpsr_c,#0xdb					                                        // Switch to undef mode
	ldr sp,=undStackTop				                                        // Define sp for undef
	msr cpsr_c,#0xd3					                                        // Switch to supervisor mode
	ldr r1,=AM335X_VECTOR_BASE_ADDR
	mcr p15,#0,r1,c12,c0,#0				                                    // Define vector table address
	ldr	r1, =interruptHandler
	str r0, [r1]						                                        	// interruptHandler = init1_handler
	ldr	r0, =AM335X_VECTOR_BASE_ADDR	                                // Load parameters for memcpy
	ldr r1, =interruptVectorStart
	ldr r2, =(interruptVectorEnd-interruptVectorStart)
	bl	memcpy							                                        	// Save vectors table
	pop {pc}
