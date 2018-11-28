#/usr/bin/env bash

# MetaMake (https://pypi.org/project/metamake/) bash completion

_mm_completions()
{
    complete -W "$(mm ls | grep -o '.*' | grep -Po '^\w+')" mm
    return 0
}

complete -F _mm_completions mm
