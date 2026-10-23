/*
 * =====================================================================================
 *
 *       Filename:  gzz_rfeadline.h
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2022-12-26 00:52:19
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Francis Grizzly Smit (FGJS), grizzly@smit.id.au
 *   Organization:
 *
 * =====================================================================================
 */

/* Alt Readline functions. */
/* Read a line of input.  Prompt with PROMPT.  A NULL PROMPT means none. */
/* Readline.h -- the names of functions callable from within readline. */

/* Copyright (C) 1987-2022 Free Software Foundation, Inc.

   This file is part of the GNU Readline Library (Readline), a library
   for reading lines of text with interactive input and history editing.

   Readline is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   Readline is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with Readline.  If not, see <http://www.gnu.org/licenses/>.
*/

#if !defined(_GZZ_READLINE_H_)
#define _GZZ_READLINE_H_

#ifdef __cplusplus
extern "C" {
#endif

#include <readline/readline.h>
#include <readline/rlconf.h>

#if defined(READLINE_CALLBACKS)

/* readline.c */
// extern void readline_internal_setup (void);
// extern char *readline_internal_teardown (int);
// extern int readline_internal_char (void);

// extern _rl_keyseq_cxt *_rl_keyseq_cxt_alloc (void);
// extern void _rl_keyseq_cxt_dispose (_rl_keyseq_cxt *);
// extern void _rl_keyseq_chain_dispose (void);

// extern int _rl_dispatch_callback (_rl_keyseq_cxt *);

/* callback.c */
// extern _rl_callback_generic_arg *_rl_callback_data_alloc (int);
// extern void _rl_callback_data_dispose (_rl_callback_generic_arg *);

#endif /* READLINE_CALLBACKS */

extern char *gzzreadline(const char *, const char *prefill);
extern char *readline(const char *);

extern char           *_rl_prefill;

#ifdef __cplusplus
}  // extern "C" //
#endif
#endif  // !defined (_GZZ_READLINE_H_)
