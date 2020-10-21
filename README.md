# ctrlp-launcher

Launcher for CtrlP

## Usage

```
:CtrlPLauncher
```

## Configuration

Edit `~/.ctrlp-launcher`

```
💻 raspi	!mintty ssh raspberrypi
⚡ windows terminal	!start wt
⚡ wsl	!start wt -p Ubuntu
👉 cmd	!start cmd
👉 vim	!start gvim
```

* Few tab characters to separate title and command.
* Leading sharp mean comments. empty line is ignored.

## Installation

```
Plug 'ctrlpvim/ctrlp.vim'
Plug 'mattn/ctrlp-launcher'
```

## License

MIT

## Author

Yasuhiro Matsumoto (a.k.a. mattn)
