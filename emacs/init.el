;; Package Manager
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

;; Evil Mode Stuff
(use-package evil
  :ensure t
  :init
  (setq evil-want-C-i-jump nil) ; Allow tab for org mode
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-fine-undo t)
  (setq evil-echo-state nil)
  :config
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :after (evil magit)
  :init
  (setq evil-collection-setup-minibuffer t)
  :config
  (add-to-list 'warning-suppress-types '(evil-collection))
  (evil-collection-init '(dired magit)))

;; UI Customization
(use-package gruvbox-theme
  :ensure t
  :init
  (require 'json)
  :config
  (load-theme 'gruvbox-dark-medium t))

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode t)
(global-auto-revert-mode t)
(setq scroll-conservatively 101)
(setq scroll-margin 3)
(setq-default fill-column 80)
(global-display-fill-column-indicator-mode 1)

(use-package whitespace
  :ensure nil
  :init
  (setq whitespace-line-column 80)
  (setq whitespace-style '(face lines-tail))
  :config
  (set-face-attribute 'whitespace-line nil
                      :background "magenta"
                      :foreground "white")
  (global-whitespace-mode 1))

;; Completion and search
(use-package vertico
  :ensure t
  :init
  (vertico-mode 1))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package consult
  :ensure t
  :bind (("C-x b" . consult-buffer)
         ("M-p"   . consult-find)))

(use-package company
  :ensure t
  :init
  (global-company-mode 1))

;; LSP Support
(use-package python--treesit-builtin-types
  :ensure nil
  :init
  (setq major-mode-remap-alist
        '((python-mode . python-ts-mode)
          (c-mode      . c-ts-mode)
          (c++-mode    . c++-ts-mode)
          (js-mode     . js-ts-mode)))
  :config
  (setq treesit-language-source-alist
        '((python         "https://github.com")
          (c              "https://github.com")
          (cpp            "https://github.compp")
          (javascript     "https://github.com")
          (typescript     "https://github.com" "master" "typescript/src")
          (tsx            "https://github.com" "master" "tsx/src")
          (rust           "https://github.com")
          (zig            "https://github.com")
          (typst          "https://github.com"))))

(use-package eglot
  :ensure nil
  :demand t
  :init
  (setq native-comp-async-report-warnings-error 'silent)
  :config
  (add-to-list 'eglot-server-programs '(python-ts-mode . ("pyright-langserver" "--stdio")))
  (add-to-list 'eglot-server-programs '(rust-ts-mode   . ("rust-analyzer")))
  (add-to-list 'eglot-server-programs '(zig-ts-mode    . ("zls")))
  (add-to-list 'eglot-server-programs '(typst-ts-mode  . ("tinymist" "lsp")))
  (add-to-list 'eglot-ignored-server-capabilities :inlayHintProvider)
  :hook
  ((python-ts-mode . eglot-ensure)
   (c-ts-mode      . eglot-ensure)
   (c++-ts-mode    . eglot-ensure)
   (zig-ts-mode    . eglot-ensure)
   (rust-ts-mode   . eglot-ensure)
   (js-ts-mode     . eglot-ensure)
   (typst-ts-mode  . eglot-ensure)
   (typescript-ts-mode . eglot-ensure)))

(use-package typst-ts-mode
  :ensure t
  :mode "\\.typ\\'"
  :config
  (add-hook 'typst-ts-mode-hook #'typst-ts-watch-mode)
  (with-eval-after-load 'treesit
    (add-to-list 'treesit-language-source-alist
                 '(typst "https://github.com"))))

(use-package python
  :ensure nil)

(use-package rust-ts-mode
  :ensure t
  :mode "\\.rs\\'"
  :init
  (setq-default rust-format-on-save t))

(use-package zig-ts-mode
  :ensure t
  :mode "\\.zig\\'"
  :init
  (setq-default zig-format-on-save t))

;; Backups and Tabs
(use-package magit
  :ensure t)

(setq make-backup-files t)
(setq create-lockfiles nil)
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))

(setq-default auto-save-default nil)
(setq-default indent-tabs-mode nil) ; Prefer spaces globally over literal tabs
(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(setq-default python-indent-offset 4)
(setq-default js-indent-level 4)
(setq-default css-indent-level 4)

