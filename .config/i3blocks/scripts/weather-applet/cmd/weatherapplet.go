package main

import (
	"fmt"
	"weather-applet/internal"
)

func main() {
	config := internal.GetConfig()
	var ids []string
	for _, v := range config {
		ids = append(ids, v.Ssid)
	}
	ssid := internal.GetCurrentSsid(ids)
	fmt.Print(ssid)
	for i := range config {
		if config[i].Ssid == ssid {
			fmt.Print(config[i])
		}
	}
}
