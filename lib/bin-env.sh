#!/bin/bash


if [[ -z "${SALT_PACKAGER__D+x}" ]]; then
    __sp_src=""
    if [[ ! -z "${BASH_SOURCE+x}" ]]; then
        __sp_src="${BASH_SOURCE[0]}"
    else
        __sp_src="$0"
    fi
    SALT_PACKAGER__D=""
    SALT_PACKAGER__D="$(dirname "$(realpath "$__sp_src")")"
    unset __sp_src
fi

export SALT_PACKAGER__D
export SALT_PACKAGER__SRC_D="$SALT_PACKAGER__D/src"
export SALT_PACKAGER__REMOTE_SRC_D="$SALT_PACKAGER__SRC_D/remote"
