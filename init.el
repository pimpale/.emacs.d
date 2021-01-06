(setq lexical-binding t)
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(package-initialize)

;; Use Package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(setq use-package-always-ensure t)

;; May be an issue idk
(use-package gnu-elpa-keyring-update)

;; Set settings
(setq inhibit-startup-screen t)
(setq sentence-end-double nil)
(setq use-dialog-box nil)
(setq compilation-read-command nil)
(setq compilation-scroll-output t)
;; No backups
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq create-lockfiles nil)
;; a buffer-local variable when set.
(setq-default indent-tabs-mode nil)
;; prevent symlinks weird stuff
(setq vc-follow-symlinks nil)


(defalias 'yes-or-no-p 'y-or-n-p) ; Accept 'y' in lieu of 'yes'.

;; Remove keybindings
(unbind-key "C-x C-d") ;; list-directory
(unbind-key "C-z") ;; suspend-frame
(unbind-key "M-o") ;; facemenu-mode
(unbind-key "<mouse-2>") ;; pasting with mouse-wheel click
(unbind-key "<C-wheel-down>") ;; text scale adjust
(unbind-key "<C-wheel-up>") ;; ditto

;; undo tree
(use-package undo-tree
  :diminish
  :bind (("C-c _" . undo-tree-visualize))
  :config
  (global-undo-tree-mode +1)
  (unbind-key "M-_" undo-tree-map))

(use-package which-key
  :init (which-key-mode))

;;;;;;;;;;;;;;;;;;;;;;;
;; Theming
;;;;;;;;;;;;;;;;;;;;;;;

;; use gruvbox theme
(use-package gruvbox-theme
	     :config (load-theme 'gruvbox-dark-medium t))

;; Use terminus
(ignore-errors (set-frame-font "Terminus 16" nil t))

;; no toolbars
(when (window-system)
  (tool-bar-mode -1)
  (scroll-bar-mode -1)
  (tooltip-mode -1))

;; highlight current line
(require 'hl-line)
(add-hook 'prog-mode-hook #'hl-line-mode)
(add-hook 'text-mode-hook #'hl-line-mode)
(set-face-attribute 'hl-line nil :background "gray21")

;; show matching parens
(show-paren-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP Configuration
;;;;;;;;;;;;;;;;;;;;;;;;;;;
(use-package lsp-mode
  :commands (lsp lsp-execute-code-action)
  :hook ((go-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration)
         (lsp-mode . lsp-diagnostics-modeline-mode))
  :bind ("C-c C-c" . #'lsp-execute-code-action)
  :custom
  (lsp-diagnostics-modeline-scope :project)
  (lsp-file-watch-threshold 5000)
  (lsp-enable-file-watchers nil))

(use-package lsp-ui
  :custom
  (lsp-ui-doc-delay 0.75)
  (lsp-ui-doc-max-height 200)
  :after lsp-mode)

(use-package rust-mode
  :hook ((rust-mode . lsp)
         (rust-mode . lsp-lens-mode)
         )
  :custom
  (rust-format-on-save t)
  (lsp-rust-server 'rust-analyzer))

(add-hook 'c-mode-hook 'lsp)
(add-hook 'cpp-mode-hook 'lsp)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Auto completion
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package company
  :diminish
  :bind (("C-." . #'company-complete))
  :hook (prog-mode . company-mode)
  :custom
  (company-dabbrev-downcase nil "Don't downcase returned candidates.")
  (company-show-numbers t "Numbers are helpful.")
  (company-tooltip-limit 20 "The more the merrier.")
  (company-tooltip-idle-delay 0.4 "Faster!")
  (company-async-timeout 20 "Some requests can take a long time. That's fine.")
  :config

  ;; Use the numbers 0-9 to select company completion candidates
  (let ((map company-active-map))
    (mapc (lambda (x) (define-key map (format "%d" x)
   `(lambda () (interactive) (company-complete-number ,x))))
          (number-sequence 0 9))))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(company which-key lsp-treemacs lsp-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
