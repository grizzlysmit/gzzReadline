/*
 * =====================================================================================
 *
 *       Filename:  gzz_rlprivate.c
 *
 *    Description:
 *
 *        Version:  1.0
 *        Created:  2022-12-26 06:22:46
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  Francis Grizzly Smit (FGJS), grizzly@smit.id.au
 *   Organization:
 *
 * =====================================================================================
 */

// #define READLINE_LIBRARY

#if defined(HAVE_CONFIG_H)
#include <config.h>
#endif
#include "gzz_rlprivate.h"
#include <stdlib.h>

#include <sys/types.h>
#include <fcntl.h>
#if defined(HAVE_SYS_FILE_H)
#include <sys/file.h>
#endif /* HAVE_SYS_FILE_H */

#if defined(HAVE_UNISTD_H)
#include <unistd.h>
#endif /* HAVE_UNISTD_H */

#if defined(HAVE_STDLIB_H)
#include <stdlib.h>
#else
#endif /* HAVE_STDLIB_H */

#if defined(HAVE_LOCALE_H)
#include <locale.h>
#endif

#include <stdio.h>
#include <errno.h>

#if !defined(errno)
extern int errno;
#endif /* !errno */

/* System-specific feature definitions and include files. */

#if defined(__EMX__)
#define INCL_DOSPROCESS
#include <os2.h>
#endif /* __EMX__ */

#if HAVE_DECL_AUDIT_USER_TTY && defined(HAVE_LIBAUDIT_H) && \
    defined(ENABLE_TTY_AUDIT_SUPPORT)
#include <sys/socket.h>
#include <libaudit.h>
#include <linux/audit.h>
#include <linux/netlink.h>

/* Report STRING to the audit system. */
void _rl_audit_tty(char *string) {
    struct audit_message req;
    struct sockaddr_nl   addr;
    size_t               size;
    int                  fd;

    fd = socket(PF_NETLINK, SOCK_RAW, NETLINK_AUDIT);
    if (fd < 0) return;
    size = strlen(string) + 1;

    if (NLMSG_SPACE(size) > MAX_AUDIT_MESSAGE_LENGTH) return;

    memset(&req, 0, sizeof(req));
    req.nlh.nlmsg_len   = NLMSG_SPACE(size);
    req.nlh.nlmsg_type  = AUDIT_USER_TTY;
    req.nlh.nlmsg_flags = NLM_F_REQUEST;
    req.nlh.nlmsg_seq   = 0;
    if (size && string) memcpy(NLMSG_DATA(&req.nlh), string, size);
    memset(&addr, 0, sizeof(addr));

    addr.nl_family = AF_NETLINK;
    addr.nl_pid    = 0;
    addr.nl_groups = 0;

    sendto(
        fd, &req, req.nlh.nlmsg_len, 0, (struct sockaddr *)&addr, sizeof(addr));
    close(fd);
}
#endif  // HAVE_DECL_AUDIT_USER_TTY && defined (HAVE_LIBAUDIT_H) && defined
        // (ENABLE_TTY_AUDIT_SUPPORT) //
/* **************************************************************** */
/*								    */
/*		   Memory Allocation and Deallocation.		    */
/*								    */
/* **************************************************************** */

static void memory_error_and_abort(const char *fname) {
    fprintf(stderr, "%s: out of virtual memory\n", fname);
    exit(2);
}

/* Return a pointer to free()able block of memory large enough
   to hold BYTES number of bytes.  If the memory cannot be allocated,
   print an error message and abort. */
PTR_T
xmalloc(size_t bytes) {
    PTR_T temp;

    temp = malloc(bytes);
    if (temp == 0) memory_error_and_abort("xmalloc");
    return (temp);
}

PTR_T
xrealloc(PTR_T pointer, size_t bytes) {
    PTR_T temp;

    temp = pointer ? realloc(pointer, bytes) : malloc(bytes);

    if (temp == 0) memory_error_and_abort("xrealloc");
    return (temp);
}

void xfree(PTR_T string) {
    if (string) free(string);
}
