package internal

import (
	"encoding/json"
	"io/ioutil"
	"os"
)

var configFolder = "weather-applet"
var configFile = "config.json"

type Configuration struct {
	Ssid      string  `json:"ssid"`
	Latitude  float64 `json:"latitude"`
	Longitude float64 `json:"longitude"`
}

// Default configuration with Gothenburg points
var defaultConfiguration Configuration = Configuration{
	Ssid:      "Your wifi name",
	Latitude:  57.7,
	Longitude: 11.9,
}

func GetConfig() []Configuration {
	path := getConfigDir()
	exists := os.MkdirAll(path, 0755)

	// could not create or read path
	if exists != nil {
		return getDefaultConfig()
	}

	fullPath := path + "/" + configFile
	f, err := os.Open(fullPath)
	// could not find config file
	if err != nil {
		writeDefaultConfig(fullPath)
		return getDefaultConfig()
	}

	defer f.Close()

	var config []Configuration
	bytes, _ := ioutil.ReadAll(f)
	json.Unmarshal(bytes, &config)

	return config
}

func getDefaultConfig() []Configuration {
	var config []Configuration
	return append(config, defaultConfiguration)
}

func writeDefaultConfig(path string) {
	config := getDefaultConfig()
	jsonData, _ := json.Marshal(config)
	f, _ := os.Create(path)
	f.Write(jsonData)
	f.Close()
}

func getConfigDir() string {
	xdg_config_home := os.Getenv("XDG_CONFIG_HOME")
	if xdg_config_home != "" {
		return xdg_config_home + "/" + configFolder
	}
	return os.Getenv("HOME") + "/.config/" + configFolder
}
