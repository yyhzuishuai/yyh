<template>
	<div class="order-page">
        <div class="breadcrumb-wrapper" style="width: 100%;">
            <div class="back_view">
                <el-button class="back_btn" @click="backClick">返回</el-button>
            </div>
        </div>
		<div class="section_title">
            <span>{{formName}}</span>
		</div>
		<el-tabs v-model="orderStatus" type="card" class="demo-tabs" @tab-change="statusChange" style="width: 100%;">
			<el-tab-pane label="全部" :name="''"></el-tab-pane>
			<el-tab-pane v-if="btnAuth('orders/未支付','查看')" label="未支付" name="未支付"></el-tab-pane>
			<el-tab-pane label="已支付" name="已支付"></el-tab-pane>
			<el-tab-pane label="已发货" name="已发货"></el-tab-pane>
			<el-tab-pane label="已完成" name="已完成"></el-tab-pane>
			<el-tab-pane label="已退款" name="已退款"></el-tab-pane>
			<el-tab-pane label="已取消" name="已取消"></el-tab-pane>
		</el-tabs>
		<el-table v-loading="listLoading" border :stripe='false' @selection-change="handleSelectionChange" ref="table"
			:data="list" @row-click="listChange" cell-class-name="operation_cell">
			<el-table-column type="selection" width="55" :resizable='true' align="left" header-align="left" />
			<el-table-column label="序号" width="120" :resizable='true' align="left" header-align="left">
				<template #default="scope">{{ scope.$index + 1}}</template>
			</el-table-column>
			<el-table-column label="订单编号" :resizable='true' align="left" header-align="left">
				<template #default="scope">
					{{scope.row.orderid}}
				</template>
			</el-table-column>
			<el-table-column label="商品" width="200px" :resizable='true' align="left" header-align="left">
				<template #default="scope">
					<div style="display: flex;align-items: center;">
						<div v-if="scope.row.picture">
							<el-image v-if="scope.row.picture.substring(0,4)=='http'" preview-teleported
								:preview-src-list="[scope.row.picture.split(',')[0]]"
								:src="scope.row.picture.split(',')[0]" style="width:100px;height:100px"></el-image>
							<el-image v-else preview-teleported
								:preview-src-list="[$config.url+scope.row.picture.split(',')[0]]"
								:src="$config.url+scope.row.picture.split(',')[0]" style="width:100px;height:100px">
							</el-image>
						</div>
						<div v-else>无图片</div>
						<span style="margin-left: 10px;">{{scope.row.goodname}}</span>
					</div>
				</template>
			</el-table-column>
			<el-table-column label="购买数量" :resizable='true' align="left" header-align="left">
				<template #default="scope">
					{{scope.row.buynumber}}
				</template>
			</el-table-column>
			<el-table-column label="价格" :resizable='true' align="left" header-align="left">
				<template #default="scope">
					<span v-if="scope.row.type!=2" style="font-size: 12px;">￥</span>{{scope.row.price}} <span
						v-if="scope.row.type==2">积分</span>
				</template>
			</el-table-column>
			<el-table-column label="总价" :resizable='true' align="left" header-align="left">
				<template #default="scope">
					<span v-if="scope.row.type!=2" style="font-size: 12px;">￥</span>{{scope.row.total}} <span
						v-if="scope.row.type==2">积分</span>
				</template>
			</el-table-column>
			<el-table-column label="地址" :resizable='true' align="left" header-align="left">
				<template #default="scope">
					{{scope.row.address}}
				</template>
			</el-table-column>
			<el-table-column label="电话" :resizable='true' align="left" header-align="left">
				<template #default="scope">
					{{scope.row.tel}}
				</template>
			</el-table-column>
			<el-table-column label="收货人" :resizable='true' align="left" header-align="left">
				<template #default="scope">
					{{scope.row.consignee}}
				</template>
			</el-table-column>
			<el-table-column label="备注" :resizable='true' align="left" header-align="left">
				<template #default="scope">
					{{scope.row.remark}}
				</template>
			</el-table-column>
			<el-table-column label="下单时间" :resizable='true' align="left" header-align="left">
				<template #default="scope">
					{{scope.row.addtime}}
				</template>
			</el-table-column>
			<el-table-column label="操作" class-name="operation-cell"
                             :resizable='true'
                             align="left"
                             header-align="left"                              width="250px">
				<template #default="scope">
					<el-button class="pay_btn" v-if="scope.row.status=='未支付'" type="primary" @click="payClick(scope.row)">
						余额支付
					</el-button>
					<el-button class="cancel_btn" v-if="scope.row.status=='未支付'" type="danger" @click="cancelClick(scope.row)">
						取消
					</el-button>
					<el-button class="refundPrice_btn" v-if="scope.row.status=='已支付'" type="danger" @click="refundPriceClick(scope.row)">
						退款
					</el-button>
                    <template v-if="!scope.row.sfsh||scope.row.sfsh=='否'">
                        <el-button class="refundGood_btn" v-if="scope.row.status=='已完成'&&scope.row.sfsh!='否'" type="danger" @click="refundGoodClick(scope.row)">
                            退货
                        </el-button>
                        <el-button class="refundGood_btn" v-else-if="scope.row.sfsh=='否'" type="danger" @click="refundGoodClick(scope.row)">
                            <el-tooltip :content="scope.row.shhf">
                                <el-icon><WarningFilled /></el-icon>
                            </el-tooltip>
                            审核驳回
                        </el-button>
                    </template>
                    <el-button class="refundGood_btn" v-else-if="scope.row.sfsh=='待审核'" type="danger">
                        退货审核中
                    </el-button>
					<el-button class="logistics_btn" v-if="scope.row.logistics" type="primary" @click="logisticsClick(scope.row)">
						物流
					</el-button>
					<el-button class="confirm_btn" v-if="scope.row.status=='已发货'" type="success" @click="confirmGoodClick(scope.row)">
						确认收货
					</el-button>
					<el-button class="toDetail_btn" v-if="scope.row.status=='已完成'" type="warning" @click="toDetailClick(scope.row)">
						评论
					</el-button>
				</template>
			</el-table-column>
		</el-table>
		<el-pagination
			background 
			:layout="layouts.join(',')"
			:total="total" 
			:page-size="listQuery.limit"
            v-model:current-page="listQuery.page"
			prev-text="上一页"
			next-text="下一页"
			:hide-on-single-page="false"
			@size-change="sizeChange"
			@current-change="currentChange" />
		<el-dialog v-model="logisticsVisible" title="物流信息" width="70%">
			<div v-html="logisticsText"></div>
            <div class="map-wrapper" style="width: 100%;height: 500px;margin-top: 20px;" v-if="merchant.id&&detail.id">
                <el-amap ref="mapRef"
                         :min-zoom="4"
                         :max-zoom="22"
                         :center="[detail.longitude,detail.latitude]"
                         :zoom="zoom">
                    <el-amap-marker :position="[merchant.longitude,merchant.latitude]" :offset="[-10,-32]">
                                    <span style="white-space: nowrap;display: flex;align-items: center;color: #2891ff;">
                                        <img title="发货地" style="width: 19px;height: 32px" src="http://webapi.amap.com/theme/v1.3/markers/b/mark_bs.png"/>
                                        发货地
                                    </span>
                    </el-amap-marker>
                    <el-amap-marker :position="[detail.longitude,detail.latitude]" :offset="[-10,-32]">
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
		</el-dialog>
        <el-dialog title="请填写退货理由" v-model="returngoodVisible" width="50%">
            <el-input v-model="returnGoodForm.returnReason" type="textarea" placeholder="退货理由" rows="5"></el-input>
            <el-tag v-for="(item,index) in reasonList" :key="index" :type="item.type" style="cursor: pointer;margin: 5px 5px 0 0;" @click="reasonClick(item.title)">{{item.title}}</el-tag>
            <div style="text-align: right">
                <el-button type="primary" style="margin-left: 10px;" @click="returnGoodSave">确认</el-button>
                <el-button type="danger" style="margin-left: 10px;" @click="returngoodVisible=false">取消</el-button>
            </div>
        </el-dialog>
	</div>
</template>

<script setup>
	import {
		ref,
		getCurrentInstance,
		nextTick,
	} from 'vue';
	import {
		useRoute,
		useRouter
	} from 'vue-router';
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const router = useRouter()
	const route = useRoute()
	//基础信息
	const tableName = 'orders'
	const formName = '商品订单'
	const table = ref(null)
	const selRows = ref([])
	const list = ref([])
	const listLoading = ref(false)
	const listQuery = ref({
		page: 1,
		limit: 20,
		userid: context?.$toolUtil.storageGet('userid'),
		sort:'id',
		order:'desc'
	})
    //基础信息
    const orderStatus = ref('')
    if(['未支付'  ,'已支付','已发货','已完成','已退款','已取消'].includes(route.query.menuJump)){
        orderStatus.value = route.query.menuJump
    }

    //权限验证
    const btnAuth = (e,a)=>{
        return context?.$toolUtil.isBackAuth(e,a)
    }
    //返回
    const backClick = () => {
        router.push(`/index/${context?.$toolUtil.storageGet('frontSessionTable')}Center`)
    }

	//多选
	const handleSelectionChange = (e) => {
		selRows.value = e
	}
	//列表数据
	const getList = () => {
		listLoading.value = true
		let params = JSON.parse(JSON.stringify(listQuery.value))
		if (orderStatus.value) {
			params['status'] = orderStatus.value
		}
		context?.$http({
			url: 'orders/list',
			method: 'get',
			params: params
		}).then(res => {
			listLoading.value = false
			list.value = res.data.data.list
			total.value = Number(res.data.data.total)
		})
	}
	//分页
	const layouts = ref(["total","prev","pager","next","sizes"])
	const total = ref(0)
	const sizeChange = (size) => {
		listQuery.value.limit = size
		getList()
	}
	const currentChange = (page) => {
		listQuery.value.page = page
		getList()
	}
	//分页

	//tab切换
	const statusChange = () => {
		listQuery.value.page = 1
		getList()
	}
	//余额支付
	const payClick = (row) => {
		ElMessageBox.confirm(`是否确定支付该订单？`, '提示', {
			confirmButtonText: '是',
			cancelButtonText: '否',
			type: 'warning',
		}).then(() => {
			context?.$http({
				url: `${row.tablename}/info/${row.goodid}`,
				method: 'get'
			}).then(res => {
				let data = res.data.data
				if (userinfo.value.money < row.total) {
					context?.$toolUtil.message('余额不足', 'error')
					return
				}
				//如果商品存在积分，则累加用户积分
				if (data.jf) {
					userinfo.value.jf = parseInt(userinfo.value.jf) + parseInt(row.total)
				}
				//减去用户余额
				userinfo.value.money = (parseFloat(userinfo.value.money) - parseFloat(row.total)).toFixed(2)
				//如果商品存在库存，则减去商品库存
				if (data.alllimittimes) {
					data.alllimittimes = parseInt(data.alllimittimes) - parseInt(row.buynumber)
				}
                //更新商品信息
                context?.$http.post(`${row.tablename}/update`,data)

				//更新用户信息
				context?.$http({
					url: `${context?.$toolUtil.storageGet('frontSessionTable')}/update`,
					method: 'post',
					data: userinfo.value
				}).then(obj => {
					row.status = '已支付'
					//修改订单状态
					context?.$http({
						url: 'orders/update',
						method: 'post',
						data: row
					}).then(res1 => {
                        context.$message.success('支付成功')
                        getSession()
                        statusChange()
					})
				})
			})
		}).catch(_ => {})
	}
	//取消订单
	const cancelClick = (row) => {
        let orders = [row]
        //多个订单共用优惠券，须一起取消
        if(row.couponNumber){
            orders = list.value.filter(item=>{
                return item.couponNumber==row.couponNumber && row.status == item.status
            })
        }
		ElMessageBox.confirm(orders.length>1?'多个订单使用了同一优惠，确定要一起取消吗？':'是否取消该订单？', '提示', {
			confirmButtonText: '是',
			cancelButtonText: '否',
			type: 'warning',
		}).then(() => {
            let primiseArr = []
            //未完成支付，未减去用户余额，未减去库存，未累加积分，只占用了优惠券
            orders.forEach(item=>{
                item.status = '已取消'
                primiseArr.push(context.$http.post('orders/update',item))   //将请求返回的primise对象放到数组中
            })
            Promise.all(primiseArr).then(resArr=>{
                context.$message.success("取消成功")
                if(orders[0].couponNumber){
                    returnCoupon(orders[0].couponNumber)
                }
                getSession()
                statusChange()
            })
		}).catch(_ => {})
	}
    //返回商品对象，如果商品存在库存,则返还库存
    const returnLimit = async (order)=>{
        let res = await context.$http.get(`${order.tablename}/info/${order.goodid}`)
        let data = res.data.data
        if(data.alllimittimes){ //如果商品存在库存，则加回去
            data.alllimittimes = parseInt(data.alllimittimes) + parseInt(order.buynumber)
            context.$http.post(`${order.tablename}/update`,data)
        }
        return data
    }
    //返还优惠券
    const returnCoupon = (couponNumber)=>{
        context.$http.get('mycoupon/page',{
            params:{
                couponNumber:couponNumber
            }
        }).then(res=>{
            let coupon = res.data.data.list[0]
            coupon.status = '可使用'
            context.$http.post('mycoupon/update',coupon)
        })
    }
	// 退款
	const refundPriceClick = (row) => {
        let orders = [row]
        //多个订单共用优惠券，须一起退款
        if(row.couponNumber){
            orders = list.value.filter(item=>{
                return item.couponNumber==row.couponNumber && row.status == item.status
            })
        }
		ElMessageBox.confirm(orders.length>1?'多个订单使用了同一优惠，确定要一起退款吗？':'是否对该订单进行退款操作？', '提示', {
			confirmButtonText: '是',
			cancelButtonText: '否',
			type: 'warning',
		}).then(async () => {
            let primiseArr = []
            for(let i in orders){
                let item = orders[i]
                item.status = '已退款'
                let data = await returnLimit(row)
                if(item.type == 2){  //积分兑换，返还积分
                    userinfo.value.jf = parseInt(userinfo.value.jf) + parseInt(item.total)
                }else{
                    if(data.jf){    //商品存在赠送积分，则减去赠送的积分
                        userinfo.value.jf = parseInt(userinfo.value.jf) - parseInt(item.total)
                    }
                    //返还余额
                    userinfo.value.money = (parseFloat(userinfo.value.money) + parseFloat(item.total)).toFixed(2)
                }
                primiseArr.push(context.$http.post('orders/update',item))
            }
            Promise.all(primiseArr).then(resArr=>{  //等待全部请求完成
                if(orders[0].couponNumber){     //如果使用了优惠券，则返还优惠券
                    returnCoupon(orders[0].couponNumber)
                }
                // 更新用户信息
                context.$http.post(`${context.$toolUtil.storageGet('frontSessionTable')}/update`,userinfo.value).then(res=>{
                    context.$message.success("退款成功")
                    getSession()
                    statusChange()
                })
            })
		}).catch(_ => {})
	}
    const returngoodVisible = ref(false)
    const returnGoodForm = ref({})
    const reasonList = ref([{
        title: '买错了',
        type: 'warning'
    }, {
        title: '质量问题',
        type: 'danger'
    }, {
        title: '不想要了',
        type: 'info'
    }])
    const returnGoodSave=()=> {
        context.$confirm(`确定退货吗？审核通过后退款金额将返回账户中。`, "提示", {
            confirmButtonText: "确定",
            cancelButtonText: "取消",
            type: "warning"
        }).then(() => {
            returnGoodForm.value.sfsh = '待审核'
            context.$http.post(`orders/update`, returnGoodForm.value).then(res => {
                context.$message.success('退货申请已提交');
                getList()
                returngoodVisible.value = false
            })
        }).catch(()=>{});
    }
    const reasonClick = (name)=>{
        if (returnGoodForm.value.returnReason) {
            returnGoodForm.value.returnReason = returnGoodForm.value.returnReason + '，' + name
        } else {
            returnGoodForm.value.returnReason = name
        }
    }
	// 退货
	const refundGoodClick = (row) => {
		ElMessageBox.confirm(`${row.sfsh=='否'?'确定要重新提交申请吗？':'确定要申请退货？'}`, '提示', {
			confirmButtonText: '是',
			cancelButtonText: '否',
			type: 'warning',
		}).then(() => {
            returnGoodForm.value = row
            returngoodVisible.value = true
		}).catch(()=>{})
	}
	//确认收货
	const confirmGoodClick = (row) => {
		ElMessageBox.confirm(`是否确认收货？`, '提示', {
			confirmButtonText: '是',
			cancelButtonText: '否',
			type: 'warning',
		}).then(() => {
			//直接完成支付，已减去用户余额，已减去库存，已累加积分，则不需要用户操作跟商品库存操作
			row.status = '已完成'
			//修改订单状态
			context?.$http({
				url: 'orders/update',
				method: 'post',
				data: row
			}).then(res1 => {
                context.$message.success('确认收货成功')
                getSession()
                statusChange()
			})
		}).catch(_ => {})
	}
	//物流
	const logisticsVisible = ref(false)
	const logisticsText = ref('')
	const logisticsClick = (row) => {
		logisticsText.value = row.logistics
		logisticsVisible.value = true
        detail.value = row
        getPosition()
	}
    const detail = ref({})
    const zoom = ref(4)
    const merchant = ref({})
    const mapRef = ref()
    const getPosition = ()=>{
        let url = `shangjia/query?shangjiazhanghao=${detail.value.shangjiazhanghao}`
        context.$http.get(url).then(res=>{
            merchant.value = res.data.data
            nextTick(()=>{
                getDrivingRoute(
                    new AMap.LngLat(merchant.value.longitude,merchant.value.latitude), // 发货地
                    new AMap.LngLat(detail.value.longitude,detail.value.latitude)  // 收货地
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
        // 搜索路线
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
	//去评论
	const toDetailClick = (row) => {
		router.push(`/index/${row.tablename}Detail?id=${row.goodid}`)
	}
	const userinfo = ref({})
	const getSession = () => {
		context?.$http({
			url: `${context?.$toolUtil.storageGet('frontSessionTable')}/session`,
			method: 'get'
		}).then(res => {
			userinfo.value = res.data.data
		})
	}
	const init = () => {
		getSession()
		getList()
	}
	init()
</script>

<style lang="scss">
.order-page {
    width: 100%;
    padding: 0 7%;
    margin: 0 auto 30px;
    background: #FFFFFF;
}
.order-page .back_view {
    width: 100%;
    padding: 20px 0;
    text-align: right;
}
.order-page .section_title {
    font-size: 26px;
    color: var(--theme);
    line-height: 0;
    text-align: left;
    position: relative;
    top: -36px;
}
.order-page .operation_cell .cell {
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
}

.order-page .el-tabs__header{
    background: #fff;
}


/* 按钮 */
.order-page .operation_cell .el-button {
    margin: 0;
    background: var(--theme);
    border: 0;
}
.order-page .operation_cell .el-button:hover {
    opacity: 0.8;
}
/* 余额支付 */
.order-page .operation_cell .el-button.pay_btn{
   background: #0660F8;   
}
/* 沙箱支付 */
.order-page .operation_cell .el-button.alipay_btn{
    background: #38af8f;
}
/* 二维码支付 */
.order-page .operation_cell .el-button.QRcode_btn{
   background: #587FE8;
}
/* 取消订单 */
.order-page .operation_cell .el-button.cancel_btn{
    background: #ee578c;
}
/* 兑换 */
.order-page .operation_cell .el-button.exchange_btn{
    background: #0B9E12;
}
/* 退款 */
.order-page .operation_cell .el-button.refundPrice_btn{
    background: #cb3b3b;
}
/* 退货 */
.order-page .operation_cell .el-button.refundGood_btn{
    background: #fb1c1c;
}
/* 物流 */
.order-page .operation_cell .el-button.logistics_btn{
    background: #1db998;
}
/* 确认收货 */
.order-page .operation_cell .el-button.confirm_btn{
    background: var(--theme);
}
/* 评论 */
.order-page .operation_cell .el-button.toDetail_btn{
    background: #5581c9;
}
/* nf9 */
.order-page .section_title span::before{
    width:100%;
    height:1px!important;
    content:'';
    background:#0949F7;
    top:20px;
    left:0px;
    position:absolute;
}
.order-page .el-tabs--card>.el-tabs__header .el-tabs__nav{
    border:none;
        background: #EBF2FD;
border-radius: 10px 10px 10px 10px;
    width:100%;
    display:flex;
    justify-items:center;
    gap:20px;
    padding:12px 20px;
    margin:20px 0px;
}
.order-page .el-tabs--card>.el-tabs__header .el-tabs__item {
   background: #F8F9FB!important;
border-radius: 5px 5px 5px 5px;
    flex:1;
    font-weight: 400;

color: #000000;
}
.order-page .el-tabs--card>.el-tabs__header{
    margin:20px 0;
}


.order-page .el-tabs--card>.el-tabs__header .el-tabs__item.is-active{
    background: #0660F8!important;
border-radius: 5px 5px 5px 5px;
color:#FFFFFF;
    font-weight: 400;
}


</style>