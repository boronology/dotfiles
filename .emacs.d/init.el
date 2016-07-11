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

;; package list
(defvar my/packages
  '(cider
    clj-refactor
    clojure-mode
    color-theme
    company
    company-jedi
    company-tern
    concurrent
    ctable
    dash
    dash-functional
    deferred
    edn
    epc
    epl
    esup
    f
    flycheck
    flycheck-pos-tip
    htmlize
    hungry-delete
    hydra
    inf-ruby
    inflections
    irony
    jedi-core
    js2-mode
    let-alist
    macrostep
    markdown-mode
    mozc
    multi-term
    multiple-cursors
    oauth
    open-junk-file
    paredit
    peg
    pkg-info
    popup
    pos-tip
    python-environment
    queue
    rainbow-delimiters
    robe
    ruby-block
    ruby-electric
    s
    seq
    simple-httpd
    skewer-mode
    slime
    slime-js
    slime-repl
    spinner
    tabbar
    tern
    tumblesocks
    twittering-mode
    undo-tree
    yasnippet
    zenburn-theme))

;; auto-install
(require 'cl)
(let ((not-installed (loop for x in my/packages
			   when (not (package-installed-p x))
			   collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
      (package-install pkg))))

;;color-theme-zenburn
;;it does not need old "color-theme"
(load-theme 'zenburn t)

;;load path
(setq load-path (append
		 (list
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

;;company-mode
(require 'company)
(setq company-idle-delay 0.1)
(when (locate-library "company")
  (global-company-mode 1)
  (global-set-key (kbd "\t") 'company-complete)
  ;; (setq company-idle-delay nil) ; 自動補完をしない
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-search-map (kbd "C-n") 'company-select-next)
  (define-key company-search-map (kbd "C-p") 'company-select-previous)
  )

;;paredit-mode
;;hilight and color paren
(require 'rainbow-delimiters)
(rainbow-delimiters-mode 1)

;;Emacs Lisp Mode
(require 'hungry-delete)
(add-hook 'emacs-lisp-mode-hook 'hungry-delete-mode)

;;C++ mode
(eval-after-load "irony"
  '(progn
     (custom-set-variables '(irony-additional-clang-options '("-std=c++14")))
     (add-to-list 'company-backends 'company-irony)
     (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
     (add-hook 'c-mode-common-hook (lambda()
				     (irony-mode)
				     (c-set-style "stroustrup")
				     (c-toggle-auto-hungry-state 1)
				     (c-toggle-electric-state 1)
				     ))))
  
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

;; Python3
;; virtualenvでjediとepcをインストールして使う
;; $ virtualenv -p python3 env
;; $ pip install jedi epc
;; $ source env/bin/activate
(require 'python)
(require 'jedi-core)
(require 'epc)
(add-hook 'python-mode-hook
	  '(lambda ()
	     (setq jedi:complete-on-dot t)
	     (setq jedi:use-shortcuts t)
	     (jedi:setup)
	     (add-to-list 'company-backends 'company-jedi)
	     (setq indent-level 4)
	     (setq python-indent 4)
	     (setq python-indent-offset 4)
	     (setq indent-tabs-mode nil)
	     (setq tab-width 4)))

;; clojure mode
;; M-x cider-jack-in
(require 'clojure-mode)
(require 'cider)
(setq nrepl-log-messages t
      cider-repl-display-in-current-window t
      cider-repl-use-clojure-font-lock t
      cider-prompt-save-file-on-load t
      cider-overlays-use-font-lock t)
(add-hook 'clojure-mode-hook
	  (lambda ()
	    (cider-mode 1)
	    (clj-refactor-mode)
	    (eldoc-mode)
	    ))
(add-hook 'cider-repl-mode-hook
	  (lambda ()
	    (company-mode)
	    (eldoc-mode)))
(cider-repl-toggle-pretty-printing)

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
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

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

