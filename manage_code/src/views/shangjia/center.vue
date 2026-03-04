<template>
	<div>
		<div class="center_view edit_form">
			<el-form class="userinfo_form" ref="userinfoFormRef" :model="form">
				<el-row>
					<el-col :span="12">
						<el-form-item label="商家账号" prop="shangjiazhanghao">
							<el-input class="list_inp" v-model="user.shangjiazhanghao" readonly placeholder="商家账号" clearable />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="商家名称" prop="shangjiamingcheng">
							<el-input class="list_inp" v-model="user.shangjiamingcheng"  placeholder="商家名称" clearable />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="头像" prop="touxiang">
							<uploads
								action="file/upload" 
								tip="请上传头像"
								style="width: 100%;text-align: left;"
								:fileUrls="user.touxiang?user.touxiang:''" 
								@change="shangjiatouxiangUploadSuccess">
							</uploads>
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="邮箱" prop="youxiang">
							<el-input class="list_inp" v-model="user.youxiang"  placeholder="邮箱" clearable />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="联系方式" prop="lianxifangshi">
							<el-input class="list_inp" v-model="user.lianxifangshi"  placeholder="联系方式" clearable />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="身份证" prop="shenfenzheng">
							<el-input class="list_inp" v-model="user.shenfenzheng"  placeholder="身份证" clearable />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="营业资质" prop="yingyezizhi">
							<uploads
								type="file"
								action="file/upload" 
								tip="请上传营业资质" 
								:limit="3" 
								style="width: 100%;text-align: left;"
								:fileUrls="user.yingyezizhi?user.yingyezizhi:''" 
								@change="shangjiayingyezizhiUploadSuccess">
							</uploads>
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
                    <el-col :span="12">
                        <el-form-item prop="fulladdress" label="地址">
                            <input class="list_inp"
                                   v-model="user.fulladdress"
                                   placeholder="请输入地址"
                                   type="text"
                                   readonly
                                   @click.native="mapClick"
                            />
                        </el-form-item>
                    </el-col>
					<span class="formModel_btn_box">
						<el-button class='confirm_btn' type="primary" @click="onSubmit">保存</el-button>
					</span>
				</el-row>
			</el-form>
		</div>
        <locationForm ref="locationRef" v-model="user" :position="user" @mapData="getAddress"></locationForm>
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
	const tableName = ref('shangjia')
	const user = ref({})
    import locationForm from '@/components/common/location.vue'

    const locationRef = ref(null)
    const mapClick = () => {
		locationRef.value.mapShow()
    }

    const getAddress = (e) => {
        user.value.longitude = e.lng
        user.value.latitude = e.lat
        user.value.fulladdress = e.fulladdress
    }
	const init = () => {
	}
	const shangjiatouxiangUploadSuccess=(fileUrls)=> {
	    user.value.touxiang = fileUrls;
	}
	const shangjiayingyezizhiUploadSuccess=(fileUrls)=> {
	    user.value.yingyezizhi = fileUrls;
	}
	const onSubmit = () => {
		if((!user.value.shangjiazhanghao)){
			context?.$toolUtil.message(`商家账号不能为空`,'error')
			return false
		}
		if((!user.value.shangjiamima)){
			context?.$toolUtil.message(`商家密码不能为空`,'error')
			return false
		}
		if((!user.value.shangjiamingcheng)){
			context?.$toolUtil.message(`商家名称不能为空`,'error')
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
		if((!user.value.lianxifangshi)){
			context?.$toolUtil.message(`联系方式不能为空`,'error')
			return false
		}
		if((user.value.lianxifangshi)&&(!context?.$toolUtil.isMobile(user.value.lianxifangshi))){
			context?.$toolUtil.message(`联系方式应输入手机格式`,'error')
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
		if(user.value.yingyezizhi!=null){
			user.value.yingyezizhi = user.value.yingyezizhi.replace(new RegExp(context?.$config.url,"g"),"");
		}
		if((user.value.maxPasswordWrong)&&(!context?.$toolUtil.isIntNumer(user.value.maxPasswordWrong))){
			context?.$toolUtil.message(`最大密码输错次数应输入整数`,'error')
			return false
		}
		if((user.value.isLocked)&&(!context?.$toolUtil.isIntNumer(user.value.isLocked))){
			context?.$toolUtil.message(`用户锁定状态应输入整数`,'error')
			return false
		}
		if((user.value.longitude)&&(!context?.$toolUtil.isNumber(user.value.longitude))){
			context?.$toolUtil.message(`经度应输入数字`,'error')
			return false
		}
		if((user.value.latitude)&&(!context?.$toolUtil.isNumber(user.value.latitude))){
			context?.$toolUtil.message(`纬度应输入数字`,'error')
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
			//文件上传样式
			.upload-demo {
				width: 100%;
			}
		}
	}
</style>
