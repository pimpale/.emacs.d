;; The directory to save all the backups in
;;(defvar --backup-directory (concat user-emacs-directory "backups"))
;;(if (not (file-exists-p --backup-directory))
;;  (make-directory --backup-directory t))
;;(setq make-backup-directory-alist '(("." . --backup-directory))
;;      make-backup-files t
;;      backup-by-copying t
;;      version-control t
;;      delete-old-versions t
;;      auto-save-default t)

(setq make-backup-files nil)
(setq auto-save-default nil)

(load-theme 'deeper-blue)
(set-frame-font "xos4 Terminus 16" nil t)
(setq vc-follow-symlinks nil)
