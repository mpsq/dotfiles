;;; init.el -*- lexical-binding: t; -*-

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
       (format +onsave +lsp)
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
       (spell +hunspell +everywhere)
       grammar

       :tools
       debugger
       (docker +lsp +tree-sitter)
       editorconfig
       llm
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
       markdown
       (org +journal +pretty)
       (python +lsp +pyright +tree-sitter)
       (rest +jq)
       (rust +lsp +tree-sitter)
       (sh +lsp)
       (web +lsp +tree-sitter)
       (yaml +lsp +tree-sitter)

       :app

       :config
       (default +bindings +smartparens +gnupg))
