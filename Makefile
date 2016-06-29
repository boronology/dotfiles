#!/usr/bin/make

.PHONY: emacs
emacs:
	mkdir -p ${HOME}/.emacs.d
	ln -s  ${PWD}/.emacs.d/init.el ${HOME}/.emacs.d/init.el

.PHONY: vim
vim:
	mkdir -p ${HOME}/.vim/dein/
	ln -s ${PWD}/.vimrc ${HOME}/.vimrc
	ln -s ${PWD}/.vim/dein.toml ${HOME}/.vim/dein.toml
	ln -s ${PWD}/.vim/dein_lazy.toml ${HOME}/.vim/dein_lazy.toml
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ${HOME}/.vim/installer.sh
	sh ${HOME}/.vim/installer.sh ${HOME}/.vim/dein/

.PHONY: fluxbox
fluxbox:
	mkdir -p ${HOME}/.fluxbox
	ln -s ${PWD}/.fluxbox/keys ${HOME}/.fluxbox/keys
	ln -s ${PWD}/.fluxbox/startup ${HOME}/.fluxbox/startup

.PHONY: shell
shell:
	ln -s ${PWD}/.zshrc ${HOME}/.zshrc
	ln -s ${PWD}/.xprofile ${HOME}/.xprofile
	ln -s ${PWD}/.zprofile ${HOME}/.zprofile

.PHONY: all
all: emacs vim fluxbox shell

