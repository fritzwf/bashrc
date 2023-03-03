# To the extent possible under law, the author(s) have dedicated all 
# copyright and related and neighboring rights to this software to the 
# public domain worldwide. This software is distributed without any warranty. 
# You should have received a copy of the CC0 Public Domain Dedication along 
# with this software. 
# If not, see <https://creativecommons.org/publicdomain/zero/1.0/>. 

# /etc/bash.bashrc: executed by bash(1) for interactive shells.

# System-wide bashrc file

# Check that we haven't already been sourced.
([[ -z ${CYG_SYS_BASHRC} ]] && CYG_SYS_BASHRC="1") || return

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# If started from sshd, make sure profile is sourced
if [[ -n "$SSH_CONNECTION" ]] && [[ "$PATH" != *:/usr/bin* ]]; then
    source /etc/profile
fi

# Warnings
unset _warning_found
for _warning_prefix in '' ${MINGW_PREFIX}; do
    for _warning_file in ${_warning_prefix}/etc/profile.d/*.warning{.once,}; do
        test -f "${_warning_file}" || continue
        _warning="$(command sed 's/^/\t\t/' "${_warning_file}" 2>/dev/null)"
        if test -n "${_warning}"; then
            if test -z "${_warning_found}"; then
                _warning_found='true'
                echo
            fi
            if test -t 1
                then printf "\t\e[1;33mwarning:\e[0m\n${_warning}\n\n"
                else printf "\twarning:\n${_warning}\n\n"
            fi
        fi
        [[ "${_warning_file}" = *.once ]] && rm -f "${_warning_file}"
    done
done
unset _warning_found
unset _warning_prefix
unset _warning_file
unset _warning

# If MSYS2_PS1 is set, use that as default PS1;
# if a PS1 is already set and exported, use that;
# otherwise set a default prompt
# of user@host, MSYSTEM variable, and current_directory
[[ -n "${MSYS2_PS1}" ]] && export PS1="${MSYS2_PS1}"
# if we have the "High Mandatory Level" group, it means we're elevated
#if [[ -n "$(command -v getent)" ]] && id -G | grep -q "$(getent -w group 'S-1-16-12288' | cut -d: -f2)"
#  then _ps1_symbol='\[\e[1m\]#\[\e[0m\]'
#  else _ps1_symbol='\$'
#fi
case "$(declare -p PS1 2>/dev/null)" in
'declare -x '*) ;; # okay
*)
  export PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[35m\]$MSYSTEM\[\e[0m\] \[\e[33m\]\w\[\e[0m\]\n'"${_ps1_symbol}"' '
  ;;
esac
unset _ps1_symbol

# Uncomment to use the terminal colours set in DIR_COLORS
# eval "$(dircolors -b /etc/DIR_COLORS)"

# Fixup git-bash in non login env
shopt -q login_shell || . /etc/profile.d/git-prompt.sh

# Display directory in prompt
#PS1='\w\$> '

ffind() {
    # find files like
	find . -name "$1" -print 2> /dev/null;
}

llook() {
    # look for string in files
	find . -name \* 2> /dev/null -exec fgrep -o -n -l "$1" {} \;
}

errlog() {
    # look for error lines in a file
	grep -inr "ERROR" "$1"
}

cd /c/Development

alias gb='echo git branch && git branch'
alias lsr='echo ls-remote && ls-remote'
alias ls='ls -l --color'
alias ll='ls -l | less -c -e -F -X -R'
alias d='ls -alF --color'
alias h='history'
alias md='mkdir'
alias s='echo git status && git status'
alias gp='echo git pull origin && git pull origin'
alias gpdev='echo git pull origin develop && git pull origin develop'
alias gprel='echo git pull origin release && git pull origin release'
alias gpmas='echo git pull origin master && git pull origin master'
alias f='find . -name $1'
alias swag='swagger-cli validate $1'
alias ngs='echo ng serve && ng serve'
alias off='exit'
alias bashrc='source C:/Users/ffeuerbacher/AppData/Local/Programs/Git/etc/bash.bashrc'
alias npmi='echo npm install --force && npm install --force'
alias ngb='echo ng build && ng build'
alias rmnpm='echo rm -rf node_modules && rm -rf node_modules'
alias diff='echo git diff develop && git diff develop'
alias cobr='echo git checkout $branch && git checkout $branch'
alias pulldev='echo git pull origin dev && git pull origin dev'
alias pushdev='echo git push origin HEAD && git push origin HEAD'
alias build='echo npm run buildAll && npm run buildAll'
alias bname='echo git branch -m && git branch -m'
alias nxgc='echo nx g c && nx g c'
alias clone-dev='echo git clone dev && git clone https://HHSDC@dev.azure.com/HHSDC/DHS\%20Modernized\%20Applications/_git/compass-ui'
alias stash='echo stash && git stash'
alias pop='echo stash pop && git stash pop'



