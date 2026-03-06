# 项目分析报告 (Vue3 + Element Plus)

## 1. src/ 目录完整文件结构 (两层)

```text
src/
├── assets/             # 静态资源（CSS, 图标, 图片, JS配置）
│   ├── css/            # 动画及公共样式
│   ├── iconfont/       # 字体图标
│   ├── img/            # 业务图片及支付图标
│   ├── js/             # 背景特效及图表主题
│   ├── china.json      # 地图数据
│   └── logo.png        # 系统Logo
├── components/         # 公共组件
│   ├── VerifySlider/   # 滑块验证
│   ├── common/         # 富文本、地图、上传、支付等通用组件
│   ├── count-to/       # 数字滚动
│   └── index/          # 布局核心组件（菜单、顶部、标签页等）
├── router/             # 路由配置
│   └── index.js
├── store/              # 状态管理 (Vuex)
│   ├── modules/        # 用户及系统模块
│   └── index.js
├── utils/              # 工具函数 (HTTP请求, 配置, 菜单处理等)
├── views/              # 页面视图（包含所有业务模块的增删改查页面）
├── App.vue             # 根组件
└── main.js             # 入口文件
```

## 2. 入口文件 (src/main.js)

```javascript
import { createApp } from 'vue'
import App from './App.vue'
import router from './router'
//阿里图标
import '@/assets/iconfont/iconfont.css'
//animate动画库
import '@/assets/css/animate.min.css'
//公共样式
import '@/assets/css/style.scss'
import store from './store'
const app = createApp(App)
app.config.warnHandler = () => null;
//高德地图工具
import VueAMap, { initAMapApiLoader } from "@vuemap/vue-amap";
import "@vuemap/vue-amap/dist/style.css"
initAMapApiLoader({
    key: "c4ae6ed30bc3f01acf60971dd5d65e7b",
    securityJsCode:'4d49f68235e05c86c862eeb230ddfc05',
    plugins: [
        "AMap.Autocomplete",
        "AMap.PlaceSearch",
        "AMap.Scale",
        "AMap.OverView",
        "AMap.ToolBar",
        "AMap.MapType",
        "AMap.PolyEditor",
        "AMap.CircleEditor",
        "AMap.Geocoder",
        "AMap.Geolocation",
        "AMap.Marker",
        "AMap.Driving"
    ],
});
app.use(VueAMap)

import http from './utils/http.js'
// 基础配置
import config from './utils/config'
//公共方法
import toolUtil from './utils/toolUtil.js'

//打印工具库
import printJS from 'print-js'

//富文本
import Editor from "@/components/common/Editor";
app.component('editor', Editor)
//上传组件
import upload from "@/components/common/upload";
app.component('uploads', upload)

//md5
import md5 from 'js-md5'
//excel导出工具
import JsonExcel from "vue-json-excel3";
app.component("downloadExcel", JsonExcel);
app.config.globalProperties.$config = config.get()
app.config.globalProperties.$project = config.getProjectName()
app.config.globalProperties.$toolUtil = toolUtil
app.config.globalProperties.$md5 = md5
app.config.globalProperties.$http = http // ajax请求方法

app.use(store)
app.use(router)
import * as Vue from 'vue'
window.Vue = Vue
function loadElementPlus() {    // 加载Element-plus
    return new Promise((resolve, reject) => {
        const script = document.createElement('script')
        script.src = 'http://clfile.zggen.cn/20251114/c7545bbab1504da0b6be2f2d2471c87e.js'
        script.onload = () => {
            // 等待下一个 tick，确保 Element Plus 内部组件注册完成
            setTimeout(() => {
                app.use(window.ElementPlus, {
                    locale: ElementPlusLocaleZhCn, // 国际化
                })
                // 全局字段
                window.ElLoading = ElementPlus.ElLoading
                window.ElMessage = ElementPlus.ElMessage
                window.ElMessageBox = ElementPlus.ElMessageBox
                window.ElNotification = ElementPlus.ElNotification
                resolve()
            }, 0)
        }
        script.onerror = reject
        document.head.appendChild(script)
    })
}
function loadIcons() {
    return new Promise((resolve, reject) => {
        const script = document.createElement('script')
        script.src = 'http://clfile.zggen.cn/20251114/3f6d667b307e408d93ac93092a0b01e6.js'
        script.onload = () => {
            setTimeout(() => {
                for (const [key, component] of Object.entries(ElementPlusIconsVue)) {
                    app.component(key, component)
                }
                resolve()
            }, 0)
        }
        script.onerror = reject
        document.head.appendChild(script)
    })
}
async function mount() {
    await loadElementPlus()
    await loadIcons()
    app.mount('#app')
}
mount()
```

## 3. 样式与主题相关文件

- **未发现**: `theme.css`, `variables.css`, `element-variables.scss`。
- **发现相关文件**: `src/assets/js/echarts-theme.js` (ECharts图表主题配置)。
  - 内容定义了图表的颜色序列、背景色、坐标轴样式等。

## 4. 布局组件使用示例

### indexMenu.vue (左侧菜单)

```vue
<template>
	<div class="menu_wrapper" :class="{'menu_wrapper_collapse':collapse}">
		<el-scrollbar wrap-class="scrollbar-wrapper" class="menu_scrollbar">
			<el-menu :default-openeds="[]" :unique-opened="true" :default-active="menuIndex" class="menu_view"
				:collapse="collapse">
				<el-menu-item class="first-item" index="/" @click="menuHandler('')">
					<i class="iconfont icon-zhuye2" v-if="collapse?false:true"></i>
					<template #title>
						<span>首页</span>
					</template>
				</el-menu-item>
                <template v-for=" (item,index) in menuList.backMenu">
                    <el-sub-menu v-if="item.child.length>1"  class="first-item" :index="item.menu">
                        <template #title>
                            <i class="iconfont" :class="item.fontClass" v-if="collapse?false:true"></i>
                            <span>{{ item.menu }}</span>
                        </template>
                        <el-menu-item class="second-item" v-for=" (child,sort) in item.child" :key="sort"
                            :index="getPath(child.classname||child.tableName,child.menuJump)"
                            @click="menuHandler(child.classname||child.tableName,child.menuJump)">{{ child.menu }}
                        </el-menu-item>
                    </el-sub-menu>
                    <el-menu-item v-else class="first-item"
                                  :index="getPath(item.child[0].classname||item.child[0].tableName,item.child[0].menuJump)"
                                  @click="menuHandler(item.child[0].classname||item.child[0].tableName,item.child[0].menuJump)">
                        <i class="iconfont" :class="item.fontClass" v-if="collapse?false:true"></i>
                        <template #title>
                            <span>{{ item.child[0].menu }}</span>
                        </template>
                    </el-menu-item>
                </template>
			</el-menu>
		</el-scrollbar>
	</div>
</template>
```

### index.vue (主容器)

```vue
<template>
	<el-container>
		<index-main></index-main>
	</el-container>
</template>
```

## 5. 根组件 (src/App.vue)

```vue
<template>
	<router-view />
</template>
<script setup>
	import {
		provide
	} from "vue";
	provide("baseUrl", process.env.VUE_APP_BASE_API)
	const debounce = (fn, delay) => {
		let timer = null;
		return function() {
			let context = this;
			let args = arguments;
			clearTimeout(timer);
			timer = setTimeout(function() {
				fn.apply(context, args);
			}, delay);
		}
	}

	const _ResizeObserver = window.ResizeObserver;
	window.ResizeObserver = class ResizeObserver extends _ResizeObserver {
		constructor(callback) {
			callback = debounce(callback, 16);
			super(callback);
		}
	}
</script>
<style lang="scss">
	#app {
		font-family: Avenir, Helvetica, Arial, sans-serif;
		-webkit-font-smoothing: antialiased;
		-moz-osx-font-smoothing: grayscale;
		color: #2c3e50;
	}
	body {
		margin: 0;
	}
	* {
		box-sizing: border-box;
	}
</style>
```
