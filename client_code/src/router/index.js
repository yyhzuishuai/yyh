import { createRouter, createWebHashHistory } from 'vue-router'
import index from '../views'
import home from '../views/pages/home.vue'

const routes = [{
		path: '/',
		redirect: '/index/home'
	},
	{
		path: '/index',
		component: index,
		children: [{
			path: 'home',
			component: home
		}
		, {
			path: 'newsList',
			component: ()=>import('@/views/pages/news/list')
		}
		, {
			path: 'syslogList',
			component: ()=>import('@/views/pages/syslog/list')
		}, {
			path: 'syslogDetail',
			component: ()=>import('@/views/pages/syslog/formModel')
		}, {
			path: 'syslogAdd',
			component: ()=>import('@/views/pages/syslog/formAdd')
		}
		, {
			path: 'yonghuList',
			component: ()=>import('@/views/pages/yonghu/list')
		}, {
			path: 'yonghuDetail',
			component: ()=>import('@/views/pages/yonghu/formModel')
		}, {
			path: 'yonghuAdd',
			component: ()=>import('@/views/pages/yonghu/formAdd')
		}
		, {
			path: 'yonghuCenter',
			component: ()=>import('@/views/pages/yonghu/center')
		}
		, {
			path: 'shangjiaList',
			component: ()=>import('@/views/pages/shangjia/list')
		}, {
			path: 'shangjiaDetail',
			component: ()=>import('@/views/pages/shangjia/formModel')
		}, {
			path: 'shangjiaAdd',
			component: ()=>import('@/views/pages/shangjia/formAdd')
		}
		, {
			path: 'dongmanshangpinList',
			component: ()=>import('@/views/pages/dongmanshangpin/list')
		}, {
			path: 'dongmanshangpinDetail',
			component: ()=>import('@/views/pages/dongmanshangpin/formModel')
		}, {
			path: 'dongmanshangpinAdd',
			component: ()=>import('@/views/pages/dongmanshangpin/formAdd')
		}
        , {
            path: 'storeupList',
            component: ()=>import('@/views/pages/storeup/list')
        }
		, {
			path: 'cartList',
			component: ()=>import('@/views/pages/shop_order/cart')
		}
		, {
			path: 'addressList',
			component: ()=>import('@/views/pages/shop_address/list')
		}
		, {
			path: 'couponList',
			component: ()=>import('@/views/pages/coupon/list')
		}, {
			path: 'couponDetail',
			component: ()=>import('@/views/pages/coupon/formModel')
		}, {
			path: 'couponAdd',
			component: ()=>import('@/views/pages/coupon/formAdd')
		}
		, {
			path: 'rechargeRecordList',
			component: ()=>import('@/views/pages/rechargeRecord/list')
		}, {
			path: 'rechargeRecordDetail',
			component: ()=>import('@/views/pages/rechargeRecord/formModel')
		}, {
			path: 'rechargeRecordAdd',
			component: ()=>import('@/views/pages/rechargeRecord/formAdd')
		}
		, {
			path: 'myCouponList',
			component: ()=>import('@/views/pages/myCoupon/list')
		}, {
			path: 'myCouponDetail',
			component: ()=>import('@/views/pages/myCoupon/formModel')
		}, {
			path: 'myCouponAdd',
			component: ()=>import('@/views/pages/myCoupon/formAdd')
		}
		, {
			path: 'zhoubiandingzhiList',
			component: ()=>import('@/views/pages/zhoubiandingzhi/list')
		}, {
			path: 'zhoubiandingzhiDetail',
			component: ()=>import('@/views/pages/zhoubiandingzhi/formModel')
		}, {
			path: 'zhoubiandingzhiAdd',
			component: ()=>import('@/views/pages/zhoubiandingzhi/formAdd')
		}
		, {
			path: 'zhoubianleixingList',
			component: ()=>import('@/views/pages/zhoubianleixing/list')
		}, {
			path: 'zhoubianleixingDetail',
			component: ()=>import('@/views/pages/zhoubianleixing/formModel')
		}, {
			path: 'zhoubianleixingAdd',
			component: ()=>import('@/views/pages/zhoubianleixing/formAdd')
		}
		, {
			path: 'dingzhidingdanList',
			component: ()=>import('@/views/pages/dingzhidingdan/list')
		}, {
			path: 'dingzhidingdanDetail',
			component: ()=>import('@/views/pages/dingzhidingdan/formModel')
		}, {
			path: 'dingzhidingdanAdd',
			component: ()=>import('@/views/pages/dingzhidingdan/formAdd')
		}
		, {
			path: 'dianpuhuodongList',
			component: ()=>import('@/views/pages/dianpuhuodong/list')
		}, {
			path: 'dianpuhuodongDetail',
			component: ()=>import('@/views/pages/dianpuhuodong/formModel')
		}, {
			path: 'dianpuhuodongAdd',
			component: ()=>import('@/views/pages/dianpuhuodong/formAdd')
		}
		, {
			path: 'dongmanzhutihuodongList',
			component: ()=>import('@/views/pages/dongmanzhutihuodong/list')
		}, {
			path: 'dongmanzhutihuodongDetail',
			component: ()=>import('@/views/pages/dongmanzhutihuodong/formModel')
		}, {
			path: 'dongmanzhutihuodongAdd',
			component: ()=>import('@/views/pages/dongmanzhutihuodong/formAdd')
		}
		, {
			path: 'huodongleixingList',
			component: ()=>import('@/views/pages/huodongleixing/list')
		}, {
			path: 'huodongleixingDetail',
			component: ()=>import('@/views/pages/huodongleixing/formModel')
		}, {
			path: 'huodongleixingAdd',
			component: ()=>import('@/views/pages/huodongleixing/formAdd')
		}
		, {
			path: 'huodongbaomingList',
			component: ()=>import('@/views/pages/huodongbaoming/list')
		}, {
			path: 'huodongbaomingDetail',
			component: ()=>import('@/views/pages/huodongbaoming/formModel')
		}, {
			path: 'huodongbaomingAdd',
			component: ()=>import('@/views/pages/huodongbaoming/formAdd')
		}
		, {
			path: 'chatMessageList',
			component: ()=>import('@/views/pages/chatMessage/list')
		}, {
			path: 'chatMessageDetail',
			component: ()=>import('@/views/pages/chatMessage/formModel')
		}, {
			path: 'chatMessageAdd',
			component: ()=>import('@/views/pages/chatMessage/formAdd')
		}
		, {
			path: 'chatFriendList',
			component: ()=>import('@/views/pages/chatFriend/list')
		}, {
			path: 'chatFriendDetail',
			component: ()=>import('@/views/pages/chatFriend/formModel')
		}, {
			path: 'chatFriendAdd',
			component: ()=>import('@/views/pages/chatFriend/formAdd')
		}
		, {
			path: 'shangpinleixingList',
			component: ()=>import('@/views/pages/shangpinleixing/list')
		}, {
			path: 'shangpinleixingDetail',
			component: ()=>import('@/views/pages/shangpinleixing/formModel')
		}, {
			path: 'shangpinleixingAdd',
			component: ()=>import('@/views/pages/shangpinleixing/formAdd')
		}
		, {
			path: 'order_confirm',
			component: ()=>import('@/views/pages/shop_order/confirm')
		}
		, {
			path: 'ordersList',
			component: ()=>import('@/views/pages/shop_order/list')
		}
		]
	},
	{
		path: '/login',
		component: ()=>import('../views/pages/login.vue')
	}
	,{
		path: '/yonghuRegister',
		component: ()=>import('@/views/pages/yonghu/register')
	}
]

const router = createRouter({
  history: createWebHashHistory(process.env.BASE_URL),
  routes
})
// 全局后置钩子，路由跳转后执行
router.afterEach(() => {
    // 滚动到顶部
    window.scrollTo(0, 0)
})

export default router
