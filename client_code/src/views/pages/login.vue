<template>
    <div class="login_view">
<div class="form" style="z-index: 1;">
    <div class="form2">
    <div class="logo"></div>
    <div class="projectName">{{projectName}}</div>
    <div class="tip"></div>
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


 
          <div class="forget-row">
        <div class="register-row">
                    <el-button class="register" @click="handleRegister('yonghu')">注册用户</el-button>

        </div>

    </div>
				<el-button class="login" v-if="loginType==1" @click="handleLogin">登录</el-button>


  
    <div class="card-decoration-1 bg-cream"></div>
    <div class="card-decoration-2 bg-mauve"></div>
</div>
</div>
<div class="circle1"></div>
<div class="circle2"></div>
    </div>
</template>
<script setup>
	import {
		ref,
		getCurrentInstance,
		nextTick,
		onMounted,
	} from "vue";
	import {
		useStore
	} from 'vuex';
	const store = useStore()
    const projectName = ref("基于springboot的动漫周边网络商店管理系统的设计与实现")
	import menu from '@/utils/menu'
	const userList = ref([])
	const menus = ref([])
	const loginForm = ref({
		role: '',
		username: '',
		password: ''
	})
	const tableName = ref('')
	const loginType = ref(1)
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
				verifySlider.reset()
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
			context?.$toolUtil.storageSet("frontToken", res.data.token);
			context?.$toolUtil.storageSet("frontRole", loginForm.value.role);
			context?.$toolUtil.storageSet("frontSessionTable", tableName.value);
			store.dispatch('user/getSession')
			let path = context?.$toolUtil.storageGet('toPath')
			if (path && path!='/login') {
				context?.$router.replace(path)
				context?.$toolUtil.storageRemove('toPath')
				return
			}
			context?.$router.replace(`/index/${tableName.value}Center`)
		},err=>{
		})
	}
	//获取菜单
	const getMenu= async ()=> {
		let arr = menu.list()
		if(!arr){
			let res = await context?.$http.get("menu/list")
			context?.$toolUtil.storageSet("menus", res.data.data.list[0].menujson);
			arr = JSON.parse(res.data.data.list[0].menujson)
		}
		menus.value = arr
		for (let i = 0; i < menus.value.length; i++) {
			if (menus.value[i].hasFrontLogin=='是') {
				userList.value.push(menus.value[i])
			}
		}
    }
	//初始化
	const init = async () => {
		await getMenu();
		loginForm.value.role = userList.value[0].roleName
	}
	onMounted(()=>{
		init()

	})
</script>

<style lang="scss">
	.login_view {
        background-image: url("http://clfile.zggen.cn/20250920/bbbb3b669b3a40c6a7fbbfa205614414.png")!important;
	}
.login_view {
    background:url(http://clfile.zggen.cn/20250905/d751839d83b74ad6bff70d69de0ae8fe.jpg) no-repeat center top / 100% 100%;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    overflow: hidden;
}

.login_view .form {
    
    background: #fff;
    width: 560px;
    margin-right:30%;
    padding: 0;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    overflow: hidden;
   border-radius: 30px 30px 30px 30px;
}
.login_view .form2 {
    width: 100%;
    background: rgba(255,255,255,.8);
    padding: 20px 40px;
    border: 0px solid #DDA0DD;
    border-bottom-left-radius: 50% 20px;
    border-bottom-right-radius: 50% 20px;
    border-top-left-radius: 10% 20px;
    border-top-right-radius: 10% 20px;
    position: relative;
      display: flex;                
    flex-direction: column;       
    align-items: center;          
    justify-content: center;      
}

.login_view .projectName {
    font-size: 20px;
   color: #000000;
    font-weight: 700;
    width: 100%;
    text-align: center;
    margin-top: 20px;
    text-shadow: 0px 0px 0px rgba(0, 0, 0, 0.3);
}

.login_view .tip {
    font-size: 16px;
    width: 100%;
    text-align: center;
    margin-top: 10px;
    color: #6b7280;
}





.login_view .form-item .el-input__inner {
    background:none;
    height: var(--input-height);
    line-height: var(--input-height);
    border: 0px solid #d1d5db;
    padding: 0 10px;
    border-radius: 6px;
}
.login_view .form-item .el-input__inner:focus {
    border: 0px solid #a7b5ca;
}


.login_view .form-item .el-select .el-select__wrapper:focus {
    border: 0px solid #a7b5ca;
}


.login_view .label .el-icon{
    font-size:18px;
    top: 4px;
}
.el-input .el-input__password {
    margin-right: 10px;
}


.login_view .form-item.code {
    margin-right: 140px;
    position: relative;
}

.login_view .form-item.roles {
    position: relative;
    background: none;
    display: flex;
    gap: 0px;
    padding: 0;
}

.login_view .el-radio.role {
    background: #fff;
    border: 1px solid #eee;
    padding: 10px;
    flex: 1;
    margin-right: 0;
    border-radius: 8px;
}

.login_view .forget-row {
    width: 90%;
    display: flex;
    justify-content: space-between;
    margin-top: 20px;
}

.login_view .register {
    background: none;
    border: none;
    font-size: 16px;
}

.login_view .register:hover{
    color:var(--theme);
}

.login_view .forget {
    background: none;
    border: 0;
    font-size: 16px;   
}
.login_view .forget:hover{
    color:var(--theme);
}

.login_view .logo {
    background: url(http://clfile.zggen.cn/20250725/889d208e5ddd4107bce6600713cdf6d1.webp);
    background-size: 100% 100%;
    width: 80px;
    height: 80px;
    animation: float 3s ease-in-out infinite;
    display: none;
}


.login_view .form-item {
    width: 90%;
    margin:10px auto 0px auto!important;
    display: flex;
      flex-direction: column;  
    align-items: flex-start; 
    background: #fff !important;
    padding: 0;
   
    line-height: 50px;
    border-radius: 10px;
}
.login_view .el-input__wrapper {
    border-radius: 5px 5px 5px 5px;
border: 1px solid #9CA3AF;    
outline: none;
     box-shadow:none!important;
    padding: 0;
    background: none!important;
}
.login_view .label {
    background: none;
    color: #9ca3af;
    padding: 0 10px;
    line-height:20px;
}
.login_view .form-item .el-select .el-select__wrapper{
    background: none;
    height: var(--input-height);
    line-height:var(--input-height);
    box-shadow:none;
     border-radius: 5px 5px 5px 5px;
border: 1px solid #9CA3AF;   
    padding: 0 10px;
    border-radius: 6px;    
}
.login_view .code-info {
    width: 120px;
    background: #fffacd;
    flex-shrink: 0;
    display: flex;
    justify-content: space-around;
    font-size: 20px;
    border-radius: 5px;
    border: 0px solid var(--theme);
    height: var(--input-height);
    line-height: var(--input-height);
    position:absolute;
    right:0;
    bottom:1px;
}



.login_view .login {
    width: 90%;
    margin:20px auto 0px auto!important;
    height: 50px;
    background: var(--theme);
    border: none;
    color: #fff;
    font-size: 18px;
    border-radius: 5px;
}
.login_view .face{
    width: 90%;
    margin:20px auto 0px auto!important;
    height: 50px;
    background: var(--theme);
    border: none;
    color: #fff;
    font-size: 18px;
    border-radius: 5px;
      text-align:center;
    line-height:50px;
}

</style>