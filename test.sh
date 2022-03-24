#!/bin/sh -e
. hmain
. vrun
. lrun
sh_toolchain_test() {
    local LRUN_COL1=20 LRUN_COL2=20
    export LRUN_LOGDIR="${HOME}/.logs/htoolchain"
    mkdir -p "${LRUN_LOGDIR}"
    echo "LOG TO: ${LRUN_LOGDIR}" >&2
    ## Ensure all toolchains are built
    : lrun htoolchain-clfs    htoolchain-clfs    all
    lrun htoolchain-freebsd htoolchain-freebsd all
    lrun htoolchain-musl    htoolchain-musl    all
    ## Build all examples.
    : lrun example-clfs     hcross -t x86_64-ht-linux-gnu  -w example all
    lrun example-musl     hcross -t x86_64-linux-musl    -w example all
    lrun example-freebsd  hcross -t x86_64-linux-freebsd -w example all
}
sh_toolchain_test
