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

<style lang="scss" scoped>
.login_view {
    background: url('~@/assets/images/login-bg.jpg') no-repeat center center;
    background-size: cover;
    width: 100vw;
    height: 100vh;
    display: flex;
    align-items: center;
    justify-content: flex-end; /* Align card to the right */
    padding-right: 15%; /* Add space from the right edge */
    position: relative;
    overflow: hidden;

    &::before {
        content: '';
        position: absolute;
        inset: 0;
        background: radial-gradient(circle at 50% 50%, rgba(255, 255, 255, 0.1), rgba(255, 255, 255, 0) 70%);
        pointer-events: none;
    }

    &::after {
        display: none; 
    }
}

.login_view .form {
    background: rgba(255, 255, 255, 0.45);
    backdrop-filter: blur(24px);
    -webkit-backdrop-filter: blur(24px);
    border: 1px solid rgba(255, 255, 255, 0.6);
    border-radius: 28px;
    padding: 48px 44px;
    width: 420px;
    /* margin: 0; <- Removed to allow flex positioning */
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    position: relative;
    z-index: 2;
    overflow: hidden;
    box-shadow: 
        0 0 0 1.5px rgba(255, 255, 255, 0.7) inset,
        0 32px 64px rgba(0, 0, 0, 0.1);
    animation: fadeInUp 0.6s ease forwards;

    &::before {
        content: '';
        position: absolute;
        top: 0; left: 50%;
        transform: translateX(-50%);
        width: 60%;
        height: 1px;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.7), transparent);
    }

    &::after {
        display: none;
    }
}

@keyframes fadeInUp {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

.login_view .form2 {
    width: 100%;
    background: transparent;
    padding: 0;
    position: relative;
    display: flex;                
    flex-direction: column;       
    align-items: center;          
    justify-content: center;      
}

@keyframes shimmer {
    0% { background-position: -200% 0; }
    100% { background-position: 200% 0; }
}

.login_view .projectName {
    font-size: 18px;
    font-weight: 700;
    text-align: center;
    line-height: 1.6;
    margin-bottom: 32px;
    color: #6B46C1; /* Deeper purple */
    letter-spacing: 0.5px;
    position: relative;

    &::after {
        content: '';
        display: block;
        width: 48px;
        height: 2px;
        margin: 12px auto 0;
        border-radius: 2px;
        background: #D6BCFA; /* Lighter purple */
    }
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
    width: 100%;
    display: flex;
    justify-content: flex-end;
    margin-top: 5px;
}

.login_view .register {
    background: none !important;
    border: none !important;
    color: #718096 !important;
    font-size: 13px !important;
    cursor: pointer !important;
    transition: color 0.3s ease !important;
    display: block !important;
    margin-bottom: 24px !important;
    text-decoration: none !important;
    padding: 0 !important;
}

.login_view .register:hover {
    color: #805AD5 !important; /* Deeper purple for hover */
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
    width: 100%;
    margin: 0 0 20px 0 !important;
    display: flex;
    flex-direction: column;  
    align-items: flex-start; 
    background: transparent !important;
    padding: 0;
    line-height: normal;
}

.login_view .label {
    color: #4A5568;
    font-size: 13px;
    margin-bottom: 8px;
    padding: 0;
    line-height: 1;
    display: block;
}

::v-deep .el-input__wrapper {
    background: rgba(255, 255, 255, 0.75) !important;
    box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05) inset !important;
    border-radius: 12px !important;
    height: 46px !important;
    padding: 0 16px !important;
    transition: all 0.3s ease !important;
    outline: none !important;
}

::v-deep .el-input__inner {
    color: #2D3748 !important;
    font-size: 14px !important;
    height: 46px !important;
}

::v-deep .el-input__inner::placeholder {
    color: #718096 !important;
}

::v-deep .el-input__wrapper.is-focus {
    box-shadow: 0 0 0 3px rgba(214, 188, 250, 0.6), 0 1px 2px rgba(0, 0, 0, 0.05) inset !important;
    background: rgba(255, 255, 255, 0.85) !important;
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
    width: 100% !important;
    height: 48px !important;
    border: none !important;
    border-radius: 12px !important;
    background: linear-gradient(135deg, #D6BCFA 0%, #A78BFA 100%) !important; /* Soft purple gradient */
    color: #FFFFFF !important;
    font-size: 16px !important;
    font-weight: 700 !important;
    cursor: pointer !important;
    letter-spacing: 2px !important;
    transition: all 0.4s ease !important;
    position: relative !important;
    overflow: hidden !important;
    margin: 0 !important;
}

.login_view .login:hover {
    background: linear-gradient(135deg, #A78BFA 0%, #805AD5 100%) !important; /* Darker purple gradient on hover */
    box-shadow: 0 8px 24px rgba(128, 90, 213, 0.3) !important;
    transform: translateY(-2px) !important;
}

.login_view .login:active {
    transform: translateY(0px) !important;
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