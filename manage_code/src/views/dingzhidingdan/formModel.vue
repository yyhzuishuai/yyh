<template>
	<div>
		<el-dialog modal-class="edit_form_modal" class="edit_form" v-model="formVisible" :title="formTitle" width="70%" destroy-on-close :fullscreen='false'>
			<el-form class="formModel_form" ref="formRef" :model="form" :rules="rules">
				<el-row >
					<el-col :span="12">
						<el-form-item label="订单编号" prop="dingdanbianhao">
							<el-input class="list_inp" v-model="form.dingdanbianhao" :readonly="true" placeholder="订单编号" />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="周边名称" prop="zhoubianmingcheng">
							<el-input class="list_inp" v-model="form.zhoubianmingcheng" placeholder="周边名称"
                                type="text"
								:readonly="!isAdd||disabledForm.zhoubianmingcheng?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item prop="shejituan"
									  label="设计图案"
						>
							<uploads
								:disabled="!isAdd||disabledForm.shejituan?true:false"
								action="file/upload"
								tip="请上传设计图案"
								style="width: 100%;text-align: left;"
								:fileUrls="form.shejituan?form.shejituan:''" 
								@change="shejituanUploadSuccess">
							</uploads>
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="周边类型" prop="zhoubianleixing">
							<el-select
								class="list_sel"
								:disabled="!isAdd||disabledForm.zhoubianleixing?true:false"
								v-model="form.zhoubianleixing" 
								placeholder="请选择周边类型"
								>
								<el-option v-for="(item,index) in zhoubianleixingLists" :label="item"
									:value="item"
									>
								</el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="颜色" prop="yanse">
							<el-input class="list_inp" v-model="form.yanse" placeholder="颜色"
                                type="text"
								:readonly="!isAdd||disabledForm.yanse?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="尺寸" prop="chicun">
							<el-input class="list_inp" v-model="form.chicun" placeholder="尺寸"
                                type="text"
								:readonly="!isAdd||disabledForm.chicun?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="材质" prop="caizhi">
							<el-input class="list_inp" v-model="form.caizhi" placeholder="材质"
                                type="text"
								:readonly="!isAdd||disabledForm.caizhi?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="商家账号" prop="shangjiazhanghao">
							<el-input class="list_inp" v-model="form.shangjiazhanghao" placeholder="商家账号"
                                type="text"
								:readonly="!isAdd||disabledForm.shangjiazhanghao?true:false" />
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

					<el-col :span="24">
						<el-form-item label="设计描述" prop="shejimiaoshu">
							<editor :value="form.shejimiaoshu" placeholder="请输入设计描述"
							   	:readonly="!isAdd||disabledForm.shejimiaoshu?true:false" :key="!isAdd"
								class="list_editor" @change="(e)=>editorChange(e,'shejimiaoshu')"></editor>
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
	const tableName = 'dingzhidingdan'
	const formName = '定制订单'
	//基础信息
	//form表单
	const form = ref({})
	const disabledForm = ref({
        dingdanbianhao : false,
        zhoubianmingcheng : false,
        shejituan : false,
        zhoubianleixing : false,
        yanse : false,
        chicun : false,
        caizhi : false,
        shejimiaoshu : false,
        shangjiazhanghao : false,
        shangjiamingcheng : false,
        yonghuzhanghao : false,
        nicheng : false,
        ispay : false,
	})
	const formVisible = ref(false)
	const isAdd = ref(false)
	const formTitle = ref('')
    
	const rules = ref({
		dingdanbianhao: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		zhoubianmingcheng: [
		],
		shejituan: [
		],
		zhoubianleixing: [
		],
		yanse: [
		],
		chicun: [
		],
		caizhi: [
		],
		shejimiaoshu: [
		],
		shangjiazhanghao: [
		],
		shangjiamingcheng: [
		],
		yonghuzhanghao: [
		],
		nicheng: [
		],
		ispay: [
		],
	})
	//表单验证
	
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
	//设计图案上传回调
	const shejituanUploadSuccess=(e)=>{
		form.value.shejituan = e
	}
	//周边类型列表
	const zhoubianleixingLists = ref([])
	//获取唯一标识
	const getUUID =()=> {
      return new Date().getTime();
    }
	//重置
	const resetForm = () => {
		form.value = {
			dingdanbianhao: getUUID(),
			zhoubianmingcheng: '',
			shejituan: '',
			zhoubianleixing: '',
			yanse: '',
			chicun: '',
			caizhi: '',
			shejimiaoshu: '',
			shangjiazhanghao: '',
			shangjiamingcheng: '',
			yonghuzhanghao: '',
			nicheng: '',

		}
	}
	//获取info
	const getInfo = ()=>{
		context?.$http({
			url: `${tableName}/info/${id.value}`,
			method: 'get'
		}).then(res => {
			let reg=new RegExp('../../../file','g')
			res.data.data.shejimiaoshu = res.data.data.shejimiaoshu?(res.data.data.shejimiaoshu.replace(reg,'../../../cl445746174/file')):'';
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
				if(x=='dingdanbianhao'){
					form.value.dingdanbianhao = row[x];
					disabledForm.value.dingdanbianhao = true;
					continue;
				}
				if(x=='zhoubianmingcheng'){
					form.value.zhoubianmingcheng = row[x];
					disabledForm.value.zhoubianmingcheng = true;
					continue;
				}
				if(x=='shejituan'){
					form.value.shejituan = row[x];
					disabledForm.value.shejituan = true;
					continue;
				}
				if(x=='zhoubianleixing'){
					form.value.zhoubianleixing = row[x];
					disabledForm.value.zhoubianleixing = true;
					continue;
				}
				if(x=='yanse'){
					form.value.yanse = row[x];
					disabledForm.value.yanse = true;
					continue;
				}
				if(x=='chicun'){
					form.value.chicun = row[x];
					disabledForm.value.chicun = true;
					continue;
				}
				if(x=='caizhi'){
					form.value.caizhi = row[x];
					disabledForm.value.caizhi = true;
					continue;
				}
				if(x=='shejimiaoshu'){
					form.value.shejimiaoshu = row[x];
					disabledForm.value.shejimiaoshu = true;
					continue;
				}
				if(x=='shangjiazhanghao'){
					form.value.shangjiazhanghao = row[x];
					disabledForm.value.shangjiazhanghao = true;
					continue;
				}
				if(x=='shangjiamingcheng'){
					form.value.shangjiamingcheng = row[x];
					disabledForm.value.shangjiamingcheng = true;
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
			if(json.hasOwnProperty('yonghuzhanghao')&& context?.$toolUtil.storageGet("sessionTable")!="users"){
				form.value.yonghuzhanghao = json.yonghuzhanghao
				disabledForm.value.yonghuzhanghao = true;
			}
			if(json.hasOwnProperty('nicheng')&& context?.$toolUtil.storageGet("sessionTable")!="users"){
				form.value.nicheng = json.nicheng
				disabledForm.value.nicheng = true;
			}
		})
		context?.$http({
			url: `option/zhoubianleixing/zhoubianleixing`,
			method: 'get',
		}).then(res=>{
			zhoubianleixingLists.value = res.data.data
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
		if(form.value.shejituan!=null) {
			form.value.shejituan = form.value.shejituan.replace(new RegExp(context?.$config.url,"g"),"");
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
