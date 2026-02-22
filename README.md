# dotfiles

Configuration files for my Arch Linux desktop, managed with
[VCSH](https://github.com/RichiH/vcsh). The setup runs
[Sway](https://github.com/swaywm/sway) on Wayland with [Doom
Emacs](https://github.com/doomemacs/doomemacs) as the primary editor.

## What's included

- **Window manager** -- [Sway](https://github.com/swaywm/sway),
  [Waybar](https://github.com/Alexays/Waybar) and
  [Fuzzel](https://codeberg.org/dnkl/fuzzel)
- **Editor** -- Doom Emacs in daemon mode 
- **Shell** -- Bash with vi mode
- **Terminal** -- [Foot](https://codeberg.org/dnkl/foot)
- **Audio** -- PipeWire / WirePlumber,
  [EasyEffects](https://github.com/wwmm/easyeffects)
- **Git** -- GPG commit signing, [delta](https://github.com/dandavison/delta)
  pager
- **Dev tools** -- Go, Java, Python, Rust, JavaScript/Node
  ([NVM](https://github.com/nvm-sh/nvm)), Docker, Terraform, Kubernetes
- **Systemd user services** -- most desktop components launch via
  `sway-session.target`
- **Scripts** -- volume/brightness control, screen capture, session lock,
  workspace management, launcher

## Setup

These dotfiles are deployed with VCSH. Each file lands in `$HOME` at the path
shown above.

```sh
vcsh clone <repo-url> dotfiles
```

## Key packages

A full list lives in `.config/packages.list` and `.config/packages-aur.list`.
NPM and pip packages are listed in `.config/packages-npm.list` and
`.config/packages-pip.list`.

## License

These are personal configuration files. Use whatever you find useful.
