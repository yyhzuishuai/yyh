<template>
	<div class="edit_view">
        <div class="breadcrumb-wrapper" style="width: 100%;">
            <div class="bread_view">
                <el-breadcrumb separator=">" class="breadcrumb">
                    <el-breadcrumb-item class="first_breadcrumb" :to="{ path: '/' }">首页</el-breadcrumb-item>
                    <el-breadcrumb-item class="second_breadcrumb" v-for="(item,index) in breadList" :key="index">{{item.name}}</el-breadcrumb-item>
                </el-breadcrumb>
            </div>
        </div>
		<el-form ref="formRef" :model="form" class="add_form" label-width="120px" :rules="rules">
			<el-row>
				<el-col :span="12">
					<el-form-item label="用户id" prop="uid">
						<el-input class="list_inp"
                                  v-model="form.uid"
                                  placeholder="用户id"
                                  type="text"
							      :readonly="!isAdd||disabledForm.uid?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="好友id" prop="fid">
						<el-input class="list_inp"
                                  v-model="form.fid"
                                  placeholder="好友id"
                                  type="text"
							      :readonly="!isAdd||disabledForm.fid?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="名称" prop="name">
						<el-input class="list_inp"
                                  v-model="form.name"
                                  placeholder="名称"
                                  type="text"
							      :readonly="!isAdd||disabledForm.name?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="图片" prop="picture">
						<uploads
							:disabled="!isAdd||disabledForm.picture?true:false"
							action="file/upload" 
							tip="请上传图片"
							style="width: 100%;text-align: left;"
							:fileUrls="form.picture?form.picture:''" 
							@change="pictureUploadSuccess">
						</uploads>
					</el-form-item>
				</el-col>
				<el-col :span="12">
					<el-form-item label="角色" prop="role">
						<el-input class="list_inp"
                                  v-model="form.role"
                                  placeholder="角色"
                                  type="text"
							      :readonly="!isAdd||disabledForm.role?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="表名" prop="tablename">
						<el-input class="list_inp"
                                  v-model="form.tablename"
                                  placeholder="表名"
                                  type="text"
							      :readonly="!isAdd||disabledForm.tablename?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="别名" prop="alias">
						<el-input class="list_inp"
                                  v-model="form.alias"
                                  placeholder="别名"
                                  type="text"
							      :readonly="!isAdd||disabledForm.alias?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="类型(0:好友申请，1:好友，2:消息)" prop="type">
						<el-input class="list_inp"
                                  v-model.number="form.type"
                                  placeholder="类型(0:好友申请，1:好友，2:消息)"
                                  type="text"
							      :readonly="!isAdd||disabledForm.type?true:false" />
					</el-form-item>
				</el-col>

			</el-row>
			<div class="formModel_btn_box">
				<el-button class="formModel_cancel" @click="backClick">取消</el-button>
				<el-button class="formModel_confirm"
                           @click="save"
                           type="success"
				>
					保存
				</el-button>
			</div>
		</el-form>
	</div>
</template>
<script setup>
	import {
		ref,
		getCurrentInstance,
		watch,
		onUnmounted,
		onMounted,
		nextTick,
		computed
	} from 'vue';
	import {
		useRoute,
		useRouter
	} from 'vue-router';
    import {
        useStore
    } from 'vuex';
    const store = useStore()
    const user = computed(()=>store.getters['user/session'])
    const moment = window.moment
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const route = useRoute()
	const router = useRouter()
	//基础信息
	const tableName = 'chatfriend'
	const formName = '好友表'
	//基础信息
	const breadList = ref([{
		name: formName
	}])
	//获取唯一标识
	const getUUID =()=> {
      return new Date().getTime();
    }
	//form表单
	const form = ref({
		uid: '',
		fid: '',
		name: '',
		picture: '',
		role: '',
		tablename: '',
		alias: '',
	})
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
	const disabledForm = ref({
		uid : false,
		fid : false,
		name : false,
		picture : false,
		role : false,
		tablename : false,
		alias : false,
		type : false,
	})
	const isAdd = ref(false)
	//表单验证
	const rules = ref({
		uid: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		fid: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		name: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		picture: [
		],
		role: [
		],
		tablename: [
		],
		alias: [
		],
		type: [
			{ validator: context.$toolUtil.validator.intNumber, trigger: 'blur' },
		],
	})
	//图片上传回调
	const pictureUploadSuccess=(e)=>{
		form.value.picture = e
	}
	//获取info
	const getInfo = ()=>{
		context?.$http({
			url: `${tableName}/info/${id.value}`,
			method: 'get'
		}).then(res => {
			let reg=new RegExp('../../../file','g')
			form.value = res.data.data
		})
	}
	const crossRow = ref('')
	const crossTable = ref('')
	const crossTips = ref('')
	const crossColumnName = ref('')
	const crossColumnValue = ref('')
	//初始化
	const init = (formId=null,formType='add',formNames='',row=null,table=null,statusColumnName=null,tips=null,statusColumnValue=null) => {
		if(formId){
			id.value = formId
			type.value = formType
		}
		if(formType == 'add'){
			isAdd.value = true
		}else if(formType == 'info'){
			isAdd.value = false
			getInfo()
		}else if(formType == 'edit'){
			isAdd.value = true
			getInfo()
		}
		else if(formType == 'cross'){
			isAdd.value = true
			// getInfo()
			for(let x in row){
				if(x=='uid'){
					form.value.uid = row[x];
					disabledForm.value.uid = true;
					continue;
				}
				if(x=='fid'){
					form.value.fid = row[x];
					disabledForm.value.fid = true;
					continue;
				}
				if(x=='name'){
					form.value.name = row[x];
					disabledForm.value.name = true;
					continue;
				}
				if(x=='picture'){
					form.value.picture = row[x];
					disabledForm.value.picture = true;
					continue;
				}
				if(x=='role'){
					form.value.role = row[x];
					disabledForm.value.role = true;
					continue;
				}
				if(x=='tablename'){
					form.value.tablename = row[x];
					disabledForm.value.tablename = true;
					continue;
				}
				if(x=='alias'){
					form.value.alias = row[x];
					disabledForm.value.alias = true;
					continue;
				}
				if(x=='type'){
					form.value.type = row[x];
					disabledForm.value.type = true;
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
		}
	}
	//初始化
	//取消
	const backClick = () => {
		history.back()
	}
	//提交
	const save=()=>{
		if(form.value.picture!=null) {
			form.value.picture = form.value.picture.replace(new RegExp(context?.$config.url,"g"),"");
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
                            crossUserId = context?.$toolUtil.storageGet('userid')
                            crossRefId = objcross['id']
                            crossOptNum = crossColumnName.value.replace(/\[/,"").replace(/\]/,"")
                        }
                    }
                }
				if(crossUserId&&crossRefId){    //限制用户操作次数
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
							}).then(async (res)=>{
                                context?.$toolUtil.message(`操作成功`,'success')
                                history.back()
							})
						}
					})
				}else{
					context?.$http({
						url: `${tableName}/${!form.value.id ? "save" : "update"}`,
						method: 'post', 
						data: form.value 
					}).then(async (res)=>{
                        context?.$toolUtil.message(`操作成功`,'success')
                        history.back()
					})
				}
			}
		})
	}
	//修改跨表数据
	const changeCrossData=(row,key)=>{
        if(type.value == 'cross'){
            let data = row
            if(key){	//如果有指定key，则只更新key属性
                data = {
                    id:row.id,
                }
                data[key] = row[key]
            }
            context?.$http({
                url: `${crossTable.value}/update`,
                method: 'post',
                data: data
            }).then(res=>{})
        }
	}
	onMounted(()=>{
		type.value = route.query.type?route.query.type:'add'
		let row = null
		let table = null
		let statusColumnName = null
		let tips = null
		let statusColumnValue = null
		if(type.value == 'cross'){
			row = context?.$toolUtil.storageGet('crossObj')?JSON.parse(context?.$toolUtil.storageGet('crossObj')):{}
			table = context?.$toolUtil.storageGet('crossTable')
			statusColumnName = context?.$toolUtil.storageGet('crossStatusColumnName')
			tips = context?.$toolUtil.storageGet('crossTips')
			statusColumnValue = context?.$toolUtil.storageGet('crossStatusColumnValue')
		}
		init(route.query.id?route.query.id:null, type.value,'', row, table, statusColumnName, tips, statusColumnValue)
	})
    onUnmounted(()=>{
        Object.keys(localStorage).map(item=>{
            if(item.startsWith('cross')){
                localStorage.removeItem(item)
            }
        })
    })
</script>
<style lang="scss" scoped>
	// 表单
	.add_form{
		// form item
		:deep(.el-form-item) {
			// 内容盒子
			.el-form-item__content {
			}
		}
	}
</style>
<style lang="scss">
.edit_view {
    width: 100%;
    padding: 0 7%;
    margin: 0 auto;
    position: relative;
    font-size:16px;
    color:#666;
}
.edit_view .add_form{
    width: 100%;
    margin: 30px auto;
    background: rgb(255, 255, 255);
    padding: 50px 100px;
    border:0px solid #eee;
    border-radius: 12px;
    box-shadow:0px 4px 6px -3px #999;
}


.edit_view .add_form .el-form-item .el-form-item__content{
    display: flex;
    justify-content: flex-start;
    align-items: center;
    flex-wrap: wrap;
    width: calc(100% - 120px);
}
.edit_view .list_inp .el-input__wrapper{
    height: 36px;
}








.edit_view .add_form .el-form-item .el-form-item__content .el-upload--picture-card{
    background-color: rgb(255, 255, 255);
    width: 100px;
    height: 90px;
    line-height: 100px;
    text-align: center;
    
    border-radius: 0px;
    cursor: pointer;
}

.edit_view .add_form .el-form-item .el-form-item__content .el-upload--picture-card .el-icon{
    font-size: 32px;
    color: #999;
}

.edit_view .add_form .el-form-item .el-form-item__content .img-uploader .el-upload__tip{
    font-size: 15px;
    color: #666;
    margin: 0;
}



</style>