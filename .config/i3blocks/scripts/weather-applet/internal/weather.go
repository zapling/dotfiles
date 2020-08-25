package internal

import (
	"os/exec"
)

// nmcli -t -f name,device connection show --active | cut -d\: -f1
func GetCurrentSsid(ids []string) string {
	nmcli := exec.Command("nmcli", "connection", "show", "--active")
	pipe, _ := nmcli.StdoutPipe()
	defer pipe.Close()

	nmcli.Start()

	for _, v := range ids {
		grep := exec.Command("grep", v)
		grep.Stdin = pipe
		_, err := grep.Output()
		if err != nil {
			continue
		}

		return v
	}

	return ""
}
