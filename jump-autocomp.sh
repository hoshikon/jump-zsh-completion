#compdef jump

_jump() {
    local state
    local json=$(cat $JUMP_COMP_CONFIG_PATH)
    local red=`tput setaf 1`
    local green=`tput setaf 2`
    local reset=`tput sgr0`

    _arguments '*:: :->subcmd'

    if [[ "$state" == "subcmd" ]]; then
        if (( ${#words[@]} == 0 )); then
            local keys=$(jq -r 'if type=="object" then keys | join(" ") else "" end' <<< "$json")
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
            local current_obj=$(jq "$json_path" <<< "$json")
            local available_commands=$(jq -r 'if type=="object" then keys | join(" ") else "" end' <<< "$current_obj")
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
