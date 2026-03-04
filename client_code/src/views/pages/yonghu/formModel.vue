<template>
	<div class="detail-page">
        <div class="breadcrumb-wrapper" style="width: 100%;">
            <div class="bread_view">
                <el-breadcrumb separator=">" class="breadcrumb">
                    <el-breadcrumb-item class="first_breadcrumb" :to="{ path: '/' }">首页</el-breadcrumb-item>
                    <el-breadcrumb-item class="second_breadcrumb" v-for="(item,index) in breadList" :key="index">{{item.name}}</el-breadcrumb-item>
                </el-breadcrumb>
            </div>
            <div class="back_view">
                <el-button class="back_btn" @click="backClick">返回</el-button>
            </div>
        </div>
		<div class="detail_view">
			<div class="info_view">
				<div class="title_view">
					<div class="detail_title">
					</div>
				</div>
				<div class="info_item">
					<div class="info_label">用户账号</div>

					<div  class="info_text" >{{detail.yonghuzhanghao}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">昵称</div>

					<div  class="info_text" >{{detail.nicheng}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">性别</div>

					<div  class="info_text" >{{detail.xingbie}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">邮箱</div>

					<div  class="info_text" >{{detail.youxiang}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">手机</div>

					<div  class="info_text" >{{detail.shouji}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">身份证</div>

					<div  class="info_text" >{{detail.shenfenzheng}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">注册时间</div>

					<div  class="info_text" >{{detail.zhuceshijian}}</div>
				</div>
				<div class="btn_view">
					<el-button class="edit_btn" type="primary" v-if="btnAuth('yonghu','私信')&&detail.id!=user.id" @click="chatClick">私信</el-button>
					<el-button class="edit_btn" v-if="centerType&&btnAuth('yonghu','修改')" type="primary" @click="editClick">修改</el-button>
					<el-button class="del_btn" v-if="centerType&&btnAuth('yonghu','删除')" type="danger" @click="delClick">删除</el-button>
				</div>
			</div>
		</div>
		<el-dialog v-model="chatVisible" :title="nowfname" width="70%" destroy-on-close @close="chatClose"
                   class="chat-dialog">
            <div class="chat_view">
                <div class="chat-content">
                    <div class="chat-item" :key="item.id" v-for="(item,index) in chatList">
                        <div class="chat_time" v-if="index>1&&moment(chatList[index-1].addtime).date()!=moment(item.addtime).date()||index==0">
                            {{ item.addtime }}
                        </div>
                        <div v-if="item.uid==user.id" class="right-content">
                            <div class="user">
                                <span>{{store.getters['user/username']}}</span>
                                <img :src="store.getters['user/avatar']" style="width: 50px;height: 50px;">
                            </div>
                            <div class="content">
                                <el-alert v-if="item.format==1" class="text-content" :title="item.content" :closable="false"
                                          type="success"></el-alert>
                                <el-image v-else-if="item.format==2" :src="baseUrl + item.content"
                                          class="chat_img" fit="scale-down"
                                          :preview-src-list="[baseUrl + item.content]"></el-image>
                                <video v-else-if="item.format==3" controls style="width: 200px;height: 160px">
                                    <source :src="baseUrl + item.content">
                                </video>
                                <audio v-else-if="item.format==5" controls style="height: 40px;">
                                    <source :src="baseUrl + item.content">
                                </audio>
                                <div v-else @click="downloadFile(item.content)" class="chat-file"
                                     style="display: flex;align-items: center;gap: 10px;border: 1px solid #999;padding: 10px;cursor: pointer;">
                                    <el-icon style="font-size: 30px;"><Document /></el-icon><span>点击下载</span>
                                </div>
                            </div>
                        </div>
                        <div v-else class="left-content">
                            <div class="user">
                                <span>{{nowfname}}</span>
                                <img :src="baseUrl+nowfpic" style="width: 50px;height: 50px;">
                            </div>
                            <div class="content">
                                <el-alert v-if="item.format==1" class="text-content" :title="item.content" :closable="false"
                                          type="warning"></el-alert>
                                <el-image v-else-if="item.format==2" :src="baseUrl + item.content"
                                          class="chat_img" fit="scale-down"
                                          :preview-src-list="[baseUrl + item.content]"></el-image>
                                <video v-else-if="item.format==3" controls style="width: 200px;height: 160px">
                                    <source :src="baseUrl + item.content">
                                </video>
                                <audio v-else-if="item.format==5" controls style="height: 40px;">
                                    <source :src="baseUrl + item.content">
                                </audio>
                                <div v-else @click="downloadFile(item.content)" class="chat-file"
                                     style="display: flex;align-items: center;gap: 10px;border: 1px solid #999;padding: 10px;cursor: pointer;">
                                    <el-icon style="font-size: 30px;"><Document /></el-icon><span>点击下载</span>
                                </div>
                            </div>
                        </div>
                        <div class="clear-float"></div>
                    </div>
                </div>
                <div class="input_box">
                    <div class="actionBar">
                        <el-popover
                            title="表情"
                            width="auto"
                            trigger="click"
                            placement="top"
                        >
                            <template #reference>
                                <i class="iconfont icon-xiaolian expression-icon-btn" style="font-size: 24px;"></i>
                            </template>
                            <template #default>
                                <Picker
                                    :data="emojiIndex"
                                    :emojiSize="24"
                                    :showPreview="showEmoji"
                                    :infiniteScroll="false"
                                    set="apple"
                                    @select="handleEmoji"
                                    :showSearch="false"
                                    :i18n="emojiI18n"
                                />
                            </template>
                        </el-popover>
                        <el-upload class="upload" :action="uploadUrl" :on-success="uploadSuccess"
                                   :show-file-list="false" accept="image/*,.mp4,.mp3">
                            <el-icon style="font-size: 28px">
                                <FolderAdd/>
                            </el-icon>
                        </el-upload>
                    </div>
                    <div class="input-row">
                        <el-input class="textarea" type="textarea" v-model="chatForm.content"></el-input>
                    </div>
                    <div class="send-box">
                        <el-button class="send" type="primary" @click="addChat">发送</el-button>
                    </div>
                </div>
            </div>
		</el-dialog>
	</div>
</template>
<script setup>
	import axios from 'axios'
    const moment = window.moment
	import {
		ref,
		getCurrentInstance,
		watch,
		onUnmounted,
		onMounted,
		nextTick,
		computed,
        inject
	} from 'vue';
	import {
		useRoute,
		useRouter
	} from 'vue-router';
	import {
		useStore
	} from 'vuex';
	const store = useStore()
	const user = computed(()=>store.getters['user/session'])
	const userAvatar = computed(()=>store.getters['user/avatar'])
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const route = useRoute()
	const router = useRouter()
    const baseUrl = ref(context.$config.url)
	//基础信息
	const tableName = 'yonghu'
	const formName = '用户'
	//基础信息
	const breadList = ref([{
		name: formName
	}])
	//权限验证
	const btnAuth = (e,a)=>{
		if(centerType.value){
			return context?.$toolUtil.isBackAuth(e,a)
		}else{
			return context?.$toolUtil.isAuth(e,a)
		}
	}
	//查看权限验证
	const btnFrontAuth = (e,a)=>{
		if(centerType.value){
			return context?.$toolUtil.isBackAuth(e,a)
		}else{
			return context?.$toolUtil.isFrontAuth(e,a)
		}
	}
	// 返回
	const backClick = () =>{
		history.back()
	}
	// 轮播图
	const bannerList = ref([])
	// 详情
	const title = ref('')
	const detail = ref({})
    const activeName = ref('false')
	const getDetail = () => {
		context?.$http({
			url: `${tableName}/detail/${route.query.id}`,
			method: 'get'
		}).then(res => {
			if(res.data.data.touxiang){
				nowfpic.value = res.data.data.touxiang.split(',')[0]
			}else if(res.data.data.headportrait){
				nowfpic.value = res.data.data.headportrait.split(',')[0]
			}
            if(res.data.data.yonghuzhanghao){
                nowfname.value = res.data.data.yonghuzhanghao
            }
            nowfid.value = res.data.data.id
			detail.value = res.data.data
		})
	}
	// 下载文件
	const downClick = (file) => {
		if(!file){
			context?.$toolUtil.message('文件不存在','error')
		}
		let arr = file.replace(new RegExp('file/', "g"), "")
		axios.get((location.href.split(context?.$config.name).length>1 ? location.href.split(context?.$config.name)[0] :'') + context?.$config.name + '/file/download?fileName=' + arr, {
			headers: {
				token: context?.$toolUtil.storageGet('frontToken')
			},
			responseType: "blob"
		}).then(({
			data
		}) => {
			const binaryData = [];
			binaryData.push(data);
			const objectUrl = window.URL.createObjectURL(new Blob(binaryData, {
				type: 'application/pdf;chartset=UTF-8'
			}))
			const a = document.createElement('a')
			a.href = objectUrl
			a.download = arr
			// a.click()
			// 下面这个写法兼容火狐
			a.dispatchEvent(new MouseEvent('click', {
				bubbles: true,
				cancelable: true,
				view: window
			}))
			window.URL.revokeObjectURL(data)
		})
	}
    const approvalSave = async (form)=>{
        context.$http.post(`${tableName}/update`,form).then(res => {
            context.$message.success('审核成功')
            approvalRef.value.approvalVisible = false
            init()
        })
    }
	// 判断是否从个人中心跳转
	const centerType = ref(false)
	const init = () => {
		if(route.query.centerType){
			centerType.value = true
		}
		getDetail()
	}
	//修改
	const editClick = () => {
		router.push(`/index/${tableName}Add?id=${detail.value.id}&&type=edit`)
	}
	//删除
	const delClick = () => {
		ElMessageBox.confirm(`是否删除此${formName}？`, '提示', {
			confirmButtonText: '是',
			cancelButtonText: '否',
			type: 'warning',
		}).then(()=>{
			context?.$http({
				url: `${tableName}/delete`,
				method: 'post',
				data: [detail.value.id]
			}).then(res=>{
				context?.$toolUtil.message('删除成功','success',()=>{
					history.back()
				})
			})

		}).catch(_ => {})
	}
    import emojiData from 'emoji-mart-vue-fast/data/all.json'
    import 'emoji-mart-vue-fast/css/emoji-mart.css'
    import {Picker, EmojiIndex} from 'emoji-mart-vue-fast/src'
    const emojiIndex = new EmojiIndex(emojiData)
    const emojiI18n = {
        categories: {
            search: '搜索结果',
            recent: '经常使用',
            smileys: '表情与情感',
            people: '人物与身体',
            nature: '动物与自然',
            foods: '食物与饮料',
            activity: '活动',
            places: '旅行与地理',
            objects: '物品',
            symbols: '符号标志',
            flags: '旗帜',
            custom: 'Custom',
            joy: '哭笑'
        }
    }
    const showEmoji = ref(false)
    // 选中emoji
    const handleEmoji = (e) => {
        chatForm.value.content += e.native;
        showEmoji.value = false
    }
	const nowfid = ref('')
	const chatVisible = ref(false)
	const chatList = ref([])
	const chatForm = ref({
		content: ''
	})
	const chatTimer = ref(null)
	const uploadUrl = ref(baseUrl.value + 'file/upload')
	const nowfpic = ref('')
	const nowfname = ref('')
	const chatClick = ()=> {
		getChatList()
		chatVisible.value = true
	}
    const scrollFlag = ref(true)
	const getChatList = () => {
		context.$http.get('chatmessage/mlist', {
			params: {
				page: 1,
				limit: 1000,
				uid: user.value.id,
				fid: nowfid.value
			}
		}).then(res => {
			if (res.data && res.data.code == 0) {
				chatList.value = res.data.data.list
				let div = document.getElementsByClassName('chat-content')[0]
				setTimeout(() => {
                    if (div){
                        if(div.scrollTop+div.clientHeight==div.scrollHeight || scrollFlag.value){
                            div.scrollTop = div.scrollHeight
                            scrollFlag.value = false
                        }
                    }
				}, 0)
				chatTimer.value = setTimeout(() => {
					getChatList()
				}, 5000)
			}
		})
	}
	const chatClose = () => {
		clearTimeout(chatTimer.value)
	}
    const downloadFile = (url)=>{
        if(!url){
            return false
        }
        window.open(baseUrl.value + 'file/download?fileName=' + url.replace("file/",''))
    }
	const uploadSuccess = (res) => {
		if (res.code == 0) {
			clearTimeout(chatTimer.value)
			context.$http.get('chatfriend/page', {
				params: {
					uid: user.value.id,
					fid: nowfid.value,
				}
			}).then(obj => {
				if (obj.data && obj.data.code == 0) {
					if (!obj.data.data.list.length) {
						context.$http.post('chatfriend/add', {
							uid: user.value.id,
							fid: nowfid.value,
							name: nowfname.value,
							picture: nowfpic.value,
							type: 2,
						tablename:  'yonghu',
						}).then(res => {
							context.$http.post('chatfriend/add', {
								uid: nowfid.value,
								fid: user.value.id,
								type: 2,
								tablename: localStorage.getItem('frontSessionTable'),
								name: localStorage.getItem('frontName'),
								picture: localStorage.getItem('headportrait'),
							}).then(res1 => {

							})
						})
					}
                    let format;
                    if(/(\.png|\.jpg|\.webp)$/i.test(res.file)){    //图片
                        format = 2
                    }else if(/(\.mp4)$/i.test(res.file)){   //mp4视频
                        format = 3
                    }else if(/(\.mp3)$/i.test(res.file)){   //mp3音频
                        format = 5
                    }else{  //文件
                        format = 4
                    }
					context.$http.post('chatmessage/add', {
						uid: user.value.id,
						fid: nowfid.value,
						content: 'file/' + res.file,
						format: format
					}).then(res2 => {
						chatForm.value = {
							content: ''
						}
                        scrollFlag.value = true
						getChatList()
					})
				}
			})
		}
	}
	const addChat = () => {
        if(!chatForm.value.content.trim())return context.$message.error("消息内容不能为空")
		clearTimeout(chatTimer.value)
		context.$http.get('chatfriend/page', {
			params: {
				uid: user.value.id,
				fid: nowfid.value,
			}
		}).then(obj => {
			if (obj.data && obj.data.code == 0) {
				if (!obj.data.data.list.length) {
					context.$http.post('chatfriend/add', {
						uid: user.value.id,
						fid: nowfid.value,
						name: nowfname.value,
						picture: nowfpic.value,
						type: 2,
						tablename:  'yonghu',
					}).then(res => {
						context.$http.post('chatfriend/add', {
							uid: nowfid.value,
							fid: user.value.id,
							type: 2,
							tablename: localStorage.getItem('frontSessionTable'),
							name: localStorage.getItem('frontName'),
							picture: localStorage.getItem('headportrait'),
						}).then(res1 => {

						})
					})
				}
				context.$http.post('chatmessage/add', {
					uid: user.value.id,
					fid: nowfid.value,
					content: chatForm.value.content,
					format: 1
				}).then(res2 => {
					chatForm.value = {
						content: ''
					}
                    scrollFlag.value = true
					getChatList()
				})
			}
		})
	}
	onMounted(()=>{
		init()
	})
</script>
<style lang="scss" scoped>
	//底部盒子
	.tabs_view {
		:deep(.el-tabs__header) {
			background: transparent;
			border: none;
		}
	}
	.chat-content {
		padding-bottom: 20px;
		width: 100%;
		margin-bottom: 10px;
		max-height: 300px;
		height: 300px;
		overflow-y: scroll;
		border: 1px solid #eeeeee;
		background: #fff;

		.left-content {
			float: left;
			margin-bottom: 10px;
			padding: 10px;
			max-width: 80%;
			display: flex;
			align-items: center;
		}

		.right-content {
			float: right;
			margin-bottom: 10px;
			padding: 10px;
			max-width: 80%;
			display: flex;
			align-items: center;
		}
	}

	.clear-float {
		clear: both;
	}
</style>