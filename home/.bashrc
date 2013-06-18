## The prompt below gets ideas from the following:
# http://briancarper.net/blog/570/git-info-in-your-zsh-prompt
# http://github.com/adamv/dotfiles/blob/master/bashrc
# http://wiki.archlinux.org/index.php/Color_Bash_Prompt
txtred='\[\e[0;31m\]' # Red
txtwht='\[\e[0;37m\]' # White
txtblu='\[\e[0;34m\]' # Blue
txtgra='\[\e[0;34m\]' # Blue
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldwht='\[\e[1;37m\]' # White
bldcyn='\[\e[1;36m\]' # Cyan
bldblu='\[\e[1;34m\]' # Cyan
bldprp='\[\e[1;35m\]' # Cyan
end='\[\e[0m\]'    # Text Reset

source /etc/bash_completion

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'

#Disable XON/XOFF to use Crtl-s in conjuction with Ctrl-r for bash history
stty ixany
stty ixoff -ixon

function parse_git {
branch=$(__git_ps1 "%s")
if [[ -z $branch ]]; then
    return
fi

local forward="⟰"
local behind="⟱"
local dot="•"

#remote_pattern_ahead="# Your branch is ahead of"
#remote_pattern_behind="# Your branch is behind"
#remote_pattern_diverge="# Your branch and (.*) have diverged"

status="$(git status 2>/dev/null)"

state=""
if [[ $status =~ "working directory clean" ]]; then
    state=${bldgrn}${dot}${end}
else
    if [[ $status =~ "Untracked files" ]]; then
        state=${bldylw}${dot}${end}
    fi
    if [[ $status =~ "Changes not staged for commit" ]]; then
        state=${state}${bldred}${dot}${end}
    fi
    if [[ $status =~ "Changes to be committed" ]]; then
        state=${state}${bldylw}${dot}${end}
    fi
fi

#direction=""
#if [[ $status =~ $remote_pattern_ahead ]]; then
#    direction=${bldgrn}${forward}${end}
#elif [[ $status =~ $remote_pattern_behind ]]; then
#    direction=${bldred}${behind}${end}
#elif [[ $status =~ $remote_pattern_diverge ]]; then
#    direction=${bldred}${forward}${end}${bldgrn}${behind}${end}
#fi

branch=${txtblu}${branch}${end}
git_bit="${bldblu}[${end}${branch}${state}\
${git_bit}${direction}${bldblu}]${end}"

printf "%s" "$git_bit"
}

function set_titlebar {
case $TERM in
    *xterm*|ansi|rxvt)
        printf "\033]0;%s\007" "$*"
        ;;
esac
}

function set_prompt {

# get cursor position and add new line if we're not in first column
local cursor_pos
stty -echo
echo -n $'\e[6n'
read -r -dR cursor_pos
stty echo
cursor_pos=${cursor_pos#??}
cursor_line=${cursor_pos##*;}
if [ ${cursor_line-1} -gt 1 ]; then
	echo "${c_error}↵${c_clr}"
fi

git="$(parse_git)"

PS1="${txtblu}\u${end} ${txtwht}\w${end}"
if [[ -n "$git" ]]; then
    PS1="$PS1 $git ${bldprp}❯❯${end} "
else
    PS1="$PS1 ${bldprp}❯❯${end} "
fi
export PS1

set_titlebar "$USER@${HOSTNAME%%.*} $PWD"
}

export PROMPT_COMMAND=set_prompt

# Useful aliases
alias homeshick="$HOME/.homesick/repos/homeshick/home/.homeshick"
alias make_xseg="$HOME/scripts/make_xseg.sh"
