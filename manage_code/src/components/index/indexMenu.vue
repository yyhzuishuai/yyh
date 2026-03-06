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

<script setup>
	import menu from '@/utils/menu'
	import {
		ref,
		toRefs,
		getCurrentInstance,
		nextTick,
        watch
	} from 'vue';
	import { useStore } from 'vuex'
	const store = useStore()
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	//props
	const props = defineProps({
		collapse: Boolean
	})
	const {
		collapse
	} = toRefs(props)
	//data
	const menuList = ref([])
	const role = ref('')
	//权限验证
	const btnAuth = (e,a)=>{
		return context?.$toolUtil.isAuth(e,a)
	}
	const init = () => {
		const menus = menu.list()
		if (menus) {
			menuList.value = menus
		}
		role.value = context?.$toolUtil.storageGet('role')

		for (let i = 0; i < menuList.value.length; i++) {
			if (menuList.value[i].roleName == role.value) {
				menuList.value = menuList.value[i];
				break;
			}
		}
	}
    // 默认菜单index
    const menuIndex = ref('')
    watch(() => context.$router.currentRoute.value,(value, oldValue) => {
        menuIndex.value = decodeURIComponent(value.fullPath)
    },{
        immediate:true
    })
	const getPath = (name,menuJump) => {
        if(name == 'center'){
            return `/${role.value}Center`
        }else if(name == 'storeup'){
            return `/storeup?type=${menuJump}`
        }else if(name == 'exampaper' && menuJump == '12'){
            return '/exampaperlist'
        }else if(name == 'examrecord' && menuJump == '22'){
            return '/examfailrecord'
        }else{
            return `/${name}${menuJump?'?menuJump='+menuJump:''}`
        }
	}
    const menuHandler = (name,menuJump) => {
        let url = getPath(name,menuJump)
        context.$router.push(url)
    }
	init()
</script>

<style>
/* 侧边栏容器 */
.menu_wrapper {
    width: 210px;
    position: fixed;
    top: 139px;
    left: 0;
    height: calc(100vh - 138px);
    padding: 0;
    z-index: 999;
    --el-menu-item-height: 44px;
    --el-menu-sub-item-height: 44px;
    background-color: var(--bg-page);
    border-right: 1px solid #FFD6C0;
    box-shadow: 2px 0 10px rgba(255,140,105,0.08);
    transition: width 0.3s ease;
}
.menu_wrapper.menu_wrapper_collapse {
    width: 64px;
}

.menu_wrapper .menu_view {
    background-color: transparent !important;
    border-right: none;
}

/* 统一菜单项基础样式 */
.menu_wrapper .el-menu-item,
.menu_wrapper .el-sub-menu__title {
    color: var(--text-main) !important;
    transition: all 0.2s ease;
    border-left: 3px solid transparent !important;
}

/* 统一菜单项 Hover */
.menu_wrapper .el-menu-item:hover,
.menu_wrapper .el-sub-menu .el-sub-menu__title:hover {
    background-color: var(--pink-light) !important;
    color: #CC4400 !important;
    border-left-color: var(--primary) !important;
}

/* 统一激活菜单项 */
.menu_wrapper .el-menu-item.is-active,
.menu_wrapper .el-sub-menu.is-active > .el-sub-menu__title {
    background-color: var(--pink) !important;
    color: var(--text-main) !important;
    font-weight: 600;
    border-left-color: var(--primary) !important;
}

/* 覆盖 Element Plus 变量 */
.menu_wrapper {
    --el-menu-bg-color: transparent;
    --el-menu-active-color: var(--text-main);
    --el-menu-hover-bg-color: var(--pink-light);
    --el-menu-hover-text-color: #CC4400;
}

/* 子菜单弹出层 */
.el-menu--popup {
    background-color: #FFF0F5 !important;
}

/* 子菜单项 */
.menu_wrapper li.el-menu-item.second-item {
    padding-left: 46px !important;
    font-size: 13px;
    color: #666666;
    background-color: transparent !important;
}

/* 子菜单项 Hover */
.menu_wrapper li.el-menu-item.second-item:hover {
    background-color: var(--pink-light) !important;
    color: #CC4400 !important;
}

/* 子菜单项激活 */
.menu_wrapper li.el-menu-item.second-item.is-active {
    background-color: var(--pink) !important;
    color: var(--text-main) !important;
    font-weight: 600;
}

/* 图标颜色继承 */
.menu_wrapper .iconfont,
.menu_wrapper .el-sub-menu__icon-arrow {
    color: inherit !important;
}

/* 移除旧的边框和背景 */
.menu_wrapper .menu_view .first-item,
.menu_wrapper .el-sub-menu.first-item .el-sub-menu__title {
    border: none !important;
    background: transparent !important;
}
.menu_wrapper .menu_view .first-item {
    border-top: none !important;
    border-bottom: none !important;
}

/* 移除旧的激活后伪元素 */
.menu_wrapper .menu_view .first-item.is-active:after {
    content: none !important;
}
</style>