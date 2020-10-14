<!--
 * @Description:
 * @Autor: TJUZQC
 * @Date: 2020-05-21 00:07:46
 * @LastEditors: TJUZQC
 * @LastEditTime: 2020-07-01 23:31:42
-->
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta
      name="viewport"
      content="width=device-width, initial-scale=1, maximum-scale=1"
    />
    <title>TJUZQC主页</title>
    <link rel="stylesheet" href="/static/layui/css/layui.css" />
    <script type="text/javascript" src="/static/layui/layui.js"></script>
    <script type="text/javascript" src="/static/layui/jQuery.js"></script>
    <script
      type="text/javascript"
      src="/static/layui/jQuerySession.js"
    ></script>
    <script
      type="text/javascript"
      src="/static/layui/jQuery.cookie.js"
    ></script>
    <script type="text/javascript">
      function browserRedirect() {
        var sUserAgent = navigator.userAgent.toLowerCase();
        var bIsIpad = sUserAgent.match(/ipad/i) == "ipad";
        var bIsIphoneOs = sUserAgent.match(/iphone os/i) == "iphone os";
        var bIsMidp = sUserAgent.match(/midp/i) == "midp";
        var bIsUc7 = sUserAgent.match(/rv:1.2.3.4/i) == "rv:1.2.3.4";
        var bIsUc = sUserAgent.match(/ucweb/i) == "ucweb";
        var bIsAndroid = sUserAgent.match(/android/i) == "android";
        var bIsCE = sUserAgent.match(/windows ce/i) == "windows ce";
        var bIsWM = sUserAgent.match(/windows mobile/i) == "windows mobile";

        if (
          bIsIpad ||
          bIsIphoneOs ||
          bIsMidp ||
          bIsUc7 ||
          bIsUc ||
          bIsAndroid ||
          bIsCE ||
          bIsWM
        ) {
          window.location.href = "https://www.tjuzqc.top/m"; //移动端网站
        }
      }
      function getLoginStatus() {
        var token = $.session.get("token");
        console.log(token);
        if (!token) {
          $("#avatar_div").hide();
          $("#logorreg").show();
        } else {
          $("#avatar").attr("src", $.cookie("avatarpath"));
          $("#avatar_div").show();
          $("#logorreg").hide();
        }
      }
      $(function () {
        $("#loginform").hide();
        getLoginStatus();
        $("#avatar").click(function () {
          console.log("avatar clicked!");
          layui.use("layer", function () {
            var layer = layui.layer;
            layer.open({
              type: 1,
              title: false,
              offset: ["60px", "90%"],
              shade: 0.01,
              closeBtn: 0,
              shadeClose: true,
              btn: ["个人中心", "退出登录"],
              yes: function () {
                var username = $.session.get("username");
                if (!username) {
                  layui.use("layer", function () {
                    layer = layui.layer;
                    layer.msg(
                      "登录失效，请重新登录",
                      {
                        icon: 1,
                        time: 2000, //2秒关闭（如果不配置，默认是3秒）
                      },
                      function () {
                        getLoginStatus();
                      }
                    );
                  });
                }
                $("iframe").attr("src", "/myspace/" + username);
              },
              btn2: function () {
                $.session.remove("token");
                getLoginStatus();
              },
            });
          });
        });
        $("#login").click(function () {
          layui.use("layer", function () {
            var layer = layui.layer;
            layer.open({
              type: 1,
              title: "登录",
              content: $("#loginform"),
              btn: ["登录", "忘记密码", "注册"],
              yes: function (index, layero) {
                var username = $("#user").val();
                var password = $("#password").val();
                console.log(username, password);
                $.post(
                  "/user/login",
                  {
                    username: username,
                    password: password,
                  },
                  function (data, status) {
                    console.log(data, status);
                    $.session.set("token", data.token);
                    $.session.set("username", data.username);
                    $.cookie("avatarpath", data.avatarpath);
                    getLoginStatus();
                  }
                );
                layer.close(index);
              },
              btn2: function (index, layero) {
                return false;
              },
              btn3: function (index, layero) {
                return false;
              },
              cancel: function () {},
            });
          });
        });
        // 开始写 jQuery 代码...
        layui.use(["element"], function () {
          var element = layui.element;
          element.on("nav(navigator)", function (data) {
            var id = data.attr("id");
            $("iframe").attr("src", "/" + id);
            console.log(id);
          });
        });
      });
    </script>
  </head>
  <body class="layui-layout-body">
    <div class="layui-layout layui-layout-admin">
      <div class="layui-header">
        <div class="layui-logo" style="color: #fefefe;">TJUZQC</div>
        <!-- 头部区域（可配合layui已有的水平导航） -->
        <ul class="layui-nav layui-layout-left" lay-filter="navigator">
          <li class="layui-nav-item layui-this"><a id="random">随机数</a></li>
          <li class="layui-nav-item"><a id="weather">QC天气</a></li>
          <li class="layui-nav-item"><a id="virus">疫情数据</a></li>
          <li class="layui-nav-item"><a id="translate">QC翻译</a></li>
          <li class="layui-nav-item"><a id="browserinfo">浏览器信息</a></li>
          <li class="layui-nav-item"><a id="location">定位</a></li>
        </ul>
        <div class="layui-nav layui-layout-right">
          <span id="logorreg">
            <li class="layui-nav-item"><a id="login">登录</a></li>
            <li class="layui-nav-item"><a id="register">注册</a></li>
          </span>
          <li class="layui-nav-item" id="avatar_div">
            <img
              id="avatar"
              class="layui-icon"
              src="{{.AvatarPath}}"
              width="50"
              height="50"
            />
          </li>
        </div>
      </div>

      <div style="left: 0;" class="layui-body">
        <iframe
          class="layui-layer-iframe"
          style="padding: 15px; width: 100%; height: 100%;"
          src="/random"
        ></iframe>
      </div>

      <div style="left: 0;" class="layui-footer">
        <p onclick="window.open('http://www.beian.miit.gov.cn', '_blank');">
          Copyright &copy; 2017-{{.CurrentYear}}
          TJUZQC 冀ICP备17015474号
        </p>
      </div>
    </div>
  </body>
  <section
    class="layui-form layui-form-pane"
    style="text-align: center;"
    id="loginform"
  >
    <div class="layui-form-item">
      <div class="layui-inline">
        <label class="layui-form-label">用户名</label>
        <div class="layui-input-inline" style="width: 200px;">
          <input
            type="text"
            id="user"
            autocomplete="open"
            class="layui-input"
            style="text-align: center;"
          />
        </div>
      </div>
    </div>
    <div class="layui-form-item">
      <div class="layui-inline">
        <label class="layui-form-label">密码</label>
        <div class="layui-input-inline" style="width: 200px;">
          <input
            type="password"
            id="password"
            autocomplete="off"
            class="layui-input"
            style="text-align: center;"
          />
        </div>
      </div>
    </div>
    <!-- <div class="layui-form-item">
    <button id="do_login" class="layui-btn" lay-submit lay-filter="formDemo">
      登录
    </button>
    <button id="do_forgot" class="layui-btn" lay-submit lay-filter="formDemo">
      忘记密码
    </button>
  </div> -->
  </section>
</html>
