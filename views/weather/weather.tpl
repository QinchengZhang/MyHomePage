<!--
 * @Description:
 * @Autor: TJUZQC
 * @Date: 2020-05-21 00:07:46
 * @LastEditors: TJUZQC
 * @LastEditTime: 2021-05-25 15:51:21
-->
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width,user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="/static/layui/css/layui.css" />
    <title>QC天气</title>
    <script type="text/javascript" src="/static/layui/layui.js"></script>
    <script type="text/javascript" src="/static/layui/jQuery.js"></script>
    <script
      type="text/javascript"
      src="https://webapi.amap.com/maps?v=1.4.8&key=2249bb2128d7c5e601e58c5896674036"
    ></script>
    <script type="text/javascript">
      function getLocation() {
        var map = new AMap.Map("", {});
        // AMap.plugin("AMap.CitySearch", function () {
        //   var citySearch = new AMap.CitySearch();
        //   citySearch.getLocalCity(function (status, result) {
        //     if (status === "complete" && result.info === "OK") {
        //       console.log(result);
        //     }
        //   });
        // });
        map.plugin("AMap.Geolocation", function () {
          var geolocation = new AMap.Geolocation({
            // 是否使用高精度定位，默认：true
            enableHighAccuracy: true,
            // 设置定位超时时间，默认：无穷大
            timeout: 10000,
          });
          geolocation.getCurrentPosition();
          AMap.event.addListener(geolocation, "complete", onComplete);
          AMap.event.addListener(geolocation, "error", onError);

          function onComplete(data) {
            $("#cityname").val(data.addressComponent.district);
            // console.log("located!");
            console.log(data);
            getWeather();
          }

          function onError(data) {
            console.log(data);
            geolocation.getCityInfo(function (status, result) {
              if (status == "complete") {
                $("#cityname").val(result.city);
              } else {
              }
            });
          }
        });
      }

      function getWeather() {
        console.log("getting weather");
        var city = $("#cityname").val();
        $.post(
          "/weather",
          {
            city: city,
          },
          function (data, status) {
            console.log(data);
            console.log(typeof(data.live));
            var live = jQuery.parseJSON(data.live);
            live = jQuery.parseJSON(live);
            var cast = jQuery.parseJSON(data.cast);
            cast = jQuery.parseJSON(cast);
            if (
              status == "success" &&
              live.status == 1 &&
              cast.status == 1
            ) {
              live = live.lives[0];
              console.log(live)
              cast = cast.forecasts[0].casts;
              console.log(cast)
              $("#cityname").val(live.city);
              $("#temperature").val(live.temperature + "℃");
              $("#weather").val(live.weather);
              $("#winddirection").val(live.winddirection);
              $("#windpower").val(live.windpower);
              $("#reporttime").val(live.reporttime);
              $("#humidity").val(live.humidity + "%");
              for (day in cast) {
                $("#casts_body").append(
                  "<tr>" +
                    '<td id="date">' +
                    cast[day].date +
                    " 星期" +
                    cast[day].week +
                    "</td>" +
                    '<td id="weather">' +
                    (cast[day].dayweather == cast[day].nightweather
                      ? cast[day].dayweather
                      : cast[day].dayweather + "转" + cast[day].nightweather) +
                    "</td>" +
                    '<td id="temp">' +
                    Math.min(cast[day].daytemp, cast[day].nighttemp) +
                    "℃" +
                    "-" +
                    Math.max(cast[day].daytemp, cast[day].nighttemp) +
                    "℃" +
                    "</td>" +
                    '<td id="wind">' +
                    (cast[day].daywind == cast[day].nightwind
                      ? cast[day].daywind + "风"
                      : cast[day].daywind +
                        "风转" +
                        cast[day].nightweather +
                        "风") +
                    "</td>" +
                    '<td id="power">' +
                    (cast[day].daypower == cast[day].nightpower
                      ? cast[day].daypower + "级"
                      : cast[day].daypower +
                        "级转" +
                        cast[day].nightpower +
                        "级") +
                    "</td>" +
                    "</tr>"
                );
              }
            } else {
              layui.use("layer", function () {
                var layer = layui.layer;

                layer.msg("出现错误！", { time: 30 });
              });
            }
          }
        );
      }

      $(function () {
        // 开始写 jQuery 代码...
        layui.use(["element"], function () {
          var element = layui.element;
          //…
        });
        getLocation();
        // getWeather();
        $("#locate").click(function () {
          getLocation();
        });
        $("#submit").click(function () {
          getWeather();
        });
      });
    </script>
  </head>

  <body style="text-align: center">
    <section class="layui-form layui-form-pane" style="text-align: center;margin-top: 30px;">
      <div class="layui-form-item">
        <div class="layui-inline">
          <label class="layui-form-label">城市</label>
          <div class="layui-input-inline" style="width: 200px">
            <input
              type="text"
              id="cityname"
              placeholder="如：天津"
              autocomplete="off"
              class="layui-input"
            />
          </div>
          <button
            id="locate"
            class="layui-btn"
            lay-submit
            lay-filter="formDemo"
          >
            定位
          </button>
        </div>
      </div>
      <div class="layui-form-item">
        <button id="submit" class="layui-btn" lay-submit lay-filter="formDemo">
          查询
        </button>
      </div>
      <div class="layui-main">
        <div class="layui-form" style="text-align: center">
          <div class="layui-form-item">
            <h3 class="site-h3" style="text-align: center">实时数据</h3>
            <div class="layui-container">
              <div class="layui-row">
                <div class="layui-col-md4">
                  <div class="layui-inline">
                    <label class="layui-form-label">天气情况</label>
                    <div class="layui-input-inline" style="width: 250px">
                      <input
                        type="text"
                        id="weather"
                        disabled="true"
                        autocomplete="off"
                        class="layui-input"
                      />
                    </div>
                  </div>
                </div>
                <div class="layui-col-md4">
                  <div class="layui-inline">
                    <label class="layui-form-label">当前温度</label>
                    <div class="layui-input-inline" style="width: 250px">
                      <input
                        type="text"
                        id="temperature"
                        disabled="true"
                        autocomplete="off"
                        class="layui-input"
                      />
                    </div>
                  </div>
                </div>
                <div class="layui-col-md4">
                  <div class="layui-inline">
                    <label class="layui-form-label">风向</label>
                    <div class="layui-input-inline" style="width: 250px">
                      <input
                        type="text"
                        id="winddirection"
                        disabled="true"
                        autocomplete="off"
                        class="layui-input"
                      />
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <div class="layui-container">
              <div class="layui-row">
                <div class="layui-col-md4">
                  <div class="layui-inline">
                    <label class="layui-form-label">风力</label>
                    <div class="layui-input-inline" style="width: 250px">
                      <input
                        type="text"
                        id="windpower"
                        disabled="true"
                        autocomplete="off"
                        class="layui-input"
                      />
                    </div>
                  </div>
                </div>
                <div class="layui-col-md4">
                  <div class="layui-inline">
                    <label class="layui-form-label">湿度</label>
                    <div class="layui-input-inline" style="width: 250px">
                      <input
                        type="text"
                        id="humidity"
                        disabled="true"
                        autocomplete="off"
                        class="layui-input"
                      />
                    </div>
                  </div>
                </div>
                <div class="layui-col-md4">
                  <div class="layui-inline">
                    <label class="layui-form-label">更新时间</label>
                    <div class="layui-input-inline" style="width: 250px">
                      <input
                        type="text"
                        id="reporttime"
                        disabled="true"
                        autocomplete="off"
                        class="layui-input"
                      />
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="layui-form-item">
            <h3 class="site-h3" style="text-align: center">预报数据</h3>
            <table class="layui-table">
              <colgroup>
                <col width="150" />
                <col width="200" />
                <col />
              </colgroup>
              <thead>
                <tr>
                  <th>日期</th>
                  <th>天气</th>
                  <th>温度</th>
                  <th>风力</th>
                  <th>风向</th>
                </tr>
              </thead>
              <tbody id="casts_body"></tbody>
            </table>
          </div>
        </div>
      </div>
    </section>
    <div
      class="head_nav_C"
      id="hongye_nav"
      style="text-align: center; margin-top: 20px"
    >
      <img src="{{.LogoPath}}" width="300" height="300" />
    </div>
  </body>
</html>
