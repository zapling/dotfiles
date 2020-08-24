package internal

import (
	"fmt"
	"os/exec"
)

// wip: https://stackoverflow.com/questions/41037870/go-exec-command-run-command-which-contains-pipe
func GetCurrentSsid(ids []string) {
	nmcli := exec.Command("nmcli", "connection", "show", "--active")
	pipe, _ := nmcli.StdoutPipe()
	defer pipe.Close()

	nmcli.Start()

	for _, v := range ids {
		grep := exec.Command("grep", v)
		grep.Stdin = pipe
		res, _ := grep.Output()
		fmt.Print(string(res))

	}

	// grep := exec.Command("grep", "bla")

	// pipe, _ = nmcli.StdoutPipe()
	// defer pipe.Close()

	// grep.Stdin = pipe

	// nmcli.Start()
	// res, err := grep.Output()

	// if err != nil {
	// 	fmt.Print(err)
	// }

	// fmt.Print(string(res))

}
