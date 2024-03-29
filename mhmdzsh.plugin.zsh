# Returns whether the given command is executable or aliased.
_has() {
  return $( whence $1 &>/dev/null )
}

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt noincappendhistory
setopt nosharehistory
setopt EXTENDED_HISTORY
unsetopt autocd beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc_comp'

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C
# End of lines added by compinstall

# Format tab completion.
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# Ignore duplicate lines in the history.
setopt HIST_IGNORE_DUPS

# Colors
autoload -U colors
colors
setopt prompt_subst

# Env Variables.
export EDITOR=nvim
export GOPATH=$HOME/projects
export PATH=$GOPATH/bin:$PATH
export GITHUB=$HOME/github
export VIM345=$GITHUB/vim345

alias cp='cp -i'
alias diff='colordiff'
alias dir='dir --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
#alias l='ls -CF'
#alias la='ls -A'
#alias ll='ls -alFh'
#alias ls='ls --color=auto'
alias mv='mv -i'
alias openports='netstat --all --numeric --programs --inet'
alias vdir='vdir --color=auto'
alias vimc='vim --servername SAMPLESERVER --remote-tab-silent'
alias vims='vim --servername SAMPLESERVER'
alias update_subs='git submodule foreach git pull origin master'
# Remove all vim swap files in a directory.
alias remove_swap='find ./ -type f -name "\.*sw[klmnop]" -delete'
# Remove all pyc files in a directory.
alias remove_pyc='find . -name "*.pyc" -exec rm -rf {} \;'
alias replace_str_mac='find . -name "*.html" -print0 | xargs -0 sed -i "" -e "s/token-search/token-options/g"'
alias replace_str_linux='find . -name "*.rb" -type f -exec sed -i -e "s/regex/replacement/g" -- {} +'
# Fixssh in tmux.
alias fixssh='export $(tmux show-environment | grep \^SSH_AUTH_SOCK=)'
alias delete_git_branches="git branch | grep -v "master" | xargs git branch -D"
# Update ctags
alias u_ctags='/usr/bin/ctags -f .tags -L <(find . -name "*.py") --fields=+iaS --python-kinds=-iv --extra=+q --exclude=virtualenv_run'
# alias u_ctags='/usr/bin/ctags -R --fields=+l --languages=python --exclude=virtualenv_run --python-kinds=-iv -f .tags $(python -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))")'
function u_ctags() {
    /usr/bin/ctags -R --fields=+l --languages=python --exclude=virtualenv_run --python-kinds=-iv -f .tags $(python -c "import os, sys; print(' '.join('{}'.format(d) for d in sys.path if os.path.isdir(d)))")
}
alias java_ctags='/usr/bin/ctags -f .tags -L <(find . -name "*.java") --fields=+iaS --sort=yes --extra=+q'

# Predictable SSH authentication socket location.
SOCK="/tmp/ssh-agent-$USER-screen"
if test $SSH_AUTH_SOCK && [ $SSH_AUTH_SOCK != $SOCK ]
then
    rm -f /tmp/ssh-agent-$USER-screen
    ln -sf $SSH_AUTH_SOCK $SOCK
    export SSH_AUTH_SOCK=$SOCK
fi

# Directory stacking.
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

DIRSTACKSIZE=20

setopt autopushd pushdsilent pushdtohome

## Remove duplicate entries
setopt pushdignoredups

## This reverts the +/- operators.
setopt pushdminus

alias d='dirs -v | head -10'
alias 1='cd -'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

# Get the default branches for the origin and upstream repos
default_origin() {
  git remote show origin | sed -n "/HEAD branch/s/.*: //p"
}

default_upstream() {
  git remote show upstream | sed -n "/HEAD branch/s/.*: //p"
}

# Open fzf results in nvim.
vimfzf() {
  nvim $(fzf)
}
