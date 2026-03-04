<template>
	<div>
		<el-dialog modal-class="edit_form_modal" class="edit_form" v-model="formVisible" :title="formTitle" width="70%" destroy-on-close :fullscreen='false'>
			<el-form class="formModel_form" ref="formRef" :model="form" :rules="rules">
				<el-row >
					<el-col :span="12">
						<el-form-item label="商品名称" prop="shangpinmingcheng">
							<el-input class="list_inp" v-model="form.shangpinmingcheng" placeholder="商品名称"
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
								>
								<el-option v-for="(item,index) in shangpinleixingLists" :label="item"
									:value="item"
									>
								</el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item prop="shangpintupian"
									  label="商品图片"
						>
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
							<el-input class="list_inp" v-model="form.dongmanpinpai" placeholder="动漫品牌"
                                type="text"
								:readonly="!isAdd||disabledForm.dongmanpinpai?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="动漫IP" prop="dongmanip">
							<el-input class="list_inp" v-model="form.dongmanip" placeholder="动漫IP"
                                type="text"
								:readonly="!isAdd||disabledForm.dongmanip?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="规格" prop="guige">
							<el-input class="list_inp" v-model="form.guige" placeholder="规格"
                                type="text"
								:readonly="!isAdd||disabledForm.guige?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="动漫材质" prop="dongmancaizhi">
							<el-input class="list_inp" v-model="form.dongmancaizhi" placeholder="动漫材质"
                                type="text"
								:readonly="!isAdd||disabledForm.dongmancaizhi?true:false" />
						</el-form-item>
					</el-col>

                    <template v-if="!isAdd">
					<el-col :span="12">
						<el-form-item label="评分" prop="score">
							<el-input class="list_inp" v-model.number="form.score" placeholder="评分"
                                type="number"
                                @mousewheel.native.prevent
								:readonly="!isAdd||disabledForm.score?true:false" />
						</el-form-item>
					</el-col>

                    </template>
					<el-col :span="12">
						<el-form-item label="单限" prop="onelimittimes">
							<el-input class="list_inp" v-model.number="form.onelimittimes" placeholder="单限"
                                type="text"
								:readonly="!isAdd||disabledForm.onelimittimes?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="库存" prop="alllimittimes">
							<el-input class="list_inp" v-model.number="form.alllimittimes" placeholder="库存"
                                type="text"
								:readonly="!isAdd||disabledForm.alllimittimes?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="价格" prop="price">
							<el-input class="list_inp" v-model.number="form.price" placeholder="价格"
                                type="number"
                                @mousewheel.native.prevent
								:readonly="!isAdd||disabledForm.price?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="商家账号" prop="shangjiazhanghao">
							<el-input class="list_inp" v-model="form.shangjiazhanghao" placeholder="商家账号"
                                type="text"
								:readonly="!isAdd||disabledForm.shangjiazhanghao?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="商家名称" prop="shangjiamingcheng">
							<el-input class="list_inp" v-model="form.shangjiamingcheng" placeholder="商家名称"
                                type="text"
								:readonly="!isAdd||disabledForm.shangjiamingcheng?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="24">
						<el-form-item label="商品详情" prop="shangpinxiangqing">
							<editor :value="form.shangpinxiangqing" placeholder="请输入商品详情"
							   	:readonly="!isAdd||disabledForm.shangpinxiangqing?true:false" :key="!isAdd"
								class="list_editor" @change="(e)=>editorChange(e,'shangpinxiangqing')"></editor>
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
	const tableName = 'dongmanshangpin'
	const formName = '动漫商品'
	//基础信息
	//form表单
	const form = ref({})
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
	const formVisible = ref(false)
	const isAdd = ref(false)
	const formTitle = ref('')
    
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
	//表单验证
	
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
	//商品类型列表
	const shangpinleixingLists = ref([])
	//商品图片上传回调
	const shangpintupianUploadSuccess=(e)=>{
		form.value.shangpintupian = e
	}
	//获取唯一标识
	const getUUID =()=> {
      return new Date().getTime();
    }
	//重置
	const resetForm = () => {
		form.value = {
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

		}
	}
	//获取info
	const getInfo = ()=>{
		context?.$http({
			url: `${tableName}/info/${id.value}`,
			method: 'get'
		}).then(res => {
			let reg=new RegExp('../../../file','g')
			res.data.data.shangpinxiangqing = res.data.data.shangpinxiangqing?(res.data.data.shangpinxiangqing.replace(reg,'../../../cl445746174/file')):'';
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
			formVisible.value = true
		}
		context?.$http({
			url: `${context?.$toolUtil.storageGet('sessionTable')}/session`,
			method: 'get'
		}).then(res => {
			var json = res.data.data
			if(context?.$toolUtil.storageGet("sessionTable")!="users" && !context?.$toolUtil.storageGet("isAdmin")) {
				disabledForm.value.score = true;
			}
			if(json.hasOwnProperty('shangjiazhanghao')&& context?.$toolUtil.storageGet("sessionTable")!="users"){
				form.value.shangjiazhanghao = json.shangjiazhanghao
				disabledForm.value.shangjiazhanghao = true;
			}
			if(json.hasOwnProperty('shangjiamingcheng')&& context?.$toolUtil.storageGet("sessionTable")!="users"){
				form.value.shangjiamingcheng = json.shangjiamingcheng
				disabledForm.value.shangjiamingcheng = true;
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
