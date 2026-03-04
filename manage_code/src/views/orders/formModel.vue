<template>
	<div>
		<el-dialog modal-class="edit_form_modal" class="edit_form" v-model="formVisible" :title="formTitle" width="70%" destroy-on-close :fullscreen='false'>
			<el-form class="formModel_form" ref="formRef" :model="form" :rules="rules">
				<el-row >
					<el-col :span="12">
						<el-form-item label="订单编号" prop="orderid">
							<el-input class="list_inp" v-model="form.orderid" :readonly="true" placeholder="订单编号" />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="商品名称" prop="goodname">
							<el-input class="list_inp" v-model="form.goodname" placeholder="商品名称"
                                type="text"
								:readonly="!isAdd||disabledForm.goodname?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item prop="picture"
									  label="图片"
						>
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
						<el-form-item label="购买数量" prop="buynumber">
							<el-input class="list_inp" v-model.number="form.buynumber" placeholder="购买数量"
                                type="text"
								:readonly="!isAdd||disabledForm.buynumber?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="单价" prop="price">
							<el-input class="list_inp" v-model.number="form.price" placeholder="单价"
                                type="number"
                                @mousewheel.native.prevent
								:readonly="!isAdd||disabledForm.price?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="折扣价" prop="discountprice">
							<el-input class="list_inp" v-model.number="form.discountprice" placeholder="折扣价"
                                type="number"
                                @mousewheel.native.prevent
								:readonly="!isAdd||disabledForm.discountprice?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="总价" prop="total">
							<el-input class="list_inp" v-model.number="form.total" placeholder="总价"
                                type="number"
                                @mousewheel.native.prevent
								:readonly="!isAdd||disabledForm.total?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="折扣总价格" prop="discounttotal">
							<el-input class="list_inp" v-model.number="form.discounttotal" placeholder="折扣总价格"
                                type="number"
                                @mousewheel.native.prevent
								:readonly="!isAdd||disabledForm.discounttotal?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="支付类型" prop="type">
							<el-select
								class="list_sel"
								:disabled="!isAdd||disabledForm.type?true:false"
								v-model="form.type" 
								placeholder="请选择支付类型"
								>
								<el-option v-for="(item,index) in typeLists" :label="item"
									:value="index + 1+''"
									>
								</el-option>
							</el-select>
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="订单状态" prop="status">
							<el-input class="list_inp" v-model="form.status" placeholder="订单状态"
                                type="text"
								:readonly="!isAdd||disabledForm.status?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="退货原因" prop="returnReason">
							<el-input class="list_inp" v-model="form.returnReason" placeholder="退货原因"
                                type="text"
								:readonly="!isAdd||disabledForm.returnReason?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="地址" prop="address">
							<el-input class="list_inp" v-model="form.address" placeholder="地址"
                                type="text"
								:readonly="!isAdd||disabledForm.address?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="电话" prop="tel">
							<el-input class="list_inp" v-model="form.tel" placeholder="电话"
                                type="text"
								:readonly="!isAdd||disabledForm.tel?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="收货人" prop="consignee">
							<el-input class="list_inp" v-model="form.consignee" placeholder="收货人"
                                type="text"
								:readonly="!isAdd||disabledForm.consignee?true:false" />
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
						<el-form-item label="创建时间" prop="addtime">
							<el-date-picker
								class="list_date"
								v-model="form.addtime"
								format="YYYY-MM-DD HH:mm:ss"
								value-format="YYYY-MM-DD HH:mm:ss"
								type="datetime"
								:readonly="!isAdd||disabledForm.addtime?true:false"
								placeholder="请选择创建时间" />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="商户名称" prop="shangjiazhanghao">
							<el-input class="list_inp" v-model="form.shangjiazhanghao" placeholder="商户名称"
                                type="text"
								:readonly="!isAdd||disabledForm.shangjiazhanghao?true:false" />
						</el-form-item>
					</el-col>

					<el-col :span="12">
						<el-form-item label="券编号" prop="couponNumber">
							<el-input class="list_inp" v-model="form.couponNumber" placeholder="券编号"
                                type="text"
								:readonly="!isAdd||disabledForm.couponNumber?true:false" />
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
						<el-form-item label="下单时间" prop="addtime">
							<el-input class="list_inp" v-model="form.addtime" placeholder="下单时间"
							readonly />
						</el-form-item>
					</el-col>
					<el-col :span="12">
						<el-form-item label="地址" prop="fulladdress">
							<el-input class="list_inp" v-model="form.fulladdress" placeholder="地址" readonly @click.native="mapClick" />
						</el-form-item>
					</el-col>
					<el-col :span="24">
						<el-form-item label="物流" prop="logistics">
							<editor :value="form.logistics" placeholder="请输入物流" :readonly="type == 'logistics'?false:true" :key="type"
								class="list_editor" @change="(e)=>editorChange(e,'logistics')"></editor>
                            <div class="map-wrapper" style="width: 100%;height: 500px" v-if="merchant?.id">
                                <el-amap ref="mapRef"
                                         :min-zoom="4"
                                         :max-zoom="22"
                                         :center="[form.longitude,form.latitude]"
                                         :zoom="zoom">
                                    <el-amap-marker :position="[merchant.longitude,merchant.latitude]" :offset="[-10,-32]">
                                        <span style="white-space: nowrap;display: flex;align-items: center;color: #2891ff;">
                                            <img title="发货地" style="width: 19px;height: 32px" src="http://webapi.amap.com/theme/v1.3/markers/b/mark_bs.png"/>
                                            发货地
                                        </span>
                                    </el-amap-marker>
                                    <el-amap-marker :position="[form.longitude,form.latitude]" :offset="[-10,-32]">
                                        <span style="white-space: nowrap;display: flex;align-items: center;color: #2891ff;">
                                            <img title="收货地" style="width: 19px;height: 32px" src="http://webapi.amap.com/theme/v1.3/markers/b/mark_bs.png"/>
                                            收货地
                                        </span>
                                    </el-amap-marker>
                                    <!-- 路线绘制 -->
                                    <el-amap-polyline
                                        v-if="drivingRoute"
                                        :path="drivingRoute"
                                        strokeColor="#FF0000"
                                        :strokeWeight="4"
                                    ></el-amap-polyline>
                                </el-amap>
                            </div>
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
		<locationForm ref="locationRef" v-model="form" :position="form" @mapData="getAddress"></locationForm>
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
	const tableName = 'orders'
	const formName = '商品订单'
	//基础信息
	import locationForm from '@/components/common/location.vue'
	const locationRef = ref(null)
	const mapClick = () => {
		if(!isAdd.value||disabledForm.fulladdress){
			return false
		}
		locationRef.value.mapShow()
	}
	const getAddress = (e) => {
		form.value.longitude = e.lng
		form.value.latitude = e.lat
		form.value.fulladdress = e.fulladdress
	}
	//form表单
	const form = ref({})
	const disabledForm = ref({
        orderid : false,
        tablename : false,
        goodid : false,
        goodname : false,
        picture : false,
        buynumber : false,
        price : false,
        discountprice : false,
        total : false,
        discounttotal : false,
        type : false,
        status : false,
        returnReason : false,
        address : false,
        tel : false,
        consignee : false,
        remark : false,
        logistics : false,
        role : false,
        addtime : false,
        userid : false,
        sfsh : false,
        shhf : false,
        longitude : false,
        latitude : false,
        fulladdress : false,
        shangjiazhanghao : false,
        couponNumber : false,
        discountAmount : false,
        orderNo : false,
	})
	const formVisible = ref(false)
	const isAdd = ref(false)
	const formTitle = ref('')
    
	const rules = ref({
		orderid: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		tablename: [
		],
		goodid: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		goodname: [
		],
		picture: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		buynumber: [
			{ validator: context.$toolUtil.validator.intNumber, trigger: 'blur' },
		],
		price: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
		discountprice: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
		total: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
		discounttotal: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
		type: [
		],
		status: [
		],
		returnReason: [
		],
		address: [
		],
		tel: [
		],
		consignee: [
		],
		remark: [
		],
		logistics: [
		],
		role: [
		],
		addtime: [
		],
		userid: [
			{required: true,message: '请输入',trigger: 'blur'}, 
		],
		sfsh: [
		],
		shhf: [
		],
		longitude: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
		latitude: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
		fulladdress: [
		],
		shangjiazhanghao: [
		],
		couponNumber: [
		],
		discountAmount: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
		orderNo: [
		],
	})
	//表单验证
	
	const formRef = ref(null)
	const id = ref(0)
	const type = ref('')
	//图片上传回调
	const pictureUploadSuccess=(e)=>{
		form.value.picture = e
	}
	//支付类型列表
    const typeLists = ref(['','现金','积分','团购'])
	//获取唯一标识
	const getUUID =()=> {
      return new Date().getTime();
    }
	//重置
	const resetForm = () => {
		form.value = {
			orderid: getUUID(),
			goodid: '',
			goodname: '',
			picture: '',
			buynumber: '',
			price: '',
			discountprice: '',
			total: '',
			discounttotal: '',
			type: '',
			status: '',
			returnReason: '',
			address: '',
			tel: '',
			consignee: '',
			remark: '',
			logistics: '',
			role: '',
			addtime: '',
			userid: '',
			sfsh: '',
			shhf: '',
			longitude: '',
			latitude: '',
			fulladdress: '',
			shangjiazhanghao: '',
			couponNumber: '',
			orderNo: '',

		}
	}
	//获取info
	const getInfo = ()=>{
		context?.$http({
			url: `${tableName}/info/${id.value}`,
			method: 'get'
		}).then(res => {
			let reg=new RegExp('../../../file','g')
			res.data.data.logistics = res.data.data.logistics?(res.data.data.logistics.replace(reg,'../../../cl445746174/file')):'';
			form.value = res.data.data
			formVisible.value = true
            getPosition()
		})
	}
    const zoom = ref(4)
    const merchant = ref({})
    const mapRef = ref()
    const getPosition = ()=>{
        let url = `shangjia/query?shangjiazhanghao=${form.value.shangjiazhanghao}`
        context.$http.get(url).then(res=>{
            merchant.value = res.data.data
            nextTick(()=>{
                getDrivingRoute(
                    new AMap.LngLat(merchant.value.longitude,merchant.value.latitude), // 发货地
                    new AMap.LngLat(form.value.longitude,form.value.latitude)  // 收货地
                )
            })
        })
    }
    const drivingRoute = ref('')
    // 获取驾车路线
    const getDrivingRoute = async (start, end)=> {
        // 使用高德驾车路线规划服务
        const driving = new AMap.Driving({
            map: mapRef.value.$$getInstance(),
            showTraffic: true
        });
        // 执行搜索
        driving.search(start, end, (status, result) => {
            if (status === 'complete' && result.routes.length) {
                // 获取路线坐标数组,三维数组展开为一维
                let pathArr = result.routes[0].steps.map(step=>{
                    return step.path.map(p=>[p.lng,p.lat])
                }).reduce((a,b)=>a.concat(b))
                drivingRoute.value = pathArr;
                // 自动调整地图视野
                mapRef.value.$$getInstance().setFitView()
            } else {
                console.error('路线规划失败:', result);
            }
        });
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
		else if(formType == 'logistics'){
			isAdd.value = false
			formTitle.value = '修改物流信息'
			getInfo()
		}
		else if(formType == 'cross'){
			isAdd.value = true
			formTitle.value = formNames
			// getInfo()
			for(let x in row){
				if(x=='orderid'){
					form.value.orderid = row[x];
					disabledForm.value.orderid = true;
					continue;
				}
				if(x=='tablename'){
					form.value.tablename = row[x];
					disabledForm.value.tablename = true;
					continue;
				}
				if(x=='goodid'){
					form.value.goodid = row[x];
					disabledForm.value.goodid = true;
					continue;
				}
				if(x=='goodname'){
					form.value.goodname = row[x];
					disabledForm.value.goodname = true;
					continue;
				}
				if(x=='picture'){
					form.value.picture = row[x];
					disabledForm.value.picture = true;
					continue;
				}
				if(x=='buynumber'){
					form.value.buynumber = row[x];
					disabledForm.value.buynumber = true;
					continue;
				}
				if(x=='price'){
					form.value.price = row[x];
					disabledForm.value.price = true;
					continue;
				}
				if(x=='discountprice'){
					form.value.discountprice = row[x];
					disabledForm.value.discountprice = true;
					continue;
				}
				if(x=='total'){
					form.value.total = row[x];
					disabledForm.value.total = true;
					continue;
				}
				if(x=='discounttotal'){
					form.value.discounttotal = row[x];
					disabledForm.value.discounttotal = true;
					continue;
				}
				if(x=='type'){
					form.value.type = row[x];
					disabledForm.value.type = true;
					continue;
				}
				if(x=='status'){
					form.value.status = row[x];
					disabledForm.value.status = true;
					continue;
				}
				if(x=='returnReason'){
					form.value.returnReason = row[x];
					disabledForm.value.returnReason = true;
					continue;
				}
				if(x=='address'){
					form.value.address = row[x];
					disabledForm.value.address = true;
					continue;
				}
				if(x=='tel'){
					form.value.tel = row[x];
					disabledForm.value.tel = true;
					continue;
				}
				if(x=='consignee'){
					form.value.consignee = row[x];
					disabledForm.value.consignee = true;
					continue;
				}
				if(x=='remark'){
					form.value.remark = row[x];
					disabledForm.value.remark = true;
					continue;
				}
				if(x=='logistics'){
					form.value.logistics = row[x];
					disabledForm.value.logistics = true;
					continue;
				}
				if(x=='role'){
					form.value.role = row[x];
					disabledForm.value.role = true;
					continue;
				}
				if(x=='addtime'){
					form.value.addtime = row[x];
					disabledForm.value.addtime = true;
					continue;
				}
				if(x=='userid'){
					form.value.userid = row[x];
					disabledForm.value.userid = true;
					continue;
				}
				if(x=='longitude'){
					form.value.longitude = row[x];
					disabledForm.value.longitude = true;
					continue;
				}
				if(x=='latitude'){
					form.value.latitude = row[x];
					disabledForm.value.latitude = true;
					continue;
				}
				if(x=='fulladdress'){
					form.value.fulladdress = row[x];
					disabledForm.value.fulladdress = true;
					continue;
				}
				if(x=='shangjiazhanghao'){
					form.value.shangjiazhanghao = row[x];
					disabledForm.value.shangjiazhanghao = true;
					continue;
				}
				if(x=='couponNumber'){
					form.value.couponNumber = row[x];
					disabledForm.value.couponNumber = true;
					continue;
				}
				if(x=='discountAmount'){
					form.value.discountAmount = row[x];
					disabledForm.value.discountAmount = true;
					continue;
				}
				if(x=='orderNo'){
					form.value.orderNo = row[x];
					disabledForm.value.orderNo = true;
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
		typeLists.value = "现金,积分".split(',')
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
