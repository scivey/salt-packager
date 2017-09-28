__tracing-u-hr-helper() {
    printf '\n%*s\n' "32" ""
}                                        
__tracing-u-hr-top() {
    __tracing-u-hr-helper | tr ' ' '='        
}
__tracing-u-hr-bottom() {
    __tracing-u-hr-helper | tr ' ' '-'
}

__tracing-meta-log() {
    echo "[tracing] $*" >&2
}

__tracing-dump-stack() {
    local ind_size="2"
    __tracing-u-hr-top
    printf 'STACKTRACE:\n' ;
    printf '%*sFRAME_COUNT: %s\n' "$ind_size" "" "${#FUNCNAME[@]}" ;
    printf '%*sFRAMES:\n' "$ind_size" "" ;
    {
        declare -i stack_top=0 stack_idx=0 sanity=0 sanity_lim=10000 ;
        declare -i bashed_stack_offset=0 calc_frame_h=0 ;
        stack_top=${#FUNCNAME[@]} ;
        local frame_src=""
        while [[ $stack_idx -lt $stack_top ]]; do
            let sanity=$sanity+1
            if [[ $sanity -gt $sanity_lim ]]; then
                __tracing-meta-log "WARNING: exceeded sanity_lim of $sanity_lim in loop" ;
                break ;
            fi
            declare -i adj_frame_height=0 ;
            let adj_frame_height=$stack_top-$stack_idx ;
            adjh_str="$adj_frame_height"
            printf 'STACK_FRAME:\n' ;
            printf '%*sFUNCNAME_IDX: %s\n' "$ind_size" "" "$stack_idx" ;
            printf '%*sHEIGHT: %s\n' "$ind_size" "" "$adjh_str" ;
            printf '%*sFUNCNAME: %s\n' "$ind_size" "" "${FUNCNAME[$stack_idx]}";
            printf '%*sBASH_SOURCE: %s\n' "$ind_size" "" "${BASH_SOURCE[$stack_idx]}" ;
            printf '%*sBASH_LINENO: %s\n' "$ind_size" "" "${BASH_LINENO[$stack_idx]}" ;
            let stack_idx=$stack_idx+1
        done
    } | sed -r 's/^/    /' ;
    printf '\nEND_STACKTRACE\n' ;
    __tracing-u-hr-top
}
