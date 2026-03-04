<template>
	<div class="login_view">

<div class="form" style="z-index: 1;">
    <div class="projectName">{{projectName}}</div>
				<div class="form-item roles" v-if="userList.length>1">
					<div class="label">
						用户类型：
					</div>
				  <el-select v-model="loginForm.role" placeholder="请选择用户类型">
					<el-option v-for="(item,index) in userList" :label="item.roleName" :value="item.roleName"></el-option>
				  </el-select>
				</div>

				<div class="form-item userName" v-if="loginType==1">
					<div class="label">
						账号：
					</div>
					<el-input class="item-input" v-model="loginForm.username" placeholder="请输入账号" name="username" />
				</div>

				<div class="form-item password" v-if="loginType==1">
					<div class="label">
						密码：
					</div>
					<el-input class="item-input" v-model="loginForm.password" type="password" show-password placeholder="请输入密码" @keydown.enter.native="handleLogin"  />
				</div>


				<div class="remember_view" v-if="loginType==1">
					<el-checkbox v-model="rememberPassword" label="记住密码" size="large" :true-label="true"
						:false-label="false" />
				</div>


    <div class="login-row">
				<el-button class="login" v-if="loginType==1" @click="handleLogin">登录</el-button>

    </div>

    <div class="register-row">
                    <el-button class="register" @click="handleRegister('shangjia')">注册商家</el-button>

    </div>
</div>
	</div>
</template>
<script setup>
	import {
		ref,
		getCurrentInstance,
		nextTick,
		onMounted,
		onUnmounted,
	} from "vue";
	import { useStore } from 'vuex'
	const store = useStore()
	const projectName = ref("基于springboot的动漫周边网络商店管理系统的设计与实现")
	const userList = ref([])
	const menus = ref([])
	const loginForm = ref({
		role: '',
		username: '',
		password: ''
	})
	const tableName = ref('')
	const loginType = ref(1)
	//是否记住密码
	const rememberPassword = ref(true)
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	//注册
    const handleRegister = (tableName) => {
    	context?.$router.push(`/${tableName}Register`)
    }
	const handleLogin = () => {
		if (!loginForm.value.username) {
			context?.$toolUtil.message('请输入用户名', 'error')
			
			return;
		}
		if (!loginForm.value.password) {
			context?.$toolUtil.message('请输入密码', 'error')
			return;
		}
		if (userList.value.length > 1) {
			if (!loginForm.value.role) {
				context?.$toolUtil.message('请选择角色', 'error')
				verifySlider.value.reset()
				return;
			}
			for (let i = 0; i < menus.value.length; i++) {
				if (menus.value[i].roleName == loginForm.value.role) {
					tableName.value = menus.value[i].pathName||menus.value[i].tableName;
				}
			}
		} else {
			tableName.value = userList.value[0].pathName||userList.value[0].tableName;
			loginForm.value.role = userList.value[0].roleName;
		}
		login()
	}
	const login = () => {
		context?.$http({
			url: `${tableName.value}/login?username=${loginForm.value.username}&password=${loginForm.value.password}`,
			method: 'post'
		}).then(res => {
			//是否保存当前账号密码至缓存
			if (rememberPassword.value) {
				let loginForm1 = JSON.parse(JSON.stringify(loginForm.value))
				delete loginForm1.code
				context?.$toolUtil.storageSet("loginForm", JSON.stringify(loginForm1));
			} else {
				context?.$toolUtil.storageRemove("loginForm")
			}
			context?.$toolUtil.storageSet("Token", res.data.token);
			context?.$toolUtil.storageSet("role", loginForm.value.role);
			context?.$toolUtil.storageSet("sessionTable", tableName.value);
			context?.$toolUtil.storageSet("adminName", loginForm.value.username);
            //vuex中获取用户信息并保存
			store.dispatch('user/getSession').then(res=>{
                context?.$router.push('/')
            })
		}, err => {
		})
	}
	//获取菜单
	const getMenu=()=> {
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
          menus.value = JSON.parse(res.data.data.list[0].menujson)
          for (let i = 0; i < menus.value.length; i++) {
            if (menus.value[i].hasBackLogin=='是') {
              userList.value.push(menus.value[i])
            }
          }
			//获取缓存是否有保存的账号密码
			let form = context?.$toolUtil.storageGet('loginForm')
			if (form) {
				
			}else {
				loginForm.value.role = userList.value[0].roleName
			}
          context?.$toolUtil.storageSet("menus", JSON.stringify(menus.value));
      })
    }
	//初始化
	const init = () => {
		getMenu();
		//获取缓存是否有保存的账号密码
		let form = context?.$toolUtil.storageGet('loginForm')
		if (form) {
			loginForm.value = JSON.parse(form)
		}
	}
	onMounted(()=>{
		init()


	})
</script>

<style lang="scss">
	.login_view {
        background-image: url("http://clfile.zggen.cn/20251108/6d6011d3e17547d9a426fe7c4ddf9cdc.webp")!important;
	}
.login_view {
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: flex-end;
    position: relative;
    overflow: hidden;
    background-size: 70vh 100vh;
    background-repeat: no-repeat;
    background-position: 10% 0;
}

.login_view .form {
    padding: 50px 30px;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    position: relative;
    overflow: hidden;
    width: 550px;
    border-radius: 10px;
    color: #000;
    overflow: visible;
    margin-right: 10%;
    background: #fff;
}

.login_view .projectName {
    font-size: 23px;
    width: 700px;
    text-align: center;
    margin-top: 0px;
    font-weight: 700;
    margin-bottom: 20px;
    /* border-bottom: 4px solid var(--theme); */
    /* padding-bottom: 20px; */
    white-space: nowrap;
}

.login_view .form-item {
    width: 100%;
    padding: 0 10px;
    border-radius: 6px;
    line-height: 50px;
    display: flex;
    margin-bottom: 20px;
    align-items: center;
    background: #fff;
    height: 50px;
    color: #000;
    border: 1px  solid #ccc;
}

.login_view .el-input__wrapper {
    border: none;
    outline: none;
    box-shadow: none!important;
    background: none;
}

.login_view .label {
    color: #000;
    padding: 0 10px;
    white-space: nowrap;
    width: auto;
    text-align: left;
    line-height: 30px;
    flex-shrink: 0;
}

.login_view .code-info {
    width: 120px;
    background: var(--theme);
    flex-shrink: 0;
    display: flex;
    justify-content: space-around;
    font-size: 20px;
    position: absolute;
    right: 5px;
    bottom: 0;
    height: 40px;
    line-height: 40px;
    border-radius: 6px;
    top: 5px;
}

.login_view .form-item.code {
    /* margin-right: 140px; */
    position: relative;
    width: 100%;
}

.login_view .form-item.roles {
    position: relative;
    display: flex;
    gap: 20px;
    margin-top: 20px;
    padding: 10px 20px;
    background: #fff;
    height: auto;
    border: 1px solid #ccc;
}

.login_view .el-radio.role {
    background: #fff;
    border: 1px solid #eee;
    padding: 10px;
    flex: 1;
    margin-right: 0;
    border-radius: 8px;
}

.login_view .login {
    width: 100%;
    height: 50px;
    background: var(--theme);
    color: #fff;
    font-size: 18px;
    border: 0px solid var(--theme);
    border-radius: 10px;
    margin: 0 auto;
}
.login_view .el-button.face{
    width: 100%;
    margin-top: 20px;
    height: 50px;
    color: var(--theme);
    border: none;
    background: #fff;
    font-size: 18px;
    margin-left: 0;
    border-radius: 10px;
    border: 1px solid;
}

.login_view .register {
    background: none;
    border: none;
    color: #333;
    border: 1px solid #999;
    height: 40px;
    flex: 1;
    margin: 0;
}

.login_view .forget {
    position: relative;
    height: 50px;
    color: var(--theme);
    border: none;
    background: none;
    font-size: 14px;
    margin-left: 0;
    border-radius: 10px;
}

.login_view .img {
    background: url(http://clfile.zggen.cn/20250817/80398b9b44024bfc8516fe0de27cacf6.webp);
    height: 100%;
    background-size: contain;
    background-repeat: no-repeat;
    background-color: #ebead6;
    flex: 1;
}

.login_view .box {
    display: flex;
    width: 70vw;
    min-width: 1200px;
    height: 700px;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    border-radius: 20px;
    overflow: hidden;
}

.login_view .form-item:hover {
    border-color: var(--theme);
}

.login_view .role {
    text-align: center;
    background: var(--theme);
    border: 1px solid #999;
    line-height: 40px;
    color: #000;
    border-radius: 6px;
}

.login_view .role.tabActive {
    background: var(--theme);
    border-color: var(--theme);
    color: #fff;
}

.login_view .remember_view {
    text-align: center;
    background: #fff;
    height: auto;
    padding: 0 10px;
    border-radius: 6px;
    display: flex;
    align-items: center;
    color: #fff;
    width: 100%;
}

.login_view .item-input {
    background: #fff;
    border-radius: 6px;
    height: 40px;
}

.login_view .register-row {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
    margin-top: 20px;
    width: 100%;
    align-items: center;
    padding-bottom: 10px;
    gap: 30px;
}

.login_view .register:hover {
}

.login_view .login-row {
    display: flex;
    width: 100%;
}

.login_view .el-select__wrapper {
    box-shadow: none!important;
}
</style>