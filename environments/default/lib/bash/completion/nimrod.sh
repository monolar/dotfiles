#!/bin/bash

# Bash completion for the Nimrod programming language (http://nimrod-lang.org)
# based on the tutorial at
# http://www.debian-administration.org/article/317/An_introduction_to_bash_completion_part_2.

# Pass as first parameter the word to complete and replace nim|tmpl files.
_nimrod_complete_compilable_files()
{
    local cur
    cur="$1"
    COMPREPLY=($(compgen -f -- ${cur}))
    # Remove files which don't end in "nim" or "tmpl". See
    # http://stackoverflow.com/a/13695061/172690.
    for idx in ${!COMPREPLY[@]}; do
        ext=${COMPREPLY[$idx]}
        ext=${ext##*.}
        if test "$ext" != "nim" -a "$ext" != "tmpl"; then
            unset -v COMPREPLY[$idx]
        fi
    done
}

# Use this to expand compilation commands.
_nimrod_expand_compile_switches()
{
    local cur opts
    cur="${COMP_WORDS[COMP_CWORD]}"
    opts="-p: --path: -d: --define: -u: --undef: -f --forceBuild"
    opts="${opts} --stackTrace --lineTrace --threads -x: --checks:"
    opts="${opts} --objChecks: --fieldChecks: --rangeChecks: --boundChecks:"
    opts="${opts} --overflowChecks: -a: --assertions: --floatChecks:"
    opts="${opts} --nanChecks: --infChecks: --deadCodeElim:"
    opts="${opts} --opt: --app: -r --run -m: --mainmodule:FILE -o:"
    opts="${opts} --out:FILE --stdout --listFullPaths -w: --warnings:"
    opts="${opts} --hints: --lib: --import: --include: --nimcache:"
    opts="${opts} --header: -c --compileOnly --noLinking --noMain"
    opts="${opts} --genScript --os: --cpu: --debuginfo --debugger:"
    opts="${opts} -t: --passC: -l: --passL: --cincludes: --clibdir:"
    opts="${opts} --clib: --genMapping --project --docSeeSrcUrl:"
    opts="${opts} --lineDir: --embedsrc --threadanalysis:"
    opts="${opts} --tlsEmulation: --taintMode: --symbolFiles:"
    opts="${opts} --implicitStatic: --patterns: --skipCfg --skipUserCfg"
    opts="${opts} --skipParentCfg --skipProjCfg --gc: --index:"
    opts="${opts} --putenv: --babelPath: --excludePath:"
    opts="${opts} --dynlibOverride: --listCmd --parallelBuild:"
    opts="${opts} --verbosity: --cs:"
    COMPREPLY+=($(compgen -W "${opts}" -- ${cur}))
}

_nimrod_complete_idetools()
{
    local cur prev opts
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts="--track: --trackDirty: --suggest --def --context --usages --eval"
    # Attempt to provide file completion, but doesn't really work because bash
    # completion won't recognize --track: as part of the switch. If only the
    # compiler didn't have to invent its own parameter passing rules which
    # break escaping even more…
    case "${prev}" in
        --track|--track:)
            # Pass the current parameter without the prefix to complete file.
            _nimrod_complete_compilable_files "${prev:8}${cur}"
            ;;
        --trackDirty|--trackDirty:)
            # Pass the current parameter without the prefix to complete file.
            _nimrod_complete_compilable_files "${prev:13}${cur}"
            ;;
        *)
            COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
            ;;
    esac
}

_nimrod_complete_serve()
{
    local opts
    opts="--server.type: --server.port: --server.address:"
    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
}

_nimrod_compiler_base()
{
    local cur prev opts
    COMREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    #opts="--help --verbose --version"

    #if [[ ${cur} == -* ]] ; then
    #    COMPREPLY=( $(compgen -W "${opts}" -- ${cur}) )
    #    return 0
    #fi

    COMPREPLY=()
    case ${COMP_CWORD} in
        1)
            # If this is the first param, use these base completions.
            opts="c compile compileToC cc compileToCpp cpp compileToOC objc"
            opts="${opts} doc doc2 i"
            opts="${opts} rst2html rst2tex jsondoc buildIndex"
            opts="${opts} run genDepend dump --advanced"
            opts="${opts} check idetools serve -v --version -h --help"
            COMPREPLY=($(compgen -W "${opts}" -- ${cur}))
            return 0
            ;;
        *)
            # Switches should autocomplate based on first command. This case
            # should match exactly the one for a single command.
            local first
            first="${COMP_WORDS[1]}"
            case "${first}" in
                --advanced|-v|--version|-h|--help|i)
                    # No completion for these commands.
                    ;;
                buildIndex)
                    # Autocomplete directories.
                    if test "${prev}" == "buildIndex"; then
                        COMPREPLY=($(compgen -d -- ${cur}))
                    fi
                    ;;
                idetools)
                    _nimrod_complete_idetools
                    ;;
                serve)
                    _nimrod_complete_serve
                    ;;
                rst2html|rst2tex)
                    # Allow the index switch plus txt/rst files.
                    COMPREPLY=($(compgen -f -- ${cur}))
                    # Remove files which don't end in "nim" or "tmpl". See
                    # http://stackoverflow.com/a/13695061/172690.
                    for idx in ${!COMPREPLY[@]}; do
                        ext=${COMPREPLY[$idx]}
                        ext=${ext##*.}
                        if test "$ext" != "txt" -a "$ext" != "rst"; then
                            unset -v COMPREPLY[$idx]
                        fi
                    done
                    # And append the possible index switch.
                    opts="--index:on"
                    if test -z "${cur}"; then
                        COMPREPLY+=($(compgen -W "${opts}" -- ${cur}))
                    elif [[ ${cur} == -* ]] ; then
                        COMPREPLY+=($(compgen -W "${opts}" -- ${cur}))
                    fi
                    ;;
                *)
                    # By default add command completion for compilable files.
                    _nimrod_complete_compilable_files "${cur}"
                    if test -z "${cur}"; then
                        _nimrod_expand_compile_switches
                    elif [[ ${cur} == -* ]] ; then
                        _nimrod_expand_compile_switches
                    fi
            esac
            ;;
    esac

    return 0
}
# How does this work?
#COMP_WORDBREAKS=${COMP_WORDBREAKS//:}
complete -F _nimrod_compiler_base nimrod

# vim:expandtab tabstop=4 shiftwidth=4 syntax=sh
