# Password Manager

Barebones password manager with absolutely no fancy features. By
that I mean,

- No password generation
- No git integration
- No questions asked
- No grepping/finding passwords
- No clipboard support
- No tree view
- Does not ask for password input (reads from stdin)
- Does not check for 'sneaky paths?'

Supports adding/deleting/listing/showing passwords. I don't
intend on implementing any more features. You can wrap this
script with something other to make use of it. See the contrib
directory for that.

Currently less than 35 SLOC. It's almost 20 times smaller
than `pass` which has a little less than 600 SLOC.


To install run, as root if necessary

    make install

You really do think that asking for password for twice blah
blah is a really important feature? Okay, then add a function
to your shellrc/profile like this.

    pmask() {
        [ "$1" ] || return 1
        printf 'Enter your password: '
        read pass
        printf 'Enter your password again: '
        read pass2
        [ "$pass" = "$pass2" ] && {
            printf '%s' "$pass" | pm a "$1" && return 0
        }
        printf "Passwords don't match\n"
        return 1
    }

You want to copy to clipboard? That's easy! You just need
to do a `pm s passname | xclip -sel c`. You can still make
it a function by doing this

    copypass() {
        [ "$1" ] || return 1
        pm s "$1" | xclip -sel c
    }

The whole rationale is that you can already do that with simple
commands. Why complicate (and possibly break) things by introducing
them into a single script? If you want some function that is
a must for you, implement it yourself with some script or
a shell function. This way, it works just as you intended it. Or use
helper functions that are located in contrib.

You can install contrib scripts by running

    make -C contrib install

