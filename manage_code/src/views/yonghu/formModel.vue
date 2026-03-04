<template>
	<div>
		<el-dialog modal-class="edit_form_modal" class="edit_form" v-model="formVisible" :title="formTitle" width="70%" destroy-on-close :fullscreen='false'>
			<el-form class="formModel_form" ref="formRef" :model="form" :rules="rules">
				<el-row >
					<el-col :span="12">
						<el-form-item label="用户账号" prop="yonghuzhanghao">
							<el-input class="list_inp" v-model="form.yonghuzhanghao" placeholder="用户账号"
								type="text" :readonly="!isAdd||disabledForm.yonghuzhanghao||form.id?true:false" />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="密码" prop="mima">
							<el-input class="list_inp" v-model="form.mima" placeholder="密码"
								type="password" :readonly="!isAdd||disabledForm.mima?true:false" />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="昵称" prop="nicheng">
							<el-input class="list_inp" v-model="form.nicheng" placeholder="昵称"
                                type="text"
								:readonly="!isAdd||disabledForm.nicheng?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="性别" prop="xingbie">
							<el-radio-group class="list_radio" v-model="form.xingbie">
								<el-radio v-for="item in xingbieLists" :label="item" :disabled="!isAdd||disabledForm.xingbie?true:false"
									size="large">{{item}}</el-radio>
							</el-radio-group>
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
						<el-form-item label="手机" prop="shouji">
							<el-input class="list_inp" v-model="form.shouji" placeholder="手机"
                                type="text"
								:readonly="!isAdd||disabledForm.shouji?true:false" />
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
	const tableName = 'yonghu'
	const formName = '用户'
	//基础信息
	//form表单
	const form = ref({})
	const disabledForm = ref({
        yonghuzhanghao : false,
        mima : false,
        nicheng : false,
        xingbie : false,
        touxiang : false,
        youxiang : false,
        shouji : false,
        shenfenzheng : false,
        zhuceshijian : false,
        maxPasswordWrong : false,
        isLocked : false,
        money : false,
	})
	const formVisible = ref(false)
	const isAdd = ref(false)
	const formTitle = ref('')
    
	const rules = ref({
		yonghuzhanghao: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		mima: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		nicheng: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		xingbie: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		touxiang: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		youxiang: [
			{required: true,message: '请输入',trigger: 'blur'}, 
			{ validator: context.$toolUtil.validator.email, trigger: 'blur' },
		],
		shouji: [
			{required: true,message: '请输入',trigger: 'blur'}, 
			{ validator: context.$toolUtil.validator.mobile, trigger: 'blur' },
		],
		shenfenzheng: [
			{required: true,message: '请输入',trigger: 'blur'}, 
			{ validator: context.$toolUtil.validator.idCard, trigger: 'blur' },
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
		money: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
	})
	//表单验证
	
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
	//性别列表
	const xingbieLists = ref([])
	//头像上传回调
	const touxiangUploadSuccess=(e)=>{
		form.value.touxiang = e
	}
	//获取唯一标识
	const getUUID =()=> {
      return new Date().getTime();
    }
	//重置
	const resetForm = () => {
		form.value = {
			yonghuzhanghao: '',
			mima: '',
			nicheng: '',
			xingbie: '',
			touxiang: '',
			youxiang: '',
			shouji: '',
			shenfenzheng: '',
			zhuceshijian: '',

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
				if(x=='yonghuzhanghao'){
					form.value.yonghuzhanghao = row[x];
					disabledForm.value.yonghuzhanghao = true;
					continue;
				}
				if(x=='mima'){
					form.value.mima = row[x];
					disabledForm.value.mima = true;
					continue;
				}
				if(x=='nicheng'){
					form.value.nicheng = row[x];
					disabledForm.value.nicheng = true;
					continue;
				}
				if(x=='xingbie'){
					form.value.xingbie = row[x];
					disabledForm.value.xingbie = true;
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
				if(x=='shouji'){
					form.value.shouji = row[x];
					disabledForm.value.shouji = true;
					continue;
				}
				if(x=='shenfenzheng'){
					form.value.shenfenzheng = row[x];
					disabledForm.value.shenfenzheng = true;
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
				if(x=='money'){
					form.value.money = row[x];
					disabledForm.value.money = true;
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
		xingbieLists.value = "男,女".split(',')
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

			}
		}
	}
</style>
