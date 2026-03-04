<template>
	<div>
		<div class="center_view">
            <div style="margin:10px 0;">
                <el-button @click="back()">返回</el-button>
            </div>
			<div class="list_search_view">
				<el-form :model="searchQuery" class="search_form" >
					<div class="search_view">
						<div class="search_label">
							用户名：
						</div>
						<div class="search_box">
							<el-input class="search_inp" v-model="searchQuery.nickname" placeholder="用户名"
								clearable>
							</el-input>
						</div>
					</div>
					<div class="search_view">
						<div class="search_label">
							评论内容：
						</div>
						<div class="search_box">
							<el-input class="search_inp" v-model="searchQuery.content" placeholder="评论内容"
								clearable>
							</el-input>
						</div>
					</div>
					<div class="search_btn_view">
						<el-button class="search_btn" type="primary" @click="searchClick()" size="small">搜索</el-button>
					</div>
				</el-form>
				<div class="btn_view">
					<el-button class="add_btn" type="success" @click="addClick" v-if="btnAuth('discussdongmanshangpin','新增')">
						新增
					</el-button>
					<el-button class="del_btn" type="danger" :disabled="selRows.length?false:true" @click="delClick(null)" >
						删除
					</el-button>
				</div>
			</div>
			<el-table
				v-loading="listLoading" :stripe='true'
				@selection-change="handleSelectionChange"
				ref="table"
				:data="list"
				@row-click="listChange">
				<el-table-column :resizable='true' align="left" header-align="left" type="selection" width="55" />
				<el-table-column label="序号" width="70" :resizable='true' align="left" header-align="left">
					<template #default="scope">{{ (listQuery.page-1)*listQuery.limit+scope.$index + 1}}</template>
				</el-table-column>
				<el-table-column min-width="140"
					:resizable='true'
					:sortable='false'
					align="left"
					header-align="left"
					prop="nickname"
					label="用户名">
					<template #default="scope">
						{{scope.row.nickname}}
					</template>
				</el-table-column>
				<el-table-column min-width="140"
					:resizable='true'
					:sortable='false'
					align="left"
					header-align="left"
					prop="score"
					label="评分">
					<template #default="scope">
                        <el-rate v-model="scope.row.score" disabled></el-rate>
					</template>
				</el-table-column>
				<el-table-column label="评论内容" min-width="140" :resizable='true' :sortable='false' align="left" header-align="left">
					<template #default="scope">
						<span v-html="scope.row.content"></span>
					</template>
				</el-table-column>
				<el-table-column label="回复内容" min-width="140" :resizable='true' :sortable='false' align="left" header-align="left">
					<template #default="scope">
						<span v-html="scope.row.reply"></span>
					</template>
				</el-table-column>
				<el-table-column min-width="140"
					:resizable='true'
					:sortable='false'
					align="left"
					header-align="left"
					prop="thumbsupnum"
					label="赞">
					<template #default="scope">
						{{scope.row.thumbsupnum}}
					</template>
				</el-table-column>
				<el-table-column min-width="140"
					:resizable='true'
					:sortable='false'
					align="left"
					header-align="left"
					prop="crazilynum"
					label="踩">
					<template #default="scope">
						{{scope.row.crazilynum}}
					</template>
				</el-table-column>
				<el-table-column min-width="140" prop="istop" label="是否置顶">
					<template #default="scope">
						<el-switch v-model="scope.row.istop"
								   :active-value="1"
								   :inactive-value="0"
								   @change="setTop(scope.row)">
						</el-switch>
					</template>
				</el-table-column>
                <el-table-column v-if="btnAuth('discussdongmanshangpin','修改')" label="禁用账号" :resizable='true' :sortable='false' align="left" header-align="left">
                    <template #default="scope">
                        <el-switch v-model="scope.row.isLocked"
                                   :active-value="1"
                                   :inactive-value="0"
                                   active-color="red"
                                   @change="updateItem(scope.row)"></el-switch>
                    </template>
                </el-table-column>
				<el-table-column label="操作" class-name="operation-cell" width="300" fixed="right" :resizable='true' :sortable='false' align="left" header-align="left">
					<template #default="scope">
						<el-button class="edit_btn" type="primary" @click="editClick(scope.row.id)" v-if=" btnAuth('discussdongmanshangpin','修改')">
							修改						</el-button>
						<el-button class="del_btn" type="danger" @click="delClick(scope.row.id)" >
							删除						</el-button>
						<el-button class="operate_btn" v-if="btnAuth('discussdongmanshangpin','查看评论')" type="warning" @click="commentClick(scope.row.id)">
							查看评论
						</el-button>
						<el-button class="operate_btn" type="warning" @click="replyClick(scope.row.id)">
							回复
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
				prev-text="<"
				next-text=">"
				:hide-on-single-page="true"
				:page-sizes="[10, 20, 30, 40, 50, 100]"
				@size-change="sizeChange"
				@current-change="currentChange"  />
		</div>
		<formModel ref="formRef" @formModelChange="formModelChange"></formModel>
	</div>
</template>
<script setup>
	import axios from 'axios'
	const moment = window.moment
	import {
		reactive,
		ref,
		getCurrentInstance,
		nextTick,
		onMounted,
		watch,
		computed,
	} from 'vue'
	import {
		useRoute,
		useRouter
	} from 'vue-router'
	import {
		useStore
	} from 'vuex';
	const store = useStore()
	const user = computed(()=>store.getters['user/session'])
	const avatar = ref(store.state.user.avatar)
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const baseUrl = ref(context.$config.url)
	import formModel from './formModel.vue'
	//基础信息
	const tableName = 'discussdongmanshangpin'
	const formName = '动漫商品评论表'
	const route = useRoute()
    const router = useRouter()
	const role = context.$toolUtil.storageGet('sessionTable')
	//基础信息
	onMounted(()=>{
	})
	//列表数据
	const list = ref(null)
	const table = ref(null)
	const listQuery = ref({
		page: 1,
		limit: 20,
		sort: 'id',
		order: 'desc'
	})
	const searchQuery = ref({})
	const selRows = ref([])
	const listLoading = ref(false)
	const listChange = (row) =>{
		nextTick(()=>{
			//table.value.clearSelection()
			table.value.toggleRowSelection(row)
		})
	}
	//列表
	const getList = () => {
		listLoading.value = true
		let params = JSON.parse(JSON.stringify(listQuery.value))
		params['sort'] = 'id'
		params['order'] = 'desc'
		params['refid'] = route.query.refid
		if(searchQuery.value.nickname&&searchQuery.value.nickname!=''){
			params['nickname'] = '%' + searchQuery.value.nickname + '%'
		}
		if(searchQuery.value.content&&searchQuery.value.content!=''){
			params['content'] = '%' + searchQuery.value.content + '%'
		}
		context.$http({
			url: `${tableName}/page`,
			method: 'get',
			params: params
		}).then(res => {
			listLoading.value = false
			list.value = res.data.data.list
			total.value = Number(res.data.data.total)
		})
	}
	//删
	const delClick = (id) => {
		let ids = []
		if (id) {
			ids = [id]
		} else {
			if (selRows.value.length) {
				for (let x in selRows.value) {
					ids.push(selRows.value[x].id)
				}
			} else {
				return false
			}
		}
		ElMessageBox.confirm(`是否删除选中${formName}`, '提示', {
			confirmButtonText: '是',
			cancelButtonText: '否',
			type: 'warning',
		}).then(() => {
			context.$http({
				url: `${tableName}/delete`,
				method: 'post',
				data: ids
			}).then(res => {
				context?.$toolUtil.message('删除成功', 'success',()=>{
					getList()
				})
                context.$http.get(`dongmanshangpin/info/${route.query.refid}`).then(res=>{
                    let detail = res.data.data
                    detail.discussNumber -= ids.length
                    context.$http.post(`dongmanshangpin/update`,detail)
                })
			})
		}).catch(_ => {})
	}
	//多选
	const handleSelectionChange = (e) => {
		selRows.value = e
	}
	//列表数据
	//分页
	const total = ref(0)
	const layouts = ref(["total","prev","pager","next","jumper"])
	const sizeChange = (size) => {
		listQuery.value.limit = size
		getList()
	}
	const currentChange = (page) => {
		listQuery.value.page = page
		getList()
	}
	//分页
	//权限验证
	const btnAuth = (e,a)=>{
		return context?.$toolUtil.isAuth(e,a)
	}
	//搜索
	const searchClick = () => {
		listQuery.value.page = 1
		getList()
	}
	//表单
	const formRef = ref(null)
	const formModelChange=()=>{
		searchClick()
	}
	const addClick = ()=>{
		formRef.value.init()
	}
	const editClick = (id=null)=>{
		if(id){
			formRef.value.init(id,'edit')
			return
		}
		if(selRows.value.length){
			formRef.value.init(selRows.value[0].id,'edit')
		}
	}

	const infoClick = (id=null)=>{
		if(id){
			formRef.value.init(id,'info')
		}
		else if(selRows.value.length){
			formRef.value.init(selRows.value[0].id,'info')
		}
	}
	// 表单
	// 预览文件
	const preClick = (file) =>{
		if(!file){
			context?.$toolUtil.message('文件不存在','error')
		}
		window.open(context?.$config.url + file)
	}
	// 下载文件
	const download = (file) => {
		if(!file){
			context?.$toolUtil.message('文件不存在','error')
		}
		let arr = file.replace(new RegExp('file/', "g"), "")
		axios.get((location.href.split(context?.$config.name).length>1 ? location.href.split(context?.$config.name)[0] :'') + context?.$config.name + '/file/download?fileName=' + arr, {
			headers: {
				token: context?.$toolUtil.storageGet('Token')
			},
			responseType: "blob"
		}).then(({
			data
		}) => {
			const binaryData = [];
			binaryData.push(data);
			const objectUrl = window.URL.createObjectURL(new Blob(binaryData, {
				type: 'application/pdf;chartset=UTF-8'
			}))
			const a = document.createElement('a')
			a.href = objectUrl
			a.download = arr
			// a.click()
			// 下面这个写法兼容火狐
			a.dispatchEvent(new MouseEvent('click', {
				bubbles: true,
				cancelable: true,
				view: window
			}))
			window.URL.revokeObjectURL(data)
		})
	}
	//评论置顶
	const setTop = (row)=>{
		context.$http.post(`${tableName}/update`,row).then(res=>{
			if(res.data.code==0){
				context.$message.success("操作成功")
				searchClick()
			}
		})
	}
    // 查看评论
	const commentClick=(id)=>{
		context?.$router.push('/discussdiscussdongmanshangpin?refid=' + id)
	}
	const replyClick=(id=null)=>{
		formRef.value.init(id,'reply')
	}
    const updateItem = (row)=>{
        context.$http.post(`${tableName}/update`,row).then(res=>{
            if(res.data.code==0){
                context.$message.success("更新成功")
            }
        })
    }
    const back = ()=>{
        store.dispatch('delThisView',route.path)
        context.$router.go(-1)
    }
	//初始化
	const init = () => {
		getList()
	}
	init()
</script>
<style lang="scss" scoped>
	// 表格样式
	.el-table {
		:deep(.el-table__body-wrapper) {
			tbody {
				tr.el-table__row--striped {
					td {
						background: #FAFAFA;
					}
				}
			}
		}
	}
</style>