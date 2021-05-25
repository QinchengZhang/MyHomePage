/*
 * @Description:
 * @Autor: TJUZQC
 * @Date: 2020-06-29 16:42:03
 * @LastEditors: TJUZQC
 * @LastEditTime: 2021-05-23 09:44:55
 */
package controllers

import (
	"github.com/beego/beego/v2/server/web"
)

type UserController struct {
	web.Controller
}

type User struct {
	Username   string `json:"username"`
	Password   string `json:"password"`
	Token      string `json:"token"`
	AvatarPath string `json:"avatarpath"`
}

func (c *UserController) Login() {
	username := c.GetString("username")
	password := c.GetString("password")
	Result := &User{username, password, "adadf45412", "/static/layui/tju.png"}
	// c.SetSession("token", string("adadf45412"))
	c.Data["json"] = Result
	c.ServeJSON()
}
