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
 * Abstract:	Introduction to the development environment
 *
 * Purpose:	Simple ARM assembler program to experiment the Embedded System
 *		Laboratory development environment under Git and Eclipse.
 *
 * Author: 	Samuel Riedo / Pascal Roulin
 * Date: 	21.09.2016
 */

/* Export public symbols */
	.global main, res, incr, i


/* Constants declaration */
#define LOOPS 8


/* Initialized variables declation */
		.data					// Pour créer des variables initialisés
		.align	8				// 
res :	.long 	16				// Crée une variable appelée res de 4 bytes contenant 16
incr :	.short 	32				// Crée une variable appelée incr de 2 bytes contenant 32


/* Uninitialized variables declation */
	.bss						// Pour créer des vairables non initialisé
	.align	8
i:	.space 	4					// Crée une variable de 4 bytes appelée i non initialisée


/* Implementation of assembler functions and methods */
	.text						// Indique le début du programme
main:	nop
	// print banner...
	ldr	r0, =banner
	bl 	printf

	/* start to implement your code here */
		mov		r0, #LOOPS		// Place la valeur de LOOPS dans r0 (r0 = 8)
		ldr		r1, =incr 		// r1 = adresse de incr
		ldrh	r1, [r1]		// r1 = valeur de incr
		ldr		r3, =res		// r3 = address de res
		ldr		r4, =i 			// r4 = address de i
		mov		r5, #0			// r5 prend la valeur 0
		str		r5, [r4]		// i = valeur de r5
next:	ldr		r2, [r3]		// r2 = valeur de res
		add		r2, r1			// r2 += r1
		str		r2, [r3]		// res = 48
		ldr		r5, [r4]		// r5 = i
		add		r5, #1			// r5 += 1
		str		r5, [r4]		// i = r5
		cmp		r5, r0			// compare les valeurs de r5 et r0
		bne		next			// si r5 n'est pas égal à r0, goto next

1:	nop							// le 1 avant
	b	1b						// branch (=goto) 1BACK (le 1 avant)
	bx	lr

1:	nop							// le 1 après, faire 1f (forward) pour l'atteindre
// Constant variables declation (rom data)	
	.section .rodata

// String definition used for message outputs (printf)
banner:	.ascii "\n"
	.ascii "HEIA-FR - Embedded Systems 1 Laboratory\n"
	.ascii "An introduction to the development environment\n"
	.ascii "--> Simple ARM assembler program to experiment the Embedded System\n"
	.ascii "    Laboratory development environment under Git and Eclipse.\n"
	.asciz "\n"

