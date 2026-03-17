# mpsq's dotfiles

Configuration files for an Arch Linux desktop that took far longer to set up
than anyone would care to admit. Managed with
[VCSH](https://github.com/RichiH/vcsh), because symlinks are for people who
haven't suffered enough.

## What's in the box

**Desktop** -- [Sway](https://github.com/swaywm/sway) on Wayland,
[Noctalia](https://github.com/noctalia-dev/noctalia-shell) for the shell and
theming + [Fuzzel](https://codeberg.org/dnkl/fuzzel) as a dynamic menu.  The
whole session is orchestrated by systemd user services under
`sway-session.target`.

**Editor** -- [Doom Emacs](https://github.com/doomemacs/doomemacs) running as a
daemon. LSP and tree-sitter.

**Terminal** -- [Foot](https://codeberg.org/dnkl/foot). Fast, Wayland-native,
does what it's told.

**Shell** -- Bash with vi mode.

**Audio** -- PipeWire and WirePlumber.
[EasyEffects](https://github.com/wwmm/easyeffects) for bikeshedding audio
settings.

**Dev tools** -- Go, Java, Python, Rust, JavaScript. Docker, Terraform,
Kubernetes.

**Scripts** -- Volume control, screen capture, workspace shuffling, and a
pinentry wrapper.

## Setup

```sh
vcsh clone <repo-url> dotfiles
```

That's it. Every file lands in `$HOME` where it belongs.

## Packages

The full inventory lives in `.config/packages.list` and
`.config/packages-aur.list`. NPM dependencies in
`.config/packages-npm.list`.

## License

Personal config files. Take whatever you find useful, no need to ask.
