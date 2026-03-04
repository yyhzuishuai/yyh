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
					<el-form-item label="报名编号" prop="baomingbianhao">
						<el-input class="list_inp" v-model="form.baomingbianhao" placeholder="请输入报名编号" readonly></el-input>
					</el-form-item>
				</el-col>
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
						<el-input class="list_inp"
                                  v-model="form.huodongleixing"
                                  placeholder="活动类型"
                                  type="text"
							      :readonly="!isAdd||disabledForm.huodongleixing?true:false" />
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
					<el-form-item label="报名时间" prop="baomingshijian">
						<el-date-picker
							class="list_date"
							v-model="form.baomingshijian"
							format="YYYY-MM-DD HH:mm:ss"
							value-format="YYYY-MM-DD HH:mm:ss"
							type="datetime"
							style="width:100%;"
							:readonly="!isAdd||disabledForm.baomingshijian?true:false"
							placeholder="请选择报名时间" />
					</el-form-item>
				</el-col>
				<el-col :span="12">
					<el-form-item label="用户账号" prop="yonghuzhanghao">
						<el-input class="list_inp"
                                  v-model="form.yonghuzhanghao"
                                  placeholder="用户账号"
                                  type="text"
							      :readonly="!isAdd||disabledForm.yonghuzhanghao?true:false" />
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
	const tableName = 'huodongbaoming'
	const formName = '活动报名'
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
	})
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
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
	const isAdd = ref(false)
	//表单验证
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
	//活动图片上传回调
	const huodongtupianUploadSuccess=(e)=>{
		form.value.huodongtupian = e
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
        form.value.baomingshijian = context?.$toolUtil.getCurDateTime()
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
		}
		context?.$http({
			url: `${context?.$toolUtil.storageGet('frontSessionTable')}/session`,
			method: 'get'
		}).then(res => {
			var json = res.data.data
			if(context?.$toolUtil.storageGet("frontSessionTable")!="users") {
				disabledForm.value.shengyuminge = true;
			}
			if(json.hasOwnProperty('yonghuzhanghao') && context?.$toolUtil.storageGet("frontSessionTable")!="users"){
				form.value.yonghuzhanghao = json.yonghuzhanghao
				disabledForm.value.yonghuzhanghao = true;
			}
			if(json.hasOwnProperty('nicheng') && context?.$toolUtil.storageGet("frontSessionTable")!="users"){
				form.value.nicheng = json.nicheng
				disabledForm.value.nicheng = true;
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
	//提交
	const save=()=>{
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
                                //修改跨表数据
                                await changeCrossData(objcross,'shengyuminge')
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
                        //修改跨表数据
                        await changeCrossData(objcross,'shengyuminge')
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



</style>