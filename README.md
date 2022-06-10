# HTOOLCHAIN - Toolchain and cross building environment tool

hcross, htoolchain-util, htoolchain-*.

## Getting Started

This scripts help the DevOps create custom cross building environments
and software building/deployment tools for their organization.

## Prerequisites

- GNU Coreutils/Busybox.
- HUTIL shell utilities [here](https://github.com/harkaitz/sh-hutil).
- GETSRC software download wrappers [here](https://github.com/harkaitz/sh-getsrc).
- GNU/Linux workstation, tested on [VOID Linux](https://voidlinux.org/).
- Build essentials: GNU/Make, ...

## Cross building environment

A cross building environment is composed by two parts: The *toolchain directory*,
where all the tools are installed, and the *environment script* which sets the
environment variables necessary for the building scripts.

1.- The toolchain directory is by default in */opt/htoolchain*

    > ls /opt/htoolchain/bin
    x86_64-ht-linux-gnu-g++
    x86_64-ht-linux-gnu-gcc
    ...
    > ls /opt/htoolchain/x86_64-ht-linux-gnu/include
    stdio.h
    ...

2.- The environment script is */usr/local/bin/TARGET-env*

    > . /usr/local/bin/x86_64-ht-linux-gnu-env
    > echo ${CC}
    x86_64-ht-linux-gnu-gcc

The DevOps can use *./bin/htoolchain-util* to write scripts that download
and build toolchains. This project includes some examples:

- *./bin/htoolchain-clfs*    : x86_64-ht-linux-gnu : A simple GCC compiler.
- *./bin/htoolchain-musl*    : x86_64-linux-musl   : MUSL libc cross compiler.
- *./bin/htoolchain-freebsd* : x86_64-pc-freebsd12 : FreeBSD 12 LLVM cross compiler.

## Automated building and deployment scripts.

You can write scripts that compile software independent of the target by using
*./bin/hcross*. For example:

    #!/bin/sh -e
    . getsrc-git
    . hcross
    build_my_project() {
        project="`getsrc_git "https://priv.organization.com/git/project"`"
        test -n "${project}"
        make -C "${project}" CC="${CC:-gcc}" ...
        ...
    }
    hcross -t "x86_64-ht-linux-gnu"      build_my_project
    hcross -t "x86_64-linux-androideabi" build_my_project
    ...

You can read some examples [here](./bin/build_example). This project contains
some wrappers around popular build tools.

- GNU Autotools [here](./bin/hautotools).
- CMake [here](./bin/hcmake).
- Meson [here](./bin/hmeson).

Wrappers around download tools:

- GETSRC [here]([here](https://github.com/harkaitz/sh-getsrc)).

Utities:

- sysroot-fix : Fix links, permissions and pkgconfig files in a sysroot. [here](./bin/sysroot-fix).

## Environment variables

### Generic environment variables

There are four environment variables that the DevOps should set in the
*environment script* regardless of the nature of the toolchain. This
variables are needed by *./bin/hcross*.

*HBUILD_DESTDIR, HBUILD_PREFIX*:

Write the script so that if this are not set point to the sysroot. For example:

    if test -n "${HBUILD_DESTDIR}";then
        export HBUILD_DESTDIR="${HBUILD_DESTDIR}"
        export HBUILD_PREFIX="${HBUILD_PREFIX:-/usr/local}"
    else
        export HBUILD_DESTDIR=
        export HBUILD_PREFIX="${HBUILD_PREFIX:-${prefix:-/usr/local}}"
    fi

*HBUILD_TOOLCHAIN*:

Set here the toolchain's name.

*HBUILD_SUDO*:

Write here whether *sudo* shall be used in the install step. For convenience
and security you can limit the usage of sudo by requiring it's usage only
when installing directly to a root owned directory.

    if test -e "${HBUILD_DESTDIR}${HBUILD_PREFIX}" && \
       test ! -w "${HBUILD_DESTDIR}${HBUILD_PREFIX}";then
        export HBUILD_SUDO=sudo
    else
        export HBUILD_SUDO=env
    fi

*HBUILD_VARS*:

The variables the script set. This is needed for the cleanup.

### C/C++ environment variables

You can use *hcross-env-c* to fill this environment variables automatically.

    #!/bin/sh -e
    . hcross-env-c
    hcross_env_c                              \
        type='gnu'                            \
        tool_prefix='x86_64-mytool-linux-gnu' \
        path='/opt/mytool/bin'                \
        prefix='/opt/mytool/sysroot/usr'      \
        prefixes='/opt/mytool/sysroot/usr /opt/mytool/sysroot'

You can write them manually:

- Tools: *CC,CXX,CPP,AR,AS,LD,RANLIB,READELF,STRIP,OBJCOPY,OBJDUMP,NM,WINDRES*.
- Flags: *CFLAGS,LDFLAGS,CPPFLAGS*.
- pkg-config flags: Should be one of this
  - *PKG_CONFIG_LIBDIR* : Do not get dependencies from the system.
  - *PKG_CONFIG_PATH* : Get dependencies from the system.
- *LT_SYS_LIBRARY_PATH* : Search path for libtool. Put */lib*s here.
- *ACLOCAL_PATH* : Search path for aclocal. Put */share/aclocal* here.

## Collaborating

For making bug reports, feature requests and donations visit
one of the following links:

1. [gemini://harkadev.com/oss/](gemini://harkadev.com/oss/)
2. [https://harkadev.com/oss/](https://harkadev.com/oss/)

