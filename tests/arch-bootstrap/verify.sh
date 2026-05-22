#!/usr/bin/env bash

set -e

chezmoi init --source ~/.local/share/chezmoi \
  --promptString "merge_tool=vimdiff" \
  --promptString "Git name=Test User" \
  --promptString "Git email=test@example.com" \
  --promptString "Git signing key="

~/.local/share/chezmoi/bootstrap.sh

pass=0
fail=0

check() {
  local desc="$1"
  local cmd="$2"
  if eval "$cmd" >/dev/null 2>&1; then
    echo "  PASS: $desc"
    pass=$((pass + 1))
  else
    echo "  FAIL: $desc"
    fail=$((fail + 1))
  fi
}

echo "==> Packages"
while IFS= read -r pkg; do
  check "$pkg" "sudo pacman -Q $pkg"
done < <(chezmoi execute-template '
{{- $pkgs := .linux_arch.all.packages -}}
{{- if .graphical -}}{{- $pkgs = concat $pkgs .linux_arch.graphical.packages -}}{{- end -}}
{{ range $pkgs }}{{ . }}{{ "\n" }}{{ end }}')

echo "==> Config files"
while IFS= read -r file; do
  check "$file" "test -e ~/$file"
done < <(chezmoi managed --include=files)

echo "==> Tmux plugins"
while IFS= read -r plugin; do
  name="${plugin##*/}"
  check "$name" "test -d ~/.tmux/plugins/$name"
done < <(grep "^set -g @plugin" ~/.tmux.conf | grep -oP "(?<=')[^/]+/[^']+" | grep -v "^github_username")

echo "==> Fish plugins"
while IFS= read -r plugin; do
  name="${plugin%%@*}"
  name="${name##*/}"
  check "$name" "fish -c 'fisher list' 2>/dev/null | grep -qF '$plugin'"
done <~/.config/fish/fish_plugins

echo ""
echo "Results: $pass passed, $fail failed"
test "$fail" -eq 0
