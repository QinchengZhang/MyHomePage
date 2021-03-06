<!--
 * @Description:
 * @Autor: TJUZQC
 * @Date: 2020-05-21 00:07:46
 * @LastEditors: TJUZQC
 * @LastEditTime: 2021-05-25 15:50:44
-->
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width,user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="/static/layui/css/layui.css" />
    <title style="color: black;">生成一个随机数</title>
    <script type="text/javascript" src="/static/layui/layui.js"></script>
    <script type="text/javascript" src="/static/layui/jQuery.js"></script>
    <script type="text/javascript">
      $(function () {
        // 开始写 jQuery 代码...
        $("#submit").click(function () {
          var Min = Math.round($("#MIN_NUM").val());
          var Max = Math.round($("#MAX_NUM").val());
          if (Max <= Min) {
            layui.use("layer", function () {
              var layer = layui.layer;

              layer.msg("输入数值范围有误，请重新输入！", { time: 30 });
            });
            location.reload();
            return;
          }
          var rand = Math.round(Math.random() * (Max - Min) + Min);
          $("#number").val(rand);
          // document.getElementById("number").innerText = rand;
        });
      });
    </script>
  </head>

  <body style="text-align: center;">
    <section class="layui-form layui-form-pane" style="text-align: center;margin-top: 30px;">
      <div class="layui-form-item">
        <div class="layui-inline">
          <label class="layui-form-label">范围</label>
          <div class="layui-input-inline" style="width: 100px;">
            <input
              type="text"
              id="MIN_NUM"
              placeholder="最小数"
              autocomplete="off"
              class="layui-input"
            />
          </div>
          <div class="layui-form-mid">-</div>
          <div class="layui-input-inline" style="width: 100px;">
            <input
              type="text"
              id="MAX_NUM"
              placeholder="最大数"
              autocomplete="off"
              class="layui-input"
            />
          </div>
        </div>
      </div>
      <div class="layui-form-item">
        <div class="layui-inline">
          <label class="layui-form-label">生成的数</label>
          <div class="layui-input-inline" style="width: 200px;">
            <input
              type="text"
              id="number"
              autocomplete="off"
              class="layui-input"
              disabled="true"
              style="text-align: center;"
            />
          </div>
          <!-- <div class="layui-form-label" id="number" style="width: 100px;"></div> -->
        </div>
      </div>
      <div class="layui-form-item">
          <button
            id="submit"
            class="layui-btn"
            lay-submit
            lay-filter="formDemo"
          >
            提交
          </button>
      </div>
    </section>
    <div class="head_nav_C" id="hongye_nav" style="text-align: center;">
      <img src="{{.LogoPath}}" width="300" height="300" />
    </div>
  </body>
</html>
