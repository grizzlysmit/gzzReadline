/*
 * =====================================================================================
 *
 *       Filename:  gzz_rfeadline.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2022-12-26 00:52:18
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Francis Grizzly Smit (FGJS), grizzly@smit.id.au
 *   Organization:
 *
 * =====================================================================================
 */

#include "gzz_rlprivate.h"
#include "gzz_readline.h"
#include <stdio.h>
#include <stdlib.h>

/* Forward declarations used in this file. */
static char *readline_internal(void);


char           *_rl_prefill;

/* Read a line of input.  Prompt with PROMPT.  An empty PROMPT means
   none.  A return value of NULL means that EOF was encountered. */
char        *gzzreadline(const char *prompt, const char *prefill) {
    char *value;
#if 0
  int in_callback;
#endif

    /* If we are at EOF return a NULL string. */
    if (rl_pending_input == EOF) {
        rl_clear_pending_input();
        return ((char *)NULL);
    }

#if 0
  /* If readline() is called after installing a callback handler, temporarily
     turn off the callback state to avoid ensuing messiness.  Patch supplied
     by the gdb folks.  XXX -- disabled.  This can be fooled and readline
     left in a strange state by a poorly-timed longjmp. */
  if (in_callback = RL_ISSTATE (RL_STATE_CALLBACK))
    RL_UNSETSTATE (RL_STATE_CALLBACK);
#endif

    rl_set_prompt(prompt);

    rl_initialize();

    size_t l;
    if (prefill == NULL || *prefill == '\0') {
        l           = 0;
        _rl_prefill = (char *)NULL;
    } else {
        l           = strlen(prefill) + 1;
        _rl_prefill = (char *)xmalloc(l);
        strncpy(_rl_prefill, prefill, l);
    }
    rl_insert_text(_rl_prefill);

    if (rl_prep_term_function) (*rl_prep_term_function)(_rl_meta_flag);

#if defined(HANDLE_SIGNALS)
    rl_set_signals();
#endif

    value = readline_internal();
    if (rl_deprep_term_function) (*rl_deprep_term_function)();

#if defined(HANDLE_SIGNALS)
    rl_clear_signals();
#endif

#if 0
  if (in_callback)
    RL_SETSTATE (RL_STATE_CALLBACK);
#endif

#if HAVE_DECL_AUDIT_USER_TTY && defined(HAVE_LIBAUDIT_H) && \
    defined(ENABLE_TTY_AUDIT_SUPPORT)
    if (value) _rl_audit_tty(value);
#endif
    xfree(_rl_prefill);

    return (value);
}

#if defined(READLINE_CALLBACKS)
#define STATIC_CALLBACK
#else
#define STATIC_CALLBACK static
#endif

STATIC_CALLBACK int
#if defined(READLINE_CALLBACKS)
readline_internal_char(void)
#else
readline_internal_charloop(void)
#endif
{
    static int lastc, eof_found;
    int        c, code, lk, r;

    lastc = EOF;

#if !defined(READLINE_CALLBACKS)
    eof_found = 0;
    while (rl_done == 0) {
#endif
        lk = _rl_last_command_was_kill;

#if defined(HAVE_POSIX_SIGSETJMP)
        code = sigsetjmp(_rl_top_level, 0);
#else
    code = setjmp(_rl_top_level);
#endif

        if (code) {
            (*rl_redisplay_function)();
            _rl_want_redisplay = 0;

            /* If we longjmped because of a timeout, handle it here. */
            if (RL_ISSTATE(RL_STATE_TIMEOUT)) {
                RL_SETSTATE(RL_STATE_DONE);
                rl_done = 1;
                return 1;
            }

            /* If we get here, we're not being called from something dispatched
             from _rl_callback_read_char(), which sets up its own value of
             _rl_top_level (saving and restoring the old, of course), so
             we can just return here. */
            if (RL_ISSTATE(RL_STATE_CALLBACK)) return (0);
        }

        if (rl_pending_input == 0) {
            /* Then initialize the argument and number of keys read. */
            _rl_reset_argument();
            rl_executing_keyseq[rl_key_sequence_length = 0] = '\0';
        }

        RL_SETSTATE(RL_STATE_READCMD);
        c = rl_read_key();
        RL_UNSETSTATE(RL_STATE_READCMD);

        /* look at input.c:rl_getc() for the circumstances under which this will
        be returned; punt immediately on read error without converting it to
        a newline; assume that rl_read_key has already called the signal
        handler. */
        if (c == READERR) {
#if defined(READLINE_CALLBACKS)
            RL_SETSTATE(RL_STATE_DONE);
            return (rl_done = 1);
#else
        RL_SETSTATE(RL_STATE_EOF);
        eof_found = 1;
        break;
#endif
        }

        /* EOF typed to a non-blank line is ^D the first time, EOF the second
        time in a row.  This won't return any partial line read from the tty.
        If we want to change this, to force any existing line to be returned
        when read(2) reads EOF, for example, this is the place to change. */
        if (c == EOF && rl_end) {
            if (RL_SIG_RECEIVED()) {
                RL_CHECK_SIGNALS();
                if (rl_signal_event_hook) (*rl_signal_event_hook)(); /* XXX */
            }

            /* XXX - reading two consecutive EOFs returns EOF */
            if (RL_ISSTATE(RL_STATE_TERMPREPPED)) {
                if (lastc == _rl_eof_char || lastc == EOF)
                    rl_end = 0;
                else
                    c = _rl_eof_char;
            } else
                c = NEWLINE;
        }

        /* The character _rl_eof_char typed to blank line, and not as the
        previous character is interpreted as EOF.  This doesn't work when
        READLINE_CALLBACKS is defined, so hitting a series of ^Ds will
        erase all the chars on the line and then return EOF. */
        if (((c == _rl_eof_char && lastc != c) || c == EOF) && rl_end == 0) {
#if defined(READLINE_CALLBACKS)
            RL_SETSTATE(RL_STATE_DONE);
            return (rl_done = 1);
#else
        RL_SETSTATE(RL_STATE_EOF);
        eof_found = 1;
        break;
#endif
        }

        lastc = c;
        r     = _rl_dispatch((unsigned char)c, _rl_keymap);
        RL_CHECK_SIGNALS();

        if (_rl_command_to_execute) {
            (*rl_redisplay_function)();

            rl_executing_keymap = _rl_command_to_execute->map;
            rl_executing_key    = _rl_command_to_execute->key;

            _rl_executing_func  = _rl_command_to_execute->func;

            rl_dispatching      = 1;
            RL_SETSTATE(RL_STATE_DISPATCHING);
            r = (*(_rl_command_to_execute->func))(_rl_command_to_execute->count,
                                                  _rl_command_to_execute->key);
            _rl_command_to_execute = 0;
            RL_UNSETSTATE(RL_STATE_DISPATCHING);
            rl_dispatching = 0;

            RL_CHECK_SIGNALS();
        }

        /* If there was no change in _rl_last_command_was_kill, then no kill
       has taken place.  Note that if input is pending we are reading
       a prefix command, so nothing has changed yet. */
        if (rl_pending_input == 0 && lk == _rl_last_command_was_kill)
            _rl_last_command_was_kill = 0;

        _rl_internal_char_cleanup();

#if defined(READLINE_CALLBACKS)
        return 0;
#else
}

return (eof_found);
#endif
    }

#if defined(READLINE_CALLBACKS)
    static int readline_internal_charloop(void) {
        int eof = 1;

        while (rl_done == 0) eof = readline_internal_char();
        return (eof);
    }
#endif /* READLINE_CALLBACKS */

    static char *readline_internal(void) {
        readline_internal_setup();
        // rl_insert_text(_rl_prefill);
        rl_eof_found = readline_internal_charloop();
        return (readline_internal_teardown(rl_eof_found));
    }
