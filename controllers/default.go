/*
 * @Description:
 * @Autor: TJUZQC
 * @Date: 2020-05-25 23:45:08
 * @LastEditors: TJUZQC
 * @LastEditTime: 2020-07-02 00:27:44
 */
package controllers

import (
	"fmt"
	"math/rand"
	"strconv"
	"strings"
	"time"

	"github.com/astaxie/beego"
	"github.com/astaxie/beego/httplib"
)

type BaseController struct {
	beego.Controller
}

type MainController BaseController

type RandomController BaseController

type WeatherController BaseController

type TranslateController BaseController

type BrowserInfoController BaseController

type VirusController BaseController

type LocationController BaseController

type WeatherData struct {
	Live string `json:"live,string"`
	Cast string `json:"cast,string"`
}

type Result struct {
	Status int
	Data   string
}

func mobile(c BaseController) bool {
	useragent := strings.ToLower(c.Ctx.Request.UserAgent())
	keyWords := []string{"iphone", "ipad", "ipod", "android", "windows phone"}
	for _, v := range keyWords {
		if strings.Contains(useragent, v) {
			return true
		}
	}
	return false
}

func (c *MainController) Get() {
	c.Data["CurrentYear"] = time.Now().Year()
	if mobile(BaseController(*c)) {
		c.TplName = "index_mobile.tpl"
	} else {
		c.TplName = "index.tpl"
	}
}

func (c *RandomController) Get() {
	c.Data["LogoPath"] = beego.AppConfig.String("LogoPath")
	if mobile(BaseController(*c)) {
		c.TplName = "random/random_mobile.tpl"
	} else {
		c.TplName = "random/random.tpl"
	}
}

func (c *WeatherController) Get() {
	c.Data["LogoPath"] = beego.AppConfig.String("LogoPath")
	if mobile(BaseController(*c)) {
		c.TplName = "weather/weather_mobile.tpl"
	} else {
		c.TplName = "weather/weather.tpl"
	}
}

func (c *WeatherController) Post() {
	city := c.GetString("city")
	live := httplib.Get("https://restapi.amap.com/v3/weather/weatherInfo?key=" + beego.AppConfig.String("amap_key") + "&city=" + city + "&extensions=base")
	cast := httplib.Get("https://restapi.amap.com/v3/weather/weatherInfo?key=" + beego.AppConfig.String("amap_key") + "&city=" + city + "&extensions=all")
	liveStr, err := live.String()
	castStr, err := cast.String()
	if err != nil {
		c.Data["json"] = "{\"status\":\"0\"}"
	} else {
		c.Data["json"] = &WeatherData{liveStr, castStr}
	}
	c.ServeJSON()
}

func (c *TranslateController) Get() {
	c.Data["LogoPath"] = beego.AppConfig.String("LogoPath")
	if mobile(BaseController(*c)) {
		c.TplName = "translate/translate_mobile.tpl"
	} else {
		c.TplName = "translate/translate.tpl"
	}
}

func (c *TranslateController) Post() {
	query := c.GetString("query")
	to := c.GetString("to")
	rand.Seed(time.Now().UnixNano())
	salt := strconv.Itoa(rand.Intn(100) * 1000)
	appId := beego.AppConfig.String("baidu_appid")
	secret := beego.AppConfig.String("baidu_secret")
	sign := Sign(appId, query, salt, secret)
	fmt.Println(appId + query + salt + secret)
	//test := md5encode("123")
	fmt.Println(sign)
	result := httplib.Get("https://fanyi-api.baidu.com/api/trans/vip/translate?q=" + query + "&from=auto&to=" + to + "&appid=" + appId + "&salt=" + salt + "&sign=" + sign)
	ResultStr, err := result.String()
	if err != nil {
		c.Data["json"] = "{\"status\":\"0\"}"
	} else {
		c.Data["json"] = &Result{1, ResultStr}
	}
	c.ServeJSON()
	//c.Ctx.WriteString(ResultStr)
	//return
}

func (c *BrowserInfoController) Get() {
	c.Data["LogoPath"] = beego.AppConfig.String("LogoPath")
	if mobile(BaseController(*c)) {
		c.TplName = "browserinfo/browserinfo_mobile.tpl"
	} else {
		c.TplName = "browserinfo/browserinfo.tpl"
	}
}

func (c *VirusController) Get() {
	if mobile(BaseController(*c)) {
		c.TplName = "virus/virus.tpl"
	} else {
		c.TplName = "virus/virus.tpl"
	}
}

func (c *LocationController) Get() {
	if mobile(BaseController(*c)) {
		c.TplName = "location/location.tpl"
	} else {
		c.TplName = "location/location.tpl"
	}
}
