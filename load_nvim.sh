
export XDG_CONFIG_HOME="$HOME/.config"
alias nvim=$XDG_CONFIG_HOME/nvim/nvim-linux64/bin/nvim

FILE=$XDG_CONFIG_HOME/nvim/nvim-linux64.tar.gz
if [ ! -f "$FILE" ]; then
    echo "No nvim installed yet"

    wget https://github.com/neovim/neovim/releases/download/v0.10.0/nvim-linux64.tar.gz

    tar xzvf nvim-linux64.tar.gz
fi

PACKER=~/.local/share/nvim/site/pack/packer/start/packer.nvim
if [ ! -d "$PACKER" ]; then
    echo "No packer installed yet"
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
     ~/.local/share/nvim/site/pack/packer/start/packer.nvim
fi
