const config = {
    get() {
        return {
            url : process.env.VUE_APP_BASE_API_URL + process.env.VUE_APP_BASE_API + '/',
            name: process.env.VUE_APP_BASE_API,
        }
    },
    getProjectName(){
        return {
            projectName: `基于springboot的动漫周边网络商店管理系统的设计与实现`
        } 
    }
}
export default config
