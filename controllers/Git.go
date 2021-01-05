/*
 * @Author: TJUZQC
 * @Date: 2021-01-05 15:04:34
 * @LastEditors: TJUZQC
 * @LastEditTime: 2021-01-05 15:34:43
 * @Description: None
 */
package controllers

import (
	"bufio"
	"fmt"
	"io"
	"os/exec"
)

type GitController BaseController

func execCommand(commandName string, params []string) bool {
	cmd := exec.Command(commandName, params...)

	//显示运行的命令
	fmt.Println(cmd.Args)

	stdout, err := cmd.StdoutPipe()

	if err != nil {
		fmt.Println(err)
		return false
	}

	cmd.Start()

	reader := bufio.NewReader(stdout)

	//实时循环读取输出流中的一行内容
	for {
		line, err2 := reader.ReadString('\n')
		if err2 != nil || io.EOF == err2 {
			break
		}
		fmt.Println(line)
	}

	cmd.Wait()
	return true
}

func (c *GitController) Pull() {
	fmt.Println("executing git pull")
	params := []string{"pull"}
	execCommand("git", params)
	c.Data["json"] = &Result{1, "pull success"}
	c.ServeJSON()
}
