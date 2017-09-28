#!/bin/bash

# shellcheck source=./../env.sh
. "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/../env.sh"

# shellcheck disable=SC2034

salt-packager-remote::parse-forceable-args() {
    declare -n is_force="$1"; shift
    is_force=false
    local arg
    while [[ $# -gt 0 ]]; do
        arg="$1"; shift
        if [[ "$arg" == "-f" ]] || [[ "$arg" == "--force" ]]; then
            is_force=true
        else
            echo "ERR: Unexpected arg: '$arg'!" >&2
            return 1
        fi
    done
}

__err-trace() {
    echo "ERROR" >&2
    echo "BASH_COMMAND: '${BASH_COMMAND}'" >&2
    __tracing-dump-stack
}

salt-packager-remote::enable-err-tracing() {
    trap __err-trace 'ERR'
}