<template>
    <div class="home_box">



			<!-- 动漫商品推荐 -->
            <div class="recomList_view">
<div class="tableName"><span>动漫商品推荐</span></div>
<div class="list">
    <div v-for="(item,index) in dongmanshangpinRecomList" @click="detailClick('dongmanshangpin',item.id)" class="item" style="cursor: pointer;">
        <img v-if="item.imgUrls" :src="item.imgUrls[0]" alt="">
        <div class="content">
          
<div class="title">动漫品牌：{{item.dongmanpinpai}}</div>
<div class="title">评分：{{item.score}}</div>

            <div class="pricenumdiv">
<div class="price"><span class="unit">￥</span><span class="number">{{item.price}}</span></div>
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
<div class="more" @click="moreClick('dongmanshangpin')" style="cursor: pointer;"><span>更多 ></span></div>
            </div>

			<!-- 周边定制首页展示 -->
            <div class="homeList_view">
<div class="tableName"><span>周边定制展示</span></div>
<div class="list">
    <div v-for="(item,index) in zhoubiandingzhiHomeList" @click="detailClick('zhoubiandingzhi',item.id)" class="item" style="cursor: pointer;">
        <img v-if="item.imgUrls" :src="item.imgUrls[0]" alt="">
        <div class="content">

<div class="title">{{item.shangjiamingcheng}}</div>
<div class="title">定制价格：{{item.dingzhijiage}}</div>

            <div class="num-row">



            </div>
        </div>
    </div>
</div>
<div class="more" @click="moreClick('zhoubiandingzhi')" style="cursor: pointer;"><span>查看更多 ></span></div>
            </div>
			<!-- 店铺活动首页展示 -->
            <div class="homeList_view">
<div class="tableName"><span>店铺活动展示</span></div>
<div class="list">
    <div v-for="(item,index) in dianpuhuodongHomeList" @click="detailClick('dianpuhuodong',item.id)" class="item" style="cursor: pointer;">
        <img v-if="item.imgUrls" :src="item.imgUrls[0]" alt="">
        <div class="content">

<div class="title">{{item.huodongbiaoti}}</div>
<div class="title">活动时间：{{item.huodongshijian}}</div>
<div class="title">{{item.shangjiamingcheng}}</div>

            <div class="num-row">



            </div>
        </div>
    </div>
</div>
<div class="more" @click="moreClick('dianpuhuodong')" style="cursor: pointer;"><span>查看更多 ></span></div>
            </div>
			<!-- 动漫主题活动首页展示 -->
            <div class="homeList_view">
<div class="tableName"><span>动漫主题活动展示</span></div>
<div class="list">
    <div v-for="(item,index) in dongmanzhutihuodongHomeList" @click="detailClick('dongmanzhutihuodong',item.id)" class="item" style="cursor: pointer;">
        <img v-if="item.imgUrls" :src="item.imgUrls[0]" alt="">
        <div class="content">

<div class="title">{{item.huodongmingcheng}}</div>
<div class="title">开始时间：{{item.kaishishijian}}</div>
<div class="title">剩余名额：{{item.shengyuminge}}</div>

            <div class="num-row">



            </div>
        </div>
    </div>
</div>
<div class="more" @click="moreClick('dongmanzhutihuodong')" style="cursor: pointer;"><span>查看更多 ></span></div>
            </div>

			<!-- 系统公告 -->
			<div class="newsList_view">
<div class="tableName"><span>系统公告</span></div>
<div class="list">
        <template v-for="(item,index) in newsList">
            <div v-if="index>0" class="item" @click="newsDetailClick(item)" style="cursor: pointer;">
                <div class="imgbox">
                   <img :src="item.imgUrls[0]" >
                </div>
                <div class="infobox">
                    <div class="date"><span class="beforebtn">阅读全文</span> <span class="datespan"> {{moment(item.addtime).format('YYYY-MM-DD')}}</span></div>
                    <div class="neirong">
                     <div class="title">{{item.title}}</div>
                   <div class="intro text-two-row">{{item.introduction}}</div>
                    </div>
                  
                   
                </div>
            </div>
        </template>
        <div class="more" @click="moreClick('news')" style="cursor: pointer"><span>查看更多 ></span></div>
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
    padding: 20px 0px 50px;
    display: flex;
    flex-wrap: wrap;
    background:#FFFFFF;  
}
.recomList_view {
     width: 100%;
      margin-left:auto;
    margin-right:auto;
    margin-top: 30px;
    position: relative;
    order:3;
   background: #F8F9FB;
    padding:20px 7%;
}

.recomList_view .list {
    width: calc(100% + 20px);
    display: flex;
    flex-wrap: wrap;
    margin-top: 20px;
    margin-left: -10px;
    
}

.recomList_view .list .item {
    width: calc(25% - 20px);
    margin: 0 10px 20px;
    border-radius: 10px;
    overflow: hidden;
    background: #fff;
    box-shadow:0px 4px 6px -3px #999;
}

.recomList_view .item img {
    display:block;
    width: 80%;
    height: 220px;
    object-fit: cover;
    border-radius:10px;
 
    margin: 20px auto;
    
}

.recomList_view .thumbsupnum,.recomList_view  .storeupnum,.recomList_view .clicknum {
    display: flex;
    align-items: center;
    gap: 6px;
}

.recomList_view .categoryList .item {
    background: #f0f0f0;
    padding: 10px 20px;
    text-align: center;
    min-width: 100px;
}

.recomList_view .el-carousel {
    height: 100%;
}

.recomList_view .el-carousel img {
    height: 100%;
}

.recomList_view .el-carousel__container {
    height: 100%;
}

.recomList_view .item .content {
    width: 100%;
    padding: 14px;
    display: flex;
    flex-wrap: wrap;
}

.recomList_view .item .content .title{
    color: #FFFFFF;
}
.recomList_view .item .content .price {
     
    text-align: left;
    color:#FFF;
    font-weight: 600;
    line-height: 1.5;
    margin: 5px 0 0 0;
    order: 5;
    font-weight: 900;
font-size: 24px;
color: #FFFFFF;
}



.recomList_view .num-row {
    display: flex;
    flex-wrap: wrap;
    margin-top: 10px;
    order:8;
}

.recomList_view .thumbsupnum {
    color: #FFF;
    margin-right: 10px;
}

.recomList_view .storeupnum {
    color: #FFF;
    margin-right: 10px;
}

.recomList_view .clicknum {
    color: #FFF;
    margin-right: 10px;
}




.recomList_view .more {
    width: auto;
    position: absolute;
    top:10px;
    right:10px;
}
.recomList_view .more span{
    color: var(--theme2);
}

/* nf9 */
.recomList_view .tableName {
    text-align: left;
    font-size: 26px;
    letter-spacing: 1px;
    margin-top:50px;
}
.recomList_view .tableName span{
   color: #000000;
    font-weight: 700;
    position:relative;
}
.recomList_view .center_view .section_title span{
    margin-left:15px;
    position:relative;
}
.recomList_view .tableName span::before{
    content:'Product_Recommendation';
    font-weight: 400;
font-size: 14px;
color: #0949F7;
    position:absolute;
    bottom:40px;
    left:1px;;
}
.recomList_view .tableName span::after{
    content:'______________________';
    font-weight: 400;
font-size: 14px;
color: #0949F7;
    position:absolute;
    bottom:35px;
    left:1px;;
}
.recomList_view  .more {
    width: 160px;
height: 40px;
    position: absolute;
    top:25px;
    right:20px;
  background: #0949F7;
border-radius: 10px 10px 10px 10px;
    text-align:center;
    line-height:30px;
    border:5px solid #EBF2FD ;
     box-sizing: border-box; /* 确保边框不会影响总大小 */
}
.recomList_view  .more span{
    color: #FFF;
    font-size: 16px;
}

.recomList_view .list .item{
border-radius: 20px 20px 20px 20px;
   
}

.recomList_view .pricenumdiv {
  
    width:100%;
    display:flex;
    justify-content:space-between;
}

.recomList_view .content .gd {
    width: 100%;
    height: 45px;
    line-height: 45px;
    text-align: center;
    font-size: 16px;
    color: var(--theme);
 
    background: #E8F0FD;
border-radius: 10px 10px 10px 10px;
    margin: 10px 0 0;
    order:11;
}



.recomList_view .content {
    margin-top:30px;
   z-index:2;
    position:relative;
   
}
.recomList_view .list .item{
 position:relative;
}
/* .recomList_view .list .item::before{
    width:100%;
    height:300px;
    content:'';
    background:url(http://clfile.zggen.cn/20250920/696f145466aa47fe9e631a1ba27e42e8.png)no-repeat ;
    background-size:100% 100% !important;
    position:absolute;
    background-size:contain;
    top:70%;
    z-index:1;
} */
.recomList_view .list .item{
     background: 
    linear-gradient(to top, transparent 50%, rgba(255, 255, 255, 0.5) 50%), /* 透明上半部分 */
    url('http://clfile.zggen.cn/20250920/696f145466aa47fe9e631a1ba27e42e8.png') bottom center no-repeat; /* 背景图片只显示在下半部分 */
  background-size: contain ;
}
.recomList_view .item:hover {
 
box-shadow: 0px 4px 10px 0px #0949F7;
border-radius: 20px 20px 20px 20px;
border: 1px solid rgba(9,73,247,0.5);
}
.homeList_view {
       width: 86%;
      margin-left:auto;
    margin-right:auto;
    margin-top: 30px;
    position: relative;
    order:4;
}
.homeList_view .tableName {
    text-align: left;
    font-size: 26px;
    letter-spacing: 1px;
}
.homeList_view .tableName span{
    padding:0 0 6px;
 
}

.homeList_view .list {
    width: 100%;
    display: flex;
    gap: 30px;
    flex-wrap: wrap;
    margin-top: 30px;
}

.homeList_view .list .item {
    flex: 1;
    max-width: 25%;
    min-width: 20%;
    border-radius: 10px;
    overflow: hidden;
    background: #fff;
    box-shadow:0px 4px 6px -3px #999;
}

.homeList_view .item img {
    width: 100%;
    height: 242px;
    object-fit: cover;
    border-radius: 10px 10px 10px 10px;
}

.homeList_view .thumbsupnum,.homeList_view  .storeupnum,.homeList_view .clicknum {
    display: flex;
    align-items: center;
    gap: 6px;
}

.homeList_view .categoryList .item {
    background: #f0f0f0;
    padding: 10px 20px;
    text-align: center;
    min-width: 100px;
}

.homeList_view .el-carousel {
    height: 100%;
}

.homeList_view .el-carousel img {
    height: 100%;
}

.homeList_view .el-carousel__container {
    height: 100%;
}

.homeList_view .content {
    width: 100%;
    padding: 14px;
    display: flex;
    flex-wrap: wrap;
}

.homeList_view .price {
    width: 100%;
    text-align: left;
font-weight: 900;
font-size: 24px;
color: #0949F7;
    line-height: 1.5;
    margin: 5px 0 0 0;
    order: 5;
}
.homeList_view .price .number {
    font-weight: 900;
font-size: 24px;
color: #0949F7;
}



.homeList_view .thumbsupnum {
    color: #FFF;
    text-align:center;
   flex: 1;
height: 30px;
background: #0949F7;
border-radius: 10px 10px 10px 10px;
    display: flex;
    align-items: center;
      justify-content:center;
}

.homeList_view .storeupnum {
       color: #FFF;
    display: flex;
    align-items: center;
      justify-content:center;
   flex:1;
height: 30px;
background: #0B9E12;
border-radius: 10px 10px 10px 10px;
}

.homeList_view .clicknum {
    color: #FFF;
    display: flex;
    align-items: center;
      justify-content:center;
    flex: 1;
height: 30px;
background: #587FE8;
border-radius: 10px 10px 10px 10px;
}

.homeList_view .more {
    width: auto;
    position: absolute;
    top:20px;
    right:0;
}
.homeList_view .more span{
    color: #b51022;
}
/* nf9 */
.homeList_view .tableName  {
    margin-top:20px;
}
.homeList_view .tableName  span {
    position:relative;
}
.homeList_view .tableName span::before{
    content:'Product_Display';
    font-weight: 400;
font-size: 14px;
color: #0949F7;
    position:absolute;
    bottom:40px;
    left:1px;;
}
.homeList_view  .tableName span::after{
    content:'___________________';
    font-weight: 400;
font-size: 14px;
color: #0949F7;
    position:absolute;
    bottom:35px;
    left:1px;
}

.homeList_view  .more {
    width: 160px!important;
height: 40px;
    position: absolute;
    top:25px;
    right:20px;
  background: #0949F7;
border-radius: 10px 10px 10px 10px;
    text-align:center;
    line-height:30px;
    border:5px solid #EBF2FD ;
     box-sizing: border-box; /* 确保边框不会影响总大小 */
}
.homeList_view   .more span{
    color: #FFF!important;
    font-size: 16px;
}

.homeList_view .list .item{
    padding:20px;
    background: #F5F5F5;
border-radius: 20px 20px 20px 20px;
}

.homeList_view .num-row {
    display: flex;
    flex-wrap: wrap;
    margin-top: 10px;
    width:100%;
    order:8;
    gap:5px;
    justify-content:space-around
}
.homeList_view .list .item:hover{
 background: #FFFFFF;
box-shadow: 0px 4px 10px 0px rgba(9,73,247,0.3);
border-radius: 20px 20px 20px 20px;
border: 1px solid #0949F7;
}
.newsList_view {
    width: 100%;
    margin-top: 30px;
    position: relative;
    order:5;
      background: #F8F9FB;
    padding:20px 7%;
}
.newsList_view .tableName {
    text-align: left;
    font-size: 26px;
    letter-spacing: 1px;
}
.newsList_view .tableName span{
}

.newsList_view .list {
    width: 100%;
    margin-top: 30px;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
}

.newsList_view .item {
    width: 50%;  
    background:#fff;
    padding:10px;
    margin:0px;
    border-radius: 0px;
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;  
}
.newsList_view .item .imgbox {
    margin: 0 20px 0 0;
}
.newsList_view .item .imgbox img{
    width: 200px;
    height: 135px;
    object-fit: cover;
    border-radius: 4px;
}
.newsList_view .item .infobox {
    flex:1;
}
.newsList_view .item .infobox .title {
    width: 100%;
    font-size: 16px;
    color: #000;
    font-weight: 600;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
}
.newsList_view .item .infobox .intro{
    margin-top:5px;
    font-size: 14px;
    color: #999;
    line-height: 24px;
    padding-right: 10px;
}
.newsList_view .item .infobox .date {
    margin-top:5px;
    text-align: left;
    color: #999;
}
.newsList_view .item .infobox .date span{
    display: block;
    float: right;
    padding-right: 10px;
}
.newsList_view .el-carousel {
    height: 100%;
}
.newsList_view .el-carousel__container {
    height: 100%;
}

.newsList_view .more {
    width: auto;
    position: absolute;
    top:20px;
    right:0;
}
.newsList_view .more span{
    color: #b51022;
}
/* nf9 */
.newsList_view .tableName  {
    margin-top:20px;
}
.newsList_view .tableName  span {
    position:relative;
}
.newsList_view .tableName span::before{
    content:'Product_Display';
    font-weight: 400;
font-size: 14px;
color: #0949F7;
    position:absolute;
    bottom:40px;
    left:1px;;
}
.newsList_view  .tableName span::after{
    content:'___________________';
    font-weight: 400;
font-size: 14px;
color: #0949F7;
    position:absolute;
    bottom:35px;
    left:1px;
}

.newsList_view  .more {
    width: 160px!important;
height: 40px;
    position: absolute;
    top:25px;
    right:20px;
  background: #0949F7;
border-radius: 10px 10px 10px 10px;
    text-align:center;
    line-height:30px;
    border:5px solid #EBF2FD ;
     box-sizing: border-box; /* 确保边框不会影响总大小 */
}
.newsList_view   .more span{
    color: #FFF!important;
    font-size: 16px;
}
.newsList_view .item{
height: 210px;
background: #FFFFFF;
border-radius: 0px 0px 0px 0px;
}
.newsList_view .item:nth-child(even) {
    border-right: 1px solid #D8D8D8; /* 设置单数元素的右边框 */
}
.newsList_view .imgbox {
    display:none;
}
/* 第一个新闻占整行 */
.newsList_view .item:first-child {
border:none;
 width:100%;
 flex: 1 1 100%;  /* 默认占50%宽度 */
background: #FFFFFF;
border-radius: 0px 0px 0px 0px;
border-bottom: 1px solid #EAEAEA;
   background-image: url('http://clfile.zggen.cn/20250920/ca3c0d13e3034649b5d83fb90642f8d8.png');
    background-size: 50% 100%;  /* 背景图片宽度为容器的50%，高度为100% */
    background-position: right center;  /* 将图片定位到右侧 */
    background-repeat: no-repeat;  /* 确保背景图片不重复 */
}


.newsList_view .item:first-child .neirong {
    height:auto;
    width:40%;
    order:-1;
}

.newsList_view .item:first-child .infobox {
    display:flex;
    align-items:center;
    justify-content:flex-end;
    
}

.newsList_view .item:first-child  .infobox .date{
    width:150px;
    display:flex;
    flex-direction:column;
    margin-left:5%;
    margin-right:auto;
    gap:10px;
    
}

.newsList_view .item:first-child .infobox .intro{
color: #0949F7;
}
.newsList_view .item:first-child .infobox .title{
color: #0949F7;
}


/* 第一个end */

.newsList_view .item .infobox .date{
    text-align:center;
    width:100%;
    display:flex;
    justify-content:space-between;
   
}




.newsList_view span.beforebtn {
    width: 130px;
height: 50px;
background: #0949F7;
border-radius: 0px 0px 0px 0px;
line-height:50px;
font-weight: 700;
font-size: 20px;
color: #FFFFFF;

}



.newsList_view .neirong {
    padding-top:20px;
}

.newsList_view .item{
    padding:20px;
}

.newsList_view .item{
    border-bottom:1px solid #D8D8D8;
     flex: 1 1 50%;  /* 默认占50%宽度 */
}
</style>