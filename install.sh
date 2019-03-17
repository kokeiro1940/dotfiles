#!/usr/local/bin/zsh

set -u

# exec DIR
THIS_DIR=$(cd $(dirname $0); pwd)
cd $THIS_DIR

# submodule update
# git submodule init
# git submodule update
git submodule update --init --recursive

echo "start setup..."
# dotfiles link
for f in .??*; do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".gitignore" ] && continue
#    [ "$f" = ".gitconfig.local.template" ] && continue
#    [ "$f" = ".require_oh-my-zsh" ] && continue
    [ "$f" = ".gitmodules" ] && continue

    ln -snfv ~/dotfiles/"$f" ~/
done

# [ -e ~/.gitconfig.local ] || cp ~/dotfiles/.gitconfig.local.template ~/.gitconfig.local

# zprezto
setopt EXTENDED_GLOB
for rcfile in ${ZDOTDIR:-$HOME}/.zprezto/runcoms/??*; do
    [ "$rcfile" = "^README.md" ] && continue
    ln -snfv "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

cat << END

**************************************************
DOTFILES SETUP FINISHED! bye.
**************************************************

END
