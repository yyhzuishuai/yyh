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
					<el-form-item label="用户账号" prop="yonghuzhanghao">
						<el-input class="list_inp" v-model="form.yonghuzhanghao" placeholder="用户账号"
							type="text" :readonly="!isAdd||disabledForm.yonghuzhanghao?true:false" />
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
						<el-input class="list_inp"
                                  v-model="form.nicheng"
                                  placeholder="昵称"
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
					<el-form-item label="头像" prop="touxiang">
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
						<el-input class="list_inp"
                                  v-model="form.youxiang"
                                  placeholder="邮箱"
                                  type="text"
							      :readonly="!isAdd||disabledForm.youxiang?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="手机" prop="shouji">
						<el-input class="list_inp"
                                  v-model="form.shouji"
                                  placeholder="手机"
                                  type="text"
							      :readonly="!isAdd||disabledForm.shouji?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="身份证" prop="shenfenzheng">
						<el-input class="list_inp"
                                  v-model="form.shenfenzheng"
                                  placeholder="身份证"
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
							style="width:100%;"
							:readonly="!isAdd||disabledForm.zhuceshijian?true:false"
							placeholder="请选择注册时间" />
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
	const tableName = 'yonghu'
	const formName = '用户'
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
		yonghuzhanghao: '',
		mima: '',
		nicheng: '',
		xingbie: '',
		touxiang: '',
		youxiang: '',
		shouji: '',
		shenfenzheng: '',
		zhuceshijian: '',
	})
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
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
	const isAdd = ref(false)
	//表单验证
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
	//性别列表
	const xingbieLists = ref([])
	//头像上传回调
	const touxiangUploadSuccess=(e)=>{
		form.value.touxiang = e
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
        form.value.zhuceshijian = context?.$toolUtil.getCurDateTime()
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
		}
		context?.$http({
			url: `${context?.$toolUtil.storageGet('frontSessionTable')}/session`,
			method: 'get'
		}).then(res => {
			var json = res.data.data
			if(context?.$toolUtil.storageGet("frontSessionTable")!="users") {
				disabledForm.value.zhuceshijian = true;
			}
            if (localStorage.getItem('autoSave')) {
                localStorage.removeItem('autoSave')
                save()
            }
		})
		xingbieLists.value = "男,女".split(',')
	}
	//初始化
	//取消
	const backClick = () => {
		history.back()
	}
	//提交
	const save=()=>{
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


.edit_view .list_date{
    line-height: 36px;
}

.edit_view .add_form .el-form-item .el-form-item__content .list_radio{
    display: flex;
    width: calc(100% - 120px);
    align-items: center;
    flex-wrap: wrap;
}
.edit_view .add_form .el-form-item .el-form-item__content .list_radio .el-radio{
    width: 30%;
    margin: 0px;
    display: flex;
    justify-content: center;
    align-items: center;
}
.edit_view .add_form .el-form-item .el-form-item__content .list_radio .el-radio .el-radio__inner{
    border-color: #999;
    background: #fff;
}
.edit_view .add_form .el-form-item .el-form-item__content .list_radio .el-radio .el-radio__label{
    color: #999;
    font-size: 16px;
}
.edit_view .add_form .el-form-item .el-form-item__content .list_radio .el-radio.is-checked .el-radio__inner{
    border-color: var(--theme);
    background: var(--theme);
}
.edit_view .add_form .el-form-item .el-form-item__content .list_radio .el-radio.is-checked .el-radio__label{
    color: var(--theme);
    font-size: 16px;
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