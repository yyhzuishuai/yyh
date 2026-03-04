<template>
    <div class="list-page">
        <div class="breadcrumb-wrapper">
            <div class="bread_view">
                <el-breadcrumb separator=">" class="breadcrumb">
                    <el-breadcrumb-item class="first_breadcrumb" :to="{ path: '/' }">首页</el-breadcrumb-item>
                    <el-breadcrumb-item class="second_breadcrumb" v-for="(item,index) in breadList" :key="index">{{item.name}}</el-breadcrumb-item>
                </el-breadcrumb>
            </div>
            <div class="back_view" v-if="centerType">
                <el-button class="back_btn btn-gradient" @click="backClick">返回</el-button>
            </div>
        </div>
		<div class="list_search glass-card">
			<div class="search_view">
				<div class="search_label">
					商品名称：
				</div>
				<div class="search_box">
					<el-input class="search_inp input-dark" v-model="searchQuery.shangpinmingcheng" placeholder="请输入商品名称"
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
                        class="search_sel input-dark"
                        clearable
                        v-model="searchQuery.shangpinleixing"
                        placeholder="请选择商品类型"
                    >
                        <el-option v-for="item in shangpinleixingLists" :label="item" :value="item"></el-option>
                    </el-select>
                </div>
            </div>
			<div class="search_view">
				<div class="search_label">
					价格：
				</div>
				<div class="search_box price_range">
					<el-input class="search_inp input-dark" v-model="searchQuery.priceStart" placeholder="最小价格"
						clearable>
					</el-input>
                    <span class="range_divider">-</span>
					<el-input class="search_inp input-dark" v-model="searchQuery.priceEnd" placeholder="最大价格"
						clearable>
					</el-input>
				</div>
			</div>
			<div class="search_btn_view">
				<el-button class="search_btn btn-gradient" @click="searchClick">搜索</el-button>
				<el-button class="add_btn btn-gradient" v-if="btnAuth('dongmanshangpin','新增')" @click="addClick">新增</el-button>
			</div>
		</div>

        <div class="sort-wrapper">
            <el-button class="item price" @click="sortClick('price')" :class="{active:sortType=='price'}">
                <el-icon class="icon" v-if="sortType!='price'"><DCaret /></el-icon>
                <el-icon class="icon desc" v-else-if="sortOrder=='desc'"><SortDown /></el-icon>
                <el-icon class="icon asc" v-else><SortUp /></el-icon>
                <span :class="{'text-gradient': sortType=='price'}">价格</span>
            </el-button>
            <el-button class="item storeup" @click="sortClick('storeupNumber')" :class="{active:sortType=='storeupNumber'}">
                <el-icon class="icon" v-if="sortType!='storeupNumber'"><DCaret /></el-icon>
                <el-icon class="icon desc" v-else-if="sortOrder=='desc'"><SortDown /></el-icon>
                <el-icon class="icon asc" v-else><SortUp /></el-icon>
                <span :class="{'text-gradient': sortType=='storeupNumber'}">收藏数</span>
            </el-button>
            <el-button class="item thumbsup" @click="sortClick('thumbsupNumber')" :class="{active:sortType=='thumbsupNumber'}">
                <el-icon class="icon" v-if="sortType!='thumbsupNumber'"><DCaret /></el-icon>
                <el-icon class="icon desc" v-else-if="sortOrder=='desc'"><SortDown /></el-icon>
                <el-icon class="icon asc" v-else><SortUp /></el-icon>
                <span :class="{'text-gradient': sortType=='thumbsupNumber'}">点赞数</span>
            </el-button>
        </div>


                <div class="data_view">
<div class="item glass-card animate-fade-up" v-for="(item,index) in list" :key="item.id" @click.stop="detailClick(item.id)" :style="{animationDelay: index*0.08+'s'}">
  
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

    <div class="data_price"><span class="price-num">￥{{item.price}}</span></div>
    <div class="count-row">
                                <div class="data_like">
                                    <span class="iconfont icon-thumb-up-line1"></span>
                                    <div class="like_num">{{item.thumbsupNumber || 0}}</div>
                                </div>

                                <div class="data_collect">
                                    <span class="iconfont icon-likeline4"></span>
                                    <div class="collect_num">{{item.storeupNumber || 0}}</div>
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
.list-page {
    background: transparent !important;
    min-height: 100vh;
    padding: 30px 7%;
    width: 100%;
}

.breadcrumb-wrapper {
    margin-bottom: 25px;
    display: flex;
    justify-content: space-between;
    align-items: center;

    .breadcrumb {
        font-size: 16px;
        
        ::v-deep .el-breadcrumb__inner {
            color: var(--color-gray) !important;
            &.is-link:hover {
                color: var(--color-pink) !important;
            }
        }
        
        ::v-deep .el-breadcrumb__separator {
            color: var(--color-pink) !important;
            font-weight: bold;
        }
    }
}

.list_search {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
    gap: 24px;
    margin-bottom: 30px;
    background: rgba(255, 255, 255, 0.05) !important;
    backdrop-filter: blur(20px);
    -webkit-backdrop-filter: blur(20px);
    border: 1px solid rgba(255, 107, 157, 0.2);
    border-radius: 20px;
    padding: 24px;
    
    .search_view {
        display: flex;
        align-items: center;
        gap: 12px;
        
        .search_label {
            color: var(--color-gray);
            font-size: 14px;
            white-space: nowrap;
        }
        
        .search_box {
            width: 200px;
            
            &.price_range {
                width: auto;
                display: flex;
                align-items: center;
                gap: 8px;
                
                .range_divider {
                    color: var(--color-gray);
                }
                
                .search_inp {
                    width: 120px;
                }
            }
        }
    }
    
    ::v-deep .el-input__wrapper, ::v-deep .el-select__wrapper {
        background: rgba(255, 255, 255, 0.05) !important;
        box-shadow: 0 0 0 1px rgba(255, 255, 255, 0.1) inset !important;
        border-radius: 12px;
        
        .el-input__inner, .el-select__placeholder {
            color: #ffffff !important;
            &::placeholder {
                color: rgba(255, 255, 255, 0.3) !important;
            }
        }
    }

    ::v-deep .el-select__caret {
        color: var(--color-pink) !important;
    }
}

.sort-wrapper {
    background: rgba(255, 255, 255, 0.03);
    border-radius: 12px;
    padding: 12px 20px;
    margin-bottom: 30px;
    display: flex;
    gap: 15px;
    
    .item {
        background: transparent;
        border: none;
        color: var(--color-gray);
        font-size: 15px;
        transition: var(--transition);
        padding: 8px 16px;
        
        &:hover {
            color: #ffffff;
        }
        
        &.active {
            color: #ffffff;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 8px;
        }
        
        .icon {
            margin-right: 6px;
        }
    }
}

.data_view {
    display: grid !important;
    grid-template-columns: repeat(4, 1fr) !important;
    gap: 24px !important;
    margin: 30px 0 40px !important;
    width: 100% !important;
    
    .item {
        background: rgba(255, 255, 255, 0.05) !important;
        backdrop-filter: blur(16px);
        -webkit-backdrop-filter: blur(16px);
        border: 1px solid rgba(255, 107, 157, 0.18) !important;
        border-radius: 20px !important;
        overflow: hidden;
        transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        cursor: pointer;
        position: relative;
        width: 100% !important;
        margin: 0 !important;
        
        &:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 40px rgba(255, 107, 157, 0.18);
            border-color: rgba(255, 107, 157, 0.45) !important;
            
            .img_box img {
                transform: scale(1.08);
            }
        }
        
        .img_box {
            width: 100% !important;
            height: 220px;
            overflow: hidden;
            border-radius: 16px 16px 0 0;
            display: block;
            
            img {
                width: 100% !important;
                height: 100% !important;
                object-fit: cover;
                display: block;
                transition: transform 0.4s ease;
            }
        }
        
        .content {
            padding: 14px 16px;
            
            .data_title {
                margin-bottom: 8px;
                color: rgba(255, 255, 255, 0.55);
                font-size: 13px;
                @extend .text-one-row;
            }
            
            .data_price {
                margin: 8px 0;
                
                .price-num {
                    background: linear-gradient(135deg, #ff6b9d, #00d4ff);
                    -webkit-background-clip: text;
                    -webkit-text-fill-color: transparent;
                    font-size: 22px;
                    font-weight: 700;
                    display: inline-block;
                }
            }
            
            .count-row {
                display: flex;
                gap: 10px;
                margin-top: 12px;
                
                .data_like, .data_collect {
                    display: flex;
                    align-items: center;
                    gap: 6px;
                    padding: 6px 16px;
                    border-radius: 50px;
                    font-size: 13px;
                    transition: all 0.3s ease;
                    cursor: pointer;
                }
                
                .data_like {
                    background: rgba(0, 212, 255, 0.12);
                    color: #00d4ff;
                    border: 1px solid rgba(0, 212, 255, 0.3);
                    
                    &:hover {
                        background: rgba(0, 212, 255, 0.22);
                        box-shadow: 0 0 14px rgba(0, 212, 255, 0.5);
                    }
                }
                
                .data_collect {
                    background: rgba(255, 107, 157, 0.12);
                    color: #ff6b9d;
                    border: 1px solid rgba(255, 107, 157, 0.3);
                    
                    &:hover {
                        background: rgba(255, 107, 157, 0.22);
                        box-shadow: 0 0 14px rgba(255, 107, 157, 0.5);
                    }
                }
            }
        }
    }
}

::v-deep .el-pagination {
    justify-content: center;
    .el-pager li {
        background: rgba(255, 255, 255, 0.05) !important;
        color: var(--color-gray) !important;
        border-radius: 8px;
        &:hover {
            color: var(--color-pink) !important;
        }
        &.is-active {
            background: linear-gradient(45deg, var(--color-pink), var(--color-blue)) !important;
            color: #ffffff !important;
        }
    }
    .btn-prev, .btn-next {
        background: rgba(255, 255, 255, 0.05) !important;
        color: var(--color-gray) !important;
        border-radius: 8px;
        &:disabled {
            opacity: 0.3;
        }
    }
}

.text-one-row {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
</style>