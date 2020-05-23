# dotfiles

My configuration and scripts

Custom scripts are located under `bin/`.

- `gr-sync` Sync local git repository diff to a remote server
- `pman` Syntactic sugar for `pacman`
  - `pman list` List available package updates
  - `pman fetch` Update package database
  - `pman search` Search for a package
  - `pman install` Install a package
  - `pman remove` Remove a package
- `certcheck` Check the expire date of given certificate
- `personal/5min-break` Display a window reminding you to take breaks every hour, if you are connected to specific VPN.

Custom `i3blocks` scripts are located under `.config/i3blocks/scripts/`

- `time` Show current Swedish time, when clicked show current time in India
- `current-spotify-song` Show the song currently playing
- `certificate-checker` Show warning if VPN certificate is expired

## Main players

- [i3-gaps](https://github.com/Airblader/i3)
- [i3blocks](https://github.com/vivien/i3blocks)
- [zsh](http://www.zsh.org/) and [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
- [kitty](https://github.com/kovidgoyal/kitty)

![Image of Desktop](i3wm.png)
