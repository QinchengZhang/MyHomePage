<!--
 * @Description:
 * @Autor: TJUZQC
 * @Date: 2020-05-21 00:07:46
 * @LastEditors: TJUZQC
 * @LastEditTime: 2021-05-25 15:57:57
-->
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <meta content="width=device-width,user-scalable=no" name="viewport" />
    <link rel="stylesheet" href="/static/layui/css/layui.css" />
    <title style="color: black;">QC翻译</title>
    <script type="text/javascript" src="/static/layui/layui.js"></script>
    <script type="text/javascript" src="/static/layui/jQuery.js"></script>
    <script type="text/javascript">
        $(function () {
            $.ajaxSettings.timeout='3000';
            // 开始写 jQuery 代码...
            layui.use(["form", "layer"], function () {
                var form = layui.form;
                var layer = layui.layer;
                $("#submit").click(function () {
                    $query = $("#query").val();
                    $to = $("#language").val().split('·')[0];
                    if($query == '' || $to == ''){
                        layer.msg("不能为空！", { time: 30 });
                        return;
                    }
                    $post_data = { query: $query, to: $to };
                    // console.log($post_data);
                    $.post(
                        "/translate",
                        $post_data,
                        function (data) {
                            if (data.status == true) {
                                result = jQuery.parseJSON(data.result);
                                console.log(result)
                                $("#result").val(result.trans_result[0].dst);
                            } else {
                                layer.msg("翻译出错！", { time: 30 });
                            }
                        }
                    );
                });
            });
        });
    </script>
</head>

<body>
<div class="layui-main" style="text-align: center;margin-top: 30px;">
    <section class="layui-form layui-form-pane">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">输入单词</label>
                <div class="layui-input-inline">
                    <input
                            type="text"
                            id="query"
                            placeholder="在此输入单词"
                            autocomplete="off"
                            class="layui-input"
                    />
                </div>
            </div>
        </div>
        <div class="layui-form-item" >
            <div class="layui-inline">
                <label class="layui-form-label">翻译为</label>
                <div class="layui-input-inline">
                    <select id="language" lay-verify="required" lay-filter="language">
                        <option value="zh·中文">中文</option>
                        <option value="en·英文" selected="selected">英文</option>
                        <option value="yue·粤语">粤语</option>
                        <option value="wyw·文言文">文言文</option>
                        <option value="jp·日语">日语</option>
                        <option value="kor·日语">韩语</option>
                        <option value="fra·法语">法语</option>
                        <option value="spa·西班牙语">西班牙语</option>
                        <option value="th·泰语">泰语</option>
                        <option value="ara·阿拉伯语">阿拉伯语</option>
                        <option value="ru·俄语">俄语</option>
                        <option value="pt·葡萄牙语">葡萄牙语</option>
                        <option value="de·德语">德语</option>
                        <option value="it·意大利语">意大利语</option>
                        <option value="el·希腊语">希腊语</option>
                        <option value="nl·荷兰语">荷兰语</option>
                        <option value="pl·波兰语">波兰语</option>
                        <option value="bul·保加利亚语">保加利亚语</option>
                        <option value="est·爱沙尼亚语">爱沙尼亚语</option>
                        <option value="dan·丹麦语">丹麦语</option>
                        <option value="fin·芬兰语">芬兰语</option>
                        <option value="cs·捷克语">捷克语</option>
                        <option value="rom·罗马尼亚语">罗马尼亚语</option>
                        <option value="slo·斯洛文尼亚语">斯洛文尼亚语</option>
                        <option value="swe·瑞典语">瑞典语</option>
                        <option value="hu·匈牙利语">匈牙利文</option>
                        <option value="cht·繁体中文">繁体中文</option>
                        <option value="vie·越南语">越南语</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">翻译结果</label>
                <div class="layui-input-inline">
                    <input
                            type="text"
                            id="result"
                            autocomplete="off"
                            class="layui-input"
                            disabled="true"
                            style="text-align: left;"
                    />
                </div>
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
</div>
<div class="head_nav_C" id="hongye_nav" style="text-align: center;">
    <img src="{{.LogoPath}}" width="300" height="300" />
</div>
</body>
</html>
