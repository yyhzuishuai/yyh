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
					<el-form-item label="活动名称" prop="huodongmingcheng">
						<el-input class="list_inp"
                                  v-model="form.huodongmingcheng"
                                  placeholder="活动名称"
                                  type="text"
							      :readonly="!isAdd||disabledForm.huodongmingcheng?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="活动图片" prop="huodongtupian">
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
							style="width:100%;"
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
							style="width:100%;"
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
							style="width:100%;"
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
							style="width:100%;"
							:readonly="!isAdd||disabledForm.jieshushijian?true:false"
							placeholder="请选择结束时间" />
					</el-form-item>
				</el-col>
				<el-col :span="12">
					<el-form-item label="剩余名额" prop="shengyuminge">
						<el-input class="list_inp"
                                  v-model.number="form.shengyuminge"
                                  placeholder="剩余名额"
                                  type="text"
							      :readonly="!isAdd||disabledForm.shengyuminge?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="活动地点" prop="huodongdidian">
						<el-input class="list_inp"
                                  v-model="form.huodongdidian"
                                  placeholder="活动地点"
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
							style="width:100%;"
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
						<editor class="list_editor" :value="form.huodongneirong" placeholder="请输入活动内容"
                            :readonly="!isAdd||disabledForm.huodongneirong?true:false" :key="!isAdd"
							@change="(e)=>editorChange(e,'huodongneirong')"></editor>
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
	const tableName = 'dongmanzhutihuodong'
	const formName = '动漫主题活动'
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
		huodongmingcheng: '',
		huodongtupian: '',
		huodongleixing: '',
		canjiaxingshi: '',
		kaishishijian: '',
		jieshushijian: '',
		shengyuminge: 0,
		huodongdidian: '',
		huodongneirong: '',
		zhuyishixiang: '',
		fabushijian: '',
	})
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
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
	const isAdd = ref(false)
	//表单验证
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
	//活动图片上传回调
	const huodongtupianUploadSuccess=(e)=>{
		form.value.huodongtupian = e
	}
	//活动类型列表
	const huodongleixingLists = ref([])
	//参加形式列表
	const canjiaxingshiLists = ref([])
	//获取info
	const getInfo = ()=>{
		context?.$http({
			url: `${tableName}/info/${id.value}`,
			method: 'get'
		}).then(res => {
			let reg=new RegExp('../../../file','g')
			res.data.data.huodongneirong = res.data.data.huodongneirong.replace(reg,'../../../cl445746174/file');
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
        form.value.fabushijian = context?.$toolUtil.getCurDateTime()
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
		}
		context?.$http({
			url: `${context?.$toolUtil.storageGet('frontSessionTable')}/session`,
			method: 'get'
		}).then(res => {
			var json = res.data.data
            if (localStorage.getItem('autoSave')) {
                localStorage.removeItem('autoSave')
                save()
            }
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
	//取消
	const backClick = () => {
		history.back()
	}
	//富文本数据回调
	const editorChange = (e,name) =>{
		form.value[name] = e
	}
	//提交
	const save=()=>{
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

.edit_view .add_form .el-form-item .el-form-item__content .list_sel{
    line-height: 36px;
    
    box-sizing: border-box;
    width: calc(100% - 120px);
    padding: 0px 10px;
    border-radius: 0px;
    background: rgb(255, 255, 255);
    font-size: 16px;
}

.edit_view .list_date{
    line-height: 36px;
}




.edit_view .add_form .el-form-item .el-form-item__content .el-textarea{
    border: 0px solid rgba(226, 227, 229, 1);
}
.edit_view .add_form .el-form-item .el-form-item__content .el-textarea .el-textarea__inner{
    width: 100%;
    min-height: 150px;
    padding: 12px;
    border: 1px solid rgba(255, 255, 255, 1);
    border-radius: 4px;
    color: #666;
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


.edit_view .add_form .el-form-item .el-form-item__content .list_editor{
    width: 100%;
    height: auto;
    margin: 0px;
    padding: 0px;
    border-radius: 0px;
    border-width: 0px;
    border-style: solid;
    border-color: var(--theme);
    background-color: rgb(255, 255, 255);
}

.edit_view .add_form .formModel_btn_box{
    display: flex;
    align-items: center;
    width: 100%;
    padding: 10px 0px 10px 0px;
    margin: 40px 0px 0px;
    justify-content: flex-end;
}

.edit_view .add_form .formModel_btn_box .formModel_confirm{
    margin: 0px 0px 0px 30px;
    padding: 0px 24px;
    width: auto;
    height: 36px;
    font-size: 16px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px;
    background: var(--theme);
    cursor: pointer;
}
.edit_view .add_form .formModel_btn_box .formModel_confirm:hover{
    background: var(--theme);
}

.edit_view .add_form .formModel_btn_box .formModel_cancel{
    margin: 0px 0px 0px 30px;
    padding: 0px 24px;
    width: auto;
    height: 36px;
    font-size: 16px;
    color: #fff;
    border-radius: 4px;
    border: 0px;
    background: rgba(188, 188, 188, 1);
    cursor: pointer;
}
.edit_view .add_form .formModel_btn_box .formModel_cancel:hover{
}


.edit_view .add_form .formModel_btn_box .formModel_face{
    margin: 0px 0px 0px 30px;
    padding: 0px 20px;
    width: auto;
    height: 36px;
    font-size: 16px;
    color: rgb(255, 255, 255);
    border-radius: 4px;
    border: 0px;
    background: rgb(191 106 106);
    cursor: pointer;
    order: -1;
}
.edit_view .add_form .formModel_btn_box .formModel_face:hover{
}







.edit_view .add_form .el-form-item{
   margin:10px;
    display: flex;
    flex-direction:column;
  
  justify-content: flex-start; 
}
.edit_view .add_form .el-form-item .el-form-item__label{
     width: 150px !important;
    background: none;
    text-align: left;
    display: block;
   font-weight: 400;
font-size: 18px;
color: #585858;
    padding-left:10px;
}
.edit_view .list_inp .el-input__wrapper{
     height: 36px;
    line-height: 36px;
    padding: 0px 10px;
    box-sizing: border-box;

    font-size: 16px;
background: #F8F9FB;
border-radius: 10px 10px 10px 10px;
    box-shadow:none;
}
.el-select__wrapper{
    background: #F8F9FB;
border-radius: 10px 10px 10px 10px;
    box-shadow:none;
}

.el-input__wrapper {
 background: #F8F9FB;
border-radius: 10px 10px 10px 10px;
    box-shadow:none;
}
.edit_view .add_form .el-form-item .el-form-item__content .face_box .face_img{
border-radius: 10px 10px 10px 10px;
}

.edit_view .add_form .el-form-item .el-form-item__content .face_box .face_btn{
    margin-top:auto;
    background: #0660F8;
border-radius: 10px 10px 10px 10px;
    color:#FFF;
}

.el-textarea__inner{
       background: #F8F9FB;
border-radius: 10px 10px 10px 10px;
    box-shadow:none;

}
.el-upload-list--picture-card .el-upload-list__item{

border-radius: 10px 10px 10px 10px;
}

.edit_view .add_form .el-form-item .el-form-item__content .el-upload--picture-card{
       background: #F8F9FB;
border-radius: 10px 10px 10px 10px;
    border:none; 
  margin:auto;
}

.el-upload.el-upload--picture-card i.el-icon {
   font-size:50px!important; 
  
}

.edit_view .add_form .el-form-item .el-form-item__content .el-upload--text .el-upload-dragger{
    background: #F8F9FB;
border-radius: 10px 10px 10px 10px;
    border:none; 
}

.editor-box {
    border:none;
    background: #F8F9FB;
    border-radius:10px;
}

.w-e-bar.w-e-bar-show.w-e-toolbar {
    background:none;
}

.w-e-text-container {
  background:none;

}

.edit_view .add_form .el-form-item .el-form-item__content .list_checkbox{
background: #F8F9FB;
border-radius: 10px 10px 10px 10px;
}

.edit_view .add_form .el-form-item .el-form-item__content .list_checkbox .el-checkbox.is-checked .el-checkbox__inner{
    display:none;
}
.edit_view .add_form .el-form-item .el-form-item__content .list_checkbox .el-checkbox .el-checkbox__inner{
    display:none;
}
</style>