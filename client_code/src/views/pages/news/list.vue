<template>
    <div class="news-page">
        <div class="breadcrumb-wrapper">
            <div class="bread_view">
                <el-breadcrumb separator=">" class="breadcrumb">
                    <el-breadcrumb-item class="first_breadcrumb" :to="{ path: '/' }">首页</el-breadcrumb-item>
                    <el-breadcrumb-item class="second_breadcrumb" v-for="(item,index) in breadList" :key="index">{{item.name}}</el-breadcrumb-item>
                </el-breadcrumb>
            </div>
        </div>

        <div class="list_search glass-card">
			<div class="search_view">
				<div class="search_label">
					标题：
				</div>
				<div class="search_box">
					<el-input class="search_inp input-dark" v-model="searchQuery.title" placeholder="请输入搜索标题" clearable></el-input>
				</div>
			</div>
			<div class="search_btn_view">
				<el-button class="search_btn btn-gradient" type="primary" @click="searchClick">搜索</el-button>
			</div>
		</div>


<div class="list">
	<template v-for="(item,index) in list" :key="index">
		<div class="item glass-card animate-fade-up" @click="newsDetail(item.id)" :style="{animationDelay: index*0.08+'s'}">
			<div class="card-left">
                <div class="dot pulse-glow"></div>
            </div>
			<div class="content">
				<div class="title-row">
                    <div class="title text-one-row">{{item.title}}</div>
                    <div class="time-tag">{{moment(item.addtime).format('YYYY-MM-DD')}}</div>
                </div>
				<div class="intro text-two-row">{{item.introduction}}</div>
			</div>
		</div>
	</template>
</div>
		<el-pagination
			background
			:layout="layouts.join(',')"
			:total="total"
			:page-size="listQuery.limit"
            v-model:current-page="listQuery.page"
			prev-text="<"
			next-text=">"
			:hide-on-single-page="true"
			@size-change="sizeChange"
			@current-change="currentChange"/>


    </div>
    <formModel ref="formModelRef"></formModel>
</template>

<script setup>
    const moment = window.moment
	import formModel from './formModel'
	import {
		ref,
		nextTick,
        computed,
		getCurrentInstance
	} from 'vue';
	import {
		useRoute,
		useRouter
	} from 'vue-router'
    import {
        useStore
    } from 'vuex';
    const store = useStore()
    const user = computed(()=>store.getters['user/session'])
	const context = getCurrentInstance()?.appContext.config.globalProperties;
    const baseUrl = ref(context.$config.url)
	//基础信息
	const tableName = 'news'
	const formName = '系统公告'
	const router = useRouter()
	const route = useRoute()
	//基础信息
    const breadList = ref([{
        name: formName
    }])
	//权限验证
	const btnAuth = (e, a) => {
		return context?.$toolUtil.isAuth(e, a)
	}
	const list = ref([])
	const listLoading = ref(false)
	const listQuery = ref({
		page: 1,
		limit: 10,
		sort: 'addtime',
		order: 'desc'
	})
	const searchQuery = ref({})
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
	const searchClick = () => {
		listQuery.value.page = 1
		getList()
	}
	const getList = () => {
		listLoading.value = true
		let params = JSON.parse(JSON.stringify(listQuery.value))
		if (searchQuery.value.title && searchQuery.value.title != '') {
			params['title'] = `%${searchQuery.value.title}%`
		}
		context?.$http({
			url: `news/list`,
			method: 'get',
			params: params
		}).then(res => {
			listLoading.value = false
			list.value = res.data.data.list
			total.value = res.data.data.total
            list.value.forEach(item=>{
                let urls = item.picture.split(',')
                item.imgUrls = urls.map(url=>{
                    if(url && url.substr(0,4)=='http'){
                        return url
                    }else{
                        return baseUrl.value+url
                    }
                })
            })
		})
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
        nextTick(()=>{
            if(route.query.id){
                newsDetail(route.query.id)
            }
        })
	}
	//定义弹窗
	const formModelRef = ref(null)
	const newsDetail = (id = null) => {
		if (id) {
			formModelRef.value.init(id)
		}
	}
	init()
</script>

<style lang="scss" scoped>
.news-page {
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
    padding: 20px 24px;
    
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
            width: 300px;
        }
    }
    
    ::v-deep .el-input__wrapper {
        background: rgba(255, 255, 255, 0.05) !important;
        box-shadow: 0 0 0 1px rgba(255, 255, 255, 0.1) inset !important;
        border-radius: 12px;
        
        .el-input__inner {
            color: #ffffff !important;
            &::placeholder {
                color: rgba(255, 255, 255, 0.3) !important;
            }
        }
    }
}

.list {
    display: grid !important;
    grid-template-columns: repeat(2, 1fr) !important;
    gap: 24px !important;
    margin: 30px 0 40px !important;
    width: 100% !important;
    
    .item {
        display: flex;
        align-items: center;
        padding: 20px 24px;
        border-left: 3px solid transparent;
        border-image: linear-gradient(180deg, var(--color-pink), var(--color-blue)) 1;
        cursor: pointer;
        transition: var(--transition);
        
        &:hover {
            transform: translateX(8px);
            
            .title {
                background: linear-gradient(45deg, var(--color-pink), var(--color-blue));
                -webkit-background-clip: text;
                background-clip: text;
                -webkit-text-fill-color: transparent;
            }
        }
        
        .card-left {
            margin-right: 16px;
            display: flex;
            align-items: center;
            
            .dot {
                width: 10px;
                height: 10px;
                border-radius: 50%;
                background: linear-gradient(135deg, var(--color-pink), var(--color-blue));
            }
        }
        
        .content {
            flex: 1;
            overflow: hidden;
            
            .title-row {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 10px;
                
                .title {
                    color: #ffffff;
                    font-weight: 600;
                    font-size: 15px;
                    transition: var(--transition);
                }
                
                .time-tag {
                    background: rgba(0, 212, 255, 0.1);
                    color: var(--color-blue);
                    border: 1px solid rgba(0, 212, 255, 0.2);
                    border-radius: 50px;
                    font-size: 12px;
                    padding: 2px 10px;
                    white-space: nowrap;
                }
            }
            
            .intro {
                color: var(--color-gray);
                font-size: 13px;
                line-height: 1.6;
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

.text-two-row {
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 2;
    overflow: hidden;
}
</style>
