/*
 * @Description:
 * @Autor: TJUZQC
 * @Date: 2020-05-25 23:45:08
 * @LastEditors: TJUZQC
 * @LastEditTime: 2020-06-29 15:57:45
 */
package main

import (
	_ "tjuzqc/routers"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/logs"
)

func main() {
	logs.SetLogger(logs.AdapterFile, `{"filename":"access.log"}`)
	beego.Run()
}
