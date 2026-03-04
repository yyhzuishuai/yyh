<template>

	<div class="list-page">
        <div class="breadcrumb-wrapper" style="width: 100%;">
            <div class="bread_view">
                <el-breadcrumb separator=">" class="breadcrumb">
                    <el-breadcrumb-item class="second_breadcrumb" :to="{ path: `/index/${sessionTable}Center` }">个人中心</el-breadcrumb-item>
                    <el-breadcrumb-item class="second_breadcrumb">{{formName}}</el-breadcrumb-item>
                </el-breadcrumb>
            </div>
            <div class="back_view" v-if="centerType">
                <el-button class="back_btn" @click="backClick">返回</el-button>
            </div>
        </div>
        
		<div class="list_search">
            <div class="search_btn_view">
                <el-button class="add_btn" @click="addClick">
                    新增{{formName}}
                </el-button>
            </div>
        </div>



                <div class="table_view">
					<el-table v-loading="listLoading" border :stripe='false' @selection-change="handleSelectionChange" ref="table"
						:data="list" @row-click="listChange">
						<el-table-column label="地址" :resizable='true' align="center" header-align="center">
							<template #default="scope">
								{{scope.row.address}}
							</template>
						</el-table-column>
						<el-table-column label="收货人" :resizable='true' align="center" header-align="center">
							<template #default="scope">
								{{scope.row.name}}
							</template>
						</el-table-column>
						<el-table-column label="电话" :resizable='true' align="center" header-align="center">
							<template #default="scope">
								{{scope.row.phone}}
							</template>
						</el-table-column>
						<el-table-column label="是否默认地址" :resizable='true' align="center" header-align="center">
							<template #default="scope">
								<el-switch v-model="scope.row.isdefault" class="ml-2" @change="(e)=>isdefaultChange(e,scope.row)" active-value="是" inactive-value="否" />
							</template>
						</el-table-column>
						<el-table-column label="操作" class-name="operation-cell" :resizable='true' align="center" header-align="center">
							<template #default="scope">
								<el-button class="edit_btn" @click="editClick(scope.row.id)" type="primary" size="default">修改</el-button>
								<el-button class="del_btn" @click="delClick(scope.row.id)" type="danger" size="default">删除</el-button>
							</template>
						</el-table-column>
					</el-table>
				</div>


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
					@current-change="currentChange"/>


		<formModel ref="formModelRef" @formModelChange="formModelChange"></formModel>
	</div>
</template>

<script setup>
	import formModel from './formModel'
	import {
		ref,
		nextTick,
		getCurrentInstance
	} from 'vue';
	import {
		useRoute,
		useRouter
	} from 'vue-router'
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	//基础信息
	const tableName = 'address'
	const formName = '地址'
	const router = useRouter()
	const route = useRoute()
	//基础信息
	//权限验证
	const btnAuth = (e, a) => {
		return context?.$toolUtil.isAuth(e, a)
	}
	const list = ref([])
	const listLoading = ref(false)
	const listQuery = ref({
		page: 1,
		limit: 20,
		userid: context?.$toolUtil.storageGet('userid')
	})
	const selRows = ref([])
	const searchQuery = ref({})
	const table = ref(null)
	const searchClick = () => {
		listQuery.value.page = 1
		getList()
	}
	const getList = () => {
		listLoading.value = true
		let params = JSON.parse(JSON.stringify(listQuery.value))
		context?.$http({
			url: `address/list`,
			method: 'get',
			params: params
		}).then(res => {
			listLoading.value = false
			list.value = res.data.data.list
			total.value = res.data.data.total
		})
	}
	//定义弹窗
	const formModelRef = ref(null)
	const formModelChange = () =>{
		listQuery.value.page = 1
		getList()
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
	//新增
	const addClick = () => {
		formModelRef.value.init(null,'新增' + formName)
	}
	//修改
	const editClick = (id = null) => {
		if (id) {
			formModelRef.value.init(id,'修改' + formName)
		}
	}
	const delClick = (id = null) => {
		if (id) {
			ElMessageBox.confirm(`是否删除选中${formName}`, '提示', {
				confirmButtonText: '是',
				cancelButtonText: '否',
				type: 'warning',
			}).then(() => {
				context?.$http({
					url: `address/delete`,
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
	const isdefaultChange = (e,row) =>{
		context?.$http({
			url: `address/update`,
			method: 'post',
			data: row
		}).then(res => {
			getList()
		})
	}
	//多选
	const handleSelectionChange = (e) => {
		selRows.value = e
	}
	//判断是否从个人中心跳转
	const centerType = ref(false)
	//返回
	const backClick = () => {
		router.push(`/index/${context?.$toolUtil.storageGet('frontSessionTable')}Center`)
	}
	const init = () => {
		if (route.query.centerType) {
			centerType.value = true
		}
		getList()
	}
	init()
</script>

<style lang="scss">
	// 表格样式
	.el-table {
		:deep(.el-table__body-wrapper) {
			tbody {
			}
		}
	}
</style>