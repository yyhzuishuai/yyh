<template>
	<div>
		<el-dialog modal-class="edit_form_modal" class="edit_form" v-model="formVisible" :title="formTitle" width="70%" destroy-on-close :fullscreen='false'>
			<el-form class="formModel_form" ref="formRef" :model="form" :rules="rules">
				<el-row >
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
							<el-select
								class="list_sel"
								:disabled="!isAdd||disabledForm.huodongleixing?true:false"
								v-model="form.huodongleixing" 
								placeholder="请选择活动类型"
								>
								<el-option v-for="(item,index) in huodongleixingLists" :label="item"
									:value="item"
									>
								</el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="参加形式" prop="canjiaxingshi">
							<el-select
								class="list_sel"
								:disabled="!isAdd||disabledForm.canjiaxingshi?true:false"
								v-model="form.canjiaxingshi" 
								placeholder="请选择参加形式"
								>
								<el-option v-for="(item,index) in canjiaxingshiLists" :label="item"
									:value="item"
									>
								</el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="开始时间" prop="kaishishijian">
							<el-date-picker
								class="list_date"
								v-model="form.kaishishijian"
								format="YYYY-MM-DD HH:mm:ss"
								value-format="YYYY-MM-DD HH:mm:ss"
								type="datetime"
								:readonly="!isAdd||disabledForm.kaishishijian?true:false"
								placeholder="请选择开始时间" />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="结束时间" prop="jieshushijian">
							<el-date-picker
								class="list_date"
								v-model="form.jieshushijian"
								format="YYYY-MM-DD HH:mm:ss"
								value-format="YYYY-MM-DD HH:mm:ss"
								type="datetime"
								:readonly="!isAdd||disabledForm.jieshushijian?true:false"
								placeholder="请选择结束时间" />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="剩余名额" prop="shengyuminge">
							<el-input class="list_inp" v-model.number="form.shengyuminge" placeholder="剩余名额"
                                type="text"
								:readonly="!isAdd||disabledForm.shengyuminge?true:false" />
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
						<el-form-item label="发布时间" prop="fabushijian">
							<el-date-picker
								class="list_date"
								v-model="form.fabushijian"
								format="YYYY-MM-DD HH:mm:ss"
								value-format="YYYY-MM-DD HH:mm:ss"
								type="datetime"
								:readonly="!isAdd||disabledForm.fabushijian?true:false"
								placeholder="请选择发布时间" />
						</el-form-item>
					</el-col>
					<el-col :span="24">
						<el-form-item label="注意事项" prop="zhuyishixiang">
							<el-input v-model="form.zhuyishixiang" placeholder="注意事项" type="textarea"
							:readonly="!isAdd||disabledForm.zhuyishixiang?true:false"
							/>
						</el-form-item>
					</el-col>
					<el-col :span="24">
						<el-form-item label="活动内容" prop="huodongneirong">
							<editor :value="form.huodongneirong" placeholder="请输入活动内容"
							   	:readonly="!isAdd||disabledForm.huodongneirong?true:false" :key="!isAdd"
								class="list_editor" @change="(e)=>editorChange(e,'huodongneirong')"></editor>
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
	const tableName = 'dongmanzhutihuodong'
	const formName = '动漫主题活动'
	//基础信息
	//form表单
	const form = ref({})
	const disabledForm = ref({
        huodongmingcheng : false,
        huodongtupian : false,
        huodongleixing : false,
        canjiaxingshi : false,
        kaishishijian : false,
        jieshushijian : false,
        shengyuminge : false,
        huodongdidian : false,
        huodongneirong : false,
        zhuyishixiang : false,
        fabushijian : false,
	})
	const formVisible = ref(false)
	const isAdd = ref(false)
	const formTitle = ref('')
    
	const rules = ref({
		huodongmingcheng: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		huodongtupian: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		huodongleixing: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		canjiaxingshi: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		kaishishijian: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		jieshushijian: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		shengyuminge: [
			{required: true,message: '请输入',trigger: 'blur'}, 
			{ validator: context.$toolUtil.validator.intNumber, trigger: 'blur' },
		],
		huodongdidian: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		huodongneirong: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		zhuyishixiang: [
		],
		fabushijian: [
			{required: true,message: '请输入',trigger: 'blur'}, 
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
	//活动类型列表
	const huodongleixingLists = ref([])
	//参加形式列表
	const canjiaxingshiLists = ref([])
	//获取唯一标识
	const getUUID =()=> {
      return new Date().getTime();
    }
	//重置
	const resetForm = () => {
		form.value = {
			huodongmingcheng: '',
			huodongtupian: '',
			huodongleixing: '',
			canjiaxingshi: '',
			kaishishijian: '',
			jieshushijian: '',
			shengyuminge: '',
			huodongdidian: '',
			huodongneirong: '',
			zhuyishixiang: '',
			fabushijian: '',

		}
	}
	//获取info
	const getInfo = ()=>{
		context?.$http({
			url: `${tableName}/info/${id.value}`,
			method: 'get'
		}).then(res => {
			let reg=new RegExp('../../../file','g')
			res.data.data.huodongneirong = res.data.data.huodongneirong?(res.data.data.huodongneirong.replace(reg,'../../../cl445746174/file')):'';
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
			form.value.fabushijian = context?.$toolUtil.getCurDateTime()
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
				if(x=='canjiaxingshi'){
					form.value.canjiaxingshi = row[x];
					disabledForm.value.canjiaxingshi = true;
					continue;
				}
				if(x=='kaishishijian'){
					form.value.kaishishijian = row[x];
					disabledForm.value.kaishishijian = true;
					continue;
				}
				if(x=='jieshushijian'){
					form.value.jieshushijian = row[x];
					disabledForm.value.jieshushijian = true;
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
				if(x=='huodongneirong'){
					form.value.huodongneirong = row[x];
					disabledForm.value.huodongneirong = true;
					continue;
				}
				if(x=='zhuyishixiang'){
					form.value.zhuyishixiang = row[x];
					disabledForm.value.zhuyishixiang = true;
					continue;
				}
				if(x=='fabushijian'){
					form.value.fabushijian = row[x];
					disabledForm.value.fabushijian = true;
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
		})
		context?.$http({
			url: `option/huodongleixing/huodongleixing`,
			method: 'get',
		}).then(res=>{
			huodongleixingLists.value = res.data.data
		})
		canjiaxingshiLists.value = "线上,线下".split(',')
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
