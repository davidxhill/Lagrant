#!/usr/bin/env bash

echo "--- Setting VIM Preferences ---"
curl https://j.mp/spf13-vim3 -L > spf13-vim.sh
curl -o /home/vagrant/.vimrc.local https://raw.github.com/davidxhill/my-vimrc/master/.vimrc.local
