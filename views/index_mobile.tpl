<!--
 * @Description: 
 * @Autor: TJUZQC
 * @Date: 2020-07-02 00:19:40
 * @LastEditors: TJUZQC
 * @LastEditTime: 2020-07-02 00:32:32
-->
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <!-- 引入样式 -->
    <link rel="stylesheet" href="static/mint-ui/lib/style.css">
    <link rel="stylesheet" href="static/mint-ui/lib/header/style.css">
</head>
<body>
<mt-header fixed title="TJUZQC主页">
    <router-link to="/" slot="left">
        <mt-button icon="back">返回</mt-button>
        <mt-button @click="handleClose">关闭</mt-button>
    </router-link>
    <mt-button icon="more" slot="right"></mt-button>
</mt-header>
</body>
<!-- 先引入 Vue -->
<script src="static/mint-ui/vue.js"></script>
<!-- 引入组件库 -->
<script src="static/mint-ui/lib/index.js"></script>
<script>
    import {Header, Navbar, Tabbar} from 'static/mint-ui'
    Vue.component(Header.name, Header);
    Vue.component(Navbar.Name, Navbar);
    Vue.component(Tabbar.Name, Tabbar);
    new Vue({
        el: '#app',
        methods: {
            handleClick: function () {
                this.$toast('Hello world!')
            }
        }
    })
</script>
</html>