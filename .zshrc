

typeset -U path cdpath fpath manpath

for profile in ${(z)NIX_PROFILES}; do
  fpath+=($profile/share/zsh/site-functions $profile/share/zsh/$ZSH_VERSION/functions $profile/share/zsh/vendor-completions)
done

HELPDIR="/nix/store/y6b258mhrmgn95cl2qzky2fblh9aswrj-zsh-5.9/share/zsh/$ZSH_VERSION/help"





# Oh-My-Zsh/Prezto calls compinit during initialization,
# calling it twice causes slight start up slowdown
# as all $fpath entries will be traversed again.
autoload -U compinit && compinit







# History options should be set in .zshrc and after oh-my-zsh sourcing.
# See https://github.com/nix-community/home-manager/issues/177.
HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
unsetopt APPEND_HISTORY
setopt HIST_IGNORE_DUPS
unsetopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY


export EDITOR=nvim


# Aliases


# Named Directory Hashes




alias rebuild="sudo nixos-rebuild switch --flake /home/bryce/.dotfiles/nix"
