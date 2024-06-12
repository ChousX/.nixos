(use-package rust-ts-mode
  :mode ("\\.rs\\'" . rust-ts-mode)
  :hook (
    (rust-ts-mode . eglot-ensure)
    (rust-ts-mode . company-mode)
  )
  :bind (
    :map rust-ts-mode-map ("<f8>" .  eglot-format-buffer))
    :config 
)
