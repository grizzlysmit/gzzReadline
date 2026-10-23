Table of Contents
-----------------

  * [NAME](#name)

  * [AUTHOR](#author)

  * [VERSION](#version)

  * [TITLE](#title)

  * [SUBTITLE](#subtitle)

  * [COPYRIGHT](#copyright)

  * [Introduction](#introduction)

  * [class Gzz_readline](#class-gzz_readline) or [on raku.land class Gzz_readline](#class-gzz-readline)

NAME
====

Gzz::Readline 

AUTHOR
======

Francis Grizzly Smit (grizzly@smit.id.au)

VERSION
=======

0.1.24

TITLE
=====

Gzz::Readline

SUBTITLE
========

A Raku module to do basic prompting with editing and like readline but with the ability to prefill the value.

COPYRIGHT
=========

LGPL V3.0+ [LICENSE](https://github.com/grizzlysmit/Syntax-Highlighters/blob/main/LICENSE)

[Top of Document](#table-of-contents)

Introduction
============

A Raku module to do basic prompting with editing and like readline but with the ability to prefill the value.

**NB: I use the NativeCall module to get at a C library `gzz_readline.so` which is a fork of the `readline` library, I had to fork it as it doesn't normally allow you to prefill the value**

NOTE: This prompt package is based on gnu readline.
---------------------------------------------------

I have modified the **Readline** **C** code to provide the required .so files. The only difference is that it supports prefilling the edit buffer with text to edit, so it is easier to fix your mistakes and/or start with the previous value or whatever value the developer wants to supply. It's licence is GPL v3 or above, enjoy.

class Gzz_readline
------------------

```raku
class Gzz_readline is export 

   sub LIBGZZ_READLINE {
        ....
        .....
    }

    #
    # gzz_readline functions.
    #
    sub gzzreadline( Str, Str ) is export returns Str
        is native( LIBGZZ_READLINE ) { * }

    method gzzreadline(Str:D $prompt, Str:D $prefill) returns Str {
        gzzreadline( $prompt, $prefill )
    }

}
```

[Top of Document](#table-of-contents)

