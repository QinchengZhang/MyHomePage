/*
 * @Description:
 * @Autor: TJUZQC
 * @Date: 2020-05-25 23:45:08
 * @LastEditors: TJUZQC
 * @LastEditTime: 2020-06-29 16:59:04
 */
package routers

import (
	"tjuzqc/controllers"

	"github.com/astaxie/beego"
)

func init() {
	beego.Router("/", &controllers.MainController{})
	beego.Router("/random", &controllers.RandomController{})
	beego.Router("/weather", &controllers.WeatherController{})
	beego.Router("/translate", &controllers.TranslateController{})
	beego.Router("/browserinfo", &controllers.BrowserInfoController{})
	beego.Router("/virus", &controllers.VirusController{})
	beego.Router("/location", &controllers.LocationController{})
	beego.Router("/user/login", &controllers.UserController{}, "post:Login")
}
