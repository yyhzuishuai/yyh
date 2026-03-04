const config = {
    get() {
        return {
            url : process.env.VUE_APP_BASE_API_URL + process.env.VUE_APP_BASE_API + '/',
            name: process.env.VUE_APP_BASE_API,
			menuList:[
				{
					name: '动漫商品',
					icon: 'icon-common16',
					child:[

						{
							name:'动漫商品',
                            url:'/index/dongmanshangpinList'

						},
					]
				},
				{
					name: '周边定制',
					icon: 'icon-common17',
					child:[

						{
							name:'周边定制',
                            url:'/index/zhoubiandingzhiList'

						},
					]
				},
				{
					name: '店铺活动',
					icon: 'icon-common45',
					child:[

						{
							name:'店铺活动',
                            url:'/index/dianpuhuodongList'

						},
					]
				},
				{
					name: '动漫主题活动',
					icon: 'icon-common23',
					child:[

						{
							name:'动漫主题活动',
                            url:'/index/dongmanzhutihuodongList'

						},
					]
				},
				{
					name: '系统公告',
					icon: 'icon-common15',
					child:[

						{
							name:'系统公告',
                            url:'/index/newsList'

						},
					]
				},
			]
        }
    },
    getProjectName(){
        return {
            projectName: `基于springboot的动漫周边网络商店管理系统的设计与实现`
        } 
    }
}
export default config
