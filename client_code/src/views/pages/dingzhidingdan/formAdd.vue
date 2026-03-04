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
					<el-form-item label="订单编号" prop="dingdanbianhao">
						<el-input class="list_inp" v-model="form.dingdanbianhao" placeholder="请输入订单编号" readonly></el-input>
					</el-form-item>
				</el-col>
				<el-col :span="12">
					<el-form-item label="周边名称" prop="zhoubianmingcheng">
						<el-input class="list_inp"
                                  v-model="form.zhoubianmingcheng"
                                  placeholder="周边名称"
                                  type="text"
							      :readonly="!isAdd||disabledForm.zhoubianmingcheng?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="设计图案" prop="shejituan">
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
							style="width:100%;"
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
						<el-input class="list_inp"
                                  v-model="form.yanse"
                                  placeholder="颜色"
                                  type="text"
							      :readonly="!isAdd||disabledForm.yanse?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="尺寸" prop="chicun">
						<el-input class="list_inp"
                                  v-model="form.chicun"
                                  placeholder="尺寸"
                                  type="text"
							      :readonly="!isAdd||disabledForm.chicun?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="材质" prop="caizhi">
						<el-input class="list_inp"
                                  v-model="form.caizhi"
                                  placeholder="材质"
                                  type="text"
							      :readonly="!isAdd||disabledForm.caizhi?true:false" />
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

				<el-col :span="24">
					<el-form-item label="设计描述" prop="shejimiaoshu">
						<editor class="list_editor" :value="form.shejimiaoshu" placeholder="请输入设计描述"
                            :readonly="!isAdd||disabledForm.shejimiaoshu?true:false" :key="!isAdd"
							@change="(e)=>editorChange(e,'shejimiaoshu')"></editor>
					</el-form-item>
				</el-col>
			</el-row>
			<div class="formModel_btn_box">
				<el-button class="formModel_cancel" @click="backClick">取消</el-button>
				<el-button class="formModel_confirm"
                           @click="save"
                           type="success"
				>
                    提交
				</el-button>
                <payForm ref="payRef" @close="payClose" @paySave="paySave"></payForm>
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
	const tableName = 'dingzhidingdan'
	const formName = '定制订单'
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
	})
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
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
	const isAdd = ref(false)
	//表单验证
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
	//设计图案上传回调
	const shejituanUploadSuccess=(e)=>{
		form.value.shejituan = e
	}
	//周边类型列表
	const zhoubianleixingLists = ref([])
	//获取info
	const getInfo = ()=>{
		context?.$http({
			url: `${tableName}/info/${id.value}`,
			method: 'get'
		}).then(res => {
			let reg=new RegExp('../../../file','g')
			res.data.data.shejimiaoshu = res.data.data.shejimiaoshu.replace(reg,'../../../cl445746174/file');
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
		}
		context?.$http({
			url: `${context?.$toolUtil.storageGet('frontSessionTable')}/session`,
			method: 'get'
		}).then(res => {
			var json = res.data.data
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
		context?.$http({
			url: `option/zhoubianleixing/zhoubianleixing`,
			method: 'get',
		}).then(res=>{
			zhoubianleixingLists.value = res.data.data
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
                                if(context.$toolUtil.isBackAuth('dingzhidingdan','支付')){
                                    context.$http.get(`${tableName}/page?sort=id&order=desc`).then(res1=>{
                                        payRef.value.payClick(tableName,res1.data.data.list[0])
                                    })
                                    return
                                }
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
                        if(context.$toolUtil.isBackAuth('dingzhidingdan','支付')){
                            context.$http.get(`${tableName}/page?sort=id&order=desc`).then(res1=>{
                                payRef.value.payClick(tableName,res1.data.data.list[0])
                            })
                            return
                        }
                        context?.$toolUtil.message(`操作成功`,'success')
                        history.back()
					})
				}
			}
		})
	}
    import payForm from '@/components/payForm'
    const payRef = ref(null)
    const payClose = (e)=>{
        history.back()
    }
    const paySave = async(data)=>{
        data.ispay = '已支付'
        context?.$http({
            url: `${tableName}/update`,
            method: 'post',
            data: data
        }).then(res => {
            context.$message.success('支付成功')
            payRef.value.payVisible = false
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