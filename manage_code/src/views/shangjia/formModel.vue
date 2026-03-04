<template>
	<div>
		<el-dialog modal-class="edit_form_modal" class="edit_form" v-model="formVisible" :title="formTitle" width="70%" destroy-on-close :fullscreen='false'>
			<el-form class="formModel_form" ref="formRef" :model="form" :rules="rules">
				<el-row >
					<el-col :span="12">
						<el-form-item label="商家账号" prop="shangjiazhanghao">
							<el-input class="list_inp" v-model="form.shangjiazhanghao" placeholder="商家账号"
								type="text" :readonly="!isAdd||disabledForm.shangjiazhanghao||form.id?true:false" />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="商家密码" prop="shangjiamima">
							<el-input class="list_inp" v-model="form.shangjiamima" placeholder="商家密码"
								type="password" :readonly="!isAdd||disabledForm.shangjiamima?true:false" />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="商家名称" prop="shangjiamingcheng">
							<el-input class="list_inp" v-model="form.shangjiamingcheng" placeholder="商家名称"
                                type="text"
								:readonly="!isAdd||disabledForm.shangjiamingcheng?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item prop="touxiang"
									  label="头像"
						>
							<uploads
								:disabled="!isAdd||disabledForm.touxiang?true:false"
								action="file/upload"
								tip="请上传头像"
								style="width: 100%;text-align: left;"
								:fileUrls="form.touxiang?form.touxiang:''" 
								@change="touxiangUploadSuccess">
							</uploads>
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="邮箱" prop="youxiang">
							<el-input class="list_inp" v-model="form.youxiang" placeholder="邮箱"
                                type="text"
								:readonly="!isAdd||disabledForm.youxiang?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="联系方式" prop="lianxifangshi">
							<el-input class="list_inp" v-model="form.lianxifangshi" placeholder="联系方式"
                                type="text"
								:readonly="!isAdd||disabledForm.lianxifangshi?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="身份证" prop="shenfenzheng">
							<el-input class="list_inp" v-model="form.shenfenzheng" placeholder="身份证"
                                type="text"
								:readonly="!isAdd||disabledForm.shenfenzheng?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="营业资质" prop="yingyezizhi">
							<uploads
								:disabled="!isAdd||disabledForm.yingyezizhi?true:false"
								type="file"
								action="file/upload" 
								tip="请上传营业资质" 
								:limit="1" 
								style="width: 100%;text-align: left;"
								:fileUrls="form.yingyezizhi?form.yingyezizhi:''" 
								@change="yingyezizhiUploadSuccess">
							</uploads>
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="注册时间" prop="zhuceshijian">
							<el-date-picker
								class="list_date"
								v-model="form.zhuceshijian"
								format="YYYY-MM-DD HH:mm:ss"
								value-format="YYYY-MM-DD HH:mm:ss"
								type="datetime"
								:readonly="!isAdd||disabledForm.zhuceshijian?true:false"
								placeholder="请选择注册时间" />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="地址" prop="fulladdress">
							<el-input class="list_inp" v-model="form.fulladdress" placeholder="地址" readonly @click.native="mapClick" />
						</el-form-item>
					</el-col>

				</el-row>
			</el-form>
			<template #footer v-if="isAdd||type=='logistics'||type=='reply'">
				<span class="formModel_btn_box">
					<el-button class="cancel_btn" @click="closeClick">取消</el-button>
					<el-button class="confirm_btn" type="primary" @click="save"
						>
						提交
					</el-button>
				</span>
			</template>
		</el-dialog>
		<locationForm ref="locationRef" v-model="form" :position="form" @mapData="getAddress"></locationForm>
	</div>
</template>
<script setup>
	import {
		reactive,
		ref,
		getCurrentInstance,
		nextTick,
		computed,
		defineEmits
	} from 'vue'
    import {
        useStore
    } from 'vuex';
	const moment = window.moment
    const store = useStore()
    const user = computed(()=>store.getters['user/session'])
	const context = getCurrentInstance()?.appContext.config.globalProperties;	
	const emit = defineEmits(['formModelChange'])
	//基础信息
	const tableName = 'shangjia'
	const formName = '商家'
	//基础信息
	import locationForm from '@/components/common/location.vue'
	const locationRef = ref(null)
	const mapClick = () => {
		if(!isAdd.value||disabledForm.fulladdress){
			return false
		}
		locationRef.value.mapShow()
	}
	const getAddress = (e) => {
		form.value.longitude = e.lng
		form.value.latitude = e.lat
		form.value.fulladdress = e.fulladdress
	}
	//form表单
	const form = ref({})
	const disabledForm = ref({
        shangjiazhanghao : false,
        shangjiamima : false,
        shangjiamingcheng : false,
        touxiang : false,
        youxiang : false,
        lianxifangshi : false,
        shenfenzheng : false,
        yingyezizhi : false,
        sfsh : false,
        shhf : false,
        zhuceshijian : false,
        maxPasswordWrong : false,
        isLocked : false,
        longitude : false,
        latitude : false,
        fulladdress : false,
	})
	const formVisible = ref(false)
	const isAdd = ref(false)
	const formTitle = ref('')
    
	const rules = ref({
		shangjiazhanghao: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		shangjiamima: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		shangjiamingcheng: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		touxiang: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		youxiang: [
			{required: true,message: '请输入',trigger: 'blur'}, 
			{ validator: context.$toolUtil.validator.email, trigger: 'blur' },
		],
		lianxifangshi: [
			{required: true,message: '请输入',trigger: 'blur'}, 
			{ validator: context.$toolUtil.validator.mobile, trigger: 'blur' },
		],
		shenfenzheng: [
			{required: true,message: '请输入',trigger: 'blur'}, 
			{ validator: context.$toolUtil.validator.idCard, trigger: 'blur' },
		],
		yingyezizhi: [
		],
		sfsh: [
		],
		shhf: [
		],
		zhuceshijian: [
		],
		maxPasswordWrong: [
			{required: true,message: '请输入',trigger: 'blur'}, 
			{ validator: context.$toolUtil.validator.intNumber, trigger: 'blur' },
		],
		isLocked: [
			{required: true,message: '请输入',trigger: 'blur'}, 
			{ validator: context.$toolUtil.validator.intNumber, trigger: 'blur' },
		],
		longitude: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
		latitude: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
		fulladdress: [
		],
	})
	//表单验证
	
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
	//头像上传回调
	const touxiangUploadSuccess=(e)=>{
		form.value.touxiang = e
	}
	//营业资质上传回调
	const yingyezizhiUploadSuccess=(e)=>{
		form.value.yingyezizhi = e
	}
	//获取唯一标识
	const getUUID =()=> {
      return new Date().getTime();
    }
	//重置
	const resetForm = () => {
		form.value = {
			shangjiazhanghao: '',
			shangjiamima: '',
			shangjiamingcheng: '',
			touxiang: '',
			youxiang: '',
			lianxifangshi: '',
			shenfenzheng: '',
			yingyezizhi: '',
			shhf: '',
			zhuceshijian: '',
			longitude: '',
			latitude: '',
			fulladdress: '',

		}
	}
	//获取info
	const getInfo = ()=>{
		context?.$http({
			url: `${tableName}/info/${id.value}`,
			method: 'get'
		}).then(res => {
			let reg=new RegExp('../../../file','g')
			form.value = res.data.data
			formVisible.value = true
		})
	}
	const crossRow = ref('')
	const crossTable = ref('')
	const crossTips = ref('')
	const crossColumnName = ref('')
	const crossColumnValue = ref('')
	//初始化
	const init=(formId=null,formType='add',formNames='',row=null,table=null,statusColumnName=null,tips=null,statusColumnValue=null)=>{
		resetForm()
			form.value.zhuceshijian = context?.$toolUtil.getCurDateTime()
		if(formId){
			id.value = formId
			type.value = formType
		}
		if(formType == 'add'){
			isAdd.value = true
			formTitle.value = '新增' + formName
			formVisible.value = true
		}else if(formType == 'info'){
			isAdd.value = false
			formTitle.value = '查看' + formName
			getInfo()
		}else if(formType == 'edit'){
			isAdd.value = true
			formTitle.value = '修改' + formName
			getInfo()
		}
		else if(formType == 'cross'){
			isAdd.value = true
			formTitle.value = formNames
			// getInfo()
			for(let x in row){
				if(x=='shangjiazhanghao'){
					form.value.shangjiazhanghao = row[x];
					disabledForm.value.shangjiazhanghao = true;
					continue;
				}
				if(x=='shangjiamima'){
					form.value.shangjiamima = row[x];
					disabledForm.value.shangjiamima = true;
					continue;
				}
				if(x=='shangjiamingcheng'){
					form.value.shangjiamingcheng = row[x];
					disabledForm.value.shangjiamingcheng = true;
					continue;
				}
				if(x=='touxiang'){
					form.value.touxiang = row[x];
					disabledForm.value.touxiang = true;
					continue;
				}
				if(x=='youxiang'){
					form.value.youxiang = row[x];
					disabledForm.value.youxiang = true;
					continue;
				}
				if(x=='lianxifangshi'){
					form.value.lianxifangshi = row[x];
					disabledForm.value.lianxifangshi = true;
					continue;
				}
				if(x=='shenfenzheng'){
					form.value.shenfenzheng = row[x];
					disabledForm.value.shenfenzheng = true;
					continue;
				}
				if(x=='yingyezizhi'){
					form.value.yingyezizhi = row[x];
					disabledForm.value.yingyezizhi = true;
					continue;
				}
				if(x=='zhuceshijian'){
					form.value.zhuceshijian = row[x];
					disabledForm.value.zhuceshijian = true;
					continue;
				}
				if(x=='maxPasswordWrong'){
					form.value.maxPasswordWrong = row[x];
					disabledForm.value.maxPasswordWrong = true;
					continue;
				}
				if(x=='isLocked'){
					form.value.isLocked = row[x];
					disabledForm.value.isLocked = true;
					continue;
				}
				if(x=='longitude'){
					form.value.longitude = row[x];
					disabledForm.value.longitude = true;
					continue;
				}
				if(x=='latitude'){
					form.value.latitude = row[x];
					disabledForm.value.latitude = true;
					continue;
				}
				if(x=='fulladdress'){
					form.value.fulladdress = row[x];
					disabledForm.value.fulladdress = true;
					continue;
				}
			}
			if(row){
				crossRow.value = row
			}
			if(table){
				crossTable.value = table
			}
			if(tips){
				crossTips.value = tips
			}
			if(statusColumnName){
				crossColumnName.value = statusColumnName
			}
			if(statusColumnValue){
				crossColumnValue.value = statusColumnValue
			}
			formVisible.value = true
		}
		context?.$http({
			url: `${context?.$toolUtil.storageGet('sessionTable')}/session`,
			method: 'get'
		}).then(res => {
			var json = res.data.data
			if(context?.$toolUtil.storageGet("sessionTable")!="users" && !context?.$toolUtil.storageGet("isAdmin")) {
				disabledForm.value.zhuceshijian = true;
			}
		})
	}
	//初始化
	//声明父级调用
	defineExpose({
		init
	})
	//关闭
	const closeClick = () => {
		formVisible.value = false
	}
	//富文本
	const editorChange = (e,name) =>{
		form.value[name] = e
	}
	//提交
	const save= async ()=>{
		if(form.value.touxiang!=null) {
			form.value.touxiang = form.value.touxiang.replace(new RegExp(context?.$config.url,"g"),"");
		}
		if(form.value.yingyezizhi!=null) {
			form.value.yingyezizhi = form.value.yingyezizhi.replace(new RegExp(context?.$config.url,"g"),"");
		}
		var table = crossTable.value
		var objcross = JSON.parse(JSON.stringify(crossRow.value))
		let crossUserId = ''
		let crossRefId = ''
		let crossOptNum = ''
		formRef.value.validate(async (valid)=>{
			if(valid){
				if(type.value == 'cross'){
					if(crossColumnName.value!=''){
						if(!crossColumnName.value.startsWith('[')){
							for(let o in objcross){
								if(o == crossColumnName.value){
									objcross[o] = crossColumnValue.value
								}
							}
							//修改跨表数据
							await changeCrossData(objcross)
						}else{
							crossUserId = user.value.id
							crossRefId = objcross['id']
							crossOptNum = crossColumnName.value.replace(/\[/,"").replace(/\]/,"")
						}
					}
				}
				if(crossUserId&&crossRefId){
					form.value.crossuserid = crossUserId
					form.value.crossrefid = crossRefId
					let params = {
						page: 1,
						limit: 1000, 
						crossuserid:form.value.crossuserid,
						crossrefid:form.value.crossrefid,
					}
					context?.$http({
						url: `${tableName}/page`,
						method: 'get', 
						params: params 
					}).then(async (res)=>{
						if(res.data.data.total>=crossOptNum){
							context?.$toolUtil.message(`${crossTips.value}`,'error')
							return false
						}else{
							context?.$http({
								url: `${tableName}/${!form.value.id ? "save" : "update"}`,
								method: 'post', 
								data: form.value 
							}).then(async res=>{
								emit('formModelChange')
								context?.$toolUtil.message(`操作成功`,'success')
                                formVisible.value = false
							})
						}
					})
				}else{
					context?.$http({
						url: `${tableName}/${!form.value.id ? "save" : "update"}`,
						method: 'post', 
						data: form.value 
					}).then(async (res)=>{
						emit('formModelChange')
						context?.$toolUtil.message(`操作成功`,'success')
                        formVisible.value = false
					})
				}
			}else{
                context.$message.error('请完善信息')
            }
		})
	}
	//修改跨表数据
	const changeCrossData = async (row,key)=>{
        if(type.value == 'cross'){
			let data = row
			if(key){	//如果有指定key，则只更新key属性
				data = {
					id:row.id,
				}
				data[key] = row[key]
			}
            await context?.$http({
                url: `${crossTable.value}/update`,
                method: 'post',
                data: data
            }).then(res=>{})
        }
	}
</script>
<style lang="scss" scoped>
	// 表单
	.formModel_form{
		:deep(.el-form-item) {
			.el-form-item__content {

				//文件上传样式
				.upload-demo {
					width: 100%;
				}
			}
		}
	}
</style>
