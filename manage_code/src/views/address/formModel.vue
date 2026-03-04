<template>
	<div>
		<el-dialog modal-class="edit_form_modal" class="edit_form" v-model="formVisible" :title="formTitle" width="70%" destroy-on-close :fullscreen='false'>
			<el-form class="formModel_form" ref="formRef" :model="form" :rules="rules">
				<el-row >
					<el-col :span="12">
						<el-form-item label="地址" prop="address">
							<el-input class="list_inp" v-model="form.address" placeholder="地址"
                                type="text"
								:readonly="!isAdd||disabledForm.address?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="收货人" prop="name">
							<el-input class="list_inp" v-model="form.name" placeholder="收货人"
                                type="text"
								:readonly="!isAdd||disabledForm.name?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="电话" prop="phone">
							<el-input class="list_inp" v-model="form.phone" placeholder="电话"
                                type="text"
								:readonly="!isAdd||disabledForm.phone?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="是否默认地址" prop="isdefault">
							<el-select
								class="list_sel"
								:disabled="!isAdd||disabledForm.isdefault?true:false"
								v-model="form.isdefault" 
								placeholder="请选择是否默认地址"
								>
								<el-option v-for="(item,index) in isdefaultLists" :label="item"
									:value="item"
									>
								</el-option>
							</el-select>
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
	const tableName = 'address'
	const formName = '地址'
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
        address : false,
        name : false,
        phone : false,
        isdefault : false,
        userid : false,
        longitude : false,
        latitude : false,
        fulladdress : false,
	})
	const formVisible = ref(false)
	const isAdd = ref(false)
	const formTitle = ref('')
    
	const rules = ref({
		address: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		name: [
		],
		phone: [
		],
		isdefault: [
		],
		userid: [
			{required: true,message: '请输入',trigger: 'blur'}, 
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
	//是否默认地址列表
	const isdefaultLists = ref([])
	//获取唯一标识
	const getUUID =()=> {
      return new Date().getTime();
    }
	//重置
	const resetForm = () => {
		form.value = {
			address: '',
			name: '',
			phone: '',
			userid: '',
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
				if(x=='address'){
					form.value.address = row[x];
					disabledForm.value.address = true;
					continue;
				}
				if(x=='name'){
					form.value.name = row[x];
					disabledForm.value.name = true;
					continue;
				}
				if(x=='phone'){
					form.value.phone = row[x];
					disabledForm.value.phone = true;
					continue;
				}
				if(x=='isdefault'){
					form.value.isdefault = row[x];
					disabledForm.value.isdefault = true;
					continue;
				}
				if(x=='userid'){
					form.value.userid = row[x];
					disabledForm.value.userid = true;
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
		form.value.userid = user.value.id
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
