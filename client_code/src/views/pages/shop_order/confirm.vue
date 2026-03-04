<template>
	<div class="confirm-page">
		<div class="section_title">
            <span>{{formName}}</span>
		</div>
		<el-card style="width: 100%">
            <el-button @click="backClick">返回</el-button>
			<el-divider content-position="center">地址</el-divider>
			<el-table :stripe='false' :data="addressList">
				<el-table-column label="选择"  :resizable='true' align="center" header-align="center">
					<template #default="scope">
						<el-radio :label="scope.$index" v-model="addressIndex">&nbsp;</el-radio>
					</template>
				</el-table-column>
				<el-table-column label="联系人" :resizable='true' align="center" header-align="center">
					<template #default="scope">
						{{scope.row.name}}
					</template>
				</el-table-column>
				<el-table-column label="联系电话" :resizable='true' align="center" header-align="center">
					<template #default="scope">
						{{scope.row.phone}}
					</template>
				</el-table-column>
				<el-table-column label="地址" :resizable='true' align="center" header-align="center">
					<template #default="scope">
						{{scope.row.address}}
					</template>
				</el-table-column>
			</el-table>
			<br>
			<div class="add_view">
				<el-button class="addressAdd_btn" @click="addressAdd" type="success">新增地址</el-button>
			</div>
			
			<el-divider content-position="center">商品清单</el-divider>
			<el-table :data="list" :stripe='false' >
				<el-table-column label="商品名称" :resizable='true' align="center" header-align="center">
					<template #default="scope">
						{{scope.row.goodname}}
					</template>
				</el-table-column>
				<el-table-column label="商品图片" :resizable='true' align="center" header-align="center">
					<template #default="scope">
						<img :src="scope.row.picture?((scope.row.picture.startsWith('http')?'':$config.url) + scope.row.picture):''" alt=""
							style="width: 150px;height: 150px;">
					</template>
				</el-table-column>
				<el-table-column label="价格" :resizable='true' align="center" header-align="center">
					<template #default="scope">
						<span style="font-size: 12px;" >￥</span>{{scope.row.realPrice}} 
					</template>
				</el-table-column>
				<el-table-column label="数量" :resizable='true' align="center" header-align="center">
					<template #default="scope">{{scope.row.buynumber}}
					</template>
				</el-table-column>
				<el-table-column label="总价" :resizable='true' align="center" header-align="center">
					<template #default="scope">
						<span style="font-size: 12px;" >￥</span>{{(scope.row.realPrice * scope.row.buynumber).toFixed(2)}} 
					</template>
				</el-table-column>
			</el-table>
            <div style="width: 100%;padding: 12px;box-sizing: border-box;display: flex;align-items: center;" v-if="payType!=2">
                <span style="width: 80px; font-size: 14px;">优惠券：</span>
                <el-button v-if="!coupon_selected.id" @click="changeCoupon">选择优惠券</el-button>
                <el-button v-if="coupon_selected.id" type="success" @click="changeCoupon">满{{coupon_selected.fullAmount}}减{{coupon_selected.discountAmount}}</el-button>
            </div>
			<el-divider content-position="center">备注</el-divider>
			
			<el-input v-model="remark" placeholder="请输入备注" type="textarea"></el-input>
			<div class="order_confirm_btn" >
				<div class="order_confirm_price">
					总价：<span class="unit" >￥</span><span class="number">{{totalPrice}}</span>
				</div>
				<el-button class="pay_btn"  @click="payClick" type="success">余额支付</el-button>
			</div>
		</el-card>
		<br>
		<formModel ref="formModelRef" @formModelChange="formModelChange"></formModel>
		<el-dialog
			title="优惠券"
			v-model="couponVisible"
			width="85%">
			<div class="coupon_list">
				<div v-if="coupon_selected.id">
					<el-button @click="clearCoupon" size='mini'>不使用优惠券</el-button>
				</div>
				<div class="coupon" v-for="(item,index) in couponList" :key="index" :class="!checkCondition(item)?'coupons':''">
					<div class="coupon_left">
						<div class="name">{{item.couponName}}</div>
						<div class="name">满{{item.fullAmount}}减{{item.discountAmount}}</div>
						<div class="date">{{item.effectTime}}-{{item.expireTime}}</div>
						<div class="date">{{item.remark}}</div>
						<div class="date1" v-if="item.shangjiazhanghao">仅限 {{item.shangjiazhanghao}} 商品使用</div>
						<div class="date1" v-else>全品类商品可使用</div>
					</div>
					<div class="coupon_right">
						<div class="price">￥<span class="num">{{item.discountAmount}}</span></div>
						<div class="btn" @click="useCoupon(item)" v-if="checkCondition(item)">
							立即使用
						</div>
						<div class="btn" v-else>
							不满条件
						</div>
					</div>
				</div>
				<div class="noList" v-if="!couponList.length">
					暂无优惠券
				</div>
			</div>
		</el-dialog>
	</div>
</template>

<script setup>
	import formModel from '../shop_address/formModel'
	import {
		ref,
		getCurrentInstance,
		nextTick,
		computed,
	} from 'vue';
	import {
		useRoute,
		useRouter
	} from 'vue-router';
    const moment = window.moment
    import {
        useStore
    } from 'vuex';
    const store = useStore()
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const router = useRouter()
	const route = useRoute()
	//基础信息
	const tableName = 'orders'
	const formName = '订单提交'
	//基础信息
    // 返回
    const backClick = () =>{
        history.back()
    }
	const list = ref([])
	const remark = ref('')
    //付款类型
    const payType = ref(1)
	//获取收货地址
	const addressIndex = ref(-1)
	const addressList = ref([])
	const getAddressList = () => {
		context.$http.get('address/page?limit=99').then(res => {
			for (let x in res.data.data.list) {
				if (res.data.data.list[x].isdefault == '是') {
					addressIndex.value = Number(x)
				}
			}
			addressList.value = res.data.data.list
		})
	}
	//新增收货地址
	const formModelRef = ref(null)
	const addressAdd = () => {
		formModelRef.value.init(null, '新增收货地址')
	}
	const formModelChange = () => {
		getAddressList()
	}
	//统计总价
	const totalPrice = computed(() => {
		let price = 0
		list.value.forEach(item=>{
			price += item.realPrice * item.buynumber
		})
		if(coupon_selected.value.id){
			price -= coupon_selected.value.discountAmount
		}
		return Number(price).toFixed(2)
	})
	//获取订单id
	const createOrder = () => {
		return moment().format('YYYYMMDDHHmmssSSS')+Math.random().toString().slice(2, 5);
	}
	//正常支付
	const payClick = async () => {
		//是否选择收货地址
		if (addressIndex.value == -1) {
			context.$toolUtil.message('请选择收货地址', 'error')
			return false
		}
        let orderNo = createOrder() + 1
        let orders = []
        for(let i in list.value){
            let item = list.value[i]
            let res = await context.$http.get(`${item.tablename}/info/${item.goodid}`)
            let data = res.data.data
            let orderid = createOrder()
            orders.push({
                orderid: orderid,
                tablename: item.tablename,
                userid: user.value.id,
                role: context.$toolUtil.storageGet('frontSessionTable'),
                goodid: item.goodid,
                goodname: item.goodname,
                shangjiazhanghao: item.shangjiazhanghao,
                picture: item.picture,
                buynumber: item.buynumber,
                discountprice: item.realPrice,
                discounttotal: Number(item.realPay.toFixed(2)),
                price: item.realPrice,
                total: Number(item.realPay.toFixed(2)),
                type: payType.value,
                //收货地址
                address: addressList.value[addressIndex.value].address,
                tel: addressList.value[addressIndex.value].phone,
                consignee: addressList.value[addressIndex.value].name,
                fulladdress: addressList.value[addressIndex.value].address,
                longitude:addressList.value[addressIndex.value].longitude,
                latitude:addressList.value[addressIndex.value].latitude,
                remark: remark.value,
                status: '未支付',
                orderNo: orderNo,
                goods:data
            })
        }
        if (coupon_selected.value.id) {
            orders.forEach(order=>{
                order.couponNumber = coupon_selected.value.couponNumber
                order.discountamount = coupon_selected.value.discountamount
            })
            coupon_selected.value.status = '已使用'
            context.$http.post(`mycoupon/update`, coupon_selected.value)
        }
        //新增订单
        Promise.all(orders.map(order=>{ //批量下单，返回primise数组，等待所有请求都完成
            return context.$http.post('orders/add',order)
        })).then(resArr=>{
            //如果存在id。说明从购物车跳转,需要删除已下单的商品
            list.value.forEach(item=>{
                if(item.id){
                    context.$http({url:'cart/delete',method:'post',data:[item.id]})
                }
            })
            let total = 0
            orders.forEach(order=>{
                total+=Number(order.total)
            })
            //判断用户余额是否充足
            if(Number(user.value.money) < Number(total.toFixed(2))){
                context.$toolUtil.message(`余额不足，请先充值`,'error',()=>{
                    router.push(`/index/${context.$toolUtil.storageGet('frontSessionTable')}Center`)
                })
                return false
            }
            //减去用户余额
            user.value.money = (parseFloat(user.value.money) - parseFloat(total)).toFixed(2)
            context.$http.post(`${context.$toolUtil.storageGet('frontSessionTable')}/update`,user.value)

            orders.forEach(order=>{
                //如果商品有库存 减去商品库存
                if(order.goods.hasOwnProperty('alllimittimes')){
                    order.goods.alllimittimes = order.goods.alllimittimes - order.buynumber
                    if(order.goods.alllimittimes==0){
                        order.goods.isShelves = 0
                    }
                }
                context.$http.post(`${order.tablename}/update`,order.goods)
                //更新订单状态
                context.$http.get('orders/list',{
                    params:{
                        page:1,
                        limit:1,
                        orderid: order.orderid
                    }
                }).then(res=>{
                    res.data.data.list[0].status = '已支付'
                    context.$http.post('orders/update',res.data.data.list[0])
                })
            })
            //下单完成，跳转订单
            context.$toolUtil.message('购买成功','success',()=>{
                router.push('/index/ordersList')
            })
        })
	}

	//获取个人信息
	const user = ref({})
	const couponVisible = ref(false)
	const coupon_selected = ref({})
	const couponList = ref([])
	const clearCoupon = ()=>{
		coupon_selected.value = {}
	}
	const o_priceTotal = computed(()=>{
		let total = 0
		list.value.forEach(item=>{
			total += item.price * item.buynumber
		})
		return total
	})
	const checkCondition = (coupon)=>{
		if(coupon.shangjiazhanghao && list.value.find(item=>item.shangjiazhanghao!=coupon.shangjiazhanghao))return false
		if(o_priceTotal.value<coupon.fullAmount)return false
		if(coupon.status=='可使用')return true
	}
	const useCoupon = (coupon)=>{
		coupon_selected.value = coupon
		couponVisible.value = false
		let quota = coupon.discountAmount
		list.value.forEach((item,index)=>{
			let d = 0
			let t = item.price*item.buynumber
			if(index<list.value.length-1){
				d = t/o_priceTotal.value*coupon.discountAmount
				quota -= d
			}else{  //最后一个商品占用剩余优惠额度
				d = quota
			}
			item.realPay = Number((t-d).toFixed(2))
		})
	}
	const changeCoupon = ()=>{
		couponVisible.value = true
		getMyList()
	}
	const getMyList = ()=> {
		context.$http.get('mycoupon/page').then(res => {
			if (res.data && res.data.code == 0) {
				res.data.data.list.forEach(item=>{
					if(moment()<moment(item.effectTime)||moment()>moment(item.expireTime)){//当前时间<生效时间||当前时间>过期时间
						return false
					}
				})
				couponList.value = res.data.data.list.filter(item=>item.status=='可使用')
			}
		})
	}
	//初始化
	const init = () => {
		getAddressList()
		if (route.query.type) {
			payType.value = route.query.type
		}
        store.dispatch('user/getSession').then(res=>{
            user.value = res.data.data
            list.value = JSON.parse(context.$toolUtil.storageGet('orders_good'))
            list.value.forEach(item=>{
                item.realPrice = item.price
                item.realPay=Number(item.realPrice*item.buynumber)
            })
        })
	}
	init()
</script>

<style lang="scss">
.coupon_list {
	width: 100%;
	display: flex;
	flex-wrap: wrap;

	.coupon {
		width: 31%;
		background: url('http://clfile.zggen.cn/20240817/3d727f394907414795e8d931697d43c2.webp');
		background-repeat: no-repeat;
		background-position: center center;
		background-size: cover;
		padding: 60px 30px;
		display: flex;
		align-items: center;
		margin: 0 1% 20px;

		position: relative;

		.no-coupon {
			position: absolute;
			width: 80px;
			right: 20px;
			top: 20px;
		}

		.coupon_left {
			flex: 1;
			color: #000;

			.name {
				font-size: 22px;
				line-height: 1.5;
			}

			.date {
				font-size: 14px;
				line-height: 1.5;
			}
			.date1 {
				font-size: 12px;
				line-height: 1.5;
				color: #FF0800;
			}
		}

		.coupon_right {
			display: flex;
			flex-direction: column;
			align-items: center;

			.price {
				color: #FF0800;
				font-size: 20px;
				padding: 0 0 10px;

				.num {
					font-size: 28px;
				}
			}

			.btn {
				width: 100px;
				height: 30px;
				line-height: 30px;
				border-radius: 30px;
				background: #FF0800;
				text-align: center;
				color: #fff;
				font-size: 18px;
				cursor: pointer;
			}
		}
	}

	.coupons {
		filter: grayscale(100%);
		order:1
	}

	.noList {
		color: #9e9e9e;
		width: 100%;
		text-align: center;
		padding: 60px 0;
	}
}
.confirm-page {
    width: 100%;
    padding: 0 7%;
    margin: 0 auto 30px;
    background:#FFFFFF;
}
.confirm-page .el-card.is-always-shadow,.confirm-page  .el-card.is-hover-shadow:focus,.confirm-page  .el-card.is-hover-shadow:hover {
    box-shadow: none;
}
.confirm-page .section_title {
    font-size: 26px;
    font-weight: 500;
    padding: 0 0 20px;
    color: var(--theme);
    text-align: left;
    position: relative;
}
.confirm-page .order_confirm_btn {
    display: flex;
    align-items: center;
    padding: 20px;
}

.confirm-page .order_confirm_price {
    font-size: 18px;
}
.confirm-page .order_confirm_price .number {
    color: red;
    font-size: 26px;
    font-weight: 700;
}
.confirm-page .order_confirm_price .unit {
    color: red;
}
.confirm-page .order_confirm_btn .el-button {
    background: var(--theme);
    border: none;
    height: 40px;
    width:130px;
    border-radius:10px;
}
/* nf9 */
.confirm-page .el-card{
    border:none;
}
.confirm-page .section_title span::before{
    width:100%;
    height:1px!important;
    content:'';
    background:#0949F7;
    top:40px;
    left:0px;
    position:absolute;
}
.confirm-page .el-divider--horizontal{
    border:none;
    margin:50px 0px;
}
.confirm-page .el-divider__text.is-center{
background: #EBF2FD;
border-radius: 10px 10px 10px 10px;
width: 100%;
height: 60px;
line-height:60px;
    text-align:center;
font-weight: 700;
font-size: 24px;
color: #0660F8;
}

.confirm-page .el-table__row{
    height:160px;
}
.confirm-page .el-table--enable-row-hover .el-table__body tr:hover>td.el-table__cell{
background: #EBF2FD;
}
.confirm-page .el-textarea__inner{
    min-height:229px!important;
}
.confirm-page .order_confirm_btn{
    justify-content:flex-end;
    gap:10px;
}


.confirm-page button.el-button.el-button--success.alipay_btn {
background: #0B9E12;
}

.confirm-page button.el-button.el-button--success.QRcode_btn {
background: #587FE8;
}

.confirm-page button.el-button.el-button--success.jf_btn {
background: #4378D1;
}
.confirm-page .el-table__inner-wrapper {
    border: 1px solid #EEEEEE!important;
}
</style>