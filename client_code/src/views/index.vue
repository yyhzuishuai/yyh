<template>
	<div id="index" class="main-containers">
        <div class="index_top">
<div class="top-header">
    <div class="headertop">

        <div class="top-right"> 


        </div>
    
    </div>
    <div class="headerbottom">
           <div class="projectName">{{projectName}}</div>

				<div v-if="Token" class="cart" style="cursor: pointer" @click="menuHandler('/index/cartList')">
					<i class="iconfont icon-gouwuche1"></i>
					<span>购物车</span>
				</div>

				<el-button v-if="!Token" class="login" @click="loginClick">
                    <el-icon><User/></el-icon>登录
				</el-button>

				<div class="user" v-if="Token">
					<el-dropdown class="avatar-container" trigger="hover">
						<div class="avatar-wrapper">
							<img class="user-avatar" :src="store.getters['user/avatar']" style="width: 50px">
							<div class="nickname">{{store.getters['user/username']}}</div>
							<el-icon class="el-icon-arrow-down">
								<arrow-down />
							</el-icon>
						</div>
						<template #dropdown>
							<el-dropdown-menu class="user-dropDown" slot="dropdown">
								<el-dropdown-item @click="menuHandler('center')" class="center">
									<span>个人中心</span>
								</el-dropdown-item>
								<el-dropdown-item @click="loginOut" class="loginOut">
									<span>退出登录</span>
								</el-dropdown-item>
							</el-dropdown-menu>
						</template>
					</el-dropdown>
				</div>
 
    </div>

</div>
            <div class="menu-wrapper">
                <el-scrollbar wrap-class="scrollbar-wrapper" class="menu_scrollbar">
                    <el-menu :unique-opened="true" :default-active="menuIndex"
                         class="menu_view" mode="horizontal" @select="menuChange"
                         :key="menuIndex"  :ellipsis="false">
                        <el-menu-item class="first-item" index="/index/home" @click="menuHandler('/')">
                            <i class="iconfont icon-zhuye2"></i>
                            <template #title>
                                <span>首页</span>
                            </template>
                        </el-menu-item>
                        <template v-for="(menu,index) in menuList" :key="menu.menu">
                            <el-sub-menu v-if="menu.child.length>1" :index="menu.name" class="first-item" :teleported="true">
                                <template #title>
                                    <i class="iconfont" :class="menu.icon"></i>
                                    <span>{{ menu.name }}</span>
                                </template>
                                <el-menu-item class="second-item" v-for=" (child,index1) in menu.child" :key="index1"
                                              :index="child.url" @click="menuHandler(child.url)">{{ child.name }}
                                </el-menu-item>
                            </el-sub-menu>
                            <el-menu-item v-else :index="menu.child[0].url" class="first-item" @click="menuHandler(menu.child[0].url)">
                                <i class="iconfont" :class="menu.icon"></i>
                                <template #title>
                                    <span>{{menu.child[0].name}}</span>
                                </template>
                            </el-menu-item>
                        </template>
                        <el-menu-item v-if="Token" :index="`/index/${context.$toolUtil.storageGet('frontSessionTable')}Center`" class="first-item" @click="menuHandler('center')">
                            <i class="iconfont icon-user1"></i>
                            <template #title>
                                <span>个人中心</span>
                            </template>
                        </el-menu-item>
                    </el-menu>
                </el-scrollbar>
            </div>

			<div class="rotation_view" >
				<mySwiper :type="3" :data="rotationList" :autoHeight="false" :autoplay="true"
					:loop="false" :navigation="true" :pagination="true"
					paginationType="1" :scrollbar="false" slidesPerView="1"
					spaceBetween="20" :centeredSlides="false"
					:freeMode="false" effectType="0"
					direction="horizontal">
					<template #default="scope">
						<img :src="scope.row.value?baseUrl + scope.row.value:''" @click="carouselClick(scope.row.url)">
					</template>
				</mySwiper>
			</div>

        </div>
		<el-scrollbar class="contain_view body-containers">
			<router-view :key="routerKey"/>
			<el-backtop :right="100" :bottom="100" />
			<div class="bottom_view ql-snow ql-editor">
                
			</div>
		</el-scrollbar>
	</div>
</template>
<script setup>
	import menu from '@/utils/menu'
	import axios from 'axios'
    const moment = window.moment
	import {
		ref,
		onBeforeUnmount,
		getCurrentInstance,
		nextTick,
		computed,
		watch,
        provide
	} from 'vue';
	import {
		useRouter,
		useRoute
	} from 'vue-router';
	import {
		useStore
	} from 'vuex';
	const store = useStore()
	const router = useRouter()
	const route = useRoute();
	const context = getCurrentInstance()?.appContext.config.globalProperties;
    const baseUrl = ref(context.$config.url)
    const projectName = ref("基于springboot的动漫周边网络商店管理系统的设计与实现")
	const Token = ref('')
	if(localStorage.getItem('frontToken') && !store.getters['user/session'].id){
		store.dispatch('user/getSession')
	}
	onBeforeUnmount(() => {
	})
	// 获取默认菜单index
	const setMenuIndex = (path)=>{
        if(path){
            menuIndex.value = path.replace('Detail','List')
        }else{
            menuIndex.value = ''
        }
	}
	// 默认菜单index
	const menuIndex = ref('')
    const routerKey = ref(Math.random())
	watch(() => router.currentRoute.value,(value, oldValue) => {
		Token.value = context?.$toolUtil.storageGet('frontToken')
        if(value.path==oldValue?.path){
            //改变路由query时重新加载router-view
            routerKey.value = Math.random()
        }
        if(value.query.centerType){
            setMenuIndex()
        }else{
            setMenuIndex(value.path)
        }
	},{
		immediate:true
	})
	const init = () => {
		// 获取菜单
		getMenu()
		// 赋值token
		Token.value = context?.$toolUtil.storageGet('frontToken')
		// 轮播图
		getRotationList()
		if(Token.value){
			getSession()
		}
	}
	// 切换菜单保存index
	const menuChange = (e)=>{
		if(e=='chat')return
	}
	// 轮播图
	const rotationList = ref([])
	const getRotationList = () => {
		context?.$http({
			url: 'config/list',
			method: 'get',
			params: {
				page: 1,
				limit: 3
			}
		}).then(res => {
			rotationList.value = res.data.data.list
		})
	}

    // 轮播图跳转
    const carouselClick = (url)=>{
        if (url) {
            if (url.startsWith('http')) {
                window.open(url)
            } else {
                context.$router.push(url)
            }
        }
    }
	const menuList = ref([])
	const role = ref('')
	const getMenu = () => {
		let params = {
			page: 1,
			limit: 1,
			sort: 'id',
		}
		context?.$http({
			url: "menu/list",
			method: "get",
			params: params
		}).then(res => {
			context?.$toolUtil.storageSet("menus", res.data.data.list[0].menujson);
		})
		menuList.value = context?.$config.menuList
	}
	const loginClick = () => {
		context?.$toolUtil.storageSet('toPath',window.history.state.current)
		router.push('/login')
	}
	const loginOut = () => {
        store.dispatch('user/loginOut')
		context?.$toolUtil.message('退出成功', 'success')
		context?.$toolUtil.storageClear()
		router.replace('/index/home')
		Token.value = ''
	}
	//菜单跳转
	const menuHandler = (name) => {
		if (name == 'center') {
			name = `${context?.$toolUtil.storageGet('frontSessionTable')}Center`
			menuChange('center')
		}
		router.push(name)
	}
	// 获取用户信息
	const getSession = () =>{
		context?.$http({
			url: `${context?.$toolUtil.storageGet('frontSessionTable')}/session`,
			method:'get'
		}).then(res=>{
			context?.$toolUtil.storageSet('userid',res.data.data.id)
			if(context?.$toolUtil.storageGet('frontSessionTable') == 'yonghu'){
				context?.$toolUtil.storageSet("frontName", res.data.data.yonghuzhanghao)
			}
			if(context?.$toolUtil.storageGet('frontSessionTable') == 'yonghu'){
				context?.$toolUtil.storageSet('headportrait',res.data.data.touxiang||'')
			}
			if(context?.$toolUtil.storageGet('frontSessionTable') == 'shangjia'){
				context?.$toolUtil.storageSet("frontName", res.data.data.shangjiazhanghao)
			}
			if(context?.$toolUtil.storageGet('frontSessionTable') == 'shangjia'){
				context?.$toolUtil.storageSet('headportrait',res.data.data.touxiang||'')
			}
		})
	}
	init()
</script>
<style lang="scss">
    .el-aside {
        transition: width 0.15s;
        -webkit-transition: width 0.15s;
        -moz-transition: width 0.15s;
        -webkit-transition: width 0.15s;
        -o-transition: width 0.15s;
    }
    .chat-badge{
        position: absolute;
        background: red;
        color: rgb(255, 255, 255);
        font-size: 12px;
        border-radius: 14px;
        padding:0 4px;
        height: 14px;
        display: flex;
        justify-content: center;
        align-items: center;
        top: -4px;
        right: -10px;
    }
.index_top .top-header {
    width: 100%;
    padding: 0px;
    background: var(--theme);
    margin:0 auto;
    display: flex;
      flex-direction: column; 
    gap: 10px; 
    align-items: center;
    color: #fff;
    border-radius: 0px 0px 0 0;
    font-size: 16px;
}
.index_top .projectName {
    margin-right: auto;
    font-size: 24px;
    color: #fff;
    font-weight: 500;
    white-space: nowrap;
}
.index_top .weather {
    color: #fff;
    white-space: nowrap;
    margin: 5px 0 0;
}
.index_top .notice-btn{
    background:none;
    padding: 0 0 0 30px;
    border: none;
    color: #fff;
    margin: 0 20px;
}
.index_top .login{
    background: none;
    border: 0px solid #ffffff50;
    color: #fff;
    font-size: 16px;
    margin: 0 20px 0 0;
}

.index_top .avatar-wrapper {
    display: flex;
    align-items: center;
    gap: 6px;
}
.index_top img.user-avatar {
    width: 40px!important;
    height: 40px;
}
.index_top .avatar-wrapper .nickname{
    color: #fff;
    white-space: nowrap;
}
.index_top .avatar-wrapper .el-icon{
    color: #fff;   
}
.index_top .chat{
    white-space: nowrap;
    margin: 0 20px 0 0;
}
.index_top .cart{
    white-space: nowrap;
    margin: 0 20px 0 0;
}

.headertop {
    width:100%;
     display: flex;
       align-items: center;
    padding:0px 40px;
}
.top-right{
       margin-left:auto;
display: flex;
       align-items: center;
}

.headerbottom{
      
  width:100%;
     display: flex;
       align-items: center;
    background: #567FEE;
    padding:10px 40px;
}
.bottom_view {
    width: 100%;
    padding: 20px 7%;
    margin: 0 auto;
    min-height: 100px;
    background: #000000;
    color: #fff;
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    align-content: center;
    justify-content: center;
    border-radius: 0 0 0px 0px;
}


.el-backtop {
    right:40px !important;
}
.main-containers{
    background:#f5f7fa;
}
#index {
    background: #f5f7fa;
}
.menu-wrapper{
    
    width: 100%;
    padding:10px 7%;
    margin: 0px auto 0px;
    background: #fff;
    border-top: 0px solid #f0f0f0;
    font-size: 16px;
    box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -2px rgba(0, 0, 0, 0.05);
    border-radius: 0px;
    overflow-y: hidden;
}
.menu-wrapper .el-scrollbar__view{
}
.menu-wrapper ul.el-menu.el-menu--horizontal.menu_view {
    font-size: 16px;
    background: none;
    height: 50px;
    display: flex;
    justify-content: center;
}
.menu-wrapper .el-menu--horizontal.el-menu {
    border-bottom:0px;
}

.menu-wrapper .el-menu--horizontal>.el-menu-item {
    align-items: center;
    border-bottom: 0px solid transparent;
    color: #333;
    font-size: 16px;
    margin-right:20px;
    border-radius: 30px;
    padding: 0;
}
.menu-wrapper .el-menu--horizontal>.el-menu-item i{
    margin: 0 3px 0 0;
}
.menu-wrapper .el-menu--horizontal>.el-menu-item:hover{
    background: #fff !important; 
    color: var(--theme) !important; 
    border-bottom: 0px solid var(--theme);
}
.menu-wrapper .el-menu--horizontal>.el-menu-item.is-active{
    background: #fff !important; 
    color: var(--theme) !important; 
    border-bottom: 0px solid var(--theme);
}


.menu-wrapper .menu_view .first-item{
    position: relative;
    background: #fff;
    border-radius: 30px;
    margin-right:20px;
    padding: 0;
}
.menu-wrapper .menu_view .first-item .el-sub-menu__title{
    color: #333;
    font-size: 16px;
    border-radius: 30px;
    padding: 0 20px 0 0;
}

.menu-wrapper .menu_view .first-item .el-sub-menu__title i{
    margin: 0 3px 0 0;
}
.menu-wrapper .menu_view .first-item .el-sub-menu__title:hover{
    background: #fff; 
    color: var(--theme);
    border-radius: 30px;
    border-bottom: 0px solid var(--theme);
}
.menu-wrapper .el-menu--horizontal>.el-sub-menu.is-active .el-sub-menu__title{
    background: #fff; 
    border-bottom: none;
    border-bottom: 0px solid var(--theme);
    border-radius: 30px;
}
.menu-wrapper .el-menu--horizontal>.el-menu-item.is-active,.menu-wrapper .el-menu--horizontal>.el-sub-menu.is-active .el-sub-menu__title {
    background: #fff;  
    color: var(--theme)!important;
    font-size: inherit;
    border-radius: 30px;
    border-bottom: 0px solid var(--theme);
}
.menu-wrapper .el-menu--horizontal .el-menu-item:not(.is-disabled):focus,.menu-wrapper  .el-menu--horizontal .el-menu-item:not(.is-disabled):hover {
    background: var(--theme-light4);
}



.el-sub-menu .el-sub-menu__icon-arrow {
    font-size: 12px;
    margin-top: -6px !important;
    position: absolute;
    top: 50%;
    right: 0;
}
.menu-wrapper .menu_wrapper {
    --el-menu-bg-color: none;
    --el-menu-active-color: var(--theme-dark);
}
.menu-wrapper .el-menu--horizontal>.el-menu-item .el-sub-menu__icon-more{
    color: #fff;
}
.el-menu--horizontal>.el-sub-menu .el-sub-menu__title{
    border: 0;
}



.menu-wrapper .el-menu--popup {
    border: none;
    border-radius: var(--el-border-radius-small);
    box-shadow: var(--el-box-shadow-light);
    min-width: 200px;
    padding: 0px 0;
    z-index: 100;
}
.menu-wrapper .el-menu--popup .second-item{
    border-radius: 30px;
}
.menu-wrapper .el-menu--popup .second-item:hover{
    background: var(--theme2) !important;
    color: #0949f7 !important;
}

.menu-wrapper i.el-icon.el-sub-menu__icon-more {
    color: #0949f7 !important;
}

.menu-wrapper .el-menu--horizontal>.el-menu-item.is-active{
background: #0660F8!important;
border-radius: 5px 5px 5px 5px;
height: 30px;
line-height:30px;
margin-top:auto;
margin-bottom:auto;
padding:10px;
color:#FFF!important;
}

li.el-sub-menu.is-active.first-item {
background: #0660F8!important;
border-radius: 5px 5px 5px 5px;
height: 30px;
line-height:30px;
margin-top:auto;
margin-bottom:auto;
padding:10px;
color:#FFF!important;
}

.menu-wrapper .el-menu--horizontal>.el-menu-item.is-active, .menu-wrapper .el-menu--horizontal>.el-sub-menu.is-active .el-sub-menu__title {
    background:none;
    color:#FFF!important;
}
.el-menu--horizontal .el-menu-item:not(.is-disabled):focus, .el-menu--horizontal .el-menu-item:not(.is-disabled):hover{
    color:#0949f7;
}

i.el-icon.el-sub-menu__icon-arrow {
    display:none;
}
.rotation_view{
    width: 100%;
    padding: 0;
    margin: 0px auto;
}
.rotation_view .swiper{
    height:450px;
}
.rotation_view .swiper-slide img {
    width: 100%;
    height:100%;
    object-fit: cover;
    border-radius: 0px; 
}
.swiper-pagination-bullet-active {
    background: var(--theme);
}


.rotation_view .swiper-button-prev{
    margin-left:40px !important; 
}
.rotation_view .swiper-button-next{
    margin-right:40px !important; 
}
.rotation_view .swiper-button-next:after,.rotation_view .swiper-button-prev:after {
    background:rgba(255,255,255,.5);
    font-size: 20px;
    color: #fff;
    font-weight: 600;
    padding: 0 20px;
    width: 50px !important;
    height: 50px !important;
    line-height: 50px !important;
    text-align: center;
    border-radius: 100%;
}

.breadcrumb-wrapper {
    width: 100%;
    padding: 10px 0;
    margin: 0 auto;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.breadcrumb-wrapper .el-breadcrumb{
   width: 100%;
   font-size: 16px; 
}

.el-breadcrumb__separator{
color: #000000;
}

.el-breadcrumb span{
color: #000000!important; 
}
.chat_view .chat-dialog{
    width: 70%;
}

.chat_view {
    display: flex;
    flex-direction: column;
    margin: 30px 0px;
    padding: 30px;
    border: 0px solid rgb(221, 221, 221);
    border-radius: 4px;
    font-size: 16px;
    background: #FFFFFF;
border-radius: 30px 30px 30px 30px;
}

.chat_view .chat-content{
    margin: 0px 0px 30px;
    padding: 0px 0px 30px;
    max-height: 400px;
    height: 400px;
    overflow-y: scroll;
    border: 1px solid rgb(221, 221, 221) !important;
    background: rgb(255, 255, 255) !important;
    border-radius: 0px;
}

.chat_view .chat-content .chat-item .chat_time{
    width: 100%;
    text-align: center;
    font-size: 16px;
    color: rgb(153, 153, 153);
    padding: 6px 0px;
}

.chat_view .chat-content .chat-item .left-content{
    margin: 0px 0px 10px;
    padding: 10px;
    display: inline-flex;
    max-width: 80%;
}

.chat_view .chat-content .chat-item .left-content .text-content{
    background-color: rgb(240, 249, 235);
    color: rgb(103, 194, 58);
}

.chat_view .chat-content .chat-item .left-content .chat_img{
    width: 120px;
    margin: 0 10px;
}

.chat_view .chat-content .chat-item .right-content{
    margin: 0px 0px 10px;
    padding: 10px;
    display: inline-flex;
    margin-left: auto;
    max-width: 80%;
}

.chat_view .chat-content .chat-item .right-content .text-content{
    background-color: rgb(253, 246, 236);
    color: rgb(230, 162, 60);
}

.chat_view .chat-content .chat-item .right-content .chat_img{
    width: 120px;
    margin: 0 10px;
}


.chat_view .input_box{
    display: flex;
    align-items: center;
}

.chat_view .input_box .el-textarea{
    position: relative;
    display: inline-block;
    width: 100%;
    vertical-align: bottom;
    font-size: 14px;
}



.chat_view .save_box{
width: 100%;
    display: flex;
    margin: 10px 0px 0px;
}

.chat_view .save_box .el-button--primary{
    margin: 0px 10px 0px 0px;
    padding: 0px 24px;
    width: auto;
    height: 36px;
    font-size: 14px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px solid rgb(252, 203, 130);
    background: var(--theme);
    cursor: pointer;
    min-width: 110px;
}

.chat_view .input_box {
    display: flex;
    flex-wrap: wrap;
}

.chat_view .actionBar {
    width: 100%;
    display: flex;
    align-items: center;
    gap: 10px;
}
.chat_view .upload {
    display: flex;
}

.chat_view .input-row {
    width: 100%;
}

.chat_view .send-box {
    margin-left: auto;
}

.chat_view .input_box {
    background: #fff;
    padding: 14px 20px;
    border: 1px solid #ddd;
}
.chat_view .el-textarea__inner {
    border: none!important;
    box-shadow: none!important;
    resize: none!important;
}
.chat_view .el-textarea__inner:focus {
    outline: none!important;
    box-shadow: none!important;
}
.chat_view .chat-content {
    margin-bottom:0px!important;

}

.chat_view .input_box {
    height:200px;
    max-height:200px;
}

.chat_view button.el-button.el-button--primary.send {
    width: 120px;
    height: 40px;
    background: #0949F7;
    border-radius: 10px 10px 10px 10px;
    font-size:18px;
}
.chat_view .el-alert.el-alert--success.is-light.text-content {
    width: 460px;
    min-height: 70px;
    height:auto;
    background: #0949F7!important;
    border-radius: 30px 0px 30px 30px;
    color:#fff!important;

    
 
}

.chat_view .el-alert.el-alert--warning.is-light.text-content {
   
       width: 460px;
      min-height:70px;    
    height:auto;
    background: #FFFFFF!important;
    border-radius: 0px 30px 30px 30px;
    border: 1px solid #B3B3B3;

}

.chat_view .chat-item {
    display: flex;
    padding-top: 24px;
    position: relative;
}

.chat_view .right-content .user {
    order: 2;
    margin-left: 10px;
}
.chat_view .left-content .user {
    order: 0;
    margin-right: 10px;
}
.chat_view .user span {
    display: none;
}
.chat_view .user img {
    width: 40px !important;
    height: 40px !important;
}
.chat_view .chat-item {
    flex-wrap:wrap;
}
.chat_view button.el-button.change_btn {
   width: 120px;
    height: 40px;
    
    border-radius: 10px 10px 10px 10px;
    font-size:18px;
 
}
</style>