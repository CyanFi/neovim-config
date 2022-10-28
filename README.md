<h1 align="center" style="font-family:georgia">Self-maintained NeoVim Configuration</h1>
<h4 align="center">Lightweight and Easy to Deploy</h4>
<hr/>
<p align="center">
  <img src="https://upload.wikimedia.org/wikipedia/commons/9/9f/Vimlogo.svg" width="250" height="250"/>
</p>

<p align="center">
<a href="https://www.gnu.org/licenses/gpl-3.0"><img src="https://img.shields.io/badge/License-GPL%20v3-blue.svg" alt="GPL License"></a>
<a href="https://github.com/sindresorhus/awesome"><img src="https://cdn.rawgit.com/sindresorhus/awesome/d7305f38d29fed78fa85652e3a63e154dd8e8829/media/badge.svg" alt="Awesome"></a>
</p>



> Final answer of your vim editor


## Installation(tested on macOS and Cent OS server)

Install neovim(skip if you already done)
(MacOS)
```bash
brew install neovim
```

Back up your original Neovim configuration(if you have one)

```bash
mv ~/.config/nvim ~/.config/nvim.bak
```



Install [Plug](https://github.com/junegunn/vim-plug)

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

Clone this repository

```
git clone https://github.com/cyanfi/neovim-config ~/.config/nvim
```

Use `nvim` to start neovim, then type `:PlugInstall` to install extensions.

**Happy hacking!**

## Architecture & Plugins:
Plugin Manager: [vim-plug](https://github.com/junegunn/vim-plug)

* [nerdTree](https://github.com/scrooloose/nerdtree), a file manager for vim

* [identLine](https://github.com/Yggdroot/indentLine), show the indent line

* [tagbar] (https://github.com/preservim/tagbar), browse the tags of the current code file and get an overview of its structure
* [nerdCommenter](https://github.com/scrooloose/nerdcommenter), comment code easily

* [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim), a highly extendable fuzzy finder over lists


  
> To install coc.nvim, make sure you have node or node.js installed, refer to the coc repo above for details.

  
* [goyo](https://github.com/junegunn/goyo.vim), 🌷 Distraction-free writing in Vim

* Vim-Bookmark

* To be continued...

The main configuration file is actually `~/nvim/init.vim`, thus you'd better delete the `.vimrc` in in your home dictionary. Refer to the Neovim site for more detailed information.



## Some Loooooonglasting Issues with this configuration:

* Color Display

  Some scripts has been added to `vimrc` to ensure the emulator to show the true color of your pretty color scheme.
* Compatability with tmux
