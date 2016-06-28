;;GCの間隔を広げる
(setq gc-cons-threshold 134217728)

;;yes-no->y-n
(fset 'yes-or-no-p 'y-or-n-p)

;;バックアップファイルを作らない
(setq backup-inhibited t)

;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

;;language setting
(prefer-coding-system 'utf-8)
(setq file-name-coding-system 'utf-8)
(setq locale-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-language-environment 'utf-8)

;;common keybind
(global-set-key "\C-x\C-b" 'electric-buffer-list)
(global-set-key "\C-m" 'newline-and-indent)
(global-set-key "\C-j" 'newline)

;;recent file mode
(require 'recentf)
(recentf-mode 1)

;;package installer
(require 'package)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(setq package-user-dir "~/.emacs.d/packages")
(package-initialize)

;;color-theme-zenburn
;;it does not need old "color-theme"
(load-theme 'zenburn t)

;;load path
(setq load-path (append
		  (list
		   (expand-file-name "~/.emacs.d/emacs-clang-complete-async")
		   (expand-file-name "~/.emacs.d/mikutter-mode")
		   (expand-file-name "~/.emacs.d/tern/emacs")
		   (expand-file-name "~/.emacs.d/emacs-2048")
		   )
		  load-path))

;;日本語入力メソッド
;;X上では別になくても困らないけど-nwではあると便利
;;C-x j(japanese)
(require 'mozc)
(setq default-input-method "japanese-mozc")
(global-set-key "\C-xj" 'mozc-mode)
;;なぜかorgに限っては無効にされる
;(setq mozc-candidate-style 'overlay)

;;org-mode
;; enable truncate
(setq org-startup-truncated nil)

;;auto-complete mode
(require 'auto-complete)
(require 'auto-complete-config)
(setq ac-quick-help-delay 0.1)
(setq ac-delay 0.1)
(setq ac-auto-show-menu nil)
(setq ac-auto-start nil)
(ac-set-trigger-key "TAB")
(add-hook 'auto-complete-mode-hook 'ac-common-setup)
(setq-default ac-sources '(ac-source-abbrev
			   ac-source-dictionary
			   ac-source-words-in-same-mode-buffers))
(add-to-list 'ac-sources 'ac-source-filename)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-repl-mode))
(global-auto-complete-mode t)

;;paredit-mode
;;hilight and color paren
(require 'rainbow-delimiters)
(rainbow-delimiters-mode 1)

;;Emacs Lisp Mode
(require 'hungry-delete)
(add-hook 'emacs-lisp-mode-hook
	  (lambda ()
	    (add-to-list 'ac-sources 'ac-source-symbols)
	    (hungry-delete-mode)
	    (ac-emacs-lisp-mode-setup)))

;;C++ mode
(require 'auto-complete-clang-async)
(setq ac-clang-cflags '("-std=c++11"))
(defun ac-cc-mode-setup ()
  (setq ac-clang-complete-executable "~/.emacs.d/emacs-clang-complete-async/clang-complete")
  (setq ac-sources '(ac-source-clang-async ac-source-dictionary))
  (ac-clang-launch-completion-process))

(add-hook 'c-mode-common-hook
	    (lambda ()
	      (ac-cc-mode-setup)
	      (c-set-style "stroustrup")
	      (c-toggle-auto-hungry-state 1)
	      (c-toggle-electric-state 1)))



;;対応する括弧をハイライト
(show-paren-mode t)

;;保存時、最後に改行を追加
(setq require-final-newline t)

;;スプラッシュスクリーンを殺す
(setq inhibit-startup-screen t)

;;左に行数を表示
(require 'linum)
(global-linum-mode t)
(setq linum-format "%5d")

;;行数と列数を下部に表示
(line-number-mode t)
(column-number-mode t)

;;スクロールを一行ずつに
(setq scroll-step 1)

;;screen size
(if window-system
    (progn
      (setq default-frame-alist
	    (append '((width . 108)
		      (height . 32)
		      (font . "Ricty-14"))
		    default-frame-alist))))

;;python-mode 残念なことにPython2と思いきやjediはPython3対応
(require 'python)
(require 'epc)
(add-hook 'python-mode-hook
	  '(lambda ()
	     (ac-set-trigger-key nil)
	     (jedi:setup)
	     (setq indent-level 4)
	     (setq python-indent 4)
	     (setq python-indent-offset 4)
	     (setq indent-tabs-mode nil)
	     (setq tab-width 4)))
;;jediでTABのキーバインドがauto-completeと衝突するのでPythonではC-tabで補完
(define-key python-mode-map (kbd "<C-tab>") 'jedi:complete)
(require 'jedi)

;;clojure mode
(require 'cider)
(require 'ac-nrepl)
(add-hook 'clojure-mode-hook
	  (lambda ()
	    (cider-mode 1)
	    (ac-nrepl-setup)))
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)

;;ファイル名の補完で大文字小文字を無視
(setq read-file-name-completion-ignore-case t)

;;Scheme-mode
;;C-c C-rで選択された式を実行
;;C-c Sでインタプリタ起動
(autoload 'scheme-mode "cmuscheme" "major mode for scheme" t)
(autoload 'run-scheme "cmuscheme" "run an inferior scheme process" t)
(setq scheme-program-name "gosh -i")

(defun scheme-other-window ()
  "Run Scheme on other window"
  (interactive)
  (switch-to-buffer-other-window
   (get-buffer-create "*scheme*"))
  (run-scheme scheme-program-name))
(add-hook 'scheme-mode-hook
	  (lambda ()
	    (local-set-key "\C-cS" 'scheme-other-window)))

;;Ruby mode
;;C-c C-sでRun-ruby
(require 'mikutter)
(require 'ruby-mode)
(require 'ruby-block)
(require 'ruby-electric)
(require 'inf-ruby)
(add-hook 'ruby-mode-hook
	  (lambda ()
	    (progn
	      (ruby-block-mode t)
	      (setq ruby-block-highlight-toggle t)
	      (ruby-electric-mode t)
	      (setq ruby-electric-expand-delimitaers-list nil)
	      (setq ruby-indent-level 2)
	      (setq ruby-indent-tabs-mode nil)
	      (inf-ruby-keys)
	      )))

;;JavaScript mode
;;tern : http://ternjs.net/
;;ternにはnode.jsが必要
;;ternによる補完を使うには他所でternサーバーを建てたうえで
;;tern-use-serverでポートを指定する
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(autoload 'tern-mode "tern.el" nil t)
(add-hook 'js2-mode-hook 'tern-mode)
(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

;;Undo-Tree mode
;;C-x uでUndo-Treeが開く
;;qでUndo-Treeを閉じる
(require 'undo-tree)
(global-undo-tree-mode)

;;junk file mode
(require 'open-junk-file)
(setq open-junk-file-format "~/.junk/%y%m%d-%H%M%S.")
(global-set-key (kbd "C-x f") 'open-junk-file)

;;shell popは使わない
;;(require 'shell-pop)
(require 'multi-term)
(global-set-key [f8] 'multi-term)

;;startup profiler
;;M-x esup
(require 'esup)

;;tumblr mode
(require 'tumblesocks)
(setq oauth-nonce-function 'oauth-internal-make-nonce)
(setq tumblesocks-blog "boronology.tumblr.com")

;;flycheck-mode
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
;;あとでflycheck-next-errorとflycheck-previous-errorのキーを定義しておく
(eval-after-load 'flycheck
  '(custom-set-variables
    '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))

;;game - 2048
;;install from https://github.com/sprang/emacs-2048
(load-library "2048")
