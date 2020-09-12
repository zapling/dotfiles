package internal

import (
	"bytes"
	"fmt"
	"github.com/zapling/yr.no-golang-client/pkg/yr"
	"os/exec"
	"strings"
)

func GetForecast(config Configuration) string {
	forecast, err := yr.GetLocationForecast(
		config.Latitude,
		config.Longitude,
		"WeatherApplet 1.0",
	)

	if err != nil {
		return ""
	}

	temperature := fmt.Sprintf(
		"%.0f",
		forecast.Properties.Timeseries[0].Data.Instant.Details.AirTemperature,
	)
	symbols := strings.Split(
		forecast.Properties.Timeseries[0].Data.Next1Hours.Summary.SymbolCode,
		"_",
	)
	emojie := Emojies[symbols[0]]

	return temperature + "°C " + emojie
}

func GetCurrentSsid() string {
	cmd := "iw dev | grep ssid | awk '{print $2'}"
	ssid, err := exec.Command("bash", "-c", cmd).Output()
	if err != nil {
		return ""
	}

	return string(bytes.Trim(ssid, "\n"))
}
