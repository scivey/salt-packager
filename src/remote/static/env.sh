#!/bin/bash

if [[ ! -v SALTED_PKG__ROOT_D ]]; then
    SALTED_PKG__ROOT_D=""
    SALTED_PKG__ROOT_D="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
fi

export SALTED_PKG__ROOT_D
if [[ ! -v SALTED_PKG__SRV_D ]]; then
    SALTED_PKG__SRV_D="$SALTED_PKG__ROOT_D/srv"
fi
export SALTED_PKG__SRV_D

if [[ ! -v SALTED_PKG__BIN_D ]]; then
    SALTED_PKG__BIN_D="$SALTED_PKG__ROOT_D/bin"
fi
export SALTED_PKG__BIN_D

if [[ ! -v SALTED_PKG__VENV_D ]]; then
    SALTED_PKG__VENV_D="${SALTED_PKG__ROOT_D}/venv"
fi
export SALTED_PKG__VENV_D

if [[ ! -v SALTED_PKG__PIP_REQS_D ]]; then
    SALTED_PKG__PIP_REQS_D="${SALTED_PKG__ROOT_D}/pip-requirements"
fi
export SALTED_PKG__PIP_REQS_D

SALTED_PKG__MINION_CONF_PATH="$SALTED_PKG__ROOT_D/minion"
export SALTED_PKG__MINION_CONF_PATH

export SALTED_PKG__LOGS_D="$SALTED_PKG__ROOT_D/log"
export SALTED_PKG__TMP_D="$SALTED_PKG__ROOT_D/tmp"
export SALTED_PKG__HASH_D="$SALTED_PKG__TMP_D/hash"

__check-cache-d() {
    local cache_d="$SALTED_PKG__ROOT_D/../salted-dev-cache/pip"
    if [[ -d "$cache_d" ]]; then
        SALTED_PKG__PIP_CACHE_D="$cache_d"
    else
        SALTED_PKG__PIP_CACHE_D=""
    fi
    export SALTED_PKG__PIP_CACHE_D
}
__check-cache-d; unset -f __check-cache-d
