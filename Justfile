default:
    @just --list

apply:
    chezmoi apply -v

diff:
    chezmoi diff

update:
    chezmoi update -v

test:
    docker buildx build -f tests/arch-bootstrap/Dockerfile -t dotfiles-test:arch-bootstrap .
    docker run --rm -t \
        --init \
        -e TERM=dumb \
        -v "$(pwd):/home/testuser/.local/share/chezmoi:ro" \
        -v dotfiles-test-pacman-cache:/var/cache/pacman/pkg \
        dotfiles-test:arch-bootstrap

test-clean:
    docker buildx build --no-cache -f tests/arch-bootstrap/Dockerfile -t dotfiles-test:arch-bootstrap .
    docker run --rm -t \
        --init \
        -e TERM=dumb \
        -v "$(pwd):/home/testuser/.local/share/chezmoi:ro" \
        -v dotfiles-test-pacman-cache:/var/cache/pacman/pkg \
        dotfiles-test:arch-bootstrap
