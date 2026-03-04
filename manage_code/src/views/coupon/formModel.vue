<template>
	<div>
		<el-dialog modal-class="edit_form_modal" class="edit_form" v-model="formVisible" :title="formTitle" width="70%" destroy-on-close :fullscreen='false'>
			<el-form class="formModel_form" ref="formRef" :model="form" :rules="rules">
				<el-row >
					<el-col :span="12">
						<el-form-item label="优惠券名称" prop="couponName">
							<el-input class="list_inp" v-model="form.couponName" placeholder="优惠券名称"
                                type="text"
								:readonly="!isAdd||disabledForm.couponName?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="优惠券类型" prop="couponType">
							<el-select
								class="list_sel"
								:disabled="!isAdd||disabledForm.couponType?true:false"
								v-model="form.couponType" 
								placeholder="请选择优惠券类型"
								>
								<el-option v-for="(item,index) in couponTypeLists" :label="item"
									:value="item"
									>
								</el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="满额" prop="fullAmount">
							<el-input class="list_inp" v-model.number="form.fullAmount" placeholder="满额"
                                type="number"
                                @mousewheel.native.prevent
								:readonly="!isAdd||disabledForm.fullAmount?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="优惠额" prop="discountAmount">
							<el-input class="list_inp" v-model.number="form.discountAmount" placeholder="优惠额"
                                type="number"
                                @mousewheel.native.prevent
								:readonly="!isAdd||disabledForm.discountAmount?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="生效时间" prop="effectTime">
							<el-date-picker
								class="list_date"
								v-model="form.effectTime"
								format="YYYY-MM-DD HH:mm:ss"
								value-format="YYYY-MM-DD HH:mm:ss"
								type="datetime"
								:readonly="!isAdd||disabledForm.effectTime?true:false"
								placeholder="请选择生效时间" />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="过期时间" prop="expireTime">
							<el-date-picker
								class="list_date"
								v-model="form.expireTime"
								format="YYYY-MM-DD HH:mm:ss"
								value-format="YYYY-MM-DD HH:mm:ss"
								type="datetime"
								:readonly="!isAdd||disabledForm.expireTime?true:false"
								placeholder="请选择过期时间" />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="备注" prop="remark">
							<el-input class="list_inp" v-model="form.remark" placeholder="备注"
                                type="text"
								:readonly="!isAdd||disabledForm.remark?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="商户名称" prop="shangjiazhanghao">
							<el-input class="list_inp" v-model="form.shangjiazhanghao" placeholder="商户名称"
                                type="text"
								:readonly="!isAdd||disabledForm.shangjiazhanghao?true:false" />
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
	const tableName = 'coupon'
	const formName = '优惠券'
	//基础信息
	//form表单
	const form = ref({})
	const disabledForm = ref({
        couponName : false,
        couponType : false,
        fullAmount : false,
        discountAmount : false,
        effectTime : false,
        expireTime : false,
        remark : false,
        userid : false,
        shangjiazhanghao : false,
	})
	const formVisible = ref(false)
	const isAdd = ref(false)
	const formTitle = ref('')
    
	const rules = ref({
		couponName: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		couponType: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		fullAmount: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
		discountAmount: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
		effectTime: [
		],
		expireTime: [
		],
		remark: [
		],
		userid: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		shangjiazhanghao: [
		],
	})
	//表单验证
	
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
	//优惠券类型列表
	const couponTypeLists = ref([])
	//获取唯一标识
	const getUUID =()=> {
      return new Date().getTime();
    }
	//重置
	const resetForm = () => {
		form.value = {
			couponName: '',
			couponType: '',
			effectTime: '',
			expireTime: '',
			remark: '',
			userid: '',
			shangjiazhanghao: '',

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
				if(x=='couponName'){
					form.value.couponName = row[x];
					disabledForm.value.couponName = true;
					continue;
				}
				if(x=='couponType'){
					form.value.couponType = row[x];
					disabledForm.value.couponType = true;
					continue;
				}
				if(x=='fullAmount'){
					form.value.fullAmount = row[x];
					disabledForm.value.fullAmount = true;
					continue;
				}
				if(x=='discountAmount'){
					form.value.discountAmount = row[x];
					disabledForm.value.discountAmount = true;
					continue;
				}
				if(x=='effectTime'){
					form.value.effectTime = row[x];
					disabledForm.value.effectTime = true;
					continue;
				}
				if(x=='expireTime'){
					form.value.expireTime = row[x];
					disabledForm.value.expireTime = true;
					continue;
				}
				if(x=='remark'){
					form.value.remark = row[x];
					disabledForm.value.remark = true;
					continue;
				}
				if(x=='userid'){
					form.value.userid = row[x];
					disabledForm.value.userid = true;
					continue;
				}
				if(x=='shangjiazhanghao'){
					form.value.shangjiazhanghao = row[x];
					disabledForm.value.shangjiazhanghao = true;
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
			if(json.hasOwnProperty('shangjiazhanghao')&& context?.$toolUtil.storageGet("sessionTable")!="users"){
				form.value.shangjiazhanghao = json.shangjiazhanghao
				disabledForm.value.shangjiazhanghao = true;
			}
			if(context?.$toolUtil.storageGet("sessionTable")!="users" && !context?.$toolUtil.storageGet("isAdmin")) {
				disabledForm.value.shangjiazhanghao = true;
			}
		})
		couponTypeLists.value = "满减券".split(',')
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
