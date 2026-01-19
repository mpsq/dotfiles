;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Doom config
(setq doom-theme 'doom-monokai-ristretto
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

;; LSP
(setq lsp-clients-typescript-max-ts-server-memory 4096)
(setq lsp-file-watch-threshold 20000)
(setq lsp-use-plists "true")

(use-package! lsp-biome
  :init
  (setq lsp-biome-format-on-save t)

  :preface
  (defun my/lsp-biome-active-hook ()
    (setq-local apheleia-formatter '(biome)))

  :config
  (add-hook 'lsp-biome-active-hook #'my/lsp-biome-active-hook))

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

;; Trigger recentf every 5 minutes (useful when running Emacs daemon)
(after! recentf
  (recentf-load-list)
  (run-at-time nil (* 5 60) #'recentf-save-list))

;; Modeline
(use-package! doom-modeline
  :config
  (setq
   doom-modeline-github t
   doom-modeline-persp-name t))

;; Do not create new workspace for new emacsclient
(after! persp-mode
  (setq persp-emacsclient-init-frame-behaviour-override "main"))

;; Treemacs config
(setq +treemacs-git-mode 'extended)
(after! treemacs
  (treemacs-follow-mode))
;; Docs for M-x +treemacs/toggle says to use M-x treemacs command to use it to
;; get the old functionality (ie. not removing projects from current)
(map! :leader "o p" #'treemacs)

;; Configure projectile for better project management
(after! projectile
  (setq projectile-project-search-path '("~/devel/" "~/code/")
        projectile-require-project-root nil))

;; GPG settings/keyring
(setq auth-sources '("~/.authinfo.gpg")
      auth-source-cache-expiry nil
      password-cache-expiry nil
      epa-armor t)

;; Magit
(setq magit-diff-refine-hunk (quote all))

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

;; Dim regions not on … focus
(use-package! focus)
