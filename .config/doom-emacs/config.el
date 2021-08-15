;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Doom config
(setq doom-theme 'doom-Iosvkem
      doom-font (font-spec :family "Iosevka Fixed SS17" :size 13)
      doom-big-font (font-spec :family "Iosevka Fixed SS17" :size 14)
      doom-variable-pitch-font (font-spec :family "Droid Sans" :size 13)
      doom-unicode-font (font-spec :family "Liberation Mono")
      doom-serif-font (font-spec :family "Droid Sans Mono")
      doom-unicode-font (font-spec :family "Iosevka SS17")
      doom-symbol-fallback-font-families '("Unifont")
      doom-emoji-fallback-font-families '("Noto Color Emoji"))

;; Nicer default buffer names
(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom")

;; Misc. settings
(setq display-line-numbers-type 'relative
      evil-want-fine-undo t               ; By default while in insert all changes are one big blob. Be more granular
      fill-column 80
      org-directory "~/docs"
      scroll-margin 2
      show-trailing-whitespace t
      undo-limit 80000000)

;; Indentation madness...
(setq evil-shift-width 2
      standard-indent 2
      tab-width 2
      indent-tabs-mode nil
      typecript-indent-level 2
      javascript-indent-level 2
      js-indent-level 2
      jsx-indent-level 2
      js2-basic-offset 2
      web-mode-markup-indent-offset 2
      web-mode-css-indent-offset 2
      web-mode-code-indent-offset 2
      css-indent-offset 2)
(add-hook! typescript-mode
  (setq typescript-indent-level 2))
(setq-hook! 'typescript-tsx-mode-hook web-mode-code-indent-offset 2)

;; LSP
(setq lsp-file-watch-threshold 20000)

;; Format on save
(setq-hook! 'js2-mode-hook +format-with-lsp nil)
(setq-hook! 'typescript-tsx-mode-hook +format-with-lsp nil)
(setq-hook! 'typescript-mode-hook +format-with-lsp nil)
(setq-hook! 'web-hook +format-with-lsp nil)
(setq +format-on-save-enabled-modes
     '(not emacs-lisp-mode  ; elisp's mechanisms are good enough
           sql-mode         ; sqlformat is currently broken
           tex-mode         ; latexindent is broken
           web-mode         ; broken with templates
           yaml-mode        ; clashes with other formatting tools
           latex-mode))

;; Better window selection
(map!
 (:leader
  :desc "Switch to window 0" :n "0" #'treemacs-select-window
  :desc "Switch to window 1" :n "1" #'winum-select-window-1
  :desc "Switch to window 2" :n "2" #'winum-select-window-2
  :desc "Switch to window 3" :n "3" #'winum-select-window-3
  :desc "Switch to window 4" :n "4" #'winum-select-window-4
  :desc "Switch to window 5" :n "5" #'winum-select-window-5
  :desc "Switch to window 6" :n "6" #'winum-select-window-6
  :desc "Switch to window 7" :n "7" #'winum-select-window-7
  :desc "Switch to window 8" :n "8" #'winum-select-window-8
  :desc "Switch to window 9" :n "9" #'winum-select-window-9))

;; Improve completion
(after! company
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 2
        company-show-quick-access t)
  (add-hook 'evil-normal-state-entry-hook #'company-abort))
(setq-default history-length 1000)
(setq-default prescient-history-length 1000)

;; Email configuration
(after! mu4e
  (setq mail-envelope-from 'header
        mail-user-agent 'mu4e-user-agent
        mail-specify-envelope-from 't
        message-kill-buffer-on-exit 't
        message-send-mail-function #'message-send-mail-with-sendmail
        message-sendmail-envelope-from 'header
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-sendmail-f-is-evil 't
        mu4e-attachment-dir "~/dl"
        mu4e-get-mail-command "true"
        mu4e-headers-include-related nil
        mu4e-index-lazy-check nil
        mu4e-update-interval 5
        mu4e-change-filenames-when-moving t
        send-mail-function #'smtpmail-send-it
        sendmail-program "/usr/bin/msmtp"))

;; Modeline
(use-package! mu4e
  :config
  (setq
   doom-modeline-enable-word-count nil
   doom-modeline-buffer-encoding nil
   doom-modeline-github t
   doom-modeline-mu4e t
   doom-modeline-gnus nil))

;; Treemacs config
(setq +treemacs-git-mode 'deferred)
(remove-hook 'doom-load-theme-hook #'doom-themes-treemacs-config)
(after! treemacs
   (setq treemacs-no-png-images t)
   (treemacs-follow-mode))

;; GPG settings/keyring
(setq auth-sources '("~/.authinfo.gpg")
      auth-source-cache-expiry nil
      password-cache-expiry nil
      epa-armor t
      epg-pinentry-mode 'loopback)
(after! pinentry
  :config
  (pinentry-start))

;; Auto flyspell
(add-hook! 'mu4e-compose-mode-hook
          (defun my-do-compose ()
            "My settings for message composition."
            (set-fill-column 80)
            (flyspell-mode)))
(defun +markdown-flyspell-word-p ()
  "Return t if point is on a word that should be spell checked.
Return nil if on a link url, markup, html, or references."
  (let ((faces (doom-enlist (get-text-property (point) 'face))))
    (or (and (memq 'font-lock-comment-face faces)
             (memq 'markdown-code-face faces))
        (not (cl-loop with unsafe-faces = '(markdown-reference-face
                                            markdown-url-face
                                            markdown-markup-face
                                            markdown-comment-face
                                            markdown-html-attr-name-face
                                            markdown-html-attr-value-face
                                            markdown-html-tag-name-face
                                            markdown-code-face)
                      for face in faces
                      if (memq face unsafe-faces)
                      return t)))))
(set-flyspell-predicate! '(markdown-mode gfm-mode)
  #'+markdown-flyspell-word-p)
(add-hook 'markdown-mode-hook 'flyspell-mode)

;; Magit inline diff
(setq magit-diff-refine-hunk (quote all))

;; Load private stuff
(when (file-exists-p "~/.config/priv/config.el")
  (load-file "~/.config/priv/config.el"))
