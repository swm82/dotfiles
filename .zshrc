# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Info
# .zshenv - Should only contain user’s environment variables.
# .zprofile - Can be used to execute commands just after logging in. DONT USE
# .zshrc - Should be used for the shell configuration and for executing commands.
# .zlogin - Same purpose than .zprofile, but read just after .zshrc. DONT USE
# .zlogout - Can be used to execute commands when a shell exit. DONT USE

bindkey -v # Vim bindings
export KEYTIMEOUT=1 # make vim mode switches faster
bindkey "^R" history-incremental-search-backward

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Options
# setopt autocd # Type name of dir to cd into it - doesn't work great with completions
# History
setopt append_history share_history histignorealldups sharehistory # Ignore duplicates, share btw sessions

# Completion/history
autoload -Uz compinit && compinit -u
autoload -U zmv # File renaming program (i.e. zmv '* *' '$f:gs/ /_' == replace all spaces with _)


## Load the shell dotfiles, and then some:
## * ~/.envs = env vars including PATH
## * ~/.extra = stuff not to commit
for file in ~/dotfiles/.{aliases,functions,envs,zshoptions,extra}; do
    [ -f "$file" ] && source "$file";
done;
unset file;

# Needed for fasd
#eval "$(fasd --init auto)"

# autojump TODO: Move this, rename in plugins dir
[[ -s "$HOME/.autojump/etc/profile.d/autojump.sh" ]] && source "$HOME/.autojump/etc/profile.d/autojump.sh"

# Plugins
plugins=(
	'zsh-autosuggestions'
	'zsh-syntax-highlighting'
	'zsh-history-substring-search'
	'fzf'
	'zsh-autocomplete'
	'k'
	#'zsh-vi-mode'
	)
for plugin in "${plugins[@]}"; do
	[ -f ~/.zsh/${plugin}/${plugin}.zsh ] && source ~/.zsh/${plugin}/${plugin}.zsh
done;
fpath=(~/.zsh/zsh-completions/src $fpath) # for zsh completions

# Themes
source ~/.zsh/themes/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.zsh/config/.p10k.zsh ]] || source ~/.zsh/config/.p10k.zsh


# Style stuff
# Case insesitive completion
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Do menu-driven completion.
zstyle ':completion:*' menu select

# Color completion for some things.
# http://linuxshellaccount.blogspot.com/2008/12/color-completion-using-zsh-modules-on.html
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# formatting and messages
# http://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# Completers for my own scripts
zstyle ':completion:*:*:sstrans*:*' file-patterns '*.(lst|clst)'
zstyle ':completion:*:*:ssnorm*:*' file-patterns '*.tsv'


# Work stuff
#. /opt/poky-anritsu/everest/2.6.1/environment-setup-aarch64-poky-linux # Everest ARM toolchain

