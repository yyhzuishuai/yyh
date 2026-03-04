<template>
    <div class="list-page">
        <div class="breadcrumb-wrapper" style="width: 100%;">
            <div class="bread_view">
                <el-breadcrumb separator=">" class="breadcrumb">
                    <el-breadcrumb-item class="first_breadcrumb" :to="{ path: '/' }">首页</el-breadcrumb-item>
                    <el-breadcrumb-item class="second_breadcrumb" v-for="(item,index) in breadList" :key="index">{{item.name}}</el-breadcrumb-item>
                </el-breadcrumb>
            </div>
            <div class="back_view" v-if="centerType">
                <el-button class="back_btn" @click="backClick">返回</el-button>
            </div>
        </div>
		<div class="list_search">
			<div class="search_view">
				<div class="search_label">
					商品名称：
				</div>
				<div class="search_box">
					<el-input class="search_inp" v-model="searchQuery.shangpinmingcheng" placeholder="商品名称"
						clearable>
					</el-input>
				</div>
			</div>
            <div class="search_view">
                <div class="search_label">
                    商品类型：
                </div>
                <div class="search_box">
                    <el-select
                        class="search_sel"
                        clearable
                        v-model="searchQuery.shangpinleixing"
                        placeholder="商品类型"
                    >
                        <el-option v-for="item in shangpinleixingLists" :label="item" :value="item"></el-option>
                    </el-select>
                </div>
            </div>
			<div class="search_view">
				<div class="search_label">
					价格：
				</div>
				<div class="search_box">
					<el-input class="search_inp" v-model="searchQuery.priceStart" placeholder="最小价格"
						clearable>
					</el-input>至
					<el-input class="search_inp" v-model="searchQuery.priceEnd" placeholder="最大价格"
						clearable>
					</el-input>
				</div>
			</div>
			<div class="search_btn_view">
				<el-button class="search_btn" @click="searchClick">搜索</el-button>
				<el-button class="add_btn" v-if="btnAuth('dongmanshangpin','新增')" @click="addClick">新增</el-button>
			</div>
		</div>

        <div class="sort-wrapper">
            <el-button class="item price" @click="sortClick('price')" :class="{active:sortType=='price'}">
                <el-icon class="icon" v-if="sortType!='price'"><DCaret /></el-icon>
                <el-icon class="icon desc" v-else-if="sortOrder=='desc'"><SortDown /></el-icon>
                <el-icon class="icon asc" v-else><SortUp /></el-icon>
                价格
            </el-button>
            <el-button class="item storeup" @click="sortClick('storeupNumber')" :class="{active:sortType=='storeupNumber'}">
                <el-icon class="icon" v-if="sortType!='storeupNumber'"><DCaret /></el-icon>
                <el-icon class="icon desc" v-else-if="sortOrder=='desc'"><SortDown /></el-icon>
                <el-icon class="icon asc" v-else><SortUp /></el-icon>
                收藏数
            </el-button>
            <el-button class="item thumbsup" @click="sortClick('thumbsupNumber')" :class="{active:sortType=='thumbsupNumber'}">
                <el-icon class="icon" v-if="sortType!='thumbsupNumber'"><DCaret /></el-icon>
                <el-icon class="icon desc" v-else-if="sortOrder=='desc'"><SortDown /></el-icon>
                <el-icon class="icon asc" v-else><SortUp /></el-icon>
                点赞数
            </el-button>
        </div>


                <div class="data_view">
<div class="item" v-for="(item,index) in list" @click.stop="detailClick(item.id)">
  
      <div class="img_box">
        
        <img :src="item.imgUrls[0]" @click.stop="preViewClick(item.imgUrls[0])">
      </div>
  
  <div class="content">
                            <div class="data_title">
                                <span>
                                    动漫品牌：{{item.dongmanpinpai}}
                                </span>
                            </div>
                            <div class="data_title">
                                <span>
                                    评分：{{item.score}}
                                </span>
                            </div>

    <div class="data_price"><span>￥</span><span>{{item.price}}</span></div>
    <div class="count-row">
                                <div class="data_like" v-if="item.thumbsupNumber">
                                    <span class="iconfont icon-thumb-up-line1"></span>
                                    <div class="like_num">{{item.thumbsupNumber}}</div>
                                </div>

                                <div class="data_collect" v-if="item.storeupNumber">
                                    <span class="iconfont icon-likeline4"></span>
                                    <div class="collect_num">{{item.storeupNumber}}</div>
                                </div>


    </div>
  </div>
</div>
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


    </div>

    <el-dialog v-model="preViewVisible" :title="'查看大图'" width="40%" destroy-on-close>
        <div style="text-align:center">
            <img :src="preViewUrl" style="max-width: 100%;" alt="">
        </div>
    </el-dialog>
</template>

<script setup>
	import {
		ref,
		getCurrentInstance,
		nextTick,
        computed,
        inject,
	} from 'vue';
    const moment = window.moment
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
    const baseUrl = ref(context.$config.url)
	//基础信息
	const tableName = 'dongmanshangpin'
	const formName = '动漫商品'
	//基础信息
	const breadList = ref([{
		name: formName
	}])
	const list = ref([])
	const listQuery = ref({
		page: 1,
		limit: 10
	})
	const total = ref(0)
	const listLoading = ref(false)
	//权限验证
	const btnAuth = (e,a)=>{
		if(centerType.value){
			return context?.$toolUtil.isBackAuth(e,a)
		}else{
			return context?.$toolUtil.isAuth(e,a)
		}
	}
	const addClick = () => {
		router.push('/index/dongmanshangpinAdd')
	}
	//判断是否从个人中心跳转
	const centerType = ref(false)
	//返回
	const backClick = () => {
		router.push(`/index/${context?.$toolUtil.storageGet('frontSessionTable')}Center`)
	}
	//搜索
	const searchQuery = ref({})
	//下拉列表
	const shangpinleixingLists = ref([])
	const getshangpinleixingLists = () => {
		context?.$http({
			url: 'option/shangpinleixing/shangpinleixing',
			method:'get',
		}).then(res=>{
			shangpinleixingLists.value = res.data.data
		})
	}
	getshangpinleixingLists()
	const searchClick = async() => {
		listQuery.value.page = 1
		getList()
	}
	//分页
	const layouts = ref(["total","prev","pager","next","sizes"])
	const sizeChange = (size) => {
		listQuery.value.limit = size
		getList()
	}
	const currentChange = (page) => {
		listQuery.value.page = page
		getList()
	}
	//分页
    const sortType = ref('')
    const sortOrder = ref('')
    const sortClick = (type)=>{
        if(sortType.value==type && sortOrder.value=='asc'){
            sortType.value = ''
            sortOrder.value = ''
        }else if(sortType.value==type && sortOrder.value=='desc'){
            sortOrder.value = 'asc'
        }else{
            sortType.value = type
            sortOrder.value = 'desc'
        }
        getList()
    }
	//列表
	const getList = () => {
		listLoading.value = true
		let params = JSON.parse(JSON.stringify(listQuery.value))
        if(!centerType.value) {
            params.isShelves = 1
        }
		if(searchQuery.value.shangpinmingcheng&&searchQuery.value.shangpinmingcheng!=''){
			params.shangpinmingcheng = '%' + searchQuery.value.shangpinmingcheng + '%'
		}
		if(searchQuery.value.shangpinleixing&&searchQuery.value.shangpinleixing!=''){
			params.shangpinleixing = searchQuery.value.shangpinleixing
		}
		if (searchQuery.value.priceStart&&searchQuery.value.priceStart!='') {
			params.priceStart = searchQuery.value.priceStart
		}
		if (searchQuery.value.priceEnd&&searchQuery.value.priceEnd!='') {
			params.priceEnd = searchQuery.value.priceEnd
		}
		if(!centerType.value){
			params['sfsh'] = '是';
		} 
        if(sortType.value){
            params['sort'] = sortType.value
            params['order'] = sortOrder.value
        }
		context?.$http({
			url: `${tableName}/${centerType.value?'page':'list'}`,
			method: 'get',
			params: params
		}).then(res => {
			listLoading.value = false
			list.value = res.data.data.list
			total.value = Number(res.data.data.total)
            list.value.forEach(item=>{
                if(item.shangpintupian!=null){
                    item.imgUrls = item.shangpintupian.split(',').map(url=> {
                        if(url && url.substr(0,4)=='http'){
                            return url
                        }else{
                            return baseUrl.value + url
                        }
                    })
                }else{
                    item.imgUrls = []
                }
            })
		})
	}
	const detailClick = (id) => {
		router.push(`${tableName}Detail?id=` + id + (centerType.value?'&&centerType=1':''))
	}
	//下载文件
	const download = (file) =>{
		if(!file){
			context?.$toolUtil.message('文件不存在','error')
		}
		const a = document.createElement('a');
		a.style.display = 'none';
		a.setAttribute('target', '_blank');
		file && a.setAttribute('download', file);
		a.href = context?.$config.url + file;
		document.body.appendChild(a);
		a.click();
		document.body.removeChild(a);
	}
	// 查看大图
	const preViewUrl = ref('')
	const preViewVisible = ref(false)
	const preViewClick = (url) =>{
		preViewUrl.value = url
		preViewVisible.value = true
	}
    const isShelvesDisabled = (row)=>{
        if(!centerType.value) {
            return false
        }
        let pubPeople = 'shangjiazhanghao'
        if(store.getters['user/username'] == row[pubPeople]) {
            return true
        }
        return false
    }
    const isShelvesChange = (e,row)=>{
        context.$http.post('${tableName}/update',row)
    }
	const init = async() => {
		if(route.query.centerType){
			centerType.value = true
		}
        if(context.$toolUtil.storageGet('frontToken') && !user.value.id){
            await store.dispatch("user/getSession")
        }
		getList()
	}
	init()
</script>
<style lang="scss" scoped>
</style>