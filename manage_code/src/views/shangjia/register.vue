<template>
	<div class="register_view">
<div class="form" style="z-index: 1;">
    <div class="projectName">{{projectName}}注册</div>
			<div class="register_form">
				<div class="list_item">
					<div class="list_label">商家账号：</div>
					<el-input class="list_inp"
						 v-model="registerForm.shangjiazhanghao"
						 placeholder="请输入商家账号"
						 type="text"
						/>
				</div>
				<div class="list_item">
					<div class="list_label">商家密码：</div>
					<el-input class="list_inp"
						 v-model="registerForm.shangjiamima"
						 placeholder="请输入商家密码"
						 type="password"
					     show-password
						 />
				</div>
				<div class="list_item">
					<div class="list_label">确认商家密码：</div>
					<el-input class="list_inp" v-model="registerForm.shangjiamima2" type="password" placeholder="请输入确认商家密码" show-password />
				</div>
				<div class="list_item">
					<div class="list_label">商家名称：</div>
					<el-input class="list_inp"
						 v-model="registerForm.shangjiamingcheng"
						 placeholder="请输入商家名称"
						 type="text"
						/>
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
					<div class="list_label">联系方式：</div>
					<el-input class="list_inp"
						 v-model="registerForm.lianxifangshi"
						 placeholder="请输入联系方式"
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
				<div class="list_item">
					<div class="list_label">营业资质：</div>
					<div class="list_file_list">
						<uploads
							type="file"
							action="file/upload"
							tip="请上传营业资质"
							:limit="3"
							:fileUrls="registerForm.yingyezizhi?registerForm.yingyezizhi:''"
							@change="yingyezizhiUploadSuccess">
						</uploads>
					</div>
				</div>
                <div class="list_item">
                    <div class="list_label">地址：</div>
                    <el-input class="list_inp"
                              v-model="registerForm.fulladdress"
                              placeholder="请输入地址"
                              type="text"
                              @click.native="mapClick"
                    />
                </div>
			</div>

    <div class="back" @click="close">已有账号，直接登录</div>
    <el-button class="register" @click="handleRegister">注册</el-button>
</div>
	</div>
<locationForm ref="location" :position="registerForm" @mapData="getAddress"></locationForm>
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
	const tableName = ref('shangjia')
	
	//公共方法
	const getUUID=()=> {
		return new Date().getTime();
	}
	const registerForm = ref({
	})
	const init=()=>{
		registerForm.value.zhuceshijian = context?.$toolUtil.getCurDateTime()
	}
    const touxiangUploadSuccess=(fileUrls)=> {
        registerForm.value.touxiang = fileUrls;
    }
    const yingyezizhiUploadSuccess=(fileUrls)=> {
        registerForm.value.yingyezizhi = fileUrls;
    }

    import locationForm from '@/components/common/location.vue'

    const location = ref(null)

    const mapClick = () => {
        location.value.mapShow()
    }

    const getAddress = (e) => {
        registerForm.value.longitude = e.lng
        registerForm.value.latitude = e.lat
        registerForm.value.fulladdress = e.fulladdress
    }
	//注册按钮
	const handleRegister = () => {
		let url = tableName.value +"/register";
		if((!registerForm.value.shangjiazhanghao)){
			context?.$toolUtil.message(`商家账号不能为空`,'error')
			return false
		}
		if((!registerForm.value.shangjiamima)){
			context?.$toolUtil.message(`商家密码不能为空`,'error')
			return false
		}
		if(registerForm.value.shangjiamima!=registerForm.value.shangjiamima2){
			context?.$toolUtil.message('两次密码输入不一致','error')
			return false
		}
		if((!registerForm.value.shangjiamingcheng)){
			context?.$toolUtil.message(`商家名称不能为空`,'error')
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
		if((!registerForm.value.lianxifangshi)){
			context?.$toolUtil.message(`联系方式不能为空`,'error')
			return false
		}
		if(registerForm.value.lianxifangshi&&(!context?.$toolUtil.isMobile(registerForm.value.lianxifangshi))){
			context?.$toolUtil.message(`联系方式应输入手机格式`,'error')
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
		if(registerForm.value.yingyezizhi!=null){
			registerForm.value.yingyezizhi = registerForm.value.yingyezizhi.replace(new RegExp(context?.$config.url,"g"),"");
		}
		if(registerForm.value.maxPasswordWrong&&(!context?.$toolUtil.isIntNumer(registerForm.value.maxPasswordWrong))){
			context?.$toolUtil.message(`最大密码输错次数应输入整数`,'error')
			return false
		}
		if(registerForm.value.isLocked&&(!context?.$toolUtil.isIntNumer(registerForm.value.isLocked))){
			context?.$toolUtil.message(`用户锁定状态应输入整数`,'error')
			return false
		}
		if(registerForm.value.longitude&&(!context?.$toolUtil.isNumber(registerForm.value.longitude))){
			context?.$toolUtil.message(`经度应输入数字`,'error')
			return false
		}
		if(registerForm.value.latitude&&(!context?.$toolUtil.isNumber(registerForm.value.latitude))){
			context?.$toolUtil.message(`纬度应输入数字`,'error')
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
        background-image: url("http://clfile.zggen.cn/20251108/56b49386ef5147b9b1b7b45f64526eb5.webp")!important;
	}
.register_view {
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: flex-end;
    position: relative;
    overflow: hidden;
    background-size: 70vh 100vh;
    background-repeat: no-repeat;
    background-position: 10% 0;
    background-attachment: fixed;
}
.register_view .box {
    display: flex;
    width: 70vw;
    min-width: 1200px;
    height: auto;
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
    border-radius: 20px;
    overflow: hidden;
}

.register_view .form {
    text-align: center;
    display: flex;
    flex-wrap: wrap;
    justify-content: center;
    position: relative;
    width: 600px;
    border-radius: 10px;
    align-items: flex-start;
    margin-right: 10%;
    margin-top: 50px;
    margin-bottom: 50px;
}

.register_view .projectName {
    font-size: 22px;
    font-weight: 700;
    width: 100%;
    text-align: center;
}
.register_view .logo {
    background-image: url(http://clfile.zggen.cn/20250817/c7f4917b88074efa96eed5ca0b734ac4.webp);
    background-size: 100% 100%;
    width: 50px;
    height: 50px;
    margin: 0 auto;
}

.register_view .circle1 {
    position: absolute;
    left: 100px;
    top: 100px;
    background: #daf4dc;
    width: 200px;
    height: 200px;
    border-radius: 50%;
    z-index: 1;
    animation: float 4s ease-in-out infinite;
}

.register_view .circle2 {
    position: absolute;
    right: 100px;
    bottom: 100px;
    background: #EBEFD9;
    width: 300px;
    height: 300px;
    border-radius: 50%;
    z-index: 0;
    animation: float 5s ease-in-out infinite;
}
.register_view .form-circle1 {
    position: absolute;
    right: -34px;
    top: -32px;
    background: #dff6e9;
    width: 140px;
    height: 140px;
    border-radius: 50%;
    z-index: -1;
}

.register_view .form-circle2 {
    position: absolute;
    left: -34px;
    bottom: -32px;
    background: #f7efeb;
    width: 140px;
    height: 140px;
    border-radius: 50%;
    z-index: -1;
}


.register_view .register_form {
    text-align: left;
    display: flex;
    flex-direction: column;
    gap: 20px;
    margin-top: 20px;
    padding: 10px 0;
}

.register_view .list_item {
    display: flex;
    align-items: center;
    color: #000;
    background: #fff;
    padding: 8px 10px;
    border-radius: 6px;
    border: 1px solid #ccc;
}

.register_view .list_label {
    min-width: 100px;
    text-align: center;
}

.register_view .list_code {
    display: flex;
}

.register_view .list_code_item {display: flex;gap: 20px;}

.register_view .register {
    background: var(--theme);
    border: none;
    color: #fff;
    width: 80%;
    margin-top: 10px;
    height: 40px;
    font-size: 18px;
    border-radius: 6px;
}

.register_view .back {
    color: var(--theme);
    border: none;
    background: #fff;
    width: 100%;
    margin-top: 10px;
    line-height: 40px;
    font-size: 18px;
    border-radius: 6px;
    
    cursor: pointer;
}

.register_view .img {
    background: url(http://clfile.zggen.cn/20250817/80398b9b44024bfc8516fe0de27cacf6.webp);
    height: 100%;
    background-size: contain;
    background-repeat: no-repeat;
    background-color: #ebead6;
    flex: 1;
}

.register_view .upload-demo {
    width: 400px;
}

.register_view .el-input__wrapper {
    border: none!important;
    box-shadow: none!important;
}

.register_view .el-select__wrapper {
    border: none;
    box-shadow: none!important;
}

</style>