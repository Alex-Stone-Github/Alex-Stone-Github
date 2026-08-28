; Initialize package repos
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

; Use package
(unless (package-installed-p 'use-package)
	(package-refresh-contents)
	(package-install 'use-package))
(eval-when-compile
	(require 'use-package))
(setq use-package-always-ensure t)

; Gruvbox theme
(use-package gruvbox-theme
    :ensure t
    :config (load-theme 'gruvbox-dark-medium t))

; LSP Client
(use-package eglot
  :ensure nil
    :init (setq native-comp-async-report-warnings-error 'silent)
    :hook (
        (python-mode . eglot-ensure)
        (c-mode      . eglot-ensure)
        (c++-mode    . eglot-ensure)
        )
    :config
    (use-package company
        :ensure t
        :init (global-company-mode)))

; Install and use git client magit
(use-package magit
  :ensure t)

; Fuzzy file find
(use-package vertico
     :ensure t
     :init (vertico-mode))
(use-package orderless
	:ensure t
	:custom
	(completion-styles '(orderless basic))
	(completion-category-overrides '((file (styles basic partial-completion)))))
(use-package consult
	     :ensure t
	     :bind (("C-x b" . consult-buffer)
		    ("M-p"   . consult-find)))

; Evil Mode
(use-package evil
	:ensure t
	:init
	(setq evil-want-integration t)
	(setq evil-want-keybinding nil)
	:config (evil-mode 1))
(use-package evil-collection
	:after (evil magit)
	:ensure t
	:config (evil-collection-init '(dired magit)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;
; General configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Evil mode
(setq evil-want-fine-undo t)
(setq evil-echo-state nil)
(setq scroll-conservatively 101)
(setq scroll-margin 3)
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backups"))))

; Backups
(setq make-backup-files t)
(setq create-lockfiles nil)
(global-auto-revert-mode t)

; Tab Sizes
(setq-default tab-width 4)
(setq-default c-basic-offset 4)
(setq-default indent-tabs-mode nil)
(setq-default python-indent-offset 4)
(setq-default js-indent-level 4)
(setq-default css-indent-level 4)

; UI Configuration
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-display-line-numbers-mode t)
(setq-default indent-tabs-mode nil)
(setq-default fill-column 80) ; add the line ruler at 80 char
(global-display-fill-column-indicator-mode 1)
(require 'whitespace) ; highlight magenta after 80 char
(setq whitespace-line-column 80)
(setq whitespace-style '(face lines-tail))
(set-face-attribute 'whitespace-line nil
                    :background "magenta"
                    :foreground "white")
(global-whitespace-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
