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

For making bug reports, feature requests, support or consulting visit
one of the following links:

1. [gemini://harkadev.com/oss/](gemini://harkadev.com/oss/)
2. [https://harkadev.com/oss/](https://harkadev.com/oss/)
## Help

aarch64-linux-gnu-env


cc-vers

    Usage: cc-vers
    
    Print versions of C environment utilities.

gcc-env

    Usage: gcc-env
    
    Compilation environment to /var/lib/gcc prefix. It also searches
    for dependencies in /usr.

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
    
    Execute command or function with a toolchain.
    
    -t l|TOOLCHAIN : Load toolchain.
    -v             : Show variables.
    -o VAR=VAL     : Set variable.
    
    -p PREFIX    : Use this prefix.
    -d DESTDIR   : Use this destination directory.
    -T NAME      : Create tar file with `gettar(1)`.
    -D           : When native install dependencies.
    -S           : Try to build static libraries/executables.
    -R           : Use sudo when installing.
    -C           : Install configuration files. (Sets HBUILD_ICONF)
    
    -w           : Run command by `build_{CMD}`
    -b           : Bootstrap to the prefix.

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

hdeploy

    Usage: hdeploy [-t TOOLCHAIN][-p PREFIX][-o TAR][-r SSH][-S][-C DIR] COMMAND
    
    Create a tar file by executing COMMAND (with HBUILD_DESTDIR set) and
    upload to SSH (when specified) (with -S using sudo).

hgmake

    Usage: hgmake [options] [clean] [all] [install] [OPTION=VALUE ...]
    
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

hrelease

    Usage: hrelease [-V][-t TOOLCHAIN,...][-N NAME][-R VER] { -s | COMMAND }
    
    This program creates releases of a project with hdeploy(1), the generated
    files can be listed with "-s". The generated output list can be saved in
    a file with "-o".
    
    You can place the following in your makefile:
    
      TOOLCHAINS=x86_64-linux-musl aarch64-linux-musl x86_64-w64-mingw32
      release:
          mkdir -p $(BUILDDIR)
          hrelease -t "$(TOOLCHAINS)" -N $(PROJECT) -R $(VERSION) -o $(BUILDDIR)/Release
          gh release create v$(VERSION) $$(cat $(BUILDDIR)/Release)
    
    Environment variables: HBUILD_RELEASE_DIR

htriplet

    Usage: htriplet {-m, -s, -z, -p} TRIPLET|noarch-OS-SYS
    
    Print machine (-m) system (-s) archive format (-z) and preferred
    prefix (-p) of the tripplet.

img2tar

    Usage: img2tar [-o TARFILE][-n PARTITION] DISK
    
    From an image "DISK" get partition "PARTITION" and create
    a tar file.
    
    Requires: mount/umount/losetup/tar/fdisk/tar

make-h-release

    Usage: make-h-release ...
    
    Add "release" target to GNUmakefile that uses "htoolchain" that
    uploads built tars/zips to github.
    
      makefile    Print 'Makefile'.
      gitignore   Print '.gitignore'.
    
    You should add "TOOLCHAINS" variable to the makefile manually, for
    example: x86_64-w64-mingw32 x86_64-linux-musl

sysroot-fix

    Usage: sysroot-fix -lkp DIRECTORY...
    
    -l : Fix links in directory.
    -p : Fix permissions.
    -k : Fix pkgconfig.

tar-install

    Usage: tar-install [-v][-S][-r SSH][-p POD][-s CHROOT] TAR
    
    Extract a tar file with `-h -o -m --no-same-permissions` in
    the local or remote (-r) machine. Using sudo (-S).
    
    Never execute `tar -xf TAR -C /` as it can break links such
    as `/usr/lib -> /lib`. Use `tar-install` instead.

x86_64-linux-gnu-env


x86_64-w64-mingw32-env


