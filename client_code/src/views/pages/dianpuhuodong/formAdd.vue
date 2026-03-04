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
					<el-form-item label="活动标题" prop="huodongbiaoti">
						<el-input class="list_inp"
                                  v-model="form.huodongbiaoti"
                                  placeholder="活动标题"
                                  type="text"
							      :readonly="!isAdd||disabledForm.huodongbiaoti?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="活动类型" prop="huodongleixing">
						<el-input class="list_inp"
                                  v-model="form.huodongleixing"
                                  placeholder="活动类型"
                                  type="text"
							      :readonly="!isAdd||disabledForm.huodongleixing?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="图片" prop="tupian">
						<uploads
							:disabled="!isAdd||disabledForm.tupian?true:false"
							action="file/upload" 
							tip="请上传图片"
							style="width: 100%;text-align: left;"
							:fileUrls="form.tupian?form.tupian:''" 
							@change="tupianUploadSuccess">
						</uploads>
					</el-form-item>
				</el-col>
				<el-col :span="12">
					<el-form-item label="活动时间" prop="huodongshijian">
						<el-input class="list_inp"
                                  v-model="form.huodongshijian"
                                  placeholder="活动时间"
                                  type="text"
							      :readonly="!isAdd||disabledForm.huodongshijian?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="商家账号" prop="shangjiazhanghao">
						<el-input class="list_inp"
                                  v-model="form.shangjiazhanghao"
                                  placeholder="商家账号"
                                  type="text"
							      :readonly="!isAdd||disabledForm.shangjiazhanghao?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="商家名称" prop="shangjiamingcheng">
						<el-input class="list_inp"
                                  v-model="form.shangjiamingcheng"
                                  placeholder="商家名称"
                                  type="text"
							      :readonly="!isAdd||disabledForm.shangjiamingcheng?true:false" />
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
	const tableName = 'dianpuhuodong'
	const formName = '店铺活动'
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
		huodongbiaoti: '',
		huodongleixing: '',
		tupian: '',
		huodongneirong: '',
		huodongshijian: '',
		shangjiazhanghao: '',
		shangjiamingcheng: '',
		fabushijian: '',
	})
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
	const disabledForm = ref({
		huodongbiaoti : false,
		huodongleixing : false,
		tupian : false,
		huodongneirong : false,
		huodongshijian : false,
		shangjiazhanghao : false,
		shangjiamingcheng : false,
		fabushijian : false,
	})
	const isAdd = ref(false)
	//表单验证
	const rules = ref({
		huodongbiaoti: [
		],
		huodongleixing: [
		],
		tupian: [
		],
		huodongneirong: [
		],
		huodongshijian: [
		],
		shangjiazhanghao: [
		],
		shangjiamingcheng: [
		],
		fabushijian: [
		],
	})
	//图片上传回调
	const tupianUploadSuccess=(e)=>{
		form.value.tupian = e
	}
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
				if(x=='huodongbiaoti'){
					form.value.huodongbiaoti = row[x];
					disabledForm.value.huodongbiaoti = true;
					continue;
				}
				if(x=='huodongleixing'){
					form.value.huodongleixing = row[x];
					disabledForm.value.huodongleixing = true;
					continue;
				}
				if(x=='tupian'){
					form.value.tupian = row[x];
					disabledForm.value.tupian = true;
					continue;
				}
				if(x=='huodongneirong'){
					form.value.huodongneirong = row[x];
					disabledForm.value.huodongneirong = true;
					continue;
				}
				if(x=='huodongshijian'){
					form.value.huodongshijian = row[x];
					disabledForm.value.huodongshijian = true;
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
			if(json.hasOwnProperty('shangjiazhanghao') && context?.$toolUtil.storageGet("frontSessionTable")!="users"){
				form.value.shangjiazhanghao = json.shangjiazhanghao
				disabledForm.value.shangjiazhanghao = true;
			}
			if(json.hasOwnProperty('shangjiamingcheng') && context?.$toolUtil.storageGet("frontSessionTable")!="users"){
				form.value.shangjiamingcheng = json.shangjiamingcheng
				disabledForm.value.shangjiamingcheng = true;
			}
			if(context?.$toolUtil.storageGet("frontSessionTable")!="users") {
				disabledForm.value.fabushijian = true;
			}
            if (localStorage.getItem('autoSave')) {
                localStorage.removeItem('autoSave')
                save()
            }
		})
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
		if(form.value.tupian!=null) {
			form.value.tupian = form.value.tupian.replace(new RegExp(context?.$config.url,"g"),"");
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

</style>