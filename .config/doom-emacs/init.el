;;; init.el -*- lexical-binding: t; -*-

;; NOTE Press 'SPC h d h' to access the documentation
;;      Press 'K' on a module to view its documentation
;;      Press 'gd' on a module to browse its  directory

(setenv "LSP_USE_PLISTS" "1")

(doom! :completion
       ;; (company +childframe)
       (corfu +orderless +icons)
       (vertico +icons +childframe)

       :ui
       doom
       (emoji +unicode)
       hl-todo
       indent-guides
       modeline
       nav-flash
       ophints
       (popup +all +defaults)
       (treemacs +lsp)
       (vc-gutter +pretty)
       vi-tilde-fringe
       (window-select +numbers)
       workspaces

       :editor
       (evil +everywhere)
       file-templates
       fold
       (format +onsave)
       multiple-cursors

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
       (spell +flyspell +hunspell +everywhere)
       grammar

       :tools
       (debugger +lsp)
       (docker +lsp)
       editorconfig
       (eval +overlay)
       (lookup +dictionary +offline)
       (lsp +peek)
       (magit +forge)
       make
       pdf
       terraform
       tree-sitter

       :os
       tty

       :lang
       data
       emacs-lisp
       (go +lsp +tree-sitter)
       (json +lsp)
       (java +lsp)
       (javascript +lsp +tree-sitter)
       markdown
       (org +journal +hugo +pretty)
       (python +lsp)
       rest
       (rust +lsp)
       (sh +lsp +tree-sitter)
       (web +lsp +tree-sitter)
       (yaml +lsp)

       :email
       (mu4e +gmail +mbsync)

       :app
       ;;everywhere

       :config
       (default +bindings +smartparens)
       )
