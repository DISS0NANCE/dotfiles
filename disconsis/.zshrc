# exports {{{
export TERM=screen-256color
export TERMINAL=urxvt
export ZSH=$HOME/.oh-my-zsh
export PYTHONSTARTUP=$HOME/.pythonrc
export ARCHFLAGS="-arch x86_64"
export EDITOR='vim'
export XDG_CONFIG_HOME=$HOME/.config
# }}}

# powerlevel9k {{{
DISABLE_AUTO_UPDATE=false
DISABLE_UPDATE_PROMPT=false
# Prevent printing of command
DISABLE_AUTO_TITLE="true"

POWERLEVEL9K_MODE='nerdfont-complete'

ZSH_THEME="powerlevel9k/powerlevel9k"
HIST_STAMPS="dd/mm/yyyy"
plugins=(zsh-autosuggestions colored-man-pages)
source $ZSH/oh-my-zsh.sh
[ -e ~/.dircolors ] && eval $(dircolors -b ~/.dircolors) || eval $(dircolors -b)

if [[ -n $SSH_CONNECTION ]]; then
    export PATH=/home/ketan/bin
fi


setopt interactivecomments
setopt CORRECT

# custom file count {{{
zsh_file_count(){
    local signal=$(ls -A1 | wc -l)
    local color='%F{052}'
    [[ $signal -eq 0 ]] && color='%F{001}'
    echo -n "%{$color%}$signal%{%f%}"
}
# }}}

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(status dir custom_file_count dir_writable vcs newline vi_mode)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(custom_alarming background_jobs virtualenv)
POWERLEVEL9K_PROMPT_ON_NEWLINE=false
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="\n"
POWERLEVEL9K_CUSTOM_FILE_COUNT="zsh_file_count"
POWERLEVEL9K_DIR_PATH_SEPARATOR=" "$'\uE0B1'" "
POWERLEVEL9K_SHORTEN_DIR_LENGTH=5
POWERLEVEL9K_SHORTEN_STRATEGY="None"
POWERLEVEL9K_BACKGROUND_JOBS_VERBOSE=true

POWERLEVEL9K_VIRTUALENV_BACKGROUND='066'

POWERLEVEL9K_STATUS_ERROR_BACKGROUND='124'
POWERLEVEL9K_STATUS_ERROR_FOREGROUND='255'
POWERLEVEL9K_STATUS_OK_BACKGROUND='220'
POWERLEVEL9K_STATUS_OK_FOREGROUND='052'

POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='214'
POWERLEVEL9K_DIR_HOME_BACKGROUND='214'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='214'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='052'
POWERLEVEL9K_DIR_HOME_FOREGROUND='052'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='052'

POWERLEVEL9K_VCS_CLEAN_BACKGROUND='118'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='093'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='039'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='016'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='016'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='016'

POWERLEVEL9K_CUSTOM_FILE_COUNT_BACKGROUND='208'

POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND='202'
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND='016'

POWERLEVEL9K_VI_MODE_INSERT_BACKGROUND='027'
POWERLEVEL9K_VI_MODE_INSERT_FOREGROUND='255'
POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='082'
POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='232'
POWERLEVEL9K_VI_INSERT_MODE_STRING=''
POWERLEVEL9K_VI_COMMAND_MODE_STRING=''

POWERLEVEL9K_CUSTOM_TASKWARRIOR="python3 $HOME/p9k_scripts/pltask.py  124 255"
POWERLEVEL9K_CUSTOM_TASKWARRIOR_BACKGROUND='234'

POWERLEVEL9K_CUSTOM_ALARMING="$HOME/p9k_scripts/alarming.sh 124 255"
POWERLEVEL9K_CUSTOM_ALARMING_BACKGROUND='234'

POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND='234'

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=238'

# get_icon_names -> print p9k icons
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=''
POWERLEVEL9K_VCS_GIT_ICON=''
POWERLEVEL9K_VCS_BRANCH_ICON=$'\ue0a0 '
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='↓'
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='↑'

POWERLEVEL9K_HOME_ICON=''
POWERLEVEL9K_HOME_SUB_ICON=''
POWERLEVEL9K_FOLDER_ICON=''

POWERLEVEL9K_OK_ICON=$'\uf42e'

local user_symbol="$"
if [[ $(print -P "%#") =~ "#" ]]; then
  user_symbol = "#"
fi

if [[ -r /usr/share/powerline/bindings/zsh/powerline.zsh ]]; then
  source /usr/share/powerline/bindings/zsh/powerline.zsh
fi

# }}}

# vim binds {{{
bindkey -v
export KEYTIMEOUT=1
setxkbmap -option ctrl:swapcaps
# }}}

# misc aliases {{{
alias kbfix="setxkbmap -option ctrl:swapcaps"
alias c="clear"
alias lh="ls -lh"
alias objdump="objdump -M intel --no-show-raw-insn"
alias rot13='tr a-mA-Mn-zN-Z n-zN-Za-mA-M'
alias public_ip='curl http://icanhazip.com'
alias nautilus='nautilus --no-desktop'
alias dict='sdcv --color'
alias -g nope='&> /dev/null &!'
alias eog='pqiv -i'
alias l="ls -lAh"
alias open='xdg-open'
alias speed='speedometer'
alias mux='tmuxinator'
alias tree='tree -I .git -I __pycache__'
alias clock='tty-clock -ctDB'
# }}}

# help {{{
autoload -Uz run-help
alias help=run-help
# }}}

# fix vi_mode {{{
function zle-line-init {
  powerlevel9k_prepare_prompts
  if (( ${+terminfo[smkx]} )); then
    printf '%s' ${terminfo[smkx]}
  fi
  zle reset-prompt
  zle -R
}

function zle-line-finish {
  powerlevel9k_prepare_prompts
  if (( ${+terminfo[rmkx]} )); then
    printf '%s' ${terminfo[rmkx]}
  fi
  zle reset-prompt
  zle -R
}

function zle-keymap-select {
  powerlevel9k_prepare_prompts
  zle reset-prompt
  zle -R
}

zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select
# }}}

# dasht {{{
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin:$HOME/.git/dasht/bin"
export MANPATH="$HOME/.git/dasht/man:$MANPATH"
# }}}

# virtualenvwrapper {{{
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_SCRIPT=$(which virtualenvwrapper.sh)
source virtualenvwrapper.sh
# }}}

# FIXME: project venv {{{
function set_project_venv {
    chdir "$@"
    if [[ `pwd | cut -d / -f 1-5` == '/home/ketan/.git/superlists' ]]
    then
        workon superlists
    else
        deactivate >& /dev/null
        true
    fi
}
alias cd=set_project_venv
# }}}

# beep {{{
function beep {
    if [[ $# > 1 ]]
    then
        duration=$1
    else
        duration=0.5
    fi
    speaker-test -t sine -f 1000 &>/dev/null &!
    sleep $duration
    pkill -9 speaker-test
}
# }}}

# fasd {{{
eval "$(fasd --init auto)"
# }}}

# vim: fdm=marker
