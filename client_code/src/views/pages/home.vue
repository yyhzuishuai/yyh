<template>
    <div class="home_box">



			<!-- 动漫商品推荐 -->
            <div class="recomList_view">
<div class="tableName"><span class="animate-fade-up">动漫商品推荐</span></div>
<div class="list">
    <div v-for="(item,index) in dongmanshangpinRecomList" @click="detailClick('dongmanshangpin',item.id)" class="item glass-card animate-fade-up" :style="{animationDelay: index*0.08+'s'}">
        <img v-if="item.imgUrls" :src="item.imgUrls[0]" alt="">
        <div class="content">
          
<div class="title">动漫品牌：{{item.dongmanpinpai}}</div>
<div class="title">评分：{{item.score}}</div>

            <div class="pricenumdiv">
<div class="price text-gradient"><span class="unit">￥</span><span class="number">{{item.price}}</span></div>
            <div class="num-row">
<div class="thumbsupnum">
	<span class="iconfont icon-thumb-up-line1"></span>
	<div class="num">{{item.thumbsupNumber}}</div>
</div>

<div class="storeupnum">
	<span class="iconfont icon-likeline4"></span>
	<div class="num">{{item.storeupNumber}}</div>
</div>


            </div>
            </div>
           
            <div class="gd">查看详情</div>
        </div>
    </div>
</div>
<div class="more btn-gradient animate-fade-up" @click="moreClick('dongmanshangpin')"><span>更多 ></span></div>
            </div>

			<!-- 周边定制首页展示 -->
            <div class="homeList_view">
<div class="tableName"><span class="animate-fade-up">周边定制展示</span></div>
<div class="list">
    <div v-for="(item,index) in zhoubiandingzhiHomeList" @click="detailClick('zhoubiandingzhi',item.id)" class="item glass-card animate-fade-up" :style="{animationDelay: index*0.08+'s'}">
        <img v-if="item.imgUrls" :src="item.imgUrls[0]" alt="">
        <div class="content">

<div class="title merchant-name">{{item.shangjiamingcheng}}</div>
<div class="title custom-price"><span class="price-label">定制价格：</span><span class="price-num text-gradient">￥{{item.dingzhijiage}}</span></div>

            <div class="num-row">



            </div>
        </div>
    </div>
</div>
<div class="more btn-gradient animate-fade-up" @click="moreClick('zhoubiandingzhi')"><span>查看更多 ></span></div>
            </div>
			<!-- 店铺活动首页展示 -->
            <div class="homeList_view">
<div class="tableName"><span class="animate-fade-up">店铺活动展示</span></div>
<div class="list">
    <div v-for="(item,index) in dianpuhuodongHomeList" @click="detailClick('dianpuhuodong',item.id)" class="item glass-card animate-fade-up" :style="{animationDelay: index*0.08+'s'}">
        <img v-if="item.imgUrls" :src="item.imgUrls[0]" alt="">
        <div class="content">

<div class="title activity-title">{{item.huodongbiaoti}}</div>
<div class="activity-time-tag">{{item.huodongshijian}}</div>
<div class="merchant-name">{{item.shangjiamingcheng}}</div>

            <div class="num-row">



            </div>
        </div>
    </div>
</div>
<div class="more btn-gradient animate-fade-up" @click="moreClick('dianpuhuodong')"><span>查看更多 ></span></div>
            </div>
			<!-- 动漫主题活动首页展示 -->
            <div class="homeList_view">
<div class="tableName"><span class="animate-fade-up">动漫主题活动展示</span></div>
<div class="list">
    <div v-for="(item,index) in dongmanzhutihuodongHomeList" @click="detailClick('dongmanzhutihuodong',item.id)" class="item glass-card animate-fade-up" :style="{animationDelay: index*0.08+'s'}">
        <img v-if="item.imgUrls" :src="item.imgUrls[0]" alt="">
        <div class="content">

<div class="title activity-name">{{item.huodongmingcheng}}</div>
<div class="info-item time"><i class="iconfont icon-shijian"></i><span>开始时间：{{item.kaishishijian}}</span></div>
<div class="info-item spots"><i class="iconfont icon-user1"></i><span>剩余名额：<em class="text-gradient">{{item.shengyuminge}}</em></span></div>

            <div class="num-row">



            </div>
        </div>
    </div>
</div>
<div class="more btn-gradient animate-fade-up" @click="moreClick('dongmanzhutihuodong')"><span>查看更多 ></span></div>
            </div>

			<!-- 系统公告 -->
			<div class="newsList_view">
<div class="tableName"><span class="animate-fade-up">系统公告</span></div>
<div class="list">
        <template v-for="(item,index) in newsList" :key="index">
            <div class="item glass-card animate-fade-up" @click="newsDetailClick(item)" :style="{animationDelay: index*0.08+'s'}">
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
        <div class="more btn-gradient animate-fade-up" @click="moreClick('news')"><span>查看更多 ></span></div>
</div>

			</div>



    </div>
    <formModel ref="newsFormModelRef"></formModel>
</template>

<script setup>
	import {
		ref,
        computed,
		getCurrentInstance
	} from 'vue';
    const moment = window.moment
	import {
		useRouter
	} from 'vue-router';
    import {
        useStore
    } from 'vuex';
    const store = useStore()
    const user = computed(()=>store.getters['user/session'])
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const router = useRouter()
    const baseUrl = ref(context.$config.url)
	//动漫商品推荐
	const dongmanshangpinRecomList = ref([])
	const getdongmanshangpinRecomList = () => {
		let autoSortUrl = 'dongmanshangpin/autoSort'
		let params = {
			sfsh: '是',
			page: 1,
			limit: 8,
            isShelves: 1,
		}
		context?.$http({
			url: autoSortUrl,
			method: 'get',
			params: params
		}).then(res => {
			dongmanshangpinRecomList.value = res.data.data.list
			dongmanshangpinRecomList.value.forEach(item=>{
				if(item.shangpintupian!=null){
					item.imgUrls = item.shangpintupian.split(',').map(item=>(isHttp(item)?'':context.$config.url)+item)
				}else{
                    item.imgUrls = []
                }
			})
		})
	}
	//周边定制首页展示
	const zhoubiandingzhiHomeList = ref([])
	const getzhoubiandingzhiHomeList = () => {
		let params = {
			page: 1,
			limit: 8,
            sort:'id',
            order:'desc',
		}
		context?.$http({
			url: 'zhoubiandingzhi/list',
			method: 'get',
			params: params
		}).then(res => {
			zhoubiandingzhiHomeList.value = res.data.data.list
			zhoubiandingzhiHomeList.value.forEach(item=>{
				if(item.yangpinzhanshi!=null){
					item.imgUrls = item.yangpinzhanshi.split(',').map(item=>(isHttp(item)?'':context.$config.url)+item)
				}else{
                    item.imgUrls = []
                }
			})
		})
	}
	//店铺活动首页展示
	const dianpuhuodongHomeList = ref([])
	const getdianpuhuodongHomeList = () => {
		let params = {
			page: 1,
			limit: 8,
            sort:'id',
            order:'desc',
		}
		context?.$http({
			url: 'dianpuhuodong/list',
			method: 'get',
			params: params
		}).then(res => {
			dianpuhuodongHomeList.value = res.data.data.list
			dianpuhuodongHomeList.value.forEach(item=>{
				if(item.tupian!=null){
					item.imgUrls = item.tupian.split(',').map(item=>(isHttp(item)?'':context.$config.url)+item)
				}else{
                    item.imgUrls = []
                }
			})
		})
	}
	//动漫主题活动首页展示
	const dongmanzhutihuodongHomeList = ref([])
	const getdongmanzhutihuodongHomeList = () => {
		let params = {
			page: 1,
			limit: 8,
            sort:'id',
            order:'desc',
		}
		context?.$http({
			url: 'dongmanzhutihuodong/list',
			method: 'get',
			params: params
		}).then(res => {
			dongmanzhutihuodongHomeList.value = res.data.data.list
			dongmanzhutihuodongHomeList.value.forEach(item=>{
				if(item.huodongtupian!=null){
					item.imgUrls = item.huodongtupian.split(',').map(item=>(isHttp(item)?'':context.$config.url)+item)
				}else{
                    item.imgUrls = []
                }
			})
		})
	}
	//系统公告弹窗
	import formModel from './news/formModel'
	const newsFormModelRef = ref(null)
	//系统公告
	const newsList = ref([])
	const getNewsList = () => {
		context?.$http({
			url: 'news/list',
			method: 'get',
			params:{
				page:1,
				limit: 5,
                sort:'id',
                order:'desc',
			}
		}).then(res=>{
			newsList.value = res.data.data.list
			newsList.value.forEach(item=>{
                let urls = item.picture.split(',')
                item.imgUrls = urls.map(url=>{
                    if(isHttp(url)){
                        return url
                    }else{
                        return baseUrl.value+url
                    }
                })
			})
		})
	}
	const newsDetailClick = (item) => {
		if (item && item.id){
			newsFormModelRef.value.init(item.id)
		}
	}
	//判断图片链接是否带http
	const isHttp = (str) => {
        return str && str.substr(0,4)=='http';
    }
	//跳转详情
	const detailClick = (table,id) => {
		router.push(`/index/${table}Detail?id=${id}`)
	}
	const moreClick = (table) => {
		router.push(`/index/${table}List`)
	}
	const init = () => {
		//动漫商品推荐
		getdongmanshangpinRecomList()
		//周边定制首页展示
		getzhoubiandingzhiHomeList()
		//店铺活动首页展示
		getdianpuhuodongHomeList()
		//动漫主题活动首页展示
		getdongmanzhutihuodongHomeList()
		//系统公告
		getNewsList()
	}
	init()
</script>

<style lang="scss">
.home_box {
    width: 100%;
    margin: 0 auto;
    padding: 0 0 50px;
    display: flex;
    flex-wrap: wrap;
    background: transparent;
}
.recomList_view {
    width: 100%;
    margin: 30px auto 0;
    position: relative;
    order: 3;
    background: transparent;
    padding: 40px 7%;
}

.recomList_view .tableName {
    text-align: left;
    margin-bottom: 20px;
}

.recomList_view .tableName span {
    color: #ffffff;
    font-size: 22px;
    font-weight: 700;
    position: relative;
    display: inline-block;
    padding-top: 25px;
    
    &::before {
        content: 'Product_Recommendation';
        position: absolute;
        top: 0;
        left: 0;
        font-weight: 400;
        font-size: 13px;
        color: var(--color-pink);
        letter-spacing: 1px;
    }
}

.recomList_view .more {
    position: absolute;
    top: 40px;
    right: 7%;
    width: auto;
    height: auto;
    padding: 8px 20px;
    border: none;
    line-height: normal;
    z-index: 5;
    
    span {
        color: #ffffff !important;
        font-size: 14px;
    }
}

.recomList_view .list {
    width: 100%;
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 24px;
    margin-top: 40px;
}

.recomList_view .list .item {
    width: 100%;
    margin: 0;
    border-radius: var(--radius-card);
    overflow: hidden;
    background: rgba(255, 255, 255, 0.08) !important;
    backdrop-filter: blur(15px);
    -webkit-backdrop-filter: blur(15px);
    border: 1px solid rgba(255, 107, 157, 0.15) !important;
    transition: var(--transition);
    cursor: pointer;
    
    &:hover {
        transform: translateY(-8px);
        box-shadow: 0 20px 40px rgba(255, 107, 157, 0.2);
        border-color: rgba(255, 107, 157, 0.4) !important;
        
        img {
            transform: scale(1.08);
        }
        
        .content .gd {
            background: linear-gradient(45deg, var(--color-pink), var(--color-blue));
            color: #fff;
            box-shadow: 0 0 15px rgba(255, 107, 157, 0.4);
        }
    }
}

.recomList_view .item img {
    display: block;
    width: 100%;
    height: 220px;
    object-fit: cover;
    transition: transform 0.4s ease;
}

.recomList_view .item .content {
    padding: 20px;
    display: flex;
    flex-direction: column;
    gap: 10px;
    margin-top: 0;
    position: relative;
    z-index: 2;
}

.recomList_view .item .content .title {
    color: rgba(255, 255, 255, 0.65);
    font-size: 13px;
    margin: 0;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.recomList_view .pricenumdiv {
    display: flex;
    align-items: center;
    justify-content: space-between;
    margin: 10px 0;
}

.recomList_view .price {
    .number {
        font-size: 22px;
        font-weight: 700;
    }
    .unit {
        font-size: 14px;
        margin-right: 2px;
    }
}

.recomList_view .num-row {
    display: flex;
    gap: 10px;
    
    .thumbsupnum, .storeupnum {
        display: flex;
        align-items: center;
        gap: 4px;
        color: rgba(255, 255, 255, 0.5);
        font-size: 12px;
        
        i {
            font-size: 14px;
        }
    }
}

.recomList_view .content .gd {
    width: 100%;
    height: 38px;
    line-height: 38px;
    text-align: center;
    font-size: 14px;
    color: var(--color-pink);
    background: rgba(255, 107, 157, 0.1);
    border: 1px solid rgba(255, 107, 157, 0.2);
    border-radius: 50px;
    margin-top: 5px;
    transition: var(--transition);
}
.homeList_view {
    width: 100%;
    margin: 30px auto 0;
    position: relative;
    order: 4;
    background: transparent;
    padding: 40px 7%;
}

.homeList_view .tableName {
    text-align: left;
    margin-bottom: 20px;
}

.homeList_view .tableName span {
    color: #ffffff;
    font-size: 22px;
    font-weight: 700;
    position: relative;
    display: inline-block;
    padding-top: 25px;
    
    &::before {
        content: 'Product_Display';
        position: absolute;
        top: 0;
        left: 0;
        font-weight: 400;
        font-size: 13px;
        color: #ff6b9d;
        letter-spacing: 1px;
    }
    
    &::after {
        display: none;
    }
}

.homeList_view .more {
    position: absolute;
    top: 40px;
    right: 7%;
    width: auto;
    height: auto;
    padding: 8px 20px;
    border: none;
    line-height: normal;
    
    span {
        color: #ffffff !important;
        font-size: 14px;
    }
}

.homeList_view .list {
    width: 100%;
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 24px;
    margin-top: 40px;
}

.homeList_view .list .item {
    width: 100%;
    margin: 0;
    border-radius: var(--radius-card);
    overflow: hidden;
    background: var(--bg-card);
    transition: var(--transition);
}

.homeList_view .item img {
    display: block;
    width: 100%;
    height: 220px;
    object-fit: cover;
    transition: transform 0.4s ease;
}

.homeList_view .item:hover img {
    transform: scale(1.08);
}

.homeList_view .content {
    padding: 16px;
}

.homeList_view .merchant-name {
    color: #ffffff;
    font-weight: 600;
    font-size: 15px;
    margin-bottom: 8px;
}

.homeList_view .custom-price {
    font-size: 13px;
    display: flex;
    align-items: center;
    gap: 4px;
    
    .price-label {
        color: rgba(255, 255, 255, 0.55);
    }
    
    .price-num {
        font-size: 20px;
        font-weight: 700;
    }
}

.homeList_view .activity-title {
    color: #ffffff;
    font-weight: bold;
    font-size: 15px;
    margin-bottom: 12px;
}

.homeList_view .activity-time-tag {
    background: rgba(255, 107, 157, 0.1);
    color: #ff6b9d;
    border: 1px solid rgba(255, 107, 157, 0.3);
    border-radius: 50px;
    font-size: 12px;
    padding: 3px 12px;
    display: inline-block;
    margin-bottom: 12px;
}

.homeList_view .activity-name {
    color: #ffffff;
    font-weight: bold;
    font-size: 16px;
    margin-bottom: 15px;
}

.homeList_view .info-item {
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
.newsList_view {
    width: 100%;
    margin: 30px auto 0;
    position: relative;
    order: 5;
    background: transparent;
    padding: 40px 7%;
}

.newsList_view .tableName {
    text-align: left;
    margin-bottom: 20px;
}

.newsList_view .tableName span {
    color: #ffffff;
    font-size: 22px;
    font-weight: 700;
    position: relative;
    display: inline-block;
    padding-top: 25px;
    
    &::before {
        content: 'System_Announcements';
        position: absolute;
        top: 0;
        left: 0;
        font-weight: 400;
        font-size: 13px;
        color: #ff6b9d;
        letter-spacing: 1px;
    }
    
    &::after {
        display: none;
    }
}

.newsList_view .more {
    position: absolute;
    top: 40px;
    right: 7%;
    width: auto;
    height: auto;
    padding: 8px 20px;
    border: none;
    line-height: normal;
    
    span {
        color: #ffffff !important;
        font-size: 14px;
    }
}

.newsList_view .list {
    width: 100%;
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 24px;
    margin-top: 40px;
}

.newsList_view .list .item {
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
            animation: pulse-glow 2s infinite;
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
</style>