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

# nix-locate is supplied by nix-index-database's full-database wrapper. Derive
# its immutable package root without embedding a generation-specific store path.
() {
  local nix_locate_bin command_not_found
  (( $+commands[nix-locate] )) || return
  nix_locate_bin="${commands[nix-locate]:A}"
  command_not_found="${nix_locate_bin:h:h}/etc/profile.d/command-not-found.sh"
  [[ -r "$command_not_found" ]] && source "$command_not_found"
}

zstyle ':omz:plugins:ssh-agent' quiet yes
zstyle ':omz:plugins:ssh-agent' lazy yes
ZSH_THEME=""
plugins=(command-not-found git brew ssh ssh-agent npm extract dotenv gh magic-enter safe-paste)
source "$ZSH/oh-my-zsh.sh"

# Oh My Zsh replaces matcher-list while loading its defaults.
zstyle ':completion:*' completer _expand _complete _ignored _correct
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original true
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' squeeze-slashes true

source "${ZSH_AUTOSUGGESTIONS_FILE:-/run/current-system/sw/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh}" 2>/dev/null
ZSH_AUTOSUGGEST_STRATEGY=(history)
source "${POWERLEVEL10K_FILE:-/run/current-system/sw/share/zsh/themes/powerlevel10k/powerlevel10k.zsh-theme}" 2>/dev/null
source "$ZDOTDIR/p10k-base.zsh"
source "$ZDOTDIR/p10k.zsh"
source "${ZSH_HISTORY_SUBSTRING_SEARCH_FILE:-/run/current-system/sw/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh}" 2>/dev/null
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
source "${ZSH_FAST_SYNTAX_HIGHLIGHTING_FILE:-/run/current-system/sw/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh}" 2>/dev/null
(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
alias vi=nvim
alias vim=nvim
setopt HIST_FCNTL_LOCK HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY NO_APPEND_HISTORY NO_EXTENDED_HISTORY NO_HIST_EXPIRE_DUPS_FIRST NO_HIST_FIND_NO_DUPS NO_HIST_IGNORE_ALL_DUPS NO_HIST_SAVE_NO_DUPS
