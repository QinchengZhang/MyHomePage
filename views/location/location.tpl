<!doctype html>
<html>
<head>
    <meta charset="utf-8">

    <meta name="viewport" content="initial-scale=1.0, user-scalable=no, width=device-width">
    <title>步行路径规划</title>
    <link rel="stylesheet" href="https://cache.amap.com/lbs/static/main.css"/>
    <script type="text/javascript"
            src="https://webapi.amap.com/maps?v=1.4.8&key=2249bb2128d7c5e601e58c5896674036&plugin=AMap.Walking"></script>
    <style type="text/css">
        #panel {
            text-align: center;
            position: fixed;
            background-color: white;
            max-height: 100%;
            overflow-y: auto;
            top: 10px;
            right: 10px;
            max-width: 300px;
        }
        #back {
            text-align: center;
            position: fixed;
            background-color: white;
            height: 40px;
            border-radius: 50%;
            overflow-y: auto;
            top: 10px;
            left: 10px;
            width: 40px;
            border: 2px solid rgba(255, 128, 0, 0.2);
            border-color: #FF8000;
        }
    </style>
    <script type="text/javascript">
        function init(){
            //基本地图加载
            var map = new AMap.Map("mapContainer", {
                resizeEnable: true,
                zoom: 16 //地图显示的缩放级别
            });
            map.plugin('AMap.Geolocation', function() {
                var geolocation = new AMap.Geolocation({
                    // 是否使用高精度定位，默认：true
                    enableHighAccuracy: true,
                    // 设置定位超时时间，默认：无穷大
                    timeout: 10000,
                    // 定位按钮的停靠位置的偏移量，默认：Pixel(10, 20)
                    buttonOffset: new AMap.Pixel(10,40),
                    //  定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：false
                    zoomToAccuracy: true,
                    //  定位按钮的排放位置,  RB表示右下
                    buttonPosition: 'LB',
                    showMarker: true,//是否显示定位
                    showCircle: true,//是否显示定位精度圈
                    panToLocation: true
                })

                geolocation.getCurrentPosition()
                AMap.event.addListener(geolocation, 'complete', onComplete)
                AMap.event.addListener(geolocation, 'error', onError)

                function onComplete (data) {
                    var marker=new AMap.Marker({
                        position: data.position,
                        title: '我的位置'
                    })
                    map.setCenter(data.position);
                    map.add(marker);
                }

                function onError (data) {
                    console.log(data);
                    alert('抱歉，定位出错了！');
                }
            })
            AMap.plugin(['AMap.ToolBar','AMap.Scale','AMap.OverView'],
                function(){
                    map.addControl(new AMap.ToolBar());

                    //map.addControl(new AMap.Scale());

                    //map.addControl(new AMap.OverView({isOpen:true}));
                });
        }
    </script>
</head>
<body style="height:100%" onload="init()">
<div id="mapContainer" style="height:100%"></div>


<script type="text/javascript" src="https://webapi.amap.com/demos/js/liteToolbar.js"></script>

</body>
</html>