# HTOOLCHAIN - Toolchain and cross building environment tool

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

Please use this wrappers if posible:

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

## Help

gcc-info

    Usage: CC=gcc CFLAGS=-std=c99 gcc-info [-d]
    
    Get information from a gcc compiler.
    
    -d : List default defines.

hautotools

    Usage: hautotools ...
    
    A wrapper around GNU Autotools projects.
    
    ... show              : Show configuration.
    ... autogen           : Execute './autogen.sh' if it exists, otherwise 'autoreconf -fi'.
    ... all CARGS...      : clean, configure, make, make install.
    ... clean             : Execute `make clean`.
    ... configure ARGS... : Execute the `./configure ...` step.
    ... make              : Execute `make ...`.
    ... install           : Execute `make install ...`.

hcmake

    Usage: hcmake ...
    
    ... show                     : Show cmake variables.
    ... toolchain                : Print the toolchain file.
    ... clean                    : Remove build directory.
    ... configure CMAKE-ARGS ... : Execute `cmake`.
    ... build      MAKE-ARGS ... : Execute `make`.
    ... install    MAKE-ARGS ... : Execute `make install`.
    ... all       CMAKE-ARGS ... : Execute all above.

hcross

    Usage: hcross [OPTS...] [CMD...]
           hcross -w [COLLECTION]
    
    Execute command or function with a toolchain.
    
    -t l|TOOLCHAIN : Load toolchain.
    -v             : Show variables.
    
    -p PREFIX    : Use this prefix.
    -d DESTDIR   : Use this destination directory.
    -D           : When native install dependencies.
    -S           : Try to build static libraries/executables.
    
    -w           : Run command by `build_{CMD}`

hcross-env-c

    Usage: hcross-env-c OPTIONS...
    
    Setup a cross C/C++ compilation environment.
    
    ... ld=PROG              : Use this linker.
    ... ldflags=FLAGS        : Linker flags.
    ... cflags=FLAGS         : C/C++ compiler flags.
    ... cppflags=FLAGS       : C/C++ preprocessor flags.
    ... type=gnu/clang       : Compiler type.
    ... prefix=PREFIX        : Default prefix (defaults to /usr/local).
    ... tool_prefix=TPREFIX  : Tool prefix, ie "x86_64-linux-gnu-". 
    ... prefixes="P1 P2 ..." : Dependency search path. 

hgmake

    Usage: hgmake [clean] [all] [install] [OPTION=VALUE ...]
    
    This is a wrapper around GNU/Make that takes environment variables
    and hbuild variables.

hmeson

    Usage: hmeson ...
    
    ... show          : Show meson variables.
    ... toolchain.txt : Print the toolchain file.
    
    ... clean                    : Remove build directory.
    ... configure MESON-ARGS ... : Execute meson.
    ... build     NINJA-ARGS ... : Execute ninja to build.
    ... install   NINJA-ARGS ... : Execute ninja to install.
    
    ... all : Clean, configure, build, install.

htest

    Usage: htest [SUITE [TEST|all]]
    
    This program helps launching tests written in bash(1) language.
    
    A "test suite" is defined as a directory, a "test" is defined as
    a bash script inside that directory. "htest" searches tests in this
    order: 
    
        - PWD/tests                   : It gets the name "local".
        - /usr/local/share/NAME/tests : Installed on /usr/local.
        - /usr/share/NAME/tests       : Installed on /usr
    
    A "test" must end in ".sh". It runs in the following environment.
    
        - PATH+= The directory containing the tests directory.
        - PATH+= The tests directory.
        - PATH+= The directory named "build" next to "tests" dir.
        - PATH+= /usr/local/bin.
        - PWD  = The directory the test is placed in.
    
    Available commands:
    
    ... ls    [SUITE] [REGEX] : List test suites.
    ...       SUITE   [REGEX] : Run tests in suite.

setup-devel-c-native

    Usage: setup-devel-c-native ...
    
    Install and maintain a C/C++ toolchain for the native platform.
    
    ... local-enable  : Enable `/usr/local` for compiling.
    ... local-disable : Disable `/usr/local` for compiling.
    ... install       : Install native compilation tools.
    ... versions      : Show native compilation tool versions.
    
    ... mingw32 i|r   : Install/Remove MS Windows 32 compiler.

sysroot-fix

    Usage: sysroot-fix -lkp DIRECTORY...
    
    -l : Fix links in directory.
    -p : Fix permissions.
    -k : Fix pkgconfig.

