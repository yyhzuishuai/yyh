<template>
	<div class="cart-page">
        <div class="breadcrumb-wrapper" style="width: 100%;">
            <div class="back_view">
                <el-button class="back_btn" @click="backClick">返回</el-button>
            </div>
        </div>
		<div class="section_title">
            <span>{{formName}}</span>
		</div>
		<br>
		<el-table :data="list" v-loading="listLoading"  @selection-change="handleSelectionChange" ref="table" :stripe='false'
			@row-click="listChange">
			<el-table-column type="selection" width="55" :resizable='false' align="center" header-align="center" />
			<el-table-column label="商品名称" :resizable='false' align="center" header-align="center">
				<template #default="scope">
					{{scope.row.goodname}}
				</template>
			</el-table-column>
			<el-table-column label="商品图片" :resizable='false' align="center" header-align="center">
				<template #default="scope">
					<img :src="scope.row.picture?((scope.row.picture.startsWith('http')?'':$config.url) + scope.row.picture):''" alt=""
						style="width: 150px;height: 150px;">
				</template>
			</el-table-column>
			<el-table-column label="价格" :resizable='false' align="center" header-align="center">
				<template #default="scope">
					<span style="font-size: 12px;">￥</span>{{scope.row.realPrice}}
				</template>
			</el-table-column>
			<el-table-column label="数量" :resizable='false' align="center" header-align="center">
				<template #default="scope">
					<el-input-number v-model="scope.row.buynumber" :min="1"
						@change="numberChange(scope.row)" @click.stop></el-input-number>
				</template>
			</el-table-column>
			<el-table-column label="总价" :resizable='false' align="center" header-align="center">
				<template #default="scope">
					<span style="font-size: 12px;">￥</span>{{(scope.row.realPrice * scope.row.buynumber).toFixed(2)}}
				</template>
			</el-table-column>
			<el-table-column label="操作" class-name="operation-cell" :resizable='false' align="center" header-align="center">
				<template #default="scope">
					<el-button class="view_btn" type="primary" @click.native="detailClick(scope.row)">查看详情</el-button>
					<el-button class="del_btn" type="danger" @click.native="delClick(scope.row.id)">删除</el-button>
				</template>
			</el-table-column>
		</el-table>
		<br>
		<div class="cart_confirm">
			<div class="cart_price">
				总价：<span class="unit">￥</span><span class="number">{{allPrice()}}</span>
			</div>
			<el-button class="confirm_btn" @click="payClick" type="success">提交订单</el-button>
		</div>
	</div>
</template>

<script setup>
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
    import {
        useStore
    } from 'vuex';
    const store = useStore()
    const user = computed(()=>store.getters['user/session'])
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const router = useRouter()
	const route = useRoute()
	//基础信息
	const tableName = 'cart'
	const formName = '购物车'
	const table = ref(null)
	const selRows = ref([])
	const list = ref([])
	const listLoading = ref(false)
	const listQuery = ref({
		page: 1,
		limit: 20,
		userid: context?.$toolUtil.storageGet('userid')
	})
	//基础信息
    //判断是否从个人中心跳转
    const centerType = ref(false)
    //返回
    const backClick = () => {
        if(centerType.value){
            history.back()
        }else{
            router.push(`/index/${context?.$toolUtil.storageGet('frontSessionTable')}Center`)
        }
    }

    //获取列表
	const getList = () => {
		listLoading.value = true
		context?.$http({
			url: 'cart/list',
			method: 'get',
			params: listQuery.value
		}).then(res => {
			listLoading.value = false
			list.value = res.data.data.list
            list.value.forEach(item=>{
                item.realPrice = item.price
            })
		})
	}
	//跳转商品详情
	const detailClick = (row) => {
		router.push(`/index/${row.tablename}Detail?id=${row.goodid}`)
	}
	//多选
	const handleSelectionChange = (e) => {
		selRows.value = e
	}
	//单击选中某行
	const listChange = (row) =>{
		nextTick(()=>{
			table.value.clearSelection()
			table.value.toggleRowSelection(row)
		})
	}
	//移除购物车
	const delClick = (id = null) => {
		if (id) {
			ElMessageBox.confirm(`是否删除选中${formName}`, '提示', {
				confirmButtonText: '是',
				cancelButtonText: '否',
				type: 'warning',
			}).then(() => {
				context?.$http({
					url: 'cart/delete',
					method: 'post',
					data: [id]
				}).then(res => {
					context?.$toolUtil.message('删除成功', 'success', () => {
						getList()
					})
				})
			}).catch(_ => {})
		}
	}
	const numberChange = (row) => {
		context?.$http({
			url: `${row.tablename}/detail/${row.goodid}`,
			method: 'get'
		}).then(res => {
			if (res.data.data.onelimittimes&&(res.data.data.onelimittimes>0)&&(row.buynumber > res.data.data.onelimittimes)) {
				row.buynumber = res.data.data.onelimittimes
				context?.$toolUtil.message(`每人单次只能购买${res.data.data.onelimittimes}件`, 'error')
				return false
			}
			context?.$http({
				url: `cart/update`,
				method: 'post',
				data: row
			}).then(obj => {})
		})
	}
	//统计总价
	const allPrice = () => {
		let price = 0
		for (let x in selRows.value) {
			price += Number((selRows.value[x].realPrice * selRows.value[x].buynumber))
		}
		return Number(price).toFixed(2)
	}
	const payClick = async () => {
		if (selRows.value.length){
			let data = []
			for(let x in selRows.value){
                let res = await context?.$http({
					url: `${selRows.value[x].tablename}/detail/${selRows.value[x].goodid}`,
					method:'get'
				})
                if(selRows.value[x].buynumber>res.data.data.alllimittimes){
                    context?.$toolUtil.message(`${selRows.value[x].goodname}库存不足`,'error')
                    return false
                }
                if(x==selRows.value.length - 1){
                    confirmOrder()
                }
			}
		}else{
			context?.$toolUtil.message('请选择需要购买的商品','error')
		}
	}
	const confirmOrder = () => {
		context?.$toolUtil.storageSet('orders_good',JSON.stringify(selRows.value))
		router.push('/index/order_confirm')
	}
	//初始化
	const init = () => {
        if(route.query.centerType){
            centerType.value = true
        }
		getList()
	}
	init()
</script>

<style lang="scss">
.cart-page {
    width: 100%;
    padding: 0 7%;
    margin: 0 auto 30px;
    min-height: 50vh;
    background:#FFFFFF;
}

.cart-page .back_view {
    width: 100%;
    text-align: right;
    padding: 10px 0;
}

.cart-page .section_title {
    color: var(--theme);
    font-size: 26px;
    line-height: 0;
    position: relative;
    top: -20px;
}


.cart-page .cart_price .number {
    color: red;
    font-size: 24px;
    font-weight: 700;
}

.cart-page .cart_price .unit {
    color: red;
}

.cart-page .confirm_btn {
    background: var(--theme);
    border: none;
    height: 40px;
}
/* nf9 */
.cart-page .section_title span::before{
    width:100%;
    height:1px!important;
    content:'';
    background:#0949F7;
    top:20px;
    left:0px;
    position:absolute;
}

.cart-page .cart_confirm {
  
    border: 0;
    background: #fff;
    width: 100%;
    left: 0;
    bottom: 0;
  
    display: flex;
    justify-content: flex-end;
    gap:30px;
    margin-bottom:50px;

}


.cart-page .el-table__row{
    height:160px;
}
.cart-page .el-table__inner-wrapper {
    border: 1px solid #EEEEEE!important;
}
</style>