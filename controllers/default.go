/*
 * @Description:
 * @Autor: TJUZQC
 * @Date: 2020-05-25 23:45:08
 * @LastEditors: TJUZQC
 * @LastEditTime: 2021-05-25 15:41:40
 */
package controllers

import (
	"fmt"
	"math/rand"
	"strconv"
	"strings"
	"time"
	utils "tjuzqc/utils"

	"github.com/beego/beego/v2/client/httplib"
	"github.com/beego/beego/v2/server/web"
)

type BaseController struct {
	web.Controller
}

type MainController struct {
	BaseController
}

type RandomController struct {
	BaseController
}
type WeatherController struct {
	BaseController
}

type TranslateController struct {
	BaseController
}

type BrowserInfoController struct {
	BaseController
}

type VirusController struct {
	BaseController
}

type LocationController struct {
	BaseController
}

type WordsConverterController struct {
	BaseController
}

type WeatherData struct {
	Status bool   `json:"status, bool"`
	Live   string `json:"live,string"`
	Cast   string `json:"cast,string"`
}

type TranslateResult struct {
	Status bool   `json:"status, bool"`
	Result string `json:"result, string"`
}

type ConvertResult TranslateResult

func (c *BaseController) isMobile() bool {
	useragent := strings.ToLower(c.Ctx.Request.UserAgent())
	keyWords := []string{"iphone", "ipad", "ipod", "android", "windows phone"}
	for _, v := range keyWords {
		if strings.Contains(useragent, v) {
			return true
		}
	}
	return false
}

//所有Controller共用的数据
func (c *BaseController) Prepare() {
	c.Data["CurrentYear"] = time.Now().Year()
	c.Data["LogoPath"], _ = web.AppConfig.String("LogoPath")
}

func (c *MainController) Get() {

	if c.isMobile() {
		c.TplName = "index_mobile.tpl"
	} else {
		c.TplName = "index.tpl"
	}
}

func (c *RandomController) Get() {
	c.Data["LogoPath"], _ = web.AppConfig.String("LogoPath")
	if c.isMobile() {
		c.TplName = "random/random_mobile.tpl"
	} else {
		c.TplName = "random/random.tpl"
	}
}

func (c *WeatherController) Get() {
	c.Data["LogoPath"], _ = web.AppConfig.String("LogoPath")
	if c.isMobile() {
		c.TplName = "weather/weather_mobile.tpl"
	} else {
		c.TplName = "weather/weather.tpl"
	}
}

func (c *WeatherController) Post() {
	city := c.GetString("city")
	amapKey, _ := web.AppConfig.String("amap_key")
	live := httplib.Get("https://restapi.amap.com/v3/weather/weatherInfo?key=" + amapKey + "&city=" + city + "&extensions=base")
	cast := httplib.Get("https://restapi.amap.com/v3/weather/weatherInfo?key=" + amapKey + "&city=" + city + "&extensions=all")
	liveStr, err := live.String()
	castStr, err := cast.String()
	if err != nil {
		c.Data["json"] = &WeatherData{false, liveStr, castStr}
	} else {
		c.Data["json"] = &WeatherData{true, liveStr, castStr}
	}
	c.ServeJSON()
}

func (c *TranslateController) Get() {
	c.Data["LogoPath"], _ = web.AppConfig.String("LogoPath")
	if c.isMobile() {
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
	appId, _ := web.AppConfig.String("baidu_appid")
	secret, _ := web.AppConfig.String("baidu_secret")
	sign := Sign(appId, query, salt, secret)
	// fmt.Println(appId + query + salt + secret)
	//test := md5encode("123")
	// fmt.Println(sign)
	result := httplib.Get("https://fanyi-api.baidu.com/api/trans/vip/translate?q=" + query + "&from=auto&to=" + to + "&appid=" + appId + "&salt=" + salt + "&sign=" + sign)
	ResultStr, err := result.String()
	fmt.Println(ResultStr)
	if err != nil {
		c.Data["json"] = &TranslateResult{false, ResultStr}
	} else {
		c.Data["json"] = &TranslateResult{true, ResultStr}
	}
	c.ServeJSON()
}

func (c *BrowserInfoController) Get() {
	c.Data["LogoPath"], _ = web.AppConfig.String("LogoPath")
	if c.isMobile() {
		c.TplName = "browserinfo/browserinfo_mobile.tpl"
	} else {
		c.TplName = "browserinfo/browserinfo.tpl"
	}
}

func (c *VirusController) Get() {
	if c.isMobile() {
		c.TplName = "virus/virus.tpl"
	} else {
		c.TplName = "virus/virus.tpl"
	}
}

func (c *LocationController) Get() {
	if c.isMobile() {
		c.TplName = "location/location.tpl"
	} else {
		c.TplName = "location/location.tpl"
	}
}

func (c *WordsConverterController) Get() {
	if c.isMobile() {
		c.TplName = "wordsconverter/wordsconverter.tpl"
	} else {
		c.TplName = "wordsconverter/wordsconverter.tpl"
	}
}

func (c *WordsConverterController) Post() {
	origin := c.GetString("origin")
	format, _ := c.GetInt("format")
	c.Data["json"] = &ConvertResult{Status: true, Result: utils.Convert(origin, format)}
	c.ServeJSON()
}
