<template>
	<div class="top_view">
		<div class="left">


</div>
<div class="center">
    <div class="projectName">{{projectName}}</div>
</div>
<div class="right">

			<el-dropdown class="avatar-container" trigger="hover">
				<div class="avatar-wrapper">
					<div class="nickname">欢迎 {{adminName}}</div>
					<img class="user-avatar" :src="store.getters['user/avatar']">
					<el-icon class="el-icon-arrow-down">
						<arrow-down />
					</el-icon>
				</div>
				<template #dropdown>
					<el-dropdown-menu class="user-dropDown" slot="dropdown">
						<el-dropdown-item class="center" @click="centerClick" >
							个人中心
						</el-dropdown-item>
						<el-dropdown-item class="chatRecord" v-if="changeHasChat()">
							<span style="display:block;" @click="chatRecordClick">聊天记录</span>
						</el-dropdown-item>
						<el-dropdown-item class="password" @click="updatepasswordClick">
							修改密码
						</el-dropdown-item>
						<el-dropdown-item class="front">
							<span style="display:block;" @click="frontClick">系统前台</span>
						</el-dropdown-item>
						<el-dropdown-item class="backUp" v-if="role=='users'">
							<span style="display:block;" @click="backUp">数据备份</span>
						</el-dropdown-item>
						<el-dropdown-item class="loginOut">
							<span style="display:block;" @click="onLogout">退出登录</span>
						</el-dropdown-item>
					</el-dropdown-menu>
				</template>
			</el-dropdown>

</div>
			<div class="breadcrumb-view">
				<el-breadcrumb separator="—">
					<el-breadcrumb-item v-for="(item,index) in breadcrumbList" :key="item.path">
						<i class="iconfont icon-zhuye2" v-if="!index"></i>
						<span @click="router.push(item.path)">{{item.name}}</span>
					</el-breadcrumb-item>
				</el-breadcrumb>
			</div>

	</div>
	<el-dialog v-model="recordVisible" :title="'聊天记录'" :append-to-body="true">
		<div class="z-box" :style='{"width":"80%","padding":"20px","margin":"0 auto"}'>
			<div class="section-content" v-for="item in recordList" :key="item.id" @click="chatClick(item)"
				 style="justify-content: space-between;">
				<div style="display: flex;align-items: center;">
					<img :src="item.picture?$config.url + item.picture:require('@/assets/img/avatar.png')"
						 style="width: 60px;height:60px;border-radius: 50%;object-fit: cover;" alt="">
					<div style="margin: 0 0 0 10px;display: flex;flex-direction: column;align-items: flex-start;">
						<div :style='{"fontSize":"14px","color":"#000","flex":"1","fontWeight":"bold"}'
							 class="item-style">{{item.name}}</div>
						<div :style='{"color":"#666","flex":"1","fontSize":"14px","lineHeight":"1.5","display":"flex","alignItems":"center"}'
							 class="item-style">
							<div v-if="item.notreadnum" style="padding: 0 5px;height: 16px;border-radius: 50%;text-align: center;line-height: 16px;font-size: 12px;background: #f00;color:#fff;width: auto;margin: 0 2px 0 0">{{item.notreadnum}}</div>
							{{item.content.split('/').length&&item.content.split('/')[0]=='upload'?'[图片]':item.content}}
						</div>
					</div>
				</div>
				<el-icon class="del-chatRecord" @click.stop="delChatRecord(item)"><Hide /></el-icon>
			</div>
			<div class="noList" v-if="!recordList.length">
				暂无聊天记录
			</div>
		</div>
	</el-dialog>
	<el-dialog v-model="chatVisible" :title="nowfname" width="70%" destroy-on-close @close="chatClose" :append-to-body="true"
			   class="chat-dialog">
        <div class="chat_view">
            <div class="chat-content">
                <div class="chat-item" :key="item.id" v-for="(item,index) in chatList">
                    <div class="chat_time" v-if="index>1&&moment(chatList[index-1].addtime).date()!=moment(item.addtime).date()||index==0">
                        {{ item.addtime }}
                    </div>
                    <div v-if="item.uid==user.id" class="right-content">
						<div class="user">
							<span>{{store.state.user.username}}</span>
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

</template>

<script setup>
	import axios from 'axios'
	const moment = window.moment
	import {
		toRefs,
		defineEmits,
		getCurrentInstance,
		ref,
		onBeforeUnmount,
		computed,
	} from 'vue';
	import {
		useRouter,
		useRoute
	} from 'vue-router';
	const route = useRoute()
	const router = useRouter()
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const baseUrl = ref(context.$config.url)
	const projectName = context.$project.projectName
	const emit = defineEmits(['collapseChange'])
	const role = context.$toolUtil.storageGet('sessionTable')
	const adminName = context.$toolUtil.storageGet('adminName')
	//权限验证
	const btnAuth = (e,a)=>{
		return context?.$toolUtil.isAuth(e,a)
	}

	const props = defineProps({
		collapse: Boolean
	})
	const {collapse} = toRefs(props)

	//获取用户信息
	import { useStore } from 'vuex'
	const store = useStore()
	const user = computed(()=>store.getters['user/session'])
	const avatar = ref(store.state.user.avatar)
	if(!store.state.user.session.id){
		store.dispatch('user/getSession').then(()=>{
            avatar.value = store.state.user.avatar
        })
	}
	const toggleClick = () => {
		emit('collapseChange')
	}
	// 数据备份
	const backUp = () =>{
		ElMessageBox.confirm(`是否备份数据库?`, '数据备份提示', {
			confirmButtonText: '是',
			cancelButtonText: '否',
			type: 'warning',
		}).then(()=>{
			axios.get(process.env.VUE_APP_BASE_API + '/mysqldump', {
			    headers: {
			      token: context?.$toolUtil.storageGet("Token")
			    },
			    responseType: "blob"
			  }).then(({data})=>{
				const binaryData = [];
				binaryData.push(data);
				const objectUrl = window.URL.createObjectURL(new Blob(binaryData, {
				    type: 'application/pdf;chartset=UTF-8'
				}))
				const a = document.createElement('a')
				a.href = objectUrl
				a.download = 'mysql.dmp'
				// a.click()
				// 下面这个写法兼容火狐
				a.dispatchEvent(new MouseEvent('click', {
				    bubbles: true,
				    cancelable: true,
				    view: window
				}))
				window.URL.revokeObjectURL(data)
				message.message("数据备份成功")
			})
		}).catch(_ => {})
	}
	// 退出登录
	const onLogout = () => {
		let toolUtil = context?.$toolUtil
		store.dispatch('delAllCachedViews')
		store.dispatch('delAllVisitedViews')
        store.dispatch('user/loginOut')
		toolUtil.storageClear()
		router.replace({
			name: "login"
		});
	}
	// 跳转前台
	const frontClick = () => {
        window.open(`${context.$config.url}client/index.html#/index/home`,'_blank')
	}
	// 个人中心
	const centerClick = () => {
		router.push(`/${role}Center`)
	}
	// 修改密码
	const updatepasswordClick = () => {
		router.push(`/updatepassword`)
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
	const recordList = ref([])
	const recordVisible = ref(false)
	const chatVisible = ref(false)
	const nowfid = ref(0)
	const nowfpic = ref('')
	const nowfname = ref('')
	const chatList = ref([])
	const chatForm = ref({
		content: ''
	})
	const chatTimer = ref(null)
	const uploadUrl = context.$config.url + 'file/upload'
	const hasChatList = [
		'yonghu',
		'shangjia',
		'dongmanshangpin',
	]
	const delChatRecord = (item)=>{
		context.$confirm(`不显示该聊天记录？`).then(()=>{
			context.$http.post('chatfriend/delete',[item.id]).then(res=>{
			context.$message.success("操作成功")
			getRecordList()
			})
		}).catch(()=>{})
	}
	const chatRecordClick = () => {
		getRecordList()
		recordVisible.value = true
	}
	const changeHasChat = () => {
		let table = context.$toolUtil.storageGet('sessionTable')
		if(hasChatList.includes(table)){
			return true
		}else{
			false
		}
	}
	const getRecordList = () => {
		context.$http.get('chatfriend/page2', {
			params: {
				uid: user.value.id,
				type: 2
			}
		}).then(res => {
			if (res.data && res.data.code == 0) {
				recordList.value = res.data.data.list
			}
		})
	}
	const chatClick = (row) => {
		nowfid.value = row.fid
		nowfpic.value = row.picture
		nowfname.value = row.name
        scrollFlag.value = true
		getChatList()
		getFriendList2()
		chatVisible.value = true
	}
	//chatfriend表中type=2，uid或fid=当前用户id的记录
	const friendList2 = ref([])
	const getFriendList2 = async ()=>{
		//获取两个id的消息列表记录(type=2)
		let res1 = await context.$http.get(`chatfriend/list?uid=${user.value.id}&type=2`)
		let res2 = await context.$http.get(`chatfriend/list?fid=${user.value.id}&type=2`)
		friendList2.value = friendList2.value.concat(res1.data.data.list)
		friendList2.value = friendList2.value.concat(res2.data.data.list)
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
		}).catch(()=>{})
	}
	const chatClose = () => {
		clearTimeout(chatTimer.value)
		chatList.value = []
		getRecordList()
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
	}
	const addChat = () => {
        if(!chatForm.value.content.trim())return context.$message.error("消息内容不能为空")
		clearTimeout(chatTimer.value)
		//如果之前没有聊天记录或者聊天记录已移除，则添加回聊天记录列表
		let record1 = friendList2.value.find(item=>item.fid==nowfid.value)
		let record2 = friendList2.value.find(item=>item.uid==nowfid.value)
		if (!record1) {
			context.$http.post('chatfriend/add', {
				uid: user.value.id,
				fid: nowfid.value,
				name: nowfname.value,
				picture: nowfpic.value,
				type: 2,
				tablename: nowtablename.value
			})
		}
		if(!record2){
			context.$http.post('chatfriend/add', {
				uid: nowfid.value,
				fid: user.value.id,
				type: 2,
				tablename: context.$toolUtil.storageGet('sessionTable'),
				name: context.$toolUtil.storageGet('adminName'),
				picture: avatar.value,
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
</script>

<style lang="scss" scoped>
	.del-friend,.del-chatRecord{
		color: #ff4444;
		font-size: 20px;
	}
	.section-content {
		cursor: pointer;
		padding: 20px;
		box-shadow: 0px 4px 10px 0px rgba(0, 0, 0, 0.3);
		margin: 0 0 20px;
		color: #333;
		background: #fff;
		display: flex;
		width: 100%;
		border-color: #efefef;
		border-width: 0;
		align-items: center;
		border-style: solid;
		position: relative;
	}

	.section-content:hover {
		color: #fff;
		background: #DF847F10;
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
	.noList {
		color: #9e9e9e;
		width: 100%;
		text-align: center;
		padding: 60px 0;
	}
</style>
<style lang="scss">
.top_view {
    display: flex;
    align-items: center;
    justify-content: space-between;
    flex-wrap: wrap;
    padding: 0px 40px;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    color: #fff;
    z-index: 9;
    height: 100px;
    background: linear-gradient(135deg, #FF8C69, #FF7055 50%, #FFB347);
    box-shadow: 0 2px 12px rgba(255,140,105,0.35);
}

.top_view::after {
    content: '✨🌸';
    position: absolute;
    right: 260px;
    top: 50%;
    transform: translateY(-50%);
    opacity: 0.2;
    pointer-events: none;
    font-size: 36px;
}

.top_view .projectName {
    position: relative;
    padding-left: 20px;
    line-height: 44px;
    margin-right: auto;
    font-size: 24px;
    color: #FFFFFF;
    font-weight: 700;
    text-shadow: 0 1px 4px rgba(0,0,0,0.15);
}

.top_view .currentDate {
    /* margin: 0 10px; */
}

.top_view .notice-btn {
    margin: 0 10px;
    border: none;
    color: var(--theme);
    background: #fff;
}

.top_view img.user-avatar {
    width: 40px;
    height: 40px;
}

.top_view .avatar-wrapper {
    display: flex;
    align-items: center;
    gap: 6px;
    outline: none;
    background: rgba(255,255,255,0.2);
    border-radius: 20px;
    padding: 4px 14px;
    color: #FFFFFF;
}

.top_view .nickname {
    order: 2;
}

.top_view .avatar-wrapper>.el-icon {
    order: 3;
}
.top_view iframe {
    width: 220px;
    height: 18px;
}

.top_view .collapse_view {
    font-size: 24px;
}

.top_view .avatar-container {color: #fff;}

.top_view .left {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.top_view .center {
    width: 100%;
    position: absolute;
    text-align: center;
    left: 0;
}

.top_view .right {
    margin-left: auto;
    display: flex;
    align-items: center;
}
.top_view .breadcrumb-view {
    position: absolute;
    bottom: -40px;
    left: 0;
    background: #f4f6f5;
    border-bottom: 1px solid #ccc;
    width: 100%;
    height: 40px;
    display: flex;
    align-items: center;
    padding: 0 40px;
}
</style>