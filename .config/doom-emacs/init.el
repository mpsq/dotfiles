;;; init.el -*- lexical-binding: t; -*-

;; NOTE Press 'SPC h d h' to access the documentation
;;      Press 'K' on a module to view its documentation
;;      Press 'gd' on a module to browse its  directory

(setenv "LSP_USE_PLISTS" "1")

(doom! :completion
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
       (dired +icons)
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
       debugger
       (docker +lsp +tree-sitter)
       editorconfig
       (lookup +dictionary +offline)
       lsp
       (magit +forge)
       make
       (terraform +lsp)
       tree-sitter

       :os
       tty

       :lang
       data
       emacs-lisp
       (go +lsp +tree-sitter)
       (json +lsp +tree-sitter)
       (java +lsp +tree-sitter)
       (javascript +lsp +tree-sitter)
       (markdown +tree-sitter)
       (org +journal +pretty)
       (python +lsp +tree-sitter)
       (rest +jq)
       (rust +lsp +tree-sitter)
       (sh +lsp +tree-sitter)
       (web +lsp +tree-sitter)
       (yaml +lsp +tree-sitter)

       :app

       :config
       (default +bindings +smartparens +gnupg)
       )
