/*
 * @Description: 
 * @Autor: TJUZQC
 * @Date: 2020-06-29 16:42:03
 * @LastEditors: TJUZQC
 * @LastEditTime: 2020-06-29 19:49:36
 */ 
package controllers

import (
	"github.com/astaxie/beego"
)

type UserController struct{
	beego.Controller
}

type User struct{
	Username string `json:"username"`
	Password string `json:"password"`
	Token string `json:"token"`
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