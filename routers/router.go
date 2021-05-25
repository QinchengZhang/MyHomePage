/*
 * @Description:
 * @Autor: TJUZQC
 * @Date: 2020-05-25 23:45:08
 * @LastEditors: TJUZQC
 * @LastEditTime: 2021-05-23 09:47:10
 */
package routers

import (
	"tjuzqc/controllers"

	"github.com/beego/beego/v2/server/web"
)

func init() {
	web.Router("/", &controllers.MainController{})
	web.Router("/random", &controllers.RandomController{})
	web.Router("/weather", &controllers.WeatherController{})
	web.Router("/translate", &controllers.TranslateController{})
	web.Router("/browserinfo", &controllers.BrowserInfoController{})
	web.Router("/virus", &controllers.VirusController{})
	web.Router("/location", &controllers.LocationController{})
	web.Router("/user/login", &controllers.UserController{}, "post:Login")
	web.Router("/git/pull", &controllers.GitController{}, "get:Pull")
	web.Router("/wordsconverter", &controllers.WordsConverterController{})
}
