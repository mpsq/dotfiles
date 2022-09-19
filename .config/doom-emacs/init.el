;;; init.el -*- lexical-binding: t; -*-

;; NOTE Press 'SPC h d h' to access the documentation
;;      Press 'K' on a module to view its documentation
;;      Press 'gd' on a module to browse its  directory

(doom! :completion
       (company +childframe)
       (vertico +icons)

       :ui
       doom
       (emoji +unicode)
       hl-todo
       hydra
       indent-guides
       modeline
       nav-flash
       ophints
       (popup +all +defaults)
       (treemacs +lsp)
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
       (dired +icons +dirvish)
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
       (lookup +dictionary +offline)
       (lsp +peek)
       (magit +forge)
       make
       pdf
       rgb
       taskrunner
       terraform
       tree-sitter

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

       :config
       (default +bindings +smartparens))
