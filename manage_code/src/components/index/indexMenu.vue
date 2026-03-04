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
.menu_wrapper{
    width: 210px;
    position: fixed;
    top: 139px;
    left: 0;
    height: calc(100vh - 138px);
    padding: 0;
    z-index: 999;
    border-radius: 0;
    --el-menu-item-height: 44px;
    --el-menu-sub-item-height: 44px;
    background: #f4f6f5;
    border: 1px solid #ccc;
}
.menu_wrapper .menu_view {
    background-color: var(--el-menu-bg-color);
    border-right:none;
    box-sizing: border-box;
    list-style: none;
    margin: 0;
    padding-left: 0;
    position: relative;
}

/** 首页 **/
.menu_wrapper .el-menu-item {
    align-items: center;
    border-bottom: 0px solid transparent;
    color: #000;
    font-size: 16px;
    border-left: 4px solid #f9fafb;
}
.menu_wrapper .el-menu-item:hover{
    background: var(--theme) !important; 
    color: #fff !important; 
    border-left: 4px solid #a3d1e8;
}
.menu_wrapper .el-menu-item.is-active{
    background: var(--theme) !important; 
    color: #fff !important; 
    font-size: 16px !important; 
    border-bottom: none;
    border-left: 4px solid #a3d1e8;
}
.menu_wrapper .el-menu-item .iconfont{
    margin-right: 10px;
}
/** 其他 **/
.menu_wrapper .menu_view .first-item{
    position: relative;
    border-top: 5px solid #fff;
    border-bottom: 5px solid #fff;
    box-sizing: content-box;
    border: 1px solid #ccc;
    border-radius: 6px;
    /* margin-bottom: 10px; */
    background: #f4f6f5;
    border-radius: 0;
}
.menu_wrapper .menu_view .first-item .el-sub-menu__title{
    color: #000;
    font-size: 16px;
    border-left: 4px solid #f9fafb;
}
.menu_wrapper .menu_view .first-item .el-sub-menu__title:hover{
    background: var(--theme);
    color: #fff;
    /* border-left: 4px solid #a3d1e8; */
}
.menu_wrapper .el-sub-menu.is-active .el-sub-menu__title{
    background: var(--theme);
    border-bottom: none;
    font-size:16px;
    border-left: none!important;
}
.menu_wrapper .el-menu-item.is-active,.menu_wrapper .el-sub-menu.is-active .el-sub-menu__title {
    background: var(--theme);
    color: #fff!important;
    font-size: 16px;
    /* border-radius: 6px; */
}
.menu_wrapper .el-menu-item:not(.is-disabled):focus,.menu_wrapper  .el-menu-item:not(.is-disabled):hover {
    background: var(--theme-light4);
}
.menu_wrapper .menu_view .first-item .el-sub-menu__title .iconfont{
    margin-right: 10px;
}
.menu_wrapper {
    --el-menu-bg-color: none;
    --el-menu-active-color: var(--theme-dark);
}
.menu_wrapper .el-menu-item .el-sub-menu__icon-more{
    color: #fff;
}

/** 二级盒子 **/
.menu_wrapper .el-menu--popup {
    border: none;
    border-radius: var(--el-border-radius-small);
    box-shadow: var(--el-box-shadow-light);
    min-width: auto;
    padding: 0px 0;
    z-index: 100; 
}
.menu_wrapper li.el-menu-item.second-item {
    padding-left:46px !important;
    border-left:none;
    /* margin-top: 10px; */
    border-radius: 0;
    background: #e6f0c6!important;
    border-bottom: 1px solid #ccc;
    color: #666;
}
.menu_wrapper li.el-menu-item.second-item:hover{
    /* background: var(--theme50) !important; */
    color: #333!important;
}
.menu_wrapper li.el-menu-item.second-item.is-active{
    color: var(--theme)!important;
}
.menu_wrapper i.el-icon.el-sub-menu__icon-more {
    color: #fff;
}


.menu_wrapper .menu_view .first-item.is-active:after {content: '';position: absolute;background-image: url(http://clfile.zggen.cn/20251108/d2ac471bd27f4819b18032150ab17ba4.webp);width: 10px;height: 18px;top: 11px;background-size: 100% 100%;left: -1px;}

.menu_wrapper .el-sub-menu.first-item .el-sub-menu__title {
    border: 1px solid #ccc;
    /* border-radius: 6px; */
}

.menu_wrapper li.el-sub-menu.first-item {
    border: none;
}
</style>