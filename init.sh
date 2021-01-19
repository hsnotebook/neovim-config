#!/bin/bash

echo "Download plug.vim...."
proxychains curl -fLo autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Download wombat.vim...."
proxychains curl -fLo colors/wombat.vim --create-dirs \
	https://raw.githubusercontent.com/sheerun/vim-wombat-scheme/master/colors/wombat.vim

echo "Open neovim, execute :PlugInstall, and enjoy it ^_^"
