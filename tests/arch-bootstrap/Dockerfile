FROM docker.io/archlinux:latest

# Only install bootstrap prerequisites — bootstrap.sh installs the rest
RUN --mount=type=cache,target=/var/cache/pacman/pkg,sharing=locked \
    pacman -Syu --noconfirm && \
    pacman -S --noconfirm git curl sudo base-devel

# Non-root user required for AUR
RUN useradd -m -G wheel testuser && \
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel

# Used to automate chezmoi init
RUN --mount=type=cache,target=/var/cache/pacman/pkg,sharing=locked \
    pacman -S --noconfirm chezmoi

USER testuser
WORKDIR /home/testuser
RUN mkdir -p /home/testuser/.local/share

# Install paru for AUR packages
RUN git clone https://aur.archlinux.org/paru-bin.git /tmp/paru && \
    cd /tmp/paru && makepkg -si --noconfirm && \
    rm -rf /tmp/paru

CMD ["/home/testuser/.local/share/chezmoi/tests/arch-bootstrap/verify.sh"]
