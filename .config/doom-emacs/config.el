;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Doom config
(setq doom-theme 'doom-Iosvkem
      doom-font (font-spec :family "Iosevka Fixed SS16" :size 13)
      doom-big-font (font-spec :family "Iosevka Fixed SS16" :size 14)
      doom-variable-pitch-font (font-spec :family "Droid Sans" :size 13)
      doom-symbol-font (font-spec :family "Liberation Mono")
      doom-serif-font (font-spec :family "Droid Sans Mono"))
(setq confirm-kill-emacs nil)
(setq emojify-emoji-set "twemoji-v2")

;; Nicer default buffer names
(setq doom-fallback-buffer-name "► Doom"
      +doom-dashboard-name "► Doom")

;; Misc. settings
(setq display-line-numbers-type 'relative
      fill-column 80
      org-directory "~/docs"
      show-trailing-whitespace t
      tramp-histfile-override "/dev/null"
      undo-limit 80000000)

;; Improve completion
(setq-default history-length 1000)
(setq-default prescient-history-length 1000)

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

;; rainbow-mode
;; Enable rainbow delimiters in prog-mode
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))
;; Enable rainbow-mode for relevant major modes
(add-hook! org-mode 'rainbow-mode)
(add-hook! prog-mode 'rainbow-mode)

;; Formatting
(use-package! apheleia
  :defer t
  :config
  ;; format markdown with prettier
  (push '(markdown-mode . prettier) apheleia-mode-alist))
;; On save
(setq +format-on-save-disabled-modes
      '(web-mode         ; broken with templates
        yaml-mode        ; clashes with other formatting tools
        ))

;; LSP
(setq lsp-clients-typescript-max-ts-server-memory 4096)
(setq lsp-file-watch-threshold 20000)
(setq lsp-use-plists "true")

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

;; Load private stuff
(when (file-exists-p "~/.config/priv/config.el")
  (load-file "~/.config/priv/config.el"))

;; Email configuration
;; see https://tecosaur.github.io/emacs-config/config.html#rebuild-mail-index
(after! mu4e
  (setq mail-user-agent 'mu4e-user-agent
        message-kill-buffer-on-exit 't
        ;; Do now expose hostname in Message-ID
        message-required-mail-headers (remove' Message-ID message-required-mail-headers)
        mu4e-attachment-dir "~/dl"
        mu4e-change-filenames-when-moving t
        mu4e-search-results-limit 1000)

  ;; mstmp conf
  (setq sendmail-program (executable-find "msmtp")
        send-mail-function #'smtpmail-send-it
        message-sendmail-f-is-evil t
        message-sendmail-envelope-from 'header
        message-sendmail-extra-arguments '("--read-envelope-from")
        message-send-mail-function #'message-send-mail-with-sendmail)

  (setq mu4e-headers-fields
        '((:account-stripe . 1)
          (:human-date . 18)
          (:maildir . 30)
          (:flags . 6)
          (:from-or-to . 30)
          (:recipnum . 2)
          (:subject)))

  (defvar mu4e-reindex-request-file "/tmp/mu_reindex_now"
    "Location of the reindex request, signaled by existance")
  (defvar mu4e-reindex-request-min-seperation 5.0
    "Don't refresh again until this many second have elapsed.
Prevents a series of redisplays from being called (when set to an appropriate value)")

  (defvar mu4e-reindex-request--file-watcher nil)
  (defvar mu4e-reindex-request--file-just-deleted nil)
  (defvar mu4e-reindex-request--last-time 0)

  (defun mu4e-reindex-request--add-watcher ()
    (setq mu4e-reindex-request--file-just-deleted nil)
    (setq mu4e-reindex-request--file-watcher
          (file-notify-add-watch mu4e-reindex-request-file
                                 '(change)
                                 #'mu4e-file-reindex-request)))

  (defadvice! mu4e-stop-watching-for-reindex-request ()
    :after #'mu4e--server-kill
    (if mu4e-reindex-request--file-watcher
        (file-notify-rm-watch mu4e-reindex-request--file-watcher)))

  (defadvice! mu4e-watch-for-reindex-request ()
    :after #'mu4e--server-start
    (mu4e-stop-watching-for-reindex-request)
    (when (file-exists-p mu4e-reindex-request-file)
      (delete-file mu4e-reindex-request-file))
    (mu4e-reindex-request--add-watcher))

  (defun mu4e-file-reindex-request (event)
    "Act based on the existance of `mu4e-reindex-request-file'"
    (if mu4e-reindex-request--file-just-deleted
        (mu4e-reindex-request--add-watcher)
      (when (equal (nth 1 event) 'created)
        (delete-file mu4e-reindex-request-file)
        (setq mu4e-reindex-request--file-just-deleted t)
        (mu4e-reindex-maybe t))))

  (defun mu4e-reindex-maybe (&optional new-request)
    "Run `mu4e--server-index' if it's been more than
`mu4e-reindex-request-min-seperation'seconds since the last request,"
    (let ((time-since-last-request (- (float-time)
                                      mu4e-reindex-request--last-time)))
      (when new-request
        (setq mu4e-reindex-request--last-time (float-time)))
      (if (> time-since-last-request mu4e-reindex-request-min-seperation)
          (mu4e--server-index nil t)
        (when new-request
          (run-at-time (* 1.1 mu4e-reindex-request-min-seperation) nil
                       #'mu4e-reindex-maybe))))))

;; Startup
(defun greedily-do-daemon-setup ()
  (require 'org)
  (when (require 'mu4e nil t)
    (setq mu4e-confirm-quit t)
    (setq +mu4e-lock-greedy t)
    (setq +mu4e-lock-relaxed t)
    (when (+mu4e-lock-available t)
      (mu4e--start))))

(defun autosave-history-daemon-mode ()
  (require 'recentf)
  ;; trigger recentf every 5 minutes (useful when running Emacs daemon)
  (run-at-time (current-time) 300 'recentf-save-list))

(when (daemonp)
  (add-hook 'emacs-startup-hook #'greedily-do-daemon-setup)
  (add-hook 'emacs-startup-hook #'autosave-history-daemon-mode))

;; Modeline
(use-package! mu4e
  :config
  (setq
   doom-modeline-github t
   doom-modeline-mu4e t
   doom-modeline-persp-name t))

;; Do not create new workspace for new emacsclient
(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main"))

;; Treemacs config
(setq +treemacs-git-mode 'extended)
(after! treemacs
  (setq treemacs-no-png-images t
        treemacs-space-between-root-nodes nil
        treemacs-collapse-dirs 5)
  (treemacs-follow-mode))

;; GPG settings/keyring
(setq auth-sources '("~/.authinfo.gpg")
      auth-source-cache-expiry nil
      password-cache-expiry nil
      epa-armor t)

;; Magit
(setq magit-diff-refine-hunk (quote all))
;; https://github.com/magit/magit/issues/3549
(setq magit-process-finish-apply-ansi-colors t)

;; vcsh / magit compatibility
(after! magit
  (defun ~/magit-process-environment (env)
    "Add GIT_DIR and GIT_WORK_TREE to ENV when in a special directory.
        https://github.com/magit/magit/issues/460."
    (let ((default (file-name-as-directory (expand-file-name default-directory)))
          (home (expand-file-name "~/")))
      (when (string= default home)
        (let ((gitdir (expand-file-name "~/.config/vcsh/repo.d/dotfiles.git/")))
          (push (format "GIT_WORK_TREE=%s" home) env)
          (push (format "GIT_DIR=%s" gitdir) env))))
    env)

  (advice-add 'magit-process-environment
              :filter-return #'~/magit-process-environment))

;; vterm
(use-package! vterm
  :config
  (evil-define-key 'insert vterm-mode-map (kbd "C-j") #'vterm--self-insert))
