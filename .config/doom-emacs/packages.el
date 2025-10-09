;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el
(package! focus)
(package! lsp-biome
  :recipe (:host github
           :repo "cxa/lsp-biome"
           :files ("lsp-biome.el")
           :branch "main"))
