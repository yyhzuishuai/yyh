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
					<el-form-item label="商品名称" prop="shangpinmingcheng">
						<el-input class="list_inp"
                                  v-model="form.shangpinmingcheng"
                                  placeholder="商品名称"
                                  type="text"
							      :readonly="!isAdd||disabledForm.shangpinmingcheng?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="商品类型" prop="shangpinleixing">
						<el-select
							class="list_sel"
							:disabled="!isAdd||disabledForm.shangpinleixing?true:false"
							v-model="form.shangpinleixing" 
							placeholder="请选择商品类型"
							style="width:100%;"
							>
							<el-option v-for="(item,index) in shangpinleixingLists" :label="item"
								:value="item"
								>
							</el-option>
						</el-select>
					</el-form-item>
				</el-col>
				<el-col :span="12">
					<el-form-item label="商品图片" prop="shangpintupian">
						<uploads
							:disabled="!isAdd||disabledForm.shangpintupian?true:false"
							action="file/upload" 
							tip="请上传商品图片"
							style="width: 100%;text-align: left;"
							:fileUrls="form.shangpintupian?form.shangpintupian:''" 
							@change="shangpintupianUploadSuccess">
						</uploads>
					</el-form-item>
				</el-col>
				<el-col :span="12">
					<el-form-item label="动漫品牌" prop="dongmanpinpai">
						<el-input class="list_inp"
                                  v-model="form.dongmanpinpai"
                                  placeholder="动漫品牌"
                                  type="text"
							      :readonly="!isAdd||disabledForm.dongmanpinpai?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="动漫IP" prop="dongmanip">
						<el-input class="list_inp"
                                  v-model="form.dongmanip"
                                  placeholder="动漫IP"
                                  type="text"
							      :readonly="!isAdd||disabledForm.dongmanip?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="规格" prop="guige">
						<el-input class="list_inp"
                                  v-model="form.guige"
                                  placeholder="规格"
                                  type="text"
							      :readonly="!isAdd||disabledForm.guige?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="动漫材质" prop="dongmancaizhi">
						<el-input class="list_inp"
                                  v-model="form.dongmancaizhi"
                                  placeholder="动漫材质"
                                  type="text"
							      :readonly="!isAdd||disabledForm.dongmancaizhi?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="评分" prop="score">
						<el-input class="list_inp"
                                  v-model.number="form.score"
                                  placeholder="评分"
                                  type="number"
							      :readonly="!isAdd||disabledForm.score?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="单限" prop="onelimittimes">
						<el-input class="list_inp"
                                  v-model.number="form.onelimittimes"
                                  placeholder="单限"
                                  type="text"
							      :readonly="!isAdd||disabledForm.onelimittimes?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="库存" prop="alllimittimes">
						<el-input class="list_inp"
                                  v-model.number="form.alllimittimes"
                                  placeholder="库存"
                                  type="text"
							      :readonly="!isAdd||disabledForm.alllimittimes?true:false" />
					</el-form-item>
				</el-col>

				<el-col :span="12">
					<el-form-item label="价格" prop="price">
						<el-input class="list_inp"
                                  v-model.number="form.price"
                                  placeholder="价格"
                                  type="number"
							      :readonly="!isAdd||disabledForm.price?true:false" />
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

				<el-col :span="24">
					<el-form-item label="商品详情" prop="shangpinxiangqing">
						<editor class="list_editor" :value="form.shangpinxiangqing" placeholder="请输入商品详情"
                            :readonly="!isAdd||disabledForm.shangpinxiangqing?true:false" :key="!isAdd"
							@change="(e)=>editorChange(e,'shangpinxiangqing')"></editor>
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
	const tableName = 'dongmanshangpin'
	const formName = '动漫商品'
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
		shangpinmingcheng: '',
		shangpinleixing: '',
		shangpintupian: '',
		dongmanpinpai: '',
		dongmanip: '',
		guige: '',
		dongmancaizhi: '',
		shangpinxiangqing: '',
		score: '0',
		shhf: '',
		isShelves: '1',
		clicktime: '',
		shangjiazhanghao: '',
		shangjiamingcheng: '',
	})
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
	const disabledForm = ref({
		shangpinmingcheng : false,
		shangpinleixing : false,
		shangpintupian : false,
		dongmanpinpai : false,
		dongmanip : false,
		guige : false,
		dongmancaizhi : false,
		shangpinxiangqing : false,
		score : false,
		onelimittimes : false,
		alllimittimes : false,
		sfsh : false,
		shhf : false,
		storeupNumber : false,
		discussNumber : false,
		price : false,
		isShelves : false,
		thumbsupNumber : false,
		crazilyNumber : false,
		clicktime : false,
		shangjiazhanghao : false,
		shangjiamingcheng : false,
	})
	const isAdd = ref(false)
	//表单验证
	const rules = ref({
		shangpinmingcheng: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		shangpinleixing: [
		],
		shangpintupian: [
		],
		dongmanpinpai: [
		],
		dongmanip: [
		],
		guige: [
		],
		dongmancaizhi: [
		],
		shangpinxiangqing: [
		],
		score: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
		onelimittimes: [
			{ validator: context.$toolUtil.validator.intNumber, trigger: 'blur' },
		],
		alllimittimes: [
			{ validator: context.$toolUtil.validator.intNumber, trigger: 'blur' },
		],
		sfsh: [
		],
		shhf: [
		],
		storeupNumber: [
			{ validator: context.$toolUtil.validator.intNumber, trigger: 'blur' },
		],
		discussNumber: [
			{ validator: context.$toolUtil.validator.intNumber, trigger: 'blur' },
		],
		price: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
		isShelves: [
			{ validator: context.$toolUtil.validator.intNumber, trigger: 'blur' },
		],
		thumbsupNumber: [
			{ validator: context.$toolUtil.validator.intNumber, trigger: 'blur' },
		],
		crazilyNumber: [
			{ validator: context.$toolUtil.validator.intNumber, trigger: 'blur' },
		],
		clicktime: [
		],
		shangjiazhanghao: [
		],
		shangjiamingcheng: [
		],
	})
	//商品类型列表
	const shangpinleixingLists = ref([])
	//商品图片上传回调
	const shangpintupianUploadSuccess=(e)=>{
		form.value.shangpintupian = e
	}
	//获取info
	const getInfo = ()=>{
		context?.$http({
			url: `${tableName}/info/${id.value}`,
			method: 'get'
		}).then(res => {
			let reg=new RegExp('../../../file','g')
			res.data.data.shangpinxiangqing = res.data.data.shangpinxiangqing.replace(reg,'../../../cl445746174/file');
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
				if(x=='shangpinmingcheng'){
					form.value.shangpinmingcheng = row[x];
					disabledForm.value.shangpinmingcheng = true;
					continue;
				}
				if(x=='shangpinleixing'){
					form.value.shangpinleixing = row[x];
					disabledForm.value.shangpinleixing = true;
					continue;
				}
				if(x=='shangpintupian'){
					form.value.shangpintupian = row[x];
					disabledForm.value.shangpintupian = true;
					continue;
				}
				if(x=='dongmanpinpai'){
					form.value.dongmanpinpai = row[x];
					disabledForm.value.dongmanpinpai = true;
					continue;
				}
				if(x=='dongmanip'){
					form.value.dongmanip = row[x];
					disabledForm.value.dongmanip = true;
					continue;
				}
				if(x=='guige'){
					form.value.guige = row[x];
					disabledForm.value.guige = true;
					continue;
				}
				if(x=='dongmancaizhi'){
					form.value.dongmancaizhi = row[x];
					disabledForm.value.dongmancaizhi = true;
					continue;
				}
				if(x=='shangpinxiangqing'){
					form.value.shangpinxiangqing = row[x];
					disabledForm.value.shangpinxiangqing = true;
					continue;
				}
				if(x=='score'){
					form.value.score = row[x];
					disabledForm.value.score = true;
					continue;
				}
				if(x=='onelimittimes'){
					form.value.onelimittimes = row[x];
					disabledForm.value.onelimittimes = true;
					continue;
				}
				if(x=='alllimittimes'){
					form.value.alllimittimes = row[x];
					disabledForm.value.alllimittimes = true;
					continue;
				}
				if(x=='storeupNumber'){
					form.value.storeupNumber = row[x];
					disabledForm.value.storeupNumber = true;
					continue;
				}
				if(x=='discussNumber'){
					form.value.discussNumber = row[x];
					disabledForm.value.discussNumber = true;
					continue;
				}
				if(x=='price'){
					form.value.price = row[x];
					disabledForm.value.price = true;
					continue;
				}
				if(x=='isShelves'){
					form.value.isShelves = row[x];
					disabledForm.value.isShelves = true;
					continue;
				}
				if(x=='thumbsupNumber'){
					form.value.thumbsupNumber = row[x];
					disabledForm.value.thumbsupNumber = true;
					continue;
				}
				if(x=='crazilyNumber'){
					form.value.crazilyNumber = row[x];
					disabledForm.value.crazilyNumber = true;
					continue;
				}
				if(x=='clicktime'){
					form.value.clicktime = row[x];
					disabledForm.value.clicktime = true;
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
			form.value.score='0'
			form.value.isShelves='1'
		}
		context?.$http({
			url: `${context?.$toolUtil.storageGet('frontSessionTable')}/session`,
			method: 'get'
		}).then(res => {
			var json = res.data.data
			if(context?.$toolUtil.storageGet("frontSessionTable")!="users") {
				disabledForm.value.score = true;
			}
			if(json.hasOwnProperty('shangjiazhanghao') && context?.$toolUtil.storageGet("frontSessionTable")!="users"){
				form.value.shangjiazhanghao = json.shangjiazhanghao
				disabledForm.value.shangjiazhanghao = true;
			}
			if(json.hasOwnProperty('shangjiamingcheng') && context?.$toolUtil.storageGet("frontSessionTable")!="users"){
				form.value.shangjiamingcheng = json.shangjiamingcheng
				disabledForm.value.shangjiamingcheng = true;
			}
            if (localStorage.getItem('autoSave')) {
                localStorage.removeItem('autoSave')
                save()
            }
		})
		context?.$http({
			url: `option/shangpinleixing/shangpinleixing`,
			method: 'get',
		}).then(res=>{
			shangpinleixingLists.value = res.data.data
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
		if(form.value.shangpintupian!=null) {
			form.value.shangpintupian = form.value.shangpintupian.replace(new RegExp(context?.$config.url,"g"),"");
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