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
 * Abstract:	Introduction to device driver development in C
 *
 * Purpose:	Demo program implementing a basic timer and countdown
 *		application, which is based on the AM335x DMTimer1 timer.
 *
 * Author: 	Samuel Riedo & Pascal Roulin
 * Date: 	23.11.16
 */

#include <stdio.h>
#include <stdbool.h>
#include <stdint.h>
#include <am335x_clock.h>

#define TIOCP_CFG_SOFTRESET (1<<1)
#define TISTAT_RESETDONE (1<<0)
#define TCLR_AR (1<<1)
#define TCLR_ST (1<<0)


struct timer1_ctrl {
  uint32_t tidr; //00
  uint32_t unused[3];	//04-0c
  uint32_t tiocp_cfg;
  uint32_t tistat;
  uint32_t tisr;
  uint32_t tier;
  uint32_t twer;
  uint32_t tclr;
  uint32_t tcrr;
  uint32_t tldr;
  uint32_t ttgr;
  uint32_t twps;
  uint32_t tmar;
  uint32_t tcar1;
  uint32_t tsicr;
  uint32_t tcar2;
  uint32_t tpir;
  uint32_t tnir;
  uint32_t tcvr;
  uint32_t tocr;	//54
  uint32_t towr;	//5c
};

static volatile struct timer1_ctrl* timer1 = (volatile struct timer1_ctrl*) 0x44e31000;
static bool is_initialized = false;

void dmtimer1_init() {
	if(is_initialized) return;
	am335x_clock_enable_timer_module (AM335X_CLOCK_TIMER1);

	timer1-> tiocp_cfg = TIOCP_CFG_SOFTRESET;
	while ((timer1-> tistat & TISTAT_RESETDONE) == 0);
	timer1->tldr = 0;
	timer1->tcrr = 0;
	timer1->ttgr = 0;
	timer1->tclr = TCLR_AR | TCLR_ST;

	is_initialized = true;
}

uint32_t dmtimer1_get_counter() {
	return timer1->tcrr;
}
