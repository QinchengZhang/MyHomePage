<!--
 * @Author: TJUZQC
 * @Date: 2021-05-23 08:04:27
 * @LastEditors: TJUZQC
 * @LastEditTime: 2021-05-25 15:51:37
 * @Description: None
-->
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width,user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="/static/layui/css/layui.css" />
    <title style="color: black">名字格式转换器</title>
    <script type="text/javascript" src="/static/layui/layui.js"></script>
    <script type="text/javascript" src="/static/layui/jQuery.js"></script>
    <script type="text/javascript">
        layui.use('form', function(){
    var form = layui.form;
    });
      $(function () {
        // 开始写 jQuery 代码...
        $("#submit").click(function () {
          var origin = $("#origin").val();
          var format = $("#format").val();
          $post_data = { origin: origin, format:format };
                    $.post(
                        "/wordsconverter",
                        $post_data,
                        function (data) {
                            // console.log(data);
                            if (data.status == true) {
                                // console.log(data.result);
                                $("#result").val(data.result);
                                $("#resultdiv").attr({
                                  "style": "visibility=visible"
                                });
                                // document.getElementById("resultdiv").style.visibility = "visible";
                            } else {
                                layer.msg("转换出错！", { time: 30 });
                            }
                        }
                    );
        });
      });
    </script>
  </head>

  <body style="text-align: center">
    <section class="layui-form layui-form-pane" style="text-align: center;margin-top: 30px;">
      <div class="layui-form-item">
        <div class="layui-inline">
          <label class="layui-form-label">原名称</label>
          <div class="layui-input-inline">
            <input
              type="text"
              id="origin"
              autocomplete="off"
              class="layui-input"
              style="text-align: center"
            />
          </div>
        </div>
      </div>
      <div class="layui-form-item" >
        <div class="layui-inline">
          <label class="layui-form-label">选择格式</label>
            <div class="layui-input-inline">
                  <select lay-verify="required" id="format">
                    <option value="0">全大写</option>
                    <option value="1">全小写</option>
                    <option value="2">小写驼峰</option>
                    <option value="3">大写驼峰</option>
                    <option value="4">下划线</option>
                  </select>
            </div>
          </div>
        </div>
      </div>
      <div class="layui-form-item">
          <button class="layui-btn" lay-submit id="submit" >转换</button>
      </div>
      <div class="layui-form-item" style="visibility: hidden;" id="resultdiv">
        <div class="layui-inline">
          <label class="layui-form-label">转化结果</label>
          <div class="layui-input-inline">
            <input
              type="text"
              id="result"
              disabled="true"
              class="layui-input"
              style="text-align: center"
            />
          </div>
        </div>
      </div>
    </section>
    
    <div class="head_nav_C" id="hongye_nav" style="text-align: center">
      <img src="{{.LogoPath}}" width="300" height="300" />
    </div>
  </body>
</html>
