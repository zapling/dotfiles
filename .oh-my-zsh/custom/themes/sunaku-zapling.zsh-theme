
# My variation of the "sunaku" theme.

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[red]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[red]%}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[red]%}#"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[red]%}?"

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=" "
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

local user_color='green'
test $UID -eq 0 && user_color='red'

PROMPT='%(?..%{$fg_bold[red]%}exit %?
%{$reset_color%})'\
'%{$bold_color%}$(git_prompt_status)%{$reset_color%}'\
'%10>..>$(git_prompt_info)%>>'\
'%{$fg_bold[$user_color]%}%~%{$reset_color%}'\
'%(!.#. $) '

PROMPT2='%{$fg[red]%}\ %{$reset_color%}'

RPROMPT='%{$fg[yellow]%}${command_benchmark} %{$fg[green]%}⧖ %{$fg[white]%}%D{%H:%M}%{$reset_color%}'

# preexec runs before each command is executed.
preexec() {
    time_before_command=$(date +%s)
}

# precmd runs before prompt is printed.
precmd() {
    if [[ ! -z $time_before_command ]]; then
        command_benchmark=$(format_timestamp $(benchmark))
    else
        command_benchmark=''
    fi
    unset time_before_command
}

benchmark() {
    echo $(($(date +%s) - time_before_command))
}

# Takes N seconds and returns string with format `Xh Ym Zs` where X, Y, Z are numbers.
# Skips time unit when 0
# Skips seconds if hours > 0
format_timestamp() {
    local hour=$(($1 / 3600))
    local min=$(($1 / 60 - $hour * 60))
    local sec=$(($1 - $min * 60 - $hour * 3600))

    local hour_str=$((($hour > 0)) && echo "${hour}h" || echo '')
    local min_str=$((($min > 0)) && echo " ${min}m" || echo '')
    local sec_str=$((($hour == 0 && $sec > 0)) && echo " ${sec}s" || echo '')
    echo ${hour_str}${min_str}${sec_str}
}
