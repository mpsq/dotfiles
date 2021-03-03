;;; init.el -*- lexical-binding: t; -*-

;; NOTE Press 'SPC h d h' to access the documentation
;;      Press 'K' on a module to view its documentation
;;      Press 'gd' on a module to browse its  directory

(doom! :completion
       (company +childframe)
       (ivy +fuzzy +childframe +icons)

       :ui
       doom
       doom-dashboard
       doom-quit
       (emoji +unicode)
       fill-column
       hl-todo
       hydra
       indent-guides
       modeline
       ophints
       (popup +defaults)
       treemacs
       vc-gutter
       vi-tilde-fringe
       (window-select +numbers)
       workspaces

       :editor
       (evil +everywhere)
       file-templates
       fold
       (format +onsave)
       multiple-cursors
       snippets

       :emacs
       dired
       electric
       (ibuffer +icons)
       undo
       vc

       :term
       vterm

       :checkers
       (syntax +childframe)
       (spell +flyspell +hunspell)
       grammar

       :tools
       (debugger +lsp)
       (docker +lsp)
       (eval +overlay)
       gist
       lookup
       (lsp +peek)
       (magit +forge)
       pdf
       rgb
       terraform

       :os
       ;;tty

       :lang
       data
       emacs-lisp
       (go +lsp)
       (json +lsp)
       (java +lsp)
       (javascript +lsp)
       markdown
       (org +journal +hugo +pretty)
       (python +lsp)
       rest
       (rust +lsp)
       (sh +lsp)
       (web +lsp)
       (yaml +lsp)

       :email
       (mu4e +gmail)

       :app
       calendar

       :config
       (default +bindings +smartparens))
