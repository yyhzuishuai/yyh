import {
	createRouter,
	createWebHashHistory
} from 'vue-router'
import login from '@/views/login.vue'
import index from '@/views/index.vue'
import HomeView from '@/views/HomeView.vue'
export const routes = [{
		path: '/login',
		name: 'login',
        meta: { title: '登录' },
		component: login
	},{
		path: '/',
		name: '首页',
        meta: { title: '首页' },
		component: index,
		children: [{
			path: '/',
			name: 'home',
			component: HomeView,
			meta: {
				affix: true,
                title: '首页'
			}
		}, {
			path: '/updatepassword',
			name: 'updatepassword',
            meta: { title: '修改密码' },
			component: () => import('../views/updatepassword.vue')
		}

		,{
			path: '/usersCenter',
			name: 'usersCenter',
            meta: { title: '管理员个人中心' },
			component: ()=>import('@/views/users/center')
		}
		,{
			path: '/shangjiaCenter',
			name: 'shangjiaCenter',
            meta: { title: '商家个人中心' },
			component: ()=>import('@/views/shangjia/center')
		}
		,{
			path: '/news',
			name: 'news',
            meta: { title: '系统公告' },
			component: ()=>import('@/views/news/list')
		}
		,{
			path: '/address',
			name: 'address',
            meta: { title: '地址' },
			component: ()=>import('@/views/address/list')
		}
		,{
			path: '/coupon',
			name: 'coupon',
            meta: { title: '优惠券' },
			component: ()=>import('@/views/coupon/list')
		}
		,{
			path: '/dingzhidingdan',
			name: 'dingzhidingdan',
            meta: { title: '定制订单' },
			component: ()=>import('@/views/dingzhidingdan/list')
		}
		,{
			path: '/myCoupon',
			name: 'myCoupon',
            meta: { title: '我的优惠券' },
			component: ()=>import('@/views/myCoupon/list')
		}
		,{
			path: '/syslog',
			name: 'syslog',
            meta: { title: '操作日志' },
			component: ()=>import('@/views/syslog/list')
		}
		,{
			path: '/storeup',
			name: 'storeup',
            meta: { title: '我的收藏' },
			component: ()=>import('@/views/storeup/list')
		}
        ,{
            path: '/menu',
            name: 'menu',
            meta: { title: '菜单权限管理' },
            component: ()=>import('@/views/menu_manage/list')
        }
		,{
			path: '/discussdongmanshangpin',
			name: 'discussdongmanshangpin',
            meta: { title: '动漫商品评论-评论' },
			component: ()=>import('@/views/discussdongmanshangpin/list')
		}
		,{
			path: '/users',
			name: 'users',
            meta: { title: '管理员' },
			component: ()=>import('@/views/users/list')
		}
		,{
			path: '/shangjia',
			name: 'shangjia',
            meta: { title: '商家' },
			component: ()=>import('@/views/shangjia/list')
		}
		,{
			path: '/rechargeRecord',
			name: 'rechargeRecord',
            meta: { title: '充值记录' },
			component: ()=>import('@/views/rechargeRecord/list')
		}
		,{
			path: '/zhoubianleixing',
			name: 'zhoubianleixing',
            meta: { title: '周边类型' },
			component: ()=>import('@/views/zhoubianleixing/list')
		}
		,{
			path: '/dongmanshangpin',
			name: 'dongmanshangpin',
            meta: { title: '动漫商品' },
			component: ()=>import('@/views/dongmanshangpin/list')
		}
		,{
			path: '/zhoubiandingzhi',
			name: 'zhoubiandingzhi',
            meta: { title: '周边定制' },
			component: ()=>import('@/views/zhoubiandingzhi/list')
		}
		,{
			path: '/huodongbaoming',
			name: 'huodongbaoming',
            meta: { title: '活动报名' },
			component: ()=>import('@/views/huodongbaoming/list')
		}
		,{
			path: '/yonghu',
			name: 'yonghu',
            meta: { title: '用户' },
			component: ()=>import('@/views/yonghu/list')
		}
		,{
			path: '/dianpuhuodong',
			name: 'dianpuhuodong',
            meta: { title: '店铺活动' },
			component: ()=>import('@/views/dianpuhuodong/list')
		}
		,{
			path: '/dongmanzhutihuodong',
			name: 'dongmanzhutihuodong',
            meta: { title: '动漫主题活动' },
			component: ()=>import('@/views/dongmanzhutihuodong/list')
		}
		,{
			path: '/orders',
			name: 'orders',
            meta: { title: '订单管理' },
			component: ()=>import('@/views/orders/list')
		}
		,{
			path: '/shangpinleixing',
			name: 'shangpinleixing',
            meta: { title: '商品类型' },
			component: ()=>import('@/views/shangpinleixing/list')
		}
		,{
			path: '/config',
			name: 'config',
            meta: { title: '轮播图' },
			component: ()=>import('@/views/config/list')
		}
		,{
			path: '/huodongleixing',
			name: 'huodongleixing',
            meta: { title: '活动类型' },
			component: ()=>import('@/views/huodongleixing/list')
		}
		]
	},
	{
		path: '/shangjiaRegister',
		name: 'shangjiaRegister',
        meta: { title: '商家注册' },
		component: ()=>import('@/views/shangjia/register')
	},
]

const router = createRouter({
	history: createWebHashHistory(process.env.BASE_URL),
	routes
})

export default router
