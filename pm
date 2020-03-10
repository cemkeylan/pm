#!/bin/sh
umask 077
error() { printf '\033[1;31m!> \033[merror: %s\n' "$@" >&2 ;}
die() { error "$1" ; exit 1 ;}

PM_DIR="${PM_DIR:-$HOME/.local/share/pm}"
usage() { printf '\033[1;36m-> \033[m%s\n' "usage: ${0##*/} [a|d|l|s] [options]" "" \
        "[a]dd  <name> - Reads the password from stdin to the given entry" \
        "[d]el  <name> - Deletes given enry" \
        "[l]ist        - Lists all the passwords" \
        "[s]how <name> - Shows the given password" "" \
        "VARIABLES:" "PM_DIR:      $PM_DIR" "PM_GPG_USER: $PM_GPG_USER" >&2 ; exit "${1:-0}" ;}

gpg="$(command -v gpg2 || command -v gpg)" || die "gnupg cannot be found"
case "$1" in
    a|add)
        [ "$2" ] || usage 1
        [ "$PM_GPG_USER" ] || die "Please set a \$PM_GPG_USER variable"
        [ -e "$PM_DIR/$2.asc" ] && die "an entry for $2 already exists"
        mkdir -p "$PM_DIR"
        tr -d '\n' < /dev/stdin > "$PM_DIR/$2"
        "$gpg" -e -a -r "$PM_GPG_USER" -- "$PM_DIR/$2" ||
            error "Could not encrypt password"
        rm -f "$PM_DIR/$2"
        ;;
    d|del) [ "$2" ] || usage 1 ; rm -f "$PM_DIR/$2.asc" ;;
    l|ls|list) { find "$PM_DIR" -type f -name '*asc' 2>/dev/null || ls -1 "$PM_DIR"/*.asc ;} | sort ;;
    s|show)
        [ "$2" ] || usage 1
        [ -r "$PM_DIR/$2.asc" ] || 
            die "Entry for $2 doesn't exist or is not readable"
        "$gpg" --decrypt "$PM_DIR/$2.asc" 2>/dev/null | tr -d '\n' ||
            die "Could not decrypt $PM_DIR/$2.asc"
        ;;
    *) usage 0 ;; esac
