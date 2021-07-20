# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
# for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
#for file in ~/.{aliases}; do
	#[ -r "$file" ] && [ -f "$file" ] && source "$file";
#done;
#unset file;
source ~/.aliases

# ## BROKEN
# Case-insensitive globbing (used in pathname expansion)
#shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
#shopt -s histappend;

# Autocorrect typos in path names when using `cd`
#shopt -s cdspell;

export EDITOR='nvim'

#===============================#
#	Functions		            #
#===============================#

# ex - archive extractor
# usage: ex <file>
extract ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Create and go to the directory
mcd ()
{
	mkdir -p $1
	cd $1
}

# Change directory to arg of last command (prob ls)
cdla () {
    cd "$_"
}

catla () {
    cat "$_"
}

# Convert .heic images to jpg
heic () {
    sips -s format jpeg $1 --out $2
}

# Convert all .heic files in directory to jpg and remove original
heicd() {
    for i in *.heic(:r) ; sips -s format jpeg "$i.heic" --out "$i.jpg" && rm "$1.heic"
}

# Shortcut to iCloud dir
icloud () {
    cd ~/icloud/$1
}

