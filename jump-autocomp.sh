#compdef jump

_jump() {
    local state
    
    # Check if jq is available
    if ! command -v jq &> /dev/null; then
        return 1
    fi
    
    # Check if config file exists and is readable
    if [[ -z "$JUMP_COMP_CONFIG_PATH" || ! -f "$JUMP_COMP_CONFIG_PATH" ]]; then
        return 1
    fi
    
    # Validate JSON and read config
    local json
    if ! json=$(cat "$JUMP_COMP_CONFIG_PATH" 2>/dev/null) || ! jq empty <<< "$json" 2>/dev/null; then
        return 1
    fi
    
    local red=$(tput setaf 1 2>/dev/null || echo '')
    local green=$(tput setaf 2 2>/dev/null || echo '')
    local reset=$(tput sgr0 2>/dev/null || echo '')

    _arguments '*:: :->subcmd'

    if [[ "$state" == "subcmd" ]]; then
        if (( ${#words[@]} == 0 )); then
            local keys=$(jq -r 'if type=="object" then keys | join(" ") else "" end' <<< "$json" 2>/dev/null)
            if [[ $keys == "" ]]; then
                echo "${red}Invalid JSON configuration${reset}"
                _nothing
            else
                eval "compadd $keys"
            fi
        else
            local args=( "${words[@]}" )
            args[-1]=()
            local json_path=$(printf ".%s" "${args[@]}")
            local current_obj=$(jq "$json_path" <<< "$json" 2>/dev/null)
            local available_commands=$(jq -r 'if type=="object" then keys | join(" ") else "" end' <<< "$current_obj" 2>/dev/null)
            if [[ $available_commands == "" ]]; then
                printf "\n${green}${current_obj}${reset}\n"
                _nothing
            else
                eval "compadd $available_commands"
            fi
        fi
    fi
    return $?
}
