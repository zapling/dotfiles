# dotfiles

![Image of Desktop](i3wm.png)

## Major players

- [i3-gaps](https://github.com/Airblader/i3)
- [i3blocks](https://github.com/vivien/i3blocks)
- [zsh](http://www.zsh.org/) and [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
- [kitty](https://github.com/kovidgoyal/kitty)
- [nvim](https://neovim.io/)

## Setup

```
cd ~ && git clone git@github.com:zapling/dotfiles.git && cd dotfiles/setup && ./setup.sh
```

## Custom scripts

Custom scripts are located under `bin/`.

- `gr-sync` Sync local git repository diff to a remote server
- `pman` Syntactic sugar for `pacman`
  - `pman list` List available package updates
  - `pman info` Information about installed package
  - `pman fetch` Update package database
  - `pman search` Search for a package
  - `pman install` Install a package
  - `pman remove` Remove a package
  - `pman upgrade` Install updates for all packages available
- `certcheck` Check the expire date of given certificate
- `colortest` Print terminal color palette
- `abc` Print alphabet with highlighting

## i3blocks scripts

Custom `i3blocks` scripts are located under `.config/i3blocks/scripts/`

- `time` Show current Swedish time, when clicked show current time in India
- `current-spotify-song` Show the song currently playing
- `weather-yr.no` Show the current weather and temperature
- `certificate-checker` Show warning if VPN certificate is expired
- `battery` Show battery percentage with indicator when discharning and charging. Support for multiple batteries.
