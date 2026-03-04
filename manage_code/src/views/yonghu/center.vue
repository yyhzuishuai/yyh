<template>
	<div>
		<div class="center_view edit_form">
			<el-form class="userinfo_form" ref="userinfoFormRef" :model="form">
				<el-row>
					<el-col :span="12">
						<el-form-item label="用户账号" prop="yonghuzhanghao">
							<el-input class="list_inp" v-model="user.yonghuzhanghao" readonly placeholder="用户账号" clearable />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="昵称" prop="nicheng">
							<el-input class="list_inp" v-model="user.nicheng"  placeholder="昵称" clearable />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="性别" prop="xingbie">
							<el-radio-group class="list_radio" v-model="user.xingbie">
								<el-radio v-for="item in yonghuxingbieLists" :label="item"
									size="large">{{item}}</el-radio>
							</el-radio-group>
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="头像" prop="touxiang">
							<uploads
								action="file/upload" 
								tip="请上传头像"
								style="width: 100%;text-align: left;"
								:fileUrls="user.touxiang?user.touxiang:''" 
								@change="yonghutouxiangUploadSuccess">
							</uploads>
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="邮箱" prop="youxiang">
							<el-input class="list_inp" v-model="user.youxiang"  placeholder="邮箱" clearable />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="手机" prop="shouji">
							<el-input class="list_inp" v-model="user.shouji"  placeholder="手机" clearable />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="身份证" prop="shenfenzheng">
							<el-input class="list_inp" v-model="user.shenfenzheng"  placeholder="身份证" clearable />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="注册时间" prop="zhuceshijian">
							<el-date-picker
								class="list_date"
								v-model="user.zhuceshijian"
								format="YYYY-MM-DD HH:mm:ss"
								value-format="YYYY-MM-DD HH:mm:ss"
								type="datetime"
								placeholder="注册时间" />
						</el-form-item>
					</el-col>
					<span class="formModel_btn_box">
						<el-button class='confirm_btn' type="primary" @click="onSubmit">保存</el-button>
					</span>
				</el-row>
			</el-form>
		</div>
	</div>
</template>

<script setup>
	import { isNumber,isIntNumer,isEmail,isMobile,isPhone,isURL,checkIdCard } from "@/utils/toolUtil";
	import {
		reactive,
		ref,
		getCurrentInstance,
        computed
	} from 'vue'
	import { useStore } from 'vuex'
	const store = useStore()
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const tableName = ref('yonghu')
	const user = ref({})
	const yonghuxingbieLists = ref([])
	const init = () => {
		yonghuxingbieLists.value = "男,女".split(',')
	}
	const yonghutouxiangUploadSuccess=(fileUrls)=> {
	    user.value.touxiang = fileUrls;
	}
	const onSubmit = () => {
		if((!user.value.yonghuzhanghao)){
			context?.$toolUtil.message(`用户账号不能为空`,'error')
			return false
		}
		if((!user.value.mima)){
			context?.$toolUtil.message(`密码不能为空`,'error')
			return false
		}
		if((!user.value.nicheng)){
			context?.$toolUtil.message(`昵称不能为空`,'error')
			return false
		}
		if((!user.value.xingbie)){
			context?.$toolUtil.message(`性别不能为空`,'error')
			return false
		}
		if((!user.value.touxiang)){
			context?.$toolUtil.message(`头像不能为空`,'error')
			return false
		}
		if(user.value.touxiang!=null){
			user.value.touxiang = user.value.touxiang.replace(new RegExp(context?.$config.url,"g"),"");
		}
		if((!user.value.youxiang)){
			context?.$toolUtil.message(`邮箱不能为空`,'error')
			return false
		}
		if((user.value.youxiang)&&(!context?.$toolUtil.isEmail(user.value.youxiang))){
			context?.$toolUtil.message(`邮箱应输入邮箱格式`,'error')
			return false
		}
		if((!user.value.shouji)){
			context?.$toolUtil.message(`手机不能为空`,'error')
			return false
		}
		if((user.value.shouji)&&(!context?.$toolUtil.isMobile(user.value.shouji))){
			context?.$toolUtil.message(`手机应输入手机格式`,'error')
			return false
		}
		if((!user.value.shenfenzheng)){
			context?.$toolUtil.message(`身份证不能为空`,'error')
			return false
		}
		if((user.value.shenfenzheng)&&(!context?.$toolUtil.checkIdCard(user.value.shenfenzheng))){
			context?.$toolUtil.message(`身份证应输入身份证格式`,'error')
			return false
		}
		if((user.value.maxPasswordWrong)&&(!context?.$toolUtil.isIntNumer(user.value.maxPasswordWrong))){
			context?.$toolUtil.message(`最大密码输错次数应输入整数`,'error')
			return false
		}
		if((user.value.isLocked)&&(!context?.$toolUtil.isIntNumer(user.value.isLocked))){
			context?.$toolUtil.message(`用户锁定状态应输入整数`,'error')
			return false
		}
		if((user.value.money)&&(!context?.$toolUtil.isNumber(user.value.money))){
			context?.$toolUtil.message(`余额应输入数字`,'error')
			return false
		}
		store.dispatch('user/update',user.value).then(res=>{
			if(res?.data&&res.data.code==0)context?.$toolUtil.message('修改成功','success')
		})

	}
	const getInfo = () => {
		context?.$http({
			url: `${tableName.value}/session`,
			method: 'get'
		}).then(res => {
			user.value = res.data.data
			init()
		})
	}
	getInfo()
</script>

<style lang="scss" scoped>
	// 表单
	.userinfo_form {
		:deep(.el-form-item) {
		}
	}
</style>
