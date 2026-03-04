<template>
    <div class="register_view">
<div class="form" style="z-index: 1;">
    <div class="logo"></div>
    <div class="projectName">{{projectName}}注册</div>
			<div class="register_form">
				<div class="list_item">
					<div class="list_label">用户账号：</div>
					<el-input class="list_inp"
						 v-model="registerForm.yonghuzhanghao"
						 placeholder="请输入用户账号"
						 type="text"
						/>
				</div>
				<div class="list_item">
					<div class="list_label">密码：</div>
					<el-input class="list_inp"
						 v-model="registerForm.mima"
						 placeholder="请输入密码"
						 type="password"
					     show-password
					 />
				</div>
				<div class="list_item">
					<div class="list_label">确认密码：</div>
					<el-input class="list_inp" v-model="registerForm.mima2" type="password" placeholder="请输入确认密码" show-password />
				</div>
				<div class="list_item">
					<div class="list_label">昵称：</div>
					<el-input class="list_inp"
						 v-model="registerForm.nicheng"
						 placeholder="请输入昵称"
						 type="text"
						/>
				</div>
				<div class="list_item">
					<div class="list_label">性别：</div>
					<el-radio-group class="list_radio" v-model="registerForm.xingbie">
						<el-radio v-for="item in yonghuxingbieLists" :label="item"
							size="large">{{item}}</el-radio>
					</el-radio-group>
				</div>
				<div class="list_item">
					<div class="list_label">头像：</div>
					<div class="list_file_list">
						<uploads
							action="file/upload"
							tip="请上传头像"
							:fileUrls="registerForm.touxiang?registerForm.touxiang:''"
							@change="touxiangUploadSuccess">
						</uploads>
					</div>
				</div>
				<div class="list_item">
					<div class="list_label">邮箱：</div>
					<el-input class="list_inp"
						 v-model="registerForm.youxiang"
						 placeholder="请输入邮箱"
						 type="text"
						/>
				</div>
				<div class="list_item">
					<div class="list_label">手机：</div>
					<el-input class="list_inp"
						 v-model="registerForm.shouji"
						 placeholder="请输入手机"
						 type="text"
						/>
				</div>
				<div class="list_item">
					<div class="list_label">身份证：</div>
					<el-input class="list_inp"
						 v-model="registerForm.shenfenzheng"
						 placeholder="请输入身份证"
						 type="text"
						/>
				</div>
			</div>

      <div class="back" @click="close">已有账号，直接登录</div>
    <div class="btn"><el-button class="register" @click="handleRegister">注册</el-button></div>
  
    <div class="form-circle1"></div>
    <div class="form-circle2"></div>
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
	} from 'vue';
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const projectName = context.$project.projectName
	//获取注册类型
	import { useRoute } from 'vue-router';
	const route = useRoute()
	const tableName = ref('yonghu')

	//公共方法
	const getUUID=()=> {
		return new Date().getTime();
	}
	const registerForm = ref({
	})
	const yonghuxingbieLists = ref([])
	const init=()=>{
		yonghuxingbieLists.value = "男,女".split(',')
		registerForm.value.zhuceshijian = context?.$toolUtil.getCurDateTime()
	}
    const touxiangUploadSuccess=(fileUrls)=> {
        registerForm.value.touxiang = fileUrls;
    }

	//注册按钮
	const handleRegister = () => {
		let url = tableName.value +"/register";
		if((!registerForm.value.yonghuzhanghao)){
			context?.$toolUtil.message(`用户账号不能为空`,'error')
			return false
		}
		if((!registerForm.value.mima)){
			context?.$toolUtil.message(`密码不能为空`,'error')
			return false
		}
		if(registerForm.value.mima!=registerForm.value.mima2){
			context?.$toolUtil.message('两次密码输入不一致','error')
			return false
		}
		if((!registerForm.value.nicheng)){
			context?.$toolUtil.message(`昵称不能为空`,'error')
			return false
		}
		if((!registerForm.value.xingbie)){
			context?.$toolUtil.message(`性别不能为空`,'error')
			return false
		}
		if(registerForm.value.touxiang!=null){
			registerForm.value.touxiang = registerForm.value.touxiang.replace(new RegExp(context?.$config.url,"g"),"");
		}
		if((!registerForm.value.touxiang)){
			context?.$toolUtil.message(`头像不能为空`,'error')
			return false
		}
		if((!registerForm.value.youxiang)){
			context?.$toolUtil.message(`邮箱不能为空`,'error')
			return false
		}
		if(registerForm.value.youxiang&&(!context?.$toolUtil.isEmail(registerForm.value.youxiang))){
			context?.$toolUtil.message(`邮箱应输入邮件格式`,'error')
			return false
		}
		if((!registerForm.value.shouji)){
			context?.$toolUtil.message(`手机不能为空`,'error')
			return false
		}
		if(registerForm.value.shouji&&(!context?.$toolUtil.isMobile(registerForm.value.shouji))){
			context?.$toolUtil.message(`手机应输入手机格式`,'error')
			return false
		}
		if((!registerForm.value.shenfenzheng)){
			context?.$toolUtil.message(`身份证不能为空`,'error')
			return false
		}
		if(registerForm.value.shenfenzheng&&(!context?.$toolUtil.checkIdCard(registerForm.value.shenfenzheng))){
			context?.$toolUtil.message(`身份证应输入身份证格式`,'error')
			return false
		}
		if(registerForm.value.maxPasswordWrong&&(!context?.$toolUtil.isIntNumer(registerForm.value.maxPasswordWrong))){
			context?.$toolUtil.message(`最大密码输错次数应输入整数`,'error')
			return false
		}
		if(registerForm.value.isLocked&&(!context?.$toolUtil.isIntNumer(registerForm.value.isLocked))){
			context?.$toolUtil.message(`用户锁定状态应输入整数`,'error')
			return false
		}
		if(registerForm.value.money&&(!context?.$toolUtil.isNumber(registerForm.value.money))){
			context?.$toolUtil.message(`余额应输入数字`,'error')
			return false
		}
		context?.$http({
			url:url,
			method:'post',
			data:registerForm.value
		}).then(res=>{
			context?.$toolUtil.message('注册成功','success', obj=>{
				context?.$router.push({
					path: "/login"
				});
			})
		})
	}
	//返回登录
	const close = () => {
		context?.$router.push({
			path: "/login"
		});
	}
	init()
	onMounted(()=>{

	})
</script>
<style lang="scss">
	.register_view {
        background-image: url("http://clfile.zggen.cn/20250920/bbbb3b669b3a40c6a7fbbfa205614414.png")!important;
	}
.register_view {
    background:url(http://clfile.zggen.cn/20250905/d751839d83b74ad6bff70d69de0ae8fe.jpg) no-repeat center top / 100% 100%;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    position: relative;
    overflow: hidden;
    padding: 0px;
}



.register_view .projectName {
    font-size: 20px;
    color: #000000;
    font-weight: 600;
    width: 100%;
    text-align: center;
    margin-top: 20px;
    text-shadow: 0px 0px 0px rgba(0, 0, 0, 0.3);
}
.register_view .logo {
    background: url(http://clfile.zggen.cn/20250725/889d208e5ddd4107bce6600713cdf6d1.webp);
    background-size: 100% 100%;
    width: 80px;
    height: 80px;
    animation: float 3s ease-in-out infinite;
    margin: 0 auto;
    display: none;
}
@keyframes float{
     0%,  100% {
        transform: translateY(0);
    }
     50% {
        transform: translateY(-10px);
    }
}

.register_view .register_form {
    width: 100%;
    text-align: left;
    display: flex;
    flex-direction: column;
    margin-top: 20px;
    padding: 0 40px;
    align-items: center;  
}




.register_view .list_item .list_inp{
    flex: 1;
}
.register_view .list_item .el-select{
    flex: 1;
}
.register_view .list_item .list_date{
    flex: 1;
}

.register_view .list_code {
    display: flex;
}
.register_view .list_code .list_code_btn{
    background: #fff;
    color: #333;
    border-radius: 10px;
    border: 1px solid #d1d5db;
    height: var(--input-height);
    line-height: var(--input-height);
}

.register_view .list_item .el-input__wrapper {
    border: none;
    outline: none;
    box-shadow: none!important;
    padding: 0;
    background: none!important;
}

.register_view .list_item .el-input__inner {
    background: #fff;
    height: var(--input-height);
    line-height: var(--input-height);
    border: 1px solid #d1d5db;
    padding: 0 10px;
    border-radius: 6px;
}
.register_view .list_item .el-input__inner:focus {
    border: 1px solid #d1d5db;
}

.register_view .list_item .list_date{
    background: #fff;
    height: var(--input-height);
    line-height: var(--input-height);
    border: 1px solid #d1d5db;
    padding: 0 10px;
    border-radius: 6px;
}
.register_view .list_item .list_date .el-input__inner {
    background:none;
    height: var(--input-height);
    line-height: var(--input-height);
    border: 0px solid rgba(193,42,49,0.3);
    padding: 0 0px;
    border-radius: 0px;
}
.register_view .list_item .list_date .el-input__inner:focus {
    border: 0px solid rgba(193,42,49,1);
}

.register_view .list_item .el-select .el-select__wrapper{
    background: #fff;
    height: var(--input-height);
    line-height:var(--input-height);
    box-shadow:none;
    border: 1px solid #d1d5db;
    padding: 0 10px;
    border-radius: 6px;    
}
.register_view .list_item .el-select .el-select__wrapper:focus {
    border: 2px solid rgba(193,42,49,1);
}

.register_view .list_code_item {display: flex;gap: 20px;
                                   width:100%;
                               }


.el-upload-list--picture-card {
    --el-upload-list-picture-card-size: 80px;
}
.el-upload--picture-card {
    --el-upload-picture-card-size: 80px;
}
.el-upload__tip {
    color: var(--el-text-color-regular);
    font-size: 14px;
    margin-top: 8px;
}
.el-radio__input.is-checked .el-radio__inner {
    background: var(--theme);
    border-color: var(--theme);
}
.el-radio__input.is-checked+.el-radio__label {
    color: var(--theme);
}
.el-upload-dragger .el-upload__text em {
    color: var(--theme);
}
.el-checkbox__input.is-checked+.el-checkbox__label {
    color: var(--theme);
}

.register_view .list_item .el-upload {
    --el-upload-dragger-padding-horizontal: 10px;
    --el-upload-dragger-padding-vertical: 10px;
}
.register_view .list_item .el-upload-dragger{
    border: 1px solid #ddd;
}
.register_view .list_item .el-upload-dragger .el-icon--upload {
    color: var(--el-text-color-placeholder);
    font-size: 60px;
    line-height: 1;
    margin-bottom:0px;
}

.el-checkbox__input.is-checked .el-checkbox__inner {
    background-color: var(--theme);
    border-color: var(--theme);
}

.register_view .btn{
    width: 100%;
  
      display: flex;
    flex-direction: column;  
    align-items: center;  
}
.register_view .btn .register {
    background: var(--theme);
    border: none;
    color: #fff;
    width: 80%;
    height: 40px;
    font-size: 18px;
    border-radius: 5px;
    margin:10px auto;
}

.register_view .back {
    width: 100%;
    padding-left: 0px;
    margin: 10px auto;
    text-align: center;
}

.register_view .form {
       background: #fff;
    width: 560px;
    margin: 20px 30% 20px 0px; 
   margin-right:30%;
    padding: 0 0 10px;
    border-radius: 30px;
    display: flex;
    flex-direction: column; 
    align-items: center; 
    flex-wrap: wrap; 
    overflow: hidden;
}
.register_view .list_item {
    display: flex;
     flex-direction: column;    
    align-items: flex-start;   
    margin-bottom: 15px;
    width:90%!important;
    margin:0px auto 15px auto;
}
.register_view .list_label {
    width: 130px;
    text-align:left;
}

</style>