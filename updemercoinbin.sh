#!/usr/bin/bash
#update emercoin-bin debian package
[[ ! -f "$(pwd)/${BASH_SOURCE}" ]] && echo "please execute this script in the same working dir" && exit 1
[[ "$(pwd)" != ${HOME}/go/src/github.com/emercoin/apt-repo ]] && echo "please move the cloned repository to $HOME/go/src/github.com/emercoin/apt-repo" && exit 1
[[ -f emercoin-bin*.deb ]] && rm emercoin-bin*.deb
[[ ! -d $HOME/.cache/yay/emercoin-bin ]] && printf '%s\n' Ab | yay -Syy emercoin-bin #its not necessary to actually install it
cd $HOME/.cache/yay/emercoin-bin || exit 1
git pull
makepkg -fp deb.PKGBUILD || exit 1
mv emercoin-bin*.deb $HOME/go/src/github.com/emercoin/apt-repo/ || exit 1
cd $HOME/go/src/github.com/emercoin/apt-repo/ || exit 1
reprepro -Vb . remove sid emercoin-bin || exit 1
reprepro -Vb . includedeb sid emercoin-bin*.deb || exit 1
[[ ! -d archive ]] && mkdir archive
mv emercoin-bin*.deb archive/
#echo "now sign the release file"
