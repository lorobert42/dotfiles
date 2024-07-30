all: zsh nvim omp

zsh:
	stow --restow --target="${HOME}" --dotfiles zsh

nvim:
	stow --restow --target="${HOME}" nvim

omp:
	stow --restow --target="${HOME}" oh-my-posh
