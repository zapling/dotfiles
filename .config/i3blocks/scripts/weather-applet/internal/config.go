package internal

import (
	"os"
)

var configFolder = "weather-applet"
var configFile = "config.json"

func GetConfig() {
	path := getConfigDir()
}

func getConfigDir() string {
	xdg_config_home := os.Getenv("XDG_CONFIG_HOME")
	if xdg_config_home != "" {
		return xdg_config_home + "/" + configFolder
	}
	return os.Getenv("HOME") + "/.config/" + configFolder
}
