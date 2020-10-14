<!--
 * @Description: 
 * @Autor: TJUZQC
 * @Date: 2020-07-02 00:21:52
 * @LastEditors: TJUZQC
 * @LastEditTime: 2020-07-02 00:27:58
--> 
<!DOCTYPE html>
<html>
<head style="background-color: #fffafa;">
    <meta charset="utf-8" />
    <meta content="width=device-width,user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="/static/layui/css/layui.css" />
    <script type="text/javascript" src="/static/layui/layui.js"></script>
    <script type="text/javascript" src="/static/layui/jQuery.js"></script>
    <script type="text/javascript">
        $(function () {
            $("#appName").val(navigator.appName);
            $("#appMinorVersion").val(navigator.appMinorVersion);
            $("#appCodeName").val(navigator.appCodeName);
            $("#appVersion").val(navigator.appVersion);
            // $("#browserLanguage").val(navigator.browserLanguage);
            $("#cookieEnabled").val(navigator.cookieEnabled == true ? "是" : "否");
            // $("#cpuClass").val(navigator.cpuClass);
            $("#onLine").val(navigator.onLine == true ? "是" : "否");
            $("#platform").val(navigator.platform);
        });
    </script>
    <title>查看浏览器信息</title>
</head>
<body style="text-align: center;">
<div class="layui-main">
    <h1 class="site-h1" style="text-align: center;" id="name">
        查看浏览器信息
    </h1>
    <section class="layui-form layui-form-pane" style="text-align: center;">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label" style="width: 200px;"
                >浏览器的代码名</label
                >
                <div class="layui-input-inline" style="width: 300px;">
                    <input
                            type="text"
                            id="appCodeName"
                            disabled="true"
                            autocomplete="off"
                            class="layui-input"
                    />
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label" style="width: 200px;"
                >浏览器的次级版本</label
                >
                <div class="layui-input-inline" style="width: 300px;">
                    <input
                            type="text"
                            id="appMinorVersion"
                            disabled="true"
                            autocomplete="off"
                            class="layui-input"
                    />
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label" style="width: 200px;"
                >浏览器的名称</label
                >
                <div class="layui-input-inline" style="width: 300px;">
                    <input
                            type="text"
                            id="appName"
                            disabled="true"
                            autocomplete="off"
                            class="layui-input"
                    />
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label" style="width: 200px;"
                >浏览器的平台和版本信息</label
                >
                <div class="layui-input-inline" style="width: 300px;">
                    <input
                            type="text"
                            id="appVersion"
                            disabled="true"
                            autocomplete="off"
                            class="layui-input"
                    />
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label" style="width: 200px;"
                >是否启用 cookie</label
                >
                <div class="layui-input-inline" style="width: 300px;">
                    <input
                            type="text"
                            id="cookieEnabled"
                            disabled="true"
                            autocomplete="off"
                            class="layui-input"
                    />
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label" style="width: 200px;"
                >系统是否脱机</label
                >
                <div class="layui-input-inline" style="width: 300px;">
                    <input
                            type="text"
                            id="onLine"
                            disabled="true"
                            autocomplete="off"
                            class="layui-input"
                    />
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label" style="width: 200px;"
                >浏览器的操作系统</label
                >
                <div class="layui-input-inline" style="width: 300px;">
                    <input
                            type="text"
                            id="platform"
                            disabled="true"
                            autocomplete="off"
                            class="layui-input"
                    />
                </div>
            </div>
        </div>
    </section>
</div>
<div class="head_nav_C" id="hongye_nav" style="text-align: center;">
    <img src="{{.LogoPath}}" width="300" height="300" />
</div>
</body>
</html>
