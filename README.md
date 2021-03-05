# Gonçalo's vim configuration

This repo contains my [vim configuration](vimrc) and [plugins](pack/vendor/start), used across Linux and macOS.

# Setup

1. `git clone --depth 1 git@github.com:goncalossilva/vimrc.git ~/.vim`
2. `cd ~/.vim && git submodule update --init`

Done.

To update all plugins, run `git submodule update --remote`.

## A note on ALE

Besides linting and (auto-)fixing, [ALE](https://github.com/dense-analysis/ale) is used for intellisense-like completion, replacing alternatives like [coc.vim](https://github.com/neoclide/coc.nvim). To have linters, LSPs, etc, available without polluting \$PATH, install them locally and source them.

For example (you probably don't need all of these):

```
$ mkdir -p $HOME/.vim-ale/{pip,npm,gem,go,git}`
$ pip install --target="$HOME/.vim-ale/pip" black pylint mypy python-language-server gitlint
$ npm install --prefix="$HOME/.vim-ale/npm" bash-language-server vim-language-server prettier prettier-eslint eslint typescript htmlhint
$ gem install --install-dir="$HOME/.vim-ale/gem" rubocop solargraph
$ GOPATH="$HOME/.vim-ale/go" go get golang.org/x/lint/golint
$ GOPATH="$HOME/.vim-ale/go" GO111MODULE="on" go get mvdan.cc/sh/v3/cmd/shfmt
$ git clone https://github.com/elixir-lsp/elixir-ls.git $HOME/.vim-ale/git/elixir-ls && cd $HOME/.vim-ale/git/elixir-ls && mix deps.get && mix compile && mix elixir_ls.release
```

And then in your vim configuration:

```
let $PYTHONPATH .= $HOME.'/.vim-ale/pip'
let $PATH .= ':'.$HOME.'/.vim-ale/pip/bin'
let $PATH .= ':'.$HOME.'/.vim-ale/npm/node_modules/.bin'
let $PATH .= ':'.$HOME.'/.vim-ale/gem/bin'
let $PATH .= ':'.$HOME.'/.vim-ale/go/bin'
let g:ale_elixir_elixir_ls_release = $HOME.'/.vim-ale/git/elixir-ls/release'
```
