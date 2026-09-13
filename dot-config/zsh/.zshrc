# Dependencies: zsh, Oh My Zsh, powerlevel10k, zsh-autosuggestions,
# zsh-history-substring-search, zsh-fast-syntax-highlighting, direnv.
export ZSH="$ZDOTDIR/plugins/oh-my-zsh"
export ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/oh-my-zsh"
export GENCOMPL_FPATH="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/completion-generator"
export GENCOMPL_PY="${GENCOMPL_PY:-python3}"
HISTFILE="$ZDOTDIR/histfile"
HISTSIZE=1000
SAVEHIST=5000
mkdir -p "$ZSH_CACHE_DIR" "${HISTFILE:h}"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

zstyle ':completion:*' completer _expand _complete _ignored _correct
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' squeeze-slashes true

# Generate completions from programs' --help output and cache them outside the
# dotfiles repository.
source "$ZDOTDIR/plugins/zsh-completion-generator/zsh-completion-generator.plugin.zsh"

# Load a Zsh plugin from the file registered by its Fedora RPM.  Keeping the
# package-owned path out of this repository avoids tying the configuration to
# a particular Fedora release or architecture.
source_rpm_file() {
  local package="$1" filename="$2" file
  (( $+commands[rpm] )) || return 0
  file="$(rpm -ql -- "$package" 2>/dev/null | command grep -F "/$filename" | command head -n 1)"
  [[ -r "$file" ]] && source "$file"
}

zstyle ':omz:plugins:ssh-agent' quiet yes
zstyle ':omz:plugins:ssh-agent' lazy yes
ZSH_THEME=""
plugins=(command-not-found git ssh ssh-agent npm extract dotenv gh magic-enter safe-paste)
source "$ZSH/oh-my-zsh.sh"

# Oh My Zsh replaces matcher-list while loading its defaults.
zstyle ':completion:*' completer _expand _complete _ignored _correct
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' squeeze-slashes true

ZSH_AUTOSUGGEST_STRATEGY=(history)
source_rpm_file zsh-autosuggestions zsh-autosuggestions.zsh

# These upstream projects are tracked as shallow submodules because Fedora
# does not provide maintained packages for them.
if [[ -r "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme"
  source "$ZDOTDIR/p10k-base.zsh"
  source "$ZDOTDIR/p10k.zsh"
fi

if [[ -r "$ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh" ]]; then
  source "$ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
  bindkey "^[[A" history-substring-search-up
  bindkey "^[[B" history-substring-search-down
else
  bindkey "^[[A" history-search-backward
  bindkey "^[[B" history-search-forward
fi

# Load this last, as required by zsh-syntax-highlighting.
source_rpm_file zsh-syntax-highlighting zsh-syntax-highlighting.zsh
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
alias vi=nvim
alias vim=nvim
setopt HIST_FCNTL_LOCK HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY NO_APPEND_HISTORY NO_EXTENDED_HISTORY NO_HIST_EXPIRE_DUPS_FIRST NO_HIST_FIND_NO_DUPS NO_HIST_IGNORE_ALL_DUPS NO_HIST_SAVE_NO_DUPS
