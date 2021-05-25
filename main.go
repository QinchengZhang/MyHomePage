/*
 * @Description:
 * @Autor: TJUZQC
 * @Date: 2020-05-25 23:45:08
 * @LastEditors: TJUZQC
 * @LastEditTime: 2021-05-25 15:18:17
 */
package main

import (
	_ "tjuzqc/routers"

	"github.com/beego/beego/v2/core/logs"
	"github.com/beego/beego/v2/server/web"
)

func main() {
	logs.SetLogger(logs.AdapterFile, `{"filename":"access.log"}`)
	web.Run()
}
