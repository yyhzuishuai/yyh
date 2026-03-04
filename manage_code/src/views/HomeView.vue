<template>
	<div class="home_view">
		<el-carousel :motion-blur='true' :cardScale='0.9' height='500px' direction='vertical' >
			<el-carousel-item v-for="item in swiperList" :key="item" @click="carouselClick(item.url)">
				<img :src="item.imgUrl" style="width: 100%;height: 100%;">
			</el-carousel-item>
		</el-carousel>

		<div class="countList">
			<el-collapse-transition v-if="btnAuth('orders','首页总数')">
				<el-card v-show="countTypeList.closeordersCountType" class="count-item">
					<template #header>
						<div class="card_head_title">
							商品订单
						</div>
						<div class="card_head_right">
							<el-icon @click="countTypeClick('hiddenordersCountType')" class="showIcons"
								:class="countTypeList.hiddenordersCountType?'showIcons1':''">
								<ArrowUpBold />
							</el-icon>
							<el-icon @click="countTypeClick('closeordersCountType')" class="closeIcons">
								<CloseBold />
							</el-icon>
						</div>
					</template>
					<el-collapse-transition>
						<div class="count_item" v-show="countTypeList.hiddenordersCountType">
							<div class="count_title"><span>商品订单总数</span></div>
							<div class="count_num"><countTo :startVal="0" :endVal="ordersCount" :duration="1000"></countTo></div>
						</div>
					</el-collapse-transition>
				</el-card>
			</el-collapse-transition>
		</div>

		<div class="chartList">
			<el-collapse-transition v-if="btnAuth('orders','首页统计')">
				<el-card v-show="cardTypeList.closeordersChartType1" class="chart-item">
					<template #header>
						<div class="card_head_title">
							商品订单
						</div>
						<div class="card_head_right">
							<el-icon @click="cardTypeClick('hiddenordersChartType1')" class="showIcons"
									 :class="cardTypeList.hiddenordersChartType1?'showIcons1':''">
								<ArrowUpBold />
							</el-icon>
							<el-icon @click="cardTypeClick('closeordersChartType1')" class="closeIcons">
								<CloseBold />
							</el-icon>
						</div>
					</template>
					<el-collapse-transition>
						<div class="card_item" v-show="cardTypeList.hiddenordersChartType1">
							<div class="chart-title"><span>日销量</span></div>
							<div id="ordersbuynumberEchart1" class="Echart" style="width: 100%;height: 400px;"></div>
						</div>
					</el-collapse-transition>
				</el-card>
			</el-collapse-transition>
			<el-collapse-transition v-if="btnAuth('orders','首页统计')">
				<el-card v-show="cardTypeList.closeordersChartType2" class="chart-item">
					<template #header>
						<div class="card_head_title">
							商品订单
						</div>
						<div class="card_head_right">
							<el-icon @click="cardTypeClick('hiddenordersChartType2')" class="showIcons"
									 :class="cardTypeList.hiddenordersChartType2?'showIcons2':''">
								<ArrowUpBold />
							</el-icon>
							<el-icon @click="cardTypeClick('closeordersChartType2')" class="closeIcons">
								<CloseBold />
							</el-icon>
						</div>
					</template>
					<el-collapse-transition>
						<div class="card_item" v-show="cardTypeList.hiddenordersChartType2">
							<div class="chart-title"><span>月销量</span></div>
							<div id="ordersbuynumberEchart2" class="Echart" style="width: 100%;height: 400px;"></div>
						</div>
					</el-collapse-transition>
				</el-card>
			</el-collapse-transition>
			<el-collapse-transition v-if="btnAuth('orders','首页统计')">
				<el-card v-show="cardTypeList.closeordersChartType3" class="chart-item">
					<template #header>
						<div class="card_head_title">
							商品订单
						</div>
						<div class="card_head_right">
							<el-icon @click="cardTypeClick('hiddenordersChartType3')" class="showIcons"
									 :class="cardTypeList.hiddenordersChartType3?'showIcons3':''">
								<ArrowUpBold />
							</el-icon>
							<el-icon @click="cardTypeClick('closeordersChartType3')" class="closeIcons">
								<CloseBold />
							</el-icon>
						</div>
					</template>
					<el-collapse-transition>
						<div class="card_item" v-show="cardTypeList.hiddenordersChartType3">
							<div class="chart-title"><span>日销额</span></div>
							<div id="orderstotalEchart3" class="Echart" style="width: 100%;height: 400px;"></div>
						</div>
					</el-collapse-transition>
				</el-card>
			</el-collapse-transition>
			<el-collapse-transition v-if="btnAuth('orders','首页统计')">
				<el-card v-show="cardTypeList.closeordersChartType4" class="chart-item">
					<template #header>
						<div class="card_head_title">
							商品订单
						</div>
						<div class="card_head_right">
							<el-icon @click="cardTypeClick('hiddenordersChartType4')" class="showIcons"
									 :class="cardTypeList.hiddenordersChartType4?'showIcons4':''">
								<ArrowUpBold />
							</el-icon>
							<el-icon @click="cardTypeClick('closeordersChartType4')" class="closeIcons">
								<CloseBold />
							</el-icon>
						</div>
					</template>
					<el-collapse-transition>
						<div class="card_item" v-show="cardTypeList.hiddenordersChartType4">
							<div class="chart-title"><span>月销额</span></div>
							<div id="orderstotalEchart4" class="Echart" style="width: 100%;height: 400px;"></div>
						</div>
					</el-collapse-transition>
				</el-card>
			</el-collapse-transition>
			<el-collapse-transition v-if="btnAuth('orders','首页统计')">
				<el-card v-show="cardTypeList.closeordersChartType5" class="chart-item">
					<template #header>
						<div class="card_head_title">
							商品订单
						</div>
						<div class="card_head_right">
							<el-icon @click="cardTypeClick('hiddenordersChartType5')" class="showIcons"
									 :class="cardTypeList.hiddenordersChartType5?'showIcons5':''">
								<ArrowUpBold />
							</el-icon>
							<el-icon @click="cardTypeClick('closeordersChartType5')" class="closeIcons">
								<CloseBold />
							</el-icon>
						</div>
					</template>
					<el-collapse-transition>
						<div class="card_item" v-show="cardTypeList.hiddenordersChartType5">
							<div class="chart-title"><span>品销量</span></div>
							<div id="ordersbuynumberEchart5" class="Echart" style="width: 100%;height: 400px;"></div>
						</div>
					</el-collapse-transition>
				</el-card>
			</el-collapse-transition>
		</div>

		<div class="home_news">
			<div class="title">系统公告</div>
<div class="list">
    <div class="item" v-for="(item,index) in newsList" :key="index"  @click="newsDetailClick(item)">
        <div class="row1">
            <div class="t1">{{item.title}}</div>
            <div class="time">{{moment(item.addtime).format('YYYY-MM-DD')}}</div>
        </div>
        <div class="row2">
            {{item.introduction}}
        </div>
    </div>
</div>
		</div>
		<el-dialog v-model="newsDialog.visible" title="系统公告" :append-to-body="true" width="60%" class="home_newsDialog">
			<div class="newsTitle" style="text-align: center;font-size: 20px;padding: 0 0 20px;color:#000;font-weight: bold;">{{newsDialog.detail.title}}</div>
			<div class="newImg" v-if="newsDialog.detail.picture">
				<img :src="newsDialog.detail.imgUrl" style="width:100%;height: 100%;object-fit: cover;max-height: 200px;"/>
			</div>
			<div class="newContent">
				<span v-html="newsDialog.detail.content"></span>
			</div>
		</el-dialog>


	</div>
</template>

<script setup>
	import {
		inject,
		nextTick,
		ref,
		getCurrentInstance,
		computed,
	} from 'vue';
	import {
		useStore
	} from 'vuex';
	const store = useStore()
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const projectName = context.$project.projectName
	const user = computed(()=>store.getters['user/session'])
	//权限验证
	const btnAuth = (e,a)=>{
		return context?.$toolUtil.isAuth(e,a)
	}
	// 轮播图
	const swiperList = ref([])
	const getSwiperList = () => {
		context.$http({
			url: 'config/list',
			method: 'get',
			params: {
				page: 1,
				limit: 3
			}
		}).then(res => {
			res.data.data.list.forEach(item=>{
				item.imgUrl = context.$config.url+item.value
			})
			swiperList.value = res.data.data.list
		})
	}
	getSwiperList()
	// 轮播图跳转
    const carouselClick = (url)=>{
        if (url) {
            if (url.startsWith('http')) {
                window.open(url)
            } else {
                context.$router.push(url)
            }
        }
    }
	const moment = window.moment
	const newsList = ref([])
	const newsDialog = ref({
		visible:false,
		detail:{}
	})
	const getNewsList = () => {
		context.$http({
			url: 'news/list',
			method: 'get',
			params: {
				page: 1,
				limit: 6,
				sort: 'id',
				order: 'desc',
			}
		}).then(res => {
			newsList.value = res.data.data.list
			newsList.value.forEach(item => {
				item.imgUrl = context.$config.url + item.picture.split(',')[0]
			})
		})
	}
	const newsDetailClick = (item) => {
		newsDialog.value.detail = item
		newsDialog.value.visible = true
	}
	//获取列表数据
	getNewsList()
	import countTo from '@/components/count-to/vue-countTo.vue';
	const countTypeList = ref({
	})
	const getCountList=()=>{
		countTypeList.value.closeordersCountType = true
		countTypeList.value.hiddenordersCountType = true
		if(btnAuth('orders','首页总数')){
			getordersCount()
		}
	}
	const ordersCount = ref(0)
	const getordersCount = () => {
		context?.$http({
			url:'orders/count',
			method: 'get'
		}).then(res=>{
			ordersCount.value = res.data.data
		})
	}
	const countTypeClick = (e) => {
		countTypeList.value[e] = !countTypeList.value[e]
	}
	//获取总数
	getCountList()
	const cardTypeClick = (e) =>{
		cardTypeList.value[e] = !cardTypeList.value[e]
		setTimeout(()=>{
			getChartList()
		},1000)
	}
	const cardTypeList = ref({
		closeordersChartType1: true,
		hiddenordersChartType1: true,
		closeordersChartType2: true,
		hiddenordersChartType2: true,
		closeordersChartType3: true,
		hiddenordersChartType3: true,
		closeordersChartType4: true,
		hiddenordersChartType4: true,
		closeordersChartType5: true,
		hiddenordersChartType5: true,
	})
	//判断是否有统计图筛选权限
	const changeStatQuery = (arr)=>{
		if(!arr){	//不传限制条件，默认都可见
			return true
		}
		let role = localStorage.getItem('role')
		for(let x in arr){
			if(arr[x] == role) {
				return true
			}
		}
		return false
	}
	import '@/assets/js/echarts-theme'
	const getordersChart1 = () => {
		nextTick(()=>{
			var buynumberEchart1 = echarts.init(document.getElementById("ordersbuynumberEchart1"),'theme');
			let params = {}
			context?.$http({
				url: `orders/value/addtime/buynumber/日`,
				method: "get",
				params
			}).then(obj=>{
				let res = obj.data.data
				let xAxis = [];
				let yAxis = [];
				let dataList = []
				for(let i=0;i<res.length;i++){
				    xAxis.push(res[i].addtime);
				    yAxis.push(parseFloat((res[i].total)));
					dataList.push({
				        value: parseFloat((res[i].total)),
				        name: res[i].addtime				    })
				}
				var option = {};
				option = {
    grid:{
        containLabel:true
    },
    tooltip: {
        trigger: 'item',
        formatter: '{b} : {c}'
    },
    xAxis: {
        data: xAxis,
        type: 'category',
    },
    yAxis: {
        type: 'value'
    },
    series:[{
        data: yAxis,
        type: 'bar',
        showBackground: true,
        backgroundStyle: {
            color: 'rgba(232, 245, 255, 0.8)'
        },
        barMaxWidth: 40,
    }]
}
				buynumberEchart1.clear()
				// 使用刚指定的配置项和数据显示图表。
				buynumberEchart1.setOption(option);
				//根据窗口的大小变动图表
				buynumberEchart1.resize();
			})
		})
	}
	const getordersChart2 = () => {
		nextTick(()=>{
			var buynumberEchart2 = echarts.init(document.getElementById("ordersbuynumberEchart2"),'theme');
			let params = {}
			context?.$http({
				url: `orders/value/addtime/buynumber/月`,
				method: "get",
				params
			}).then(obj=>{
				let res = obj.data.data
				let xAxis = [];
				let yAxis = [];
				let dataList = []
				for(let i=0;i<res.length;i++){
				    xAxis.push(res[i].addtime);
				    yAxis.push(parseFloat((res[i].total)));
					dataList.push({
				        value: parseFloat((res[i].total)),
				        name: res[i].addtime				    })
				}
				var option = {};
				option = {
    grid:{
        containLabel:true
    },
    tooltip: {
        trigger: 'item',
        formatter: '{b} : {c}'
    },
    xAxis: {
        data: xAxis,
        type: 'category',
    },
    yAxis: {
        type: 'value'
    },
    series:[{
        data: yAxis,
        type: 'bar',
        showBackground: true,
        backgroundStyle: {
            color: 'rgba(232, 245, 255, 0.8)'
        },
        barMaxWidth: 40,
    }]
}
                let middle = option.xAxis
                option.xAxis = option.yAxis
                option.yAxis = middle
				buynumberEchart2.clear()
				// 使用刚指定的配置项和数据显示图表。
				buynumberEchart2.setOption(option);
				//根据窗口的大小变动图表
				buynumberEchart2.resize();
			})
		})
	}
	const getordersChart3 = () => {
		nextTick(()=>{
			var totalEchart3 = echarts.init(document.getElementById("orderstotalEchart3"),'theme');
			let params = {}
			context?.$http({
				url: `orders/value/addtime/total/日`,
				method: "get",
				params
			}).then(obj=>{
				let res = obj.data.data
				let xAxis = [];
				let yAxis = [];
				let dataList = []
				for(let i=0;i<res.length;i++){
				    xAxis.push(res[i].addtime);
				    yAxis.push(parseFloat((res[i].total)));
					dataList.push({
				        value: parseFloat((res[i].total)),
				        name: res[i].addtime				    })
				}
				var option = {};
				option = {
    grid:{
        containLabel:true
    },
    tooltip: {
        trigger: 'item',
        formatter: '{b} : {c}'
    },
    xAxis: {
        data: xAxis,
        type: 'category',
    },
    yAxis: {
        type: 'value'
    },
    series:{
        data: yAxis,
        type: 'line'
    }
}
				totalEchart3.clear()
				// 使用刚指定的配置项和数据显示图表。
				totalEchart3.setOption(option);
				//根据窗口的大小变动图表
				totalEchart3.resize();
			})
		})
	}
	const getordersChart4 = () => {
		nextTick(()=>{
			var totalEchart4 = echarts.init(document.getElementById("orderstotalEchart4"),'theme');
			let params = {}
			context?.$http({
				url: `orders/value/addtime/total/月`,
				method: "get",
				params
			}).then(obj=>{
				let res = obj.data.data
				let xAxis = [];
				let yAxis = [];
				let dataList = []
				for(let i=0;i<res.length;i++){
				    xAxis.push(res[i].addtime);
				    yAxis.push(parseFloat((res[i].total)));
					dataList.push({
				        value: parseFloat((res[i].total)),
				        name: res[i].addtime				    })
				}
				var option = {};
				option = {
    grid:{
        containLabel:true
    },
    tooltip: {
        trigger: 'item',
        formatter: '{b} : {c}'
    },
    xAxis: {
        data: xAxis,
        type: 'category',
    },
    yAxis: {
        type: 'value'
    },
    series:{
        data: yAxis,
        type: 'line'
    }
}
                Object.assign(option.series,{areaStyle: {}, smooth: true})
				totalEchart4.clear()
				// 使用刚指定的配置项和数据显示图表。
				totalEchart4.setOption(option);
				//根据窗口的大小变动图表
				totalEchart4.resize();
			})
		})
	}
	const getordersChart5 = () => {
		nextTick(()=>{
			var buynumberEchart5 = echarts.init(document.getElementById("ordersbuynumberEchart5"),'theme');
			let params = {}
			context?.$http({
				url: `orders/value/goodname/buynumber?order=desc`,
				method: "get",
				params
			}).then(obj=>{
				let res = obj.data.data
				let xAxis = [];
				let yAxis = [];
				let dataList = []
				for(let i=0;i<res.length;i++){
				    xAxis.push(res[i].goodname);
				    yAxis.push(parseFloat((res[i].total)));
					dataList.push({
				        value: parseFloat((res[i].total)),
				        name: res[i].goodname				    })
				}
				var option = {};
				option = {
    legend: {
        orient: 'vertical',
        left: 'left'
    },
    tooltip: {
        trigger: 'item',
        formatter: '{b} : {c} ({d}%)'
    },
    series: [
        {
            type: 'pie',
            radius: '55%',
            center: ['50%', '60%'],
            data: dataList,
            emphasis: {
                itemStyle: {
                  shadowBlur: 10,
                  shadowOffsetX: 0,
                  shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            }
        }
    ]
}
				buynumberEchart5.clear()
				// 使用刚指定的配置项和数据显示图表。
				buynumberEchart5.setOption(option);
				//根据窗口的大小变动图表
				buynumberEchart5.resize();
			})
		})
	}
	const getChartList = () => {
		if(btnAuth('orders','首页统计')){
			getordersChart1()
		}
		if(btnAuth('orders','首页统计')){
			getordersChart2()
		}
		if(btnAuth('orders','首页统计')){
			getordersChart3()
		}
		if(btnAuth('orders','首页统计')){
			getordersChart4()
		}
		if(btnAuth('orders','首页统计')){
			getordersChart5()
		}
	}
	//获取统计图数据
	getChartList()
</script>
<style lang="scss" scoped>
	// 首页盒子
	.home_view {
        background-image: url("http://clfile.zggen.cn/20250728/efa8c4527e0d4b5fa31b9fa123463b16.webp")!important;
	}

	.showIcons {
		transition: transform 0.3s;
		margin-right: 10px;
	}

	.showIcons1 {
		transform: rotate(-180deg);
	}
</style>
<style>
.condition-box {
	display: flex;
	gap: 10px;
	justify-content: center;
}

.condition-box>* {
	max-width: 300px;
}
.home_view .countList {
    display: flex;
    flex-wrap: wrap;
    gap: 30px;
    justify-content: center;
    margin: 30px 0 0;
}

.home_view .count-item {
    flex: 1;
    min-width: 18%;
    position: relative;
    border-radius: 0;
    background-size: 100% 100%;
    box-shadow: none;
    border: 1px solid #ccc;
    background: linear-gradient(to top, #f2f2f2, #fff);
}

.home_view .el-card__header {
    display: none;
}

.home_view .count_title {
    color: #000;
    order: 1;
}

.home_view .count_num {
    font-size: 30px;
    font-weight: 700;
    line-height: 50px;
    color: var(--theme);
}
.home_view {
    padding: 30px;
}

.home_view .chartList {
    display: flex;
    flex-wrap: wrap;
    gap: 30px;
    margin-top: 60px;
}

.home_view .chart-item {
    flex: 1;
    min-width: 30%;
    border-radius: 0;
    overflow: visible;
    box-shadow: none;
    border: 1px solid #ccc;
}

.home_view .row3 {
    display: flex;
    margin-top: 30px;
    gap: 30px;
}
.home_view .el-carousel img {
    object-fit: cover;
}

.home_view .el-carousel {
    margin-bottom: 20px;
}
.home_view .chart-title {font-size: 22px;font-weight: 700;padding-left: 0px;line-height: 40px;width: 100%;background-size: 100% 100%;height: 44px;margin: 0 auto;text-align: center;position: relative;background: linear-gradient(to top, #f2f2f2, #fff);}

.home_view .count_item {
    display: flex;
    flex-direction: column;
    text-align: left;
}

.home_view .count-item:after {
    background-image: url(http://clfile.zggen.cn/20251108/690261f32b6a455291fb52ad3b5234b5.webp);
    background-size: 100% 100%;
    position: absolute;
    content: '';
    width: 60px;
    height: 100%;
    left: 20px;
    top: 0;
}

.count-item .el-card__body {
    padding-left: 100px;
}

.chart-item .el-card__body {
    padding: 0;
}
.home-calendar{
  box-shadow: rgba(0, 0, 0, 0.1) 0px 0px 0px;
  margin: 30px auto 30px;
  color: rgb(102, 102, 102);
  min-width: 480px;
  font-size: inherit;
  background: #fff;
  overflow: hidden;
  height: 600px;
  border: 1px solid #ccc;
  padding: 0;
  border-radius: 0;
  background: #f4f7ed;
}
.home-calendar .header{
  padding: 17px 40px;
  border-color: rgba(126, 96, 16, 0.1);
  flex-wrap: wrap;
  background: var(--theme-light1);
  border-width: 0px 0px 1px;
  display: flex;
  width: 100%;
  border-style: solid;
  justify-content: space-between;
  height: auto;
  background: #fff;
}
.home-calendar .header .btn{
  cursor: pointer;
  border: 0px solid rgb(153, 153, 153);
  padding: 0px 0px 0px 12px;
  align-items: center;
  color: rgb(102, 102, 102);
  border-radius: 4px;
  display: flex;
  width: auto;
  font-size: inherit;
  justify-content: center;
  order: 2;
}
.home-calendar .header .title{
  padding: 0px 10px;
  font-size: 24px;
  align-items: center;
  justify-content: center;
  display: flex;
  color: rgb(51, 51, 51);
}
.home-calendar table{
  width: 100%;
  padding: 0px 0px 20px;
  height: auto;
}
.home-calendar tbody,.home-calendar thead{
  width: 100%;
}
.home-calendar tr{
  width: 100%;
  align-items: center;
  justify-content: center;
  display: flex;
}
.home-calendar th{
  align-items: center;
  flex: 1;
  display: flex;
  line-height: 50px;
  justify-content: center;
}
.home-calendar td{
  cursor: pointer;
  padding: 6px 12px 12px;
  flex: 1;
  display: flex;
  justify-content: center;
  text-align: center;
}

.home-calendar .header .btn.lastYear,.home-calendar .header .btn.nextYear {
    display: none;
}

.home-calendar .btn.lastMonth {
    margin-left: auto;
}

.home-calendar:before {
    content: '日历';
    font-size: 22px;
    color: #555;
    line-height: 44px;
    text-align: center;
    display: block;
    margin: 0 auto;
    background: linear-gradient(to top, #f2f2f2, #fff);
    width: 100%;
}

.home-calendar table {
    background: #f4f7ed;
}

.home-calendar .header .btn .text {
    display: none;
}

.home-calendar .lastMonth .iconfont {
    transform: rotate(180deg);
}

.home-calendar .iconfont {
    font-size: 28px;
    background: #fff;
    border-radius: 50%;
}

.home-calendar td.today {
    background: var(--theme);
    border-radius: 6px;
    color: #fff;
}
.home_news {
    padding: 0 30px 30px;
    background: #fff;
    border-radius: 16px;
    margin-top: 60px;
    padding: 0;
    border: 1px solid #ccc;
    border-radius: 0;
}

.home_news .title {
    font-size: 22px;
    line-height: 60px;
    width: 500px;
    background-size: 100% 100%;
    text-align: center;
    position: relative;
    margin: 0 auto;
    background: linear-gradient(to top, #f2f2f2, #fff);
    width: 100%;
}

.home_news .list {
    overflow: auto;
    /* height: 500px; */
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
    flex-wrap: wrap;
    gap: 30px;
    padding: 20px;
}

.home_news .item {
    background: var(--theme-light1);
    /* margin-bottom: 20px; */
    padding: 20px;
    border-radius: 10px;
    flex: 1;
    min-width: 30%;
    cursor: pointer;
}

.home_news .row1 {
    display: flex;
    justify-content: space-between;
}

.home_news .t1 {
    font-size: 18px;
}

.home_news .time {
    font-size: 14px;
    color: #999;
}

.home_news .row2 {
    margin-top: 10px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    width: 100%;
}

.home_news .item:hover {
    background: var(--theme);
    color: #fff;
}
</style>