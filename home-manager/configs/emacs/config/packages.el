(use-package timu-macos-theme
  :ensure t
  :config 
  (load-theme 'timu-macos))

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
  ))

(use-package evil
  :after (general)
  :config
    (evil-mode 1)
    (evil-set-undo-system 'undo-redo)
    (general-evil-setup t))

(use-package magit)

(use-package company)

(use-package eglot)

(use-package flycheck
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package flycheck-eglot
  :ensure t
  :after (flycheck eglot)
  :custom (flycheck-eglot-exclusive nil)
  :config
  (global-flycheck-eglot-mode 1))

;;(use-package doom-modeline
  ;;:ensure t
  ;;:init (doom-modeline-mode 1)
  ;;:config (column-number-mode 1)
  ;;:custom
  ;;(doom-modeline-height 20)
  ;;(doom-modeline-window-width-limit nil)
  ;;(doom-modeline-buffer-file-name-style 'truncate-with-project)
  ;;(doom-modeline-minor-modes nil)
  ;;(doom-modeline-enable-word-count t)
  ;;(doom-modeline-buffer-encoding nil)
  ;;(doom-modeline-buffer-modification-icon t)
  ;;(doom-modeline-time t)
  ;;(doom-modeline-vcs-max-length 50))
