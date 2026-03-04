<template>
	<div>
		<el-dialog modal-class="edit_form_modal" class="edit_form" v-model="formVisible" :title="formTitle" width="70%" destroy-on-close :fullscreen='false'>
			<el-form class="formModel_form" ref="formRef" :model="form" :rules="rules">
				<el-row >
					<el-col :span="12">
						<el-form-item label="用户名" prop="nickname">
							<el-input class="list_inp" v-model="form.nickname" placeholder="用户名"
                                type="text"
								readonly />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="评分" prop="score">
							<el-input class="list_inp" v-model.number="form.score" placeholder="评分"
                                type="number"
                                @mousewheel.native.prevent
								readonly />
						</el-form-item>
					</el-col>

					<el-col :span="24">
						<el-form-item label="评论内容" prop="content">
                            <editor :value="form.content||''" placeholder="请输入评论内容" :readonly="true"
                                    class="list_editor" @change="(e)=>editorChange(e,'content')"></editor>
						</el-form-item>
					</el-col>
					<el-col :span="24">
						<el-form-item label="回复内容" prop="reply">
                            <editor :value="form.reply||''" placeholder="请输入回复内容"
                                    class="list_editor" @change="(e)=>editorChange(e,'reply')"></editor>
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
	const tableName = 'discussdongmanshangpin'
	const formName = '动漫商品评论表'
	//基础信息
	//form表单
	const form = ref({})
	const disabledForm = ref({
        refid : false,
        userid : false,
        avatarurl : false,
        nickname : false,
        score : false,
        content : false,
        reply : false,
        thumbsupnum : false,
        crazilynum : false,
        istop : false,
        tuserids : false,
        cuserids : false,
	})
	const formVisible = ref(false)
	const isAdd = ref(false)
	const formTitle = ref('')
    
	const rules = ref({
		refid: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		userid: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		avatarurl: [
		],
		nickname: [
		],
		score: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
		content: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		reply: [
		],
		thumbsupnum: [
			{ validator: context.$toolUtil.validator.intNumber, trigger: 'blur' },
		],
		crazilynum: [
			{ validator: context.$toolUtil.validator.intNumber, trigger: 'blur' },
		],
		istop: [
			{ validator: context.$toolUtil.validator.intNumber, trigger: 'blur' },
		],
		tuserids: [
		],
		cuserids: [
		],
	})
	//表单验证
	
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
	//头像上传回调
	const avatarurlUploadSuccess=(e)=>{
		form.value.avatarurl = e
	}
	//获取唯一标识
	const getUUID =()=> {
      return new Date().getTime();
    }
	//重置
	const resetForm = () => {
		form.value = {
			refid: '',
			userid: '',
			avatarurl: '',
			nickname: '',
			score: '',
			content: '',
			reply: '',
			tuserids: '',
			cuserids: '',

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
		else if(formType == 'reply'){
			type.value = formType
			isAdd.value = true
			disabledForm.value.cpicture = true
			disabledForm.value.content = true
			formTitle.value = '回复'
			getInfo()
		}
		else if(formType == 'cross'){
			isAdd.value = true
			formTitle.value = formNames
			// getInfo()
			for(let x in row){
				if(x=='refid'){
					form.value.refid = row[x];
					disabledForm.value.refid = true;
					continue;
				}
				if(x=='userid'){
					form.value.userid = row[x];
					disabledForm.value.userid = true;
					continue;
				}
				if(x=='avatarurl'){
					form.value.avatarurl = row[x];
					disabledForm.value.avatarurl = true;
					continue;
				}
				if(x=='nickname'){
					form.value.nickname = row[x];
					disabledForm.value.nickname = true;
					continue;
				}
				if(x=='score'){
					form.value.score = row[x];
					disabledForm.value.score = true;
					continue;
				}
				if(x=='content'){
					form.value.content = row[x];
					disabledForm.value.content = true;
					continue;
				}
				if(x=='reply'){
					form.value.reply = row[x];
					disabledForm.value.reply = true;
					continue;
				}
				if(x=='thumbsupnum'){
					form.value.thumbsupnum = row[x];
					disabledForm.value.thumbsupnum = true;
					continue;
				}
				if(x=='crazilynum'){
					form.value.crazilynum = row[x];
					disabledForm.value.crazilynum = true;
					continue;
				}
				if(x=='istop'){
					form.value.istop = row[x];
					disabledForm.value.istop = true;
					continue;
				}
				if(x=='tuserids'){
					form.value.tuserids = row[x];
					disabledForm.value.tuserids = true;
					continue;
				}
				if(x=='cuserids'){
					form.value.cuserids = row[x];
					disabledForm.value.cuserids = true;
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
		if(form.value.reply==""){
			context.$toolUtil.message("回复内容不能为空","error")
			return
		}
		if(form.value.avatarurl!=null) {
			form.value.avatarurl = form.value.avatarurl.replace(new RegExp(context?.$config.url,"g"),"");
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
