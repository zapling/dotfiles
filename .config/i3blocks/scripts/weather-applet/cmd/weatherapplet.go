package main

import (
	"fmt"
	"os"
	"weather-applet/internal"
)

func main() {
	ssid := internal.GetCurrentSsid()
	if ssid == "" {
		os.Exit(1)
	}

	config := internal.GetConfig()
	for i := range config {
		if config[i].Ssid == ssid {
			fmt.Println(internal.GetForecast(config[i]))
		}
	}
}
