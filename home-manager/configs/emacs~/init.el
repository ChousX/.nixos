;; -*- coding: utf-8; lexical-binding: t -*-

(setq custom-file "~/.emacs.d/emacs-custom.el")
(load custom-file t)

(setq backup-directory-alist
      '(("." . "~/.emacs.d/backups"))
      auto-save-file-name-transforms
      '((".*" "~/.emacs.d/auto-save-list/" t))
)

(setq 
      packages-enable-at-startup nil
      inhibit-startup-message t ;; No need to see GNU agitprop.
      frame-resize-pixelwise t
      package-native-compile t
      scroll-conservatively 1000
      undo-limit 100000
      auto-save-default t
      save-interprogram-paste-before-kill t ;; Save existing clipboard text into the kill ring before replacing it.
      window-combination-resize t
      ring-bell-function 'ignore  ;; Never ding at me, ever.
      visible-bell t
      x-stretch-cursor t
      confirm-kill-processes nil
      make-backup-files nil
      create-lockfiles nil
)

(defalias 'view-emacs-news 'ignore)
(defalias 'describe-gnu-project 'ignore)

;; Never mix tabs and spaces. Never use tabs, period.
;; We need the setq-default here because this becomes
;; a buffer-local variable when set.
(setq-default indent-tabs-mode nil)

(setq gc-cons-threshold 100000000)
(global-display-line-numbers-mode 1)
(column-number-mode)
(set-fringe-mode 10)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

(global-subword-mode 1)
(global-auto-revert-mode 1)

(setq x-select-enable-clipboard t)

;; Setting Default States
(setq-default initial-major-mode 'emacs-lisp-mode) ;; Setting starting state to emacs-lisp-mode
(setq-default initial-scratch-message nil)  ;; No need to remind me what a scratch buffer is.
(defalias 'yas-or-no-p 'y-or-n-p)

;; Formating
(add-hook 'before-save-hook #'whitespace-cleanup)
(setq-default sentence-end-double-space nil)  ;; Double-spaces after periods is morally wrong.

(set-charset-priority 'unicode)
(prefer-coding-system 'utf-8-unix)

(add-to-list 'default-frame-alist '(fullscreen . maximized))


(use-package general
	     :config
	     (general-create-definer chousx/leader
	       :keymaps '(normal visual emacs)
	       :prefix "SPC"
	       :global-prefix "C-SPC"
	      )
	     (chousx/leader
	       :keymaps 'normal
	       "." 'find-file
	       "f" 'eglot-format
	       "b" 'ibuffer
	       "d" 'eldoc
	       "a" 'eglot-code-actions
	       "r" 'eglot-rename
	     )
)

(use-package evil
  :after (general)
  :config
    (evil-mode 1)
    (evil-set-undo-system 'undo-redo)
    (general-evil-setup t)
)

(use-package magit)

(use-package company)
(use-package rust-mode
  :init 
  (setq rust-mode-treesitter-derive t)
)

(use-package rust-ts-mode
  :mode ("\\.rs" . rust-ts-mode)
  :hook (
    (rust-ts-mode . eglot)
    (rust-ts-mode . company-mode)
  )
  :bind (
    :map rust-ts-mode-map("<f8>" .  eglot-format-buffer)
  )
  ;;:config (
    ;;(add-hook 'rust-mode-hook 'eglot-ensure)
    ;;(add-to-list 'eglot-server-programs '(rust-ts-mode . ("rust-analyzer")))
    ;;(add-to-list 'eglot-server-programs '((rust-ts-mode rust-mode) . ("rust-analyzer" :initializationOptions (:check (:command "clippy")))))
  ;;)
)

    

(global-set-key (kbd "<f7>") 'recompile)

(use-package timu-macos-theme
  :ensure t
  :config
  (load-theme 'timu-macos t)
)

(use-package exec-path-from-shell
  :init (exec-path-from-shell-initialize))
