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
 * Abstract: 	An introduction the ARM's assembler language
 *
 * Purpose:	Program to generate and print all the primer numbers up to MAX.
 *
 * Author: 	<author's>
 * Date: 	<date>
 */

// Export public symbols
	.global main, table

// Declaration of the constants
#define MAX 100
#define TRUE 1
#define FALSE 0

/* Initialized variables declation */
		.data					// Pour créer des variables initialisés
		.align	8				//
i :		.short 	0


/* Uninitialized variables declation */
		.bss						// Pour créer des vairables non initialisé
		.align	8
table:	.space 	MAX					// Table de 100 cases de 1 byte



// Implementation of assembler functions and methods
	.text
	.align	8

main:	nop
	// print banner...
	ldr	r0, =banner
	bl 	printf

	// Fill table with 1

	mov		r4, #TRUE
	ldr 	r5, =table		// r5 = first table element address
	ldr		r7, =i
	ldrh	r6, [r7]		// r6 = i
	mov		r7, #MAX

l1:
	strb 	r4, [r5]		// table[r5]=true=1
	add		r5, #1			// r5++
	add		r6, #1			// i++
	cmp		r6, r7			// i!=max
	bne		l1

// --------------------------------------------
// part 2

	ldr		r5,=table
	mov		r4, #FALSE
	mov		r6, #2			// i = 2

l2:
	mov		r8, r6, lsl #1	// j = 2i

l3:

	strb	r4, [r5, r8]	// table[j]=0

	cmp		r8, r7			// j != max
	add		r8, r6			// j+= i
	blo		l3

	add		r6, #1
	cmp		r6, r7			// i!=max
	bne		l2

// ---------------------------------------------

	mov		r6, #2			// i = 2
	ldr 	r5, =table		// r5 = first table element address
l4:
	ldrb 	r8, [r5, r6]	// r8 = table[i]

	cmp		r8, #1
	bne		nottrue

	ldr		r0, =format		// stuff for printing
	mov 	r1, r6
	bl 		printf			// print

nottrue:
	add		r6, #1			// i++
	cmp		r6, r7			// i!= max
	bne		l4

1:
	nop
	b 1b

// Constant variables declation (rom data)
	.section .rodata

// String definition used for message outputs (printf)
banner:	.ascii "\n"
	.ascii "HEIA-FR - Embedded Systems 1 Laboratory\n"
	.ascii "An introduction the ARM's assembler language\n"
	.ascii "--> Program to generate and print all the primer numbers up to MAX\n"
	.asciz "\n"

format:	.asciz "%d\n"

