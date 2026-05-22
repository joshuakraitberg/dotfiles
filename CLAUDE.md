# Chezmoi Dotfiles

Cross-distro dotfiles managed with chezmoi.

## Structure

- `.chezmoidata/packages.yaml` — package lists per OS, split into `all` and
  `graphical`
- `.chezmoitemplates/logging.sh` — shared logging: `log_info`, `log_warn`,
  `log_error`, `die`
- `.chezmoi.yaml.tmpl` — config template; auto-detects graphical via Wayland/X11
  sockets
- `run_onchange_before_*.sh.tmpl` — scripts run before chezmoi apply
- `run_onchange_after_*.sh.tmpl` — scripts run after chezmoi apply
- `bootstrap.sh` — minimal first-run bootstrap; runs before chezmoi; must stay
  POSIX sh
- `tests/arch-bootstrap/` — Docker-based bootstrap test

## Script conventions

- Shebang `#!/usr/bin/env bash` (except `bootstrap.sh`: POSIX `sh`)
- Template logic (`{{- }}`) at the top only — no template expressions in main
  code body
- Shell variables assigned from template values using `| quote`
- Arrays for package lists: `pkgs=({{ range $pkgs }}{{ . | quote }} {{ end }})`
- `set -e` placed after function definitions
- Use `die` instead of `log_error + exit 1`
- Guard array installs:
  `(( ${#arr[@]} )) && { log_info "..."; install_fn "${arr[@]}"; }`
- Functions named `install_<manager>` (e.g. `install_pacman`, `install_aur`,
  `install_apt`, `install_snap`)

## packages.yaml structure

```yaml
linux_<os>:
  all:
    packages: [...] # native package manager
    aur: [...] # AUR (arch only)
    snap: [...] # snap (ubuntu only)
  graphical:
    packages: [...] # only installed when graphical environment detected
    aur: [...]
    snap: [...]
```

## Graphical detection

Auto-detected in `.chezmoi.yaml.tmpl` via Wayland socket
(`/run/user/{uid}/wayland-0`) or X11 socket (`/tmp/.X11-unix/X0`). Works
correctly over SSH.

## Testing

```bash
just test        # build + run (cached pacman volume)
just test-clean  # force full rebuild
```

`verify.sh` calls `bootstrap.sh` then checks packages, managed files, tmux
plugins, and fish plugins.
