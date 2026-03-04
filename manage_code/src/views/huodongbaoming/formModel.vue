<template>
	<div>
		<el-dialog modal-class="edit_form_modal" class="edit_form" v-model="formVisible" :title="formTitle" width="70%" destroy-on-close :fullscreen='false'>
			<el-form class="formModel_form" ref="formRef" :model="form" :rules="rules">
				<el-row >
					<el-col :span="12">
						<el-form-item label="报名编号" prop="baomingbianhao">
							<el-input class="list_inp" v-model="form.baomingbianhao" :readonly="true" placeholder="报名编号" />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="活动名称" prop="huodongmingcheng">
							<el-input class="list_inp" v-model="form.huodongmingcheng" placeholder="活动名称"
                                type="text"
								:readonly="!isAdd||disabledForm.huodongmingcheng?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item prop="huodongtupian"
									  label="活动图片"
						>
							<uploads
								:disabled="!isAdd||disabledForm.huodongtupian?true:false"
								action="file/upload"
								tip="请上传活动图片"
								style="width: 100%;text-align: left;"
								:fileUrls="form.huodongtupian?form.huodongtupian:''" 
								@change="huodongtupianUploadSuccess">
							</uploads>
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="活动类型" prop="huodongleixing">
							<el-input class="list_inp" v-model="form.huodongleixing" placeholder="活动类型"
                                type="text"
								:readonly="!isAdd||disabledForm.huodongleixing?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="活动地点" prop="huodongdidian">
							<el-input class="list_inp" v-model="form.huodongdidian" placeholder="活动地点"
                                type="text"
								:readonly="!isAdd||disabledForm.huodongdidian?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="报名时间" prop="baomingshijian">
							<el-date-picker
								class="list_date"
								v-model="form.baomingshijian"
								format="YYYY-MM-DD HH:mm:ss"
								value-format="YYYY-MM-DD HH:mm:ss"
								type="datetime"
								:readonly="!isAdd||disabledForm.baomingshijian?true:false"
								placeholder="请选择报名时间" />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="用户账号" prop="yonghuzhanghao">
							<el-input class="list_inp" v-model="form.yonghuzhanghao" placeholder="用户账号"
                                type="text"
								:readonly="!isAdd||disabledForm.yonghuzhanghao?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="昵称" prop="nicheng">
							<el-input class="list_inp" v-model="form.nicheng" placeholder="昵称"
                                type="text"
								:readonly="!isAdd||disabledForm.nicheng?true:false" />
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
	const tableName = 'huodongbaoming'
	const formName = '活动报名'
	//基础信息
	//form表单
	const form = ref({})
	const disabledForm = ref({
        baomingbianhao : false,
        huodongmingcheng : false,
        huodongtupian : false,
        huodongleixing : false,
        shengyuminge : false,
        huodongdidian : false,
        baomingshijian : false,
        yonghuzhanghao : false,
        nicheng : false,
        crossuserid : false,
        crossrefid : false,
	})
	const formVisible = ref(false)
	const isAdd = ref(false)
	const formTitle = ref('')
    
	const rules = ref({
		baomingbianhao: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		huodongmingcheng: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		huodongtupian: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		huodongleixing: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		shengyuminge: [
			{required: true,message: '请输入',trigger: 'blur'}, 
			{ validator: context.$toolUtil.validator.intNumber, trigger: 'blur' },
		],
		huodongdidian: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		baomingshijian: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		yonghuzhanghao: [
		],
		nicheng: [
		],
		crossuserid: [
		],
		crossrefid: [
		],
	})
	//表单验证
	
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
	//活动图片上传回调
	const huodongtupianUploadSuccess=(e)=>{
		form.value.huodongtupian = e
	}
	//获取唯一标识
	const getUUID =()=> {
      return new Date().getTime();
    }
	//重置
	const resetForm = () => {
		form.value = {
			baomingbianhao: getUUID(),
			huodongmingcheng: '',
			huodongtupian: '',
			huodongleixing: '',
			shengyuminge: '1',
			huodongdidian: '',
			baomingshijian: '',
			yonghuzhanghao: '',
			nicheng: '',
			crossuserid: '',
			crossrefid: '',

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
			form.value.baomingshijian = context?.$toolUtil.getCurDateTime()
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
				if(x=='baomingbianhao'){
					form.value.baomingbianhao = row[x];
					disabledForm.value.baomingbianhao = true;
					continue;
				}
				if(x=='huodongmingcheng'){
					form.value.huodongmingcheng = row[x];
					disabledForm.value.huodongmingcheng = true;
					continue;
				}
				if(x=='huodongtupian'){
					form.value.huodongtupian = row[x];
					disabledForm.value.huodongtupian = true;
					continue;
				}
				if(x=='huodongleixing'){
					form.value.huodongleixing = row[x];
					disabledForm.value.huodongleixing = true;
					continue;
				}
				if(x=='shengyuminge'){
					form.value.shengyuminge = row[x];
					disabledForm.value.shengyuminge = true;
					continue;
				}
				if(x=='huodongdidian'){
					form.value.huodongdidian = row[x];
					disabledForm.value.huodongdidian = true;
					continue;
				}
				if(x=='baomingshijian'){
					form.value.baomingshijian = row[x];
					disabledForm.value.baomingshijian = true;
					continue;
				}
				if(x=='yonghuzhanghao'){
					form.value.yonghuzhanghao = row[x];
					disabledForm.value.yonghuzhanghao = true;
					continue;
				}
				if(x=='nicheng'){
					form.value.nicheng = row[x];
					disabledForm.value.nicheng = true;
					continue;
				}
				if(x=='crossuserid'){
					form.value.crossuserid = row[x];
					disabledForm.value.crossuserid = true;
					continue;
				}
				if(x=='crossrefid'){
					form.value.crossrefid = row[x];
					disabledForm.value.crossrefid = true;
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
			form.value.shengyuminge='1'
			formVisible.value = true
		}
		context?.$http({
			url: `${context?.$toolUtil.storageGet('sessionTable')}/session`,
			method: 'get'
		}).then(res => {
			var json = res.data.data
			if(context?.$toolUtil.storageGet("sessionTable")!="users" && !context?.$toolUtil.storageGet("isAdmin")) {
				disabledForm.value.shengyuminge = true;
			}
			if(json.hasOwnProperty('yonghuzhanghao')&& context?.$toolUtil.storageGet("sessionTable")!="users"){
				form.value.yonghuzhanghao = json.yonghuzhanghao
				disabledForm.value.yonghuzhanghao = true;
			}
			if(json.hasOwnProperty('nicheng')&& context?.$toolUtil.storageGet("sessionTable")!="users"){
				form.value.nicheng = json.nicheng
				disabledForm.value.nicheng = true;
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
		if(form.value.huodongtupian!=null) {
			form.value.huodongtupian = form.value.huodongtupian.replace(new RegExp(context?.$config.url,"g"),"");
		}
		var table = crossTable.value
		var objcross = JSON.parse(JSON.stringify(crossRow.value))
		if(objcross!='') {
            if(form.value.shengyuminge==0){
                return context.$message.error('剩余名额不能为空')
            }
			objcross.shengyuminge = objcross.shengyuminge - form.value.shengyuminge
			if(objcross.shengyuminge<0){
				context?.$toolUtil.message('剩余名额不足','error')
				return false
			}
		}
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
								//修改跨表数据
								await changeCrossData(objcross,'shengyuminge')
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
						//修改跨表数据
						await changeCrossData(objcross,'shengyuminge')
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
