#!/usr/bin/make

.PHONY: emacs
emacs:
	mkdir -p ${HOME}/.emacs.d
	ln -sf  ${PWD}/.emacs.d/init.el ${HOME}/.emacs.d/init.el

.PHONY: vim
vim:
	mkdir -p ${HOME}/.vim/dein/
	ln -sf ${PWD}/.vimrc ${HOME}/.vimrc
	ln -sf ${PWD}/.vim/dein.toml ${HOME}/.vim/dein.toml
	ln -sf ${PWD}/.vim/dein_lazy.toml ${HOME}/.vim/dein_lazy.toml
	curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ${HOME}/.vim/installer.sh
	sh ${HOME}/.vim/installer.sh ${HOME}/.vim/dein/

.PHONY: fluxbox
fluxbox:
	mkdir -p ${HOME}/.fluxbox
	ln -sf ${PWD}/.fluxbox/keys ${HOME}/.fluxbox/keys
	ln -sf ${PWD}/.fluxbox/startup ${HOME}/.fluxbox/startup

.PHONY: shell
shell:
	ln -sf ${PWD}/.zshrc ${HOME}/.zshrc
	ln -sf ${PWD}/.xprofile ${HOME}/.xprofile
	ln -sf ${PWD}/.zshenv ${HOME}/.zshenv

.PHONY: mikutter_main
mikutter_main:
	mkdir -p ${HOME}/mikutter
	git clone git://toshia.dip.jp/mikutter.git ${HOME}/mikutter

.PHONY: mikutter_plugin
mikutter_plugin:
	mkdir -p ${HOME}/.mikutter/plugin
	touch ${HOME}/.mikutter/plugin/aspectframe.rb
	touch ${HOME}/.mikutter/plugin/display_requirements.rb
	curl https://gist.githubusercontent.com/boronology/be0019622a76b6757407b335495439d0/raw/d9018c6c10a3e5a4499784d31da95b72fd6d1b4a/force_delete.rb > ${HOME}/.mikutter/plugin/force_delete.rb
	mkdir -p ${HOME}/.mikutter/plugin/open_web_of_tweet
	git clone git@github.com:boronology/open_web_of_tweet.git ${HOME}/.mikutter/plugin/open_web_of_tweet
	mkdir -p ${HOME}/.mikutter/plugin/sub_parts_client
	git clone git@github.com:toshia/mikutter-sub-parts-client.git ${HOME}/.mikutter/plugin/sub_parts_client
	mkdir -p ${HOME}/.mikutter/plugin/nested-quote
	git clone https://github.com/toshia/mikutter-nested-quote.git ${HOME}/.mikutter/plugin/nested-quote
	mkdir -p ${HOME}/.mikutter/plugin/mikutter_suddenly_death
	git clone git@github.com:Akkiesoft/mikutter_suddenly_death.git ${HOME}/.mikutter/plugin/mikutter_suddenly_death

.PHONY: mikutter
mikutter: mikutter_main mikutter_plugin

.PHONY: lumina
lumina:
	mkdir -p ${HOME}/.fluxbox
	ln -sf ${PWD}/.fluxbox/lumina_startup.sh ${HOME}/.fluxbox/lumina_startup.sh
	chmod +x ${PWD}/.fluxbox/lumina_startup.sh
	echo "手動でlumina_startup.shをスタートアップ実行に登録すること"

.PHONY: all
all: emacs vim fluxbox shell mikutter

