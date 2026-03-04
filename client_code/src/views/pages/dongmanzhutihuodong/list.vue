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
					活动名称：
				</div>
				<div class="search_box">
					<el-input class="search_inp input-dark" v-model="searchQuery.huodongmingcheng" placeholder="请输入活动名称"
						clearable>
					</el-input>
				</div>
			</div>
			<div class="search_btn_view">
				<el-button class="search_btn btn-gradient" @click="searchClick">搜索</el-button>
				<el-button class="add_btn btn-gradient" v-if="btnAuth('dongmanzhutihuodong','新增')" @click="addClick">新增</el-button>
			</div>
		</div>

        <div class="data_view">
            <div class="item glass-card animate-fade-up" v-for="(item,index) in list" :key="item.id" @click.stop="detailClick(item.id)" :style="{animationDelay: index*0.08+'s'}">
                <div class="img_box">
                    <img :src="item.imgUrls[0]" @click.stop="preViewClick(item.imgUrls[0])">
                    <div class="status-tag" v-if="item.shengyuminge > 0">火热报名中</div>
                    <div class="status-tag expired" v-else>名额已满</div>
                </div>
                <div class="content">
                    <div class="data_title activity-name">
                        <span>{{item.huodongmingcheng}}</span>
                    </div>
                    <div class="activity-info">
                        <div class="info-item time">
                            <i class="iconfont icon-shijian"></i>
                            <span>开始时间：{{item.kaishishijian}}</span>
                        </div>
                        <div class="info-item spots">
                            <i class="iconfont icon-user1"></i>
                            <span>剩余名额：<em class="text-gradient">{{item.shengyuminge}}</em></span>
                        </div>
                    </div>
                    <div class="count-row"></div>
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
	const tableName = 'dongmanzhutihuodong'
	const formName = '动漫主题活动'
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
		router.push('/index/dongmanzhutihuodongAdd')
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
	//列表
	const getList = () => {
		listLoading.value = true
		let params = JSON.parse(JSON.stringify(listQuery.value))
		if(searchQuery.value.huodongmingcheng&&searchQuery.value.huodongmingcheng!=''){
			params.huodongmingcheng = '%' + searchQuery.value.huodongmingcheng + '%'
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
                if(item.huodongtupian!=null){
                    item.imgUrls = item.huodongtupian.split(',').map(url=> {
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
            width: 250px;
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

.data_view {
    display: grid !important;
    grid-template-columns: repeat(3, 1fr) !important;
    gap: 30px !important;
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
                transform: scale(1.06);
            }
        }
        
        .img_box {
            width: 100% !important;
            aspect-ratio: 16 / 9;
            overflow: hidden;
            position: relative;
            display: block;
            
            img {
                width: 100% !important;
                height: 100% !important;
                object-fit: cover;
                display: block;
                transition: transform 0.4s ease;
            }

            .status-tag {
                position: absolute;
                top: 12px;
                left: 12px;
                background: linear-gradient(135deg, #ff6b9d, #00d4ff);
                color: white;
                font-size: 11px;
                padding: 4px 12px;
                border-radius: 50px;
                z-index: 1;
                font-weight: 600;
                box-shadow: 0 4px 10px rgba(255, 107, 157, 0.3);

                &.expired {
                    background: rgba(255, 255, 255, 0.2);
                    box-shadow: none;
                }
            }
        }
        
        .content {
            padding: 20px;
            
            .activity-name {
                color: #ffffff;
                font-weight: bold;
                font-size: 16px;
                margin-bottom: 15px;
                @extend .text-one-row;
            }
            
            .activity-info {
                .info-item {
                    display: flex;
                    align-items: center;
                    gap: 8px;
                    color: var(--color-gray);
                    font-size: 13px;
                    margin-bottom: 8px;

                    i {
                        font-size: 14px;
                        color: var(--color-blue);
                    }

                    em {
                        font-style: normal;
                        font-weight: 700;
                        font-size: 16px;
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