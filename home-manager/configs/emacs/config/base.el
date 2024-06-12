(setq custom-file (make-temp-name "/tmp/"))
(setq custom-safe-themes t)
(setq 
  ;;gc-cons-threshold 100000000
  use-package-always-ensure t
  inhibit-startup-screen t
  initial-scratch-message nil
  sentence-end-double-space nil
  ring-bell-function 'ignore 
  save-interprogram-paste-before-kill t
  use-dialog-box nil
  mark-even-if-inactive nil
  case-fold-search nil
  compilation-read-command nil
  compilation-scroll-output 'first-error
  use-short-answers t
  fast-but-imprecise-scrolling t
  load-prefer-newer t
  confirm-kill-processes nil
  native-comp-async-report-warnings-errors 'silent
  truncate-string-ellipsis "…"

  make-backup-files nil
  auto-save-default nil
  create-lockfiles nil
)
(set-fringe-mode 10)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(menu-bar-mode -1)

(set-charset-priority 'unicode)
(prefer-coding-system 'utf-8-unix)

(delete-selection-mode t)
(global-display-line-numbers-mode t)
(column-number-mode)

(defalias 'view-emacs-news 'ignore)
(defalias 'describe-gnu-project 'ignore)

;;Start off with gc super heigh then after every thing is inited set it back
(defvar file-name-handler-alist-backup
        file-name-handler-alist)
(setq gc-cons-threshold most-positive-fixnum
      file-name-handler-alist nil)
(add-hook 'after-init-hook
  (lambda ()
    (garbage-collect)
    (setq gc-cons-threshold
            (car (get 'gc-cons-threshold 'standard-value))
      file-name-handler-alist
        (append
          file-name-handler-alist-backup
          file-name-handler-alist))))

;;Well in term mouse is enabled
(unless (display-graphic-p)
  (xterm-mouse-mode 1))
