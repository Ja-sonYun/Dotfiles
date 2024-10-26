#!/bin/zsh

fix_grammar_with_openai() {
    zle -R "[Fixing grammar with OpenAI...]"

    if [[ -z $BUFFER ]]; then
        return
    fi

    local current_input="${LBUFFER}${RBUFFER}"
    local fixed_text=$($GLOBAL_PYTHON $CONFIG/zsh/zle/_better_grammar.py $current_input)

    LBUFFER="${fixed_text}"
    RBUFFER=""
}

zle -N fix_grammar_with_openai
