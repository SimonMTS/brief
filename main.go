package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"os/exec"
	"regexp"
	"strings"
)

/*

:vnew | 0read ! go run . expand('%')
:lua require"pcurl".pcurl_vsplit()

todo:
open a vim split with just the output
refresh that output on reruns

*/

func main() {
    if len(os.Args) < 2 {
        log.Fatalln("Needs a file")
    }

    dat, err := os.ReadFile(os.Args[1])
    if err != nil {
        log.Fatalln(err.Error())
    }

    var lines []string
    commentRegex := regexp.MustCompile(`\s*#.*$`)
    scanner := bufio.NewScanner(strings.NewReader(string(dat)))
    for scanner.Scan() {
        line := commentRegex.ReplaceAllString(scanner.Text(), "")
        if len(line) > 0 {
            lines = append(lines, line)
        }
    }

    commandString := ""
    for i, l := range lines {
        commandString += " " + l

        if i+1 < len(lines) && lines[i+1][0] != '-' {
            commandString += "\n"
        }
    }
    commandString += " --silent"

    cmd := exec.Command("sh", "-c", commandString)
    out, err := cmd.CombinedOutput()
    if err != nil {
        log.Println(commandString)
        log.Fatalln(err.Error())
    }

    // fmt.Println(strings.Replace(string(out), "\r", "", -1))
    fmt.Println(string(out))
}
