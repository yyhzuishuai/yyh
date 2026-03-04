<template>
	<div class="center_view">
		<div class="section_title">
			<span>{{formName}}</span>
		</div>
		<div class="usersView">
			<div class="usersTabView">
				<div class="usersTab" :class="tabIndex=='center'?'usersTabActive':''" @click="tabClick({tableName:'center'})">个人中心</div>
				<div class="usersTab " :class="tabIndex=='updatePassword'?'usersTabActive':''" @click="tabClick({tableName:'updatePassword'})">修改密码</div>
                <div class="usersTab " :class="tabIndex=='chat'?'usersTabActive':''" @click="tabClick({tableName:'chat'})">聊天记录</div>
				<template v-for="(item,index) in menuList">
					<div v-if="item.child.length>1" class="usersTab" @mouseenter="usersTabHover(index)"
						 @mouseleave="usersTabLeave">
						{{item.menu}}
						<el-collapse-transition>
							<div class="usersTabHoverView" v-if="usersTabIndex==index">
								<div class="usersTabHoverTab" v-for="(items,indexs) in item.child" @click="tabClick(items)">
									{{items.menu}}
                                </div>
							</div>
						</el-collapse-transition>
					</div>
					<div v-else-if="hasBack(item.child[0]) " class="usersTab" @click="tabClick(item.child[0])">
						{{item.child[0].menu}}
					</div>
				</template>
                <div class="usersTab" v-if="btnAuth('storeup','查看')" @click="tabClick({tableName:'storeup',type:1})">我的收藏</div>
			</div>
			<div class="usersBox updateInfo" v-if="tabIndex=='center'">
				<el-form class="usersForm" ref="userFormRef" :model="userForm" label-width="120px" :rules="rules">
					<el-row>
						<el-col :span="12">
							<el-form-item prop="shangjiazhanghao" label="商家账号">
								<el-input class="list_inp" v-model="userForm.shangjiazhanghao" placeholder="商家账号" readonly></el-input>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item prop="shangjiamingcheng" label="商家名称">
								<el-input class="list_inp" v-model="userForm.shangjiamingcheng" placeholder="商家名称" ></el-input>
							</el-form-item>
						</el-col>
						<el-col :span="24">
							<el-form-item prop="touxiang" label="头像">
								<uploads
									action="file/upload" 
									tip="请上传头像"
									style="width: 100%;text-align: left;"
									:fileUrls="userForm.touxiang?userForm.touxiang:''" 
									@change="touxiangUploadSuccess">
								</uploads>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item prop="youxiang" label="邮箱">
								<el-input class="list_inp" v-model="userForm.youxiang" placeholder="邮箱" ></el-input>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item prop="lianxifangshi" label="联系方式">
								<el-input class="list_inp" v-model="userForm.lianxifangshi" placeholder="联系方式" ></el-input>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item prop="shenfenzheng" label="身份证">
								<el-input class="list_inp" v-model="userForm.shenfenzheng" placeholder="身份证" ></el-input>
							</el-form-item>
						</el-col>
						<el-col :span="24">
							<el-form-item prop="yingyezizhi" label="营业资质">
								<uploads
									type="file"
									action="file/upload" 
									tip="请上传营业资质" 
									:limit="1" 
									style="width: 100%;text-align: left;"
									:fileUrls="userForm.yingyezizhi?userForm.yingyezizhi:''" 
									@change="yingyezizhiUploadSuccess">
								</uploads>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item label="注册时间" prop="zhuceshijian">
								<el-date-picker
									class="list_date"
									v-model="userForm.zhuceshijian"
									format="YYYY-MM-DD HH:mm:ss"
									value-format="YYYY-MM-DD HH:mm:ss"
									type="datetime"
									style="width:100%;"
									disabled
									placeholder="请选择注册时间" />
							</el-form-item>
						</el-col>
                        <el-col :span="12">
                            <el-form-item prop="panswer" label="地址">
                                <input class="list_inp"
                                       v-model="userForm.fulladdress"
                                       placeholder="请输入地址"
                                       type="text"
                                       readonly
                                       @click.native="mapClick"
                                />
                            </el-form-item>
                        </el-col>
					</el-row>
					<div class="formModel_btn_box">
						<el-button class="formModel_confirm" @click="updateSession">更新信息</el-button>
						<el-button class="formModel_cancel" @click="loginout" type="danger">退出登录</el-button>
					</div>
				</el-form>
			</div>
			<div class="usersBox updatePassword" v-if="tabIndex=='updatePassword'">
				<el-form class="usersForm" ref="passwordFormRef" :model="passwordForm" label-width="120px"
					:rules="passwordRules">
					<el-row>
						<el-col :span="12">
							<el-form-item label="原密码" prop="mima">
								<el-input class="list_inp" v-model="passwordForm.mima" placeholder="原密码"
									type="password"></el-input>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item label="新密码" prop="newmima">
								<el-input class="list_inp" v-model="passwordForm.newmima" placeholder="新密码"
									type="password"></el-input>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item label="确认密码" prop="newmima2">
								<el-input class="list_inp" v-model="passwordForm.newmima2" placeholder="确认密码"
									type="password"></el-input>
							</el-form-item>
						</el-col>
					</el-row>
					<div class="formModel_btn_box">
						<el-button class="formModel_confirm" @click="updatePassword">修改密码</el-button>
					</div>
				</el-form>
			</div>
			<div class="usersBox chatRecord" v-if="tabIndex=='chat'">
				<div class="z-box" :style='{"width":"70%","padding":"20px","margin":"0 auto"}'>
					<div class="section-content" v-for="item in recordList" :key="item.id" @click="chatClick(item)"
                         style="justify-content: space-between;">
                        <div style="display: flex;align-items: center;">
                            <img :src="item.picture?$config.url + item.picture:require('@/assets/avatar.png')" style="width: 60px;height:60px;border-radius: 50%;object-fit: cover;"
                                 alt="">
                            <div style="margin: 0 0 0 10px;display: flex;flex-direction: column;align-items: flex-start;">
                                <div :style='{"fontSize":"14px","color":"#000","flex":"1","fontWeight":"bold"}'
                                     class="item-style">{{item.name}}</div>
                                <div :style='{"color":"#666","flex":"1","fontSize":"14px","lineHeight":"1.5","display":"flex","alignItems":"center"}'
                                     class="item-style">
                                    <div v-if="item.notreadnum" style="padding: 0 5px;height: 16px;border-radius: 50%;text-align: center;line-height: 16px;font-size: 12px;background: #f00;color:#fff;width: auto;margin: 0 2px 0 0">{{item.notreadnum}}</div>
                                    {{item.content.split('/').length>1&&item.content.split('/')[0]=='upload'?'[图片]':item.content}}
                                </div>
                            </div>
                        </div>
                        <el-icon class="del-chatRecord" @click.stop="delChatRecord(item)"><Hide /></el-icon>
					</div>
					<div class="noList" v-if="!recordList.length">
						暂无聊天记录
					</div>
				</div>
			</div>
			<div class="usersBox myCoupon" v-if="tabIndex=='myCoupon'">
			  <div class="coupon-list">
				<div class="item" v-for="(item,index) in couponList" :key="index" :class="item.status=='已过期'?'disabled expired':item.status=='已使用'?'disabled used':''">
					<div class="box1">
						<div class="coupon-name">{{item.couponName}}</div>
						<div class="coupon-condition">满{{item.fullAmount}}减{{item.discountAmount}}</div>
						<div class="coupon-term">{{item.effectTime}}-{{item.expireTime}}</div>
						<div class="coupon-number">{{item.couponNumber}}</div>
						<div class="coupon-remark">{{item.remark}}</div>
						<div class="coupon-limit" v-if="item.shangjiazhanghao">仅限 {{item.shangjiazhanghao}} 商品使用</div>
						<div class="coupon-limit" v-else>全品类商品可使用</div>
					</div>
					<div class="box2">
						<div class="price">￥<span class="num">{{item.discountAmount}}</span></div>
						<div class="btn" v-if="item.status=='可使用'">{{item.status}}</div>
					</div>
				</div>
				<div class="noList" v-if="!couponList.length">
					暂无优惠券
				</div>
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
                        <div v-if="item.uid==userForm.id" class="right-content">
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
        <locationForm ref="location" :position="userForm" @mapData="getAddress"></locationForm>
	</div>
</template>
<script setup>
    const moment = window.moment
	import {
		ref,
		getCurrentInstance,
		watch,
		onUnmounted,
		onMounted,
	} from 'vue';
	import {
		useRoute,
		useRouter
	} from 'vue-router';
	import { useStore } from 'vuex'
	const store = useStore()
	import menu from '@/utils/menu'
	const context = getCurrentInstance()?.appContext.config.globalProperties;
    const baseUrl = ref(context.$config.url)
	const route = useRoute()
	const router = useRouter()
	//基础信息
	const tableName = 'shangjia'
	const formName = '个人中心'
	//基础信息
	const uploadUrl = context.$config.url + 'file/upload'
	//个人信息
	const userFormRef = ref(null)
	const userForm = ref({})
    import locationForm from '@/components/location.vue'

    const location = ref(null)

    const mapClick = () => {
        location.value.mapShow()
    }

    const getAddress = (e) => {
        userForm.value.longitude = e.lng
        userForm.value.latitude = e.lat
        userForm.value.fulladdress = e.fulladdress
    }
    //权限验证
    const btnAuth = (e, a) => {
        return context?.$toolUtil.isBackAuth(e, a)
    }
	//修改密码
	const passwordFormRef = ref(null)
	const passwordForm = ref({
		mima: '',
		newmima: '',
		newmima2: ''
	})
	const passwordRules = ref({
		mima: [{
			required: true,
			message: '请输入',
			trigger: 'blur'
		}, ],
		newmima: [{
			required: true,
			message: '请输入',
			trigger: 'blur'
		}, ],
		newmima2: [{
			required: true,
			message: '请输入',
			trigger: 'blur'
		}, ],
	})
	//验证规则
	const rules = ref({
		shangjiazhanghao: [
			{required: true,message: '请输入',trigger: 'blur'},
		],
		shangjiamima: [
			{required: true,message: '请输入',trigger: 'blur'},
		],
		shangjiamingcheng: [
			{required: true,message: '请输入',trigger: 'blur'},
		],
		touxiang: [
			{required: true,message: '请输入',trigger: 'blur'},
		],
		youxiang: [
			{required: true,message: '请输入',trigger: 'blur'},
			{ validator: context.$toolUtil.validator.email, trigger: 'blur' },
		],
		lianxifangshi: [
			{required: true,message: '请输入',trigger: 'blur'},
			{ validator: context.$toolUtil.validator.mobile, trigger: 'blur' },
		],
		shenfenzheng: [
			{required: true,message: '请输入',trigger: 'blur'},
			{ validator: context.$toolUtil.validator.idCard, trigger: 'blur' },
		],
		yingyezizhi: [
		],
		sfsh: [
		],
		shhf: [
		],
		zhuceshijian: [
		],
		longitude: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
		latitude: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
		fulladdress: [
		],
	})
	const getSession = () =>{
		context?.$http({
			url: `${context?.$toolUtil.storageGet('frontSessionTable')}/session`,
			method:'get'
		}).then(res=>{
			context?.$toolUtil.storageSet('userid',res.data.data.id)
			context?.$toolUtil.storageSet("frontName", res.data.data.shangjiazhanghao)
			context?.$toolUtil.storageSet('headportrait',res.data.data.touxiang||'')
			userForm.value = res.data.data
		})
	}
	//菜单跳转
	const tabIndex = ref('center')
	const tabClick = (item) => {
		if (item.tableName == 'center') {
			tabIndex.value = 'center'
			return
		}
		if (item.tableName == 'updatePassword') {
			passwordForm.value = {
				mima: '',
				newmima: '',
				newmima2: ''
			}
			tabIndex.value = 'updatePassword'
			return
		}
		if (item.tableName == 'chat') {
			getRecordList()
			tabIndex.value = 'chat'
			return
		}
		if (item.tableName == 'my_coupon') {
			getMyList()
			tabIndex.value = 'myCoupon'
			return
		}
		if(item.tableName=='examrecord'&&item.menuJump=='22'){
			router.push(`/index/examfailrecord?centerType=1`)
			return
		}
		if(item.tableName=='forum'&&item.menuJump=='14'){
			router.push(`/index/forumList?centerType=1&myType=1`)
			return
		}
        if(item.tableName=='storeup'){
            router.push(`/index/storeupList?centerType=1&type=${item.type}`)
            return;
        }
        router.push(`/index/${item.classname||item.tableName}List?centerType=1${item.menuJump?'&menuJump='+item.menuJump:''}`)
	}
    const hasBack = (menu)=>{
        if(menu.tableName=='storeup'){
            return false
        }
        return true
    }
	// 修改密码
	const updatePassword = async ()=>{
		passwordFormRef.value.validate(async (valid) => {
			if (valid) {
				if(passwordForm.value.mima != userForm.value.shangjiamima){
					context?.$toolUtil.message('原密码不正确', 'error')
					return false
				}
				if(passwordForm.value.newmima != passwordForm.value.newmima2){
					context?.$toolUtil.message('两次输入密码不一致', 'error')
					return false
				}
                if(passwordForm.value.mima==passwordForm.value.newmima){
                    context?.$toolUtil.message('新密码不能与原密码相同', 'error')
                    return false
                }
				userForm.value.shangjiamima = passwordForm.value.newmima
				store.dispatch('user/update',userForm.value).then(res=>{
					if(res?.data&&res.data.code==0){
						context?.$toolUtil.message('更新成功','success')
						passwordForm.value = {
							mima: '',
							newmima: '',
							newmima2: ''
						}
						getSession()
					}
				})
			}
		})
	}
	//菜单
	const menuList = ref([])
	const role = ref('')
	//头像上传回调
	const touxiangUploadSuccess=(e)=>{
		userForm.value.touxiang = e
	}
	//营业资质上传回调
	const yingyezizhiUploadSuccess=(e)=>{
		userForm.value.yingyezizhi = e
	}
	//初始化
	const init = () => {
		const menus = menu.list()
		let arr = []
		if (menus) {
			menuList.value = menus
		}
		role.value = context?.$toolUtil.storageGet('frontRole')
		for (let i = 0; i < menuList.value.length; i++) {
			if (menuList.value[i].roleName == role.value) {
				arr = menuList.value[i].backMenu
				break;
			}
		}
		menuList.value = arr
		getSession()
	}
	//菜单悬浮的显示与隐藏
	const usersTabIndex = ref(-1)
	const usersTabHover = (index) => {
		usersTabIndex.value = index
	}
	const usersTabLeave = () => {
		usersTabIndex.value = -1
	}
	//富文本
	const editorChange = (e,name) =>{
		userForm.value[name] = e
	}
	//保存
	const updateSession = () => {
		userFormRef.value.validate((valid)=>{
			if(valid){
				if(userForm.value.touxiang!=null){
					userForm.value.touxiang = userForm.value.touxiang.replace(new RegExp(context?.$config.url,"g"),"");
				}
				if(userForm.value.yingyezizhi!=null){
					userForm.value.yingyezizhi = userForm.value.yingyezizhi.replace(new RegExp(context?.$config.url,"g"),"");
				}
				store.dispatch('user/update',userForm.value).then(res=>{
					if(res?.data&&res.data.code==0){
						context?.$toolUtil.message('更新成功','success')
						getSession()
					}
				})
			}
		})
	}
	//退出登录
	const loginout = () => {
		context?.$toolUtil.message('退出成功', 'success')
		context?.$toolUtil.storageClear()
		router.replace('/index/home')
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
	const chatVisible = ref(false)
	const nowfid = ref(0)
	const nowfpic = ref('')
	const nowfname = ref('')
	const mypic = ref(localStorage.getItem('headportrait'))
	const chatList = ref([])
	const chatForm = ref({
		content: ''
	})
	const chatTimer = ref(null)
    const delChatRecord = (item)=>{
        context.$confirm(`不显示该聊天记录？`).then(()=>{
            context.$http.post('chatfriend/delete',[item.id]).then(res=>{
                context.$message.success("操作成功")
                getRecordList()
            })
        }).catch(()=>{})
    }
	const getRecordList = () => {
		context.$http.get('chatfriend/page2', {
			params: {
				uid: Number(localStorage.getItem('userid')),
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
		getChatList()
        getFriendList2()
		chatVisible.value = true
	}
    //chatfriend表中type=2，uid或fid=当前用户id的记录
    const friendList2 = ref([])
    const getFriendList2 = async ()=>{
        //获取两个id的消息列表记录(type=2)
        let res1 = await context.$http.get(`chatfriend/list?uid=${userForm.value.id}&type=2`)
        let res2 = await context.$http.get(`chatfriend/list?fid=${userForm.value.id}&type=2`)
        friendList2.value = friendList2.value.concat(res1.data.data.list)
        friendList2.value = friendList2.value.concat(res2.data.data.list)
    }
    const scrollFlag = ref(true)
	const getChatList = () => {
		context.$http.get('chatmessage/mlist', {
			params: {
				page: 1,
				limit: 1000,
				uid: Number(localStorage.getItem('userid')),
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
				uid: Number(localStorage.getItem('userid')),
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
                uid: Number(localStorage.getItem('userid')),
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
                fid: Number(localStorage.getItem('userid')),
                type: 2,
                tablename: localStorage.getItem('frontSessionTable'),
                name: localStorage.getItem('frontName'),
                picture: mypic.value,
            })
        }
		context.$http.post('chatmessage/add', {
			uid: Number(localStorage.getItem('userid')),
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
		const couponList = ref([])
		const getMyList = ()=>{
			context.$http.get('mycoupon/page').then(res => {
				if (res.data && res.data.code == 0) {
					res.data.data.list.forEach(item=>{
						if(moment()<moment(item.effectTime)||moment()>moment(item.expireTime)){//当前时间<生效时间||当前时间>过期时间
							return false
						}
						if(moment()<moment(item.effectTime) && item.status=='可使用'){
							item.status = `待启用`
						}else if(moment()>moment(item.expireTime) && item.status!='已使用'){
							item.status = `已过期`
							context.$http.post('mycoupon/update', item).then(obj => {})
						}
					})
					couponList.value = res.data.data.list
				}
			})
		}
	init()
</script>

<style lang="scss" scoped>
	.usersView {
		.usersBox {
			.usersForm {
				// form item
				:deep(.el-form-item) {
					// 内容盒子
					.el-form-item__content {
						//文件上传样式
						.upload-demo {
							width: 100%;
						}
					}
				}
			}
		}
	}
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
	.coupon-list {
		width: 100%;
		display: flex;
		flex-wrap: wrap;
		.item {
			width: 49%;
			margin: 0 1% 20px 0;
			background: url('http://clfile.zggen.cn/20240817/3d727f394907414795e8d931697d43c2.webp');
			background-repeat: no-repeat;
			background-position: center center;
			background-size: cover;
			padding: 60px 30px;
			display: flex;
			align-items: center;
			position: relative;
			.box1 {
				flex: 1;
				color: #000;
				.coupon-name,coupon-condition {
					font-size: 22px;
					line-height: 1.5;
				}
				.coupon-term,coupon-term {
					font-size: 14px;
					line-height: 1.5;
				}
				.coupon-limit {
					font-size: 12px;
					line-height: 1.5;
					color: #FF0800;
				}
			}
			.box2 {
				display: flex;
				flex-direction: column;
				align-items: center;
				.price {
					color: #FF0800;
					font-size: 20px;
					padding: 0 0 10px;
					.num {
						font-size: 28px;
					}
				}
				.btn {
					width: 100px;
					height: 30px;
					line-height: 30px;
					border-radius: 30px;
					background: #FF0800;
					text-align: center;
					color: #fff;
					font-size: 18px;
				}
			}
		}
		.disabled {
			filter: grayscale(100%);
		}
		.used::after{
			background: url("http://clfile.zggen.cn/20240820/b2a0113b267c494ca7dd7bab1ecd4117.png");
			position: absolute;
			right: 10%;
			top: 15%;
			content: "";
			width: 100px;
			height: 100px;
			background-size: 100% 100%;
		}
		.expired::after{
			background: url("http://clfile.zggen.cn/20240820/b899406b040047288f88c5f441d3b311.png");
			position: absolute;
			right: 10%;
			top: 15%;
			content: "";
			width: 100px;
			height: 100px;
			background-size: 100% 100%;
		}
		.noList {
			color: #9e9e9e;
			width: 100%;
			text-align: center;
			padding: 60px 0;
		}
	}
</style>
<style lang="scss">
/**总盒子**/
.center_view {
    width: 100%;
    padding: 0 7% 50px;
    margin: 0 auto;
    overflow: hidden;
    font-size: 16px;
    /* display: flex; */
}
/**内容区**/
.center_view .usersView{
    display: flex;
    margin: 0;
    background: none;
    padding: 0px;
    border-radius: 8px;
}

/**右部 总盒子**/
.center_view .usersView .usersBox{
    width: calc(100% - 0px);
    background: #fff;
    margin: 0px;
    padding: 0px;
    box-sizing: border-box;
    box-shadow: none;
    border-radius: 0 0 6px 6px;
    padding-bottom: 50px;
    
   box-shadow: 0px 0px 5px 0px rgba(0,0,0,0.3);
border-radius: 0px 0px 0px 0px;
}
/**form盒子**/
.center_view .usersView .usersBox .usersForm{
    width: 100%;
    padding: 30px;
}
.center_view .usersView .usersBox .usersForm .el-form-item{
    margin: 0px 0px 20px;
    display: flex;
}
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__label{
    width: 150px !important;
    background: none;
    text-align: right;
    display: block;
    font-size: 16px;
    color: rgb(51, 51, 51);
    font-weight: 500;
}
.center_view .list_inp .el-form-item__content{
    display: flex;
    justify-content: flex-start;
    align-items: center;
    flex-wrap: wrap;
    width: calc(100% - 120px);
}
.center_view .el-form-item .el-input__wrapper{
    height: 36px;
    line-height: 36px;
    padding: 0px 10px;
    width: 100%;
    box-sizing: border-box;
    background: rgb(255, 255, 255);
    font-size: 16px;
    border-radius: 8px;
}
.center_view .el-input__wrapper.is-focus {
    box-shadow: 0 0 0 1px var(--theme) inset;
}

/**会员**/
.center_view .vip_item{
    display: flex;
    align-items: center;
}
.center_view .vip_item .vip_btn{
    background: var(--theme);
    color: rgb(255, 255, 255);
    height: 36px;
    line-height: 36px;
    padding: 0px 20px;
    border-radius: 8px;
    margin: 0px 0px 0px 5px;
    border-color: var(--theme);
}
/**end**/

/**下拉选择**/
.center_view .el-form-item__content .list_sel{
    line-height: 36px;
    /* border: 1px solid var(--theme); */
    box-sizing: border-box;
    width: calc(100% - 120px);
    padding: 0;
    border-radius: 0px;
    background: rgb(255, 255, 255);
    font-size: 16px;
    border-radius: 4px;
}
.center_view .el-form-item__content .list_sel .el-select__wrapper{
    line-height: 36px;
    border-radius:8px;
}
.center_view .el-form-item__content .list_sel .el-select__wrapper.is-focused {
    box-shadow: 0 0 0 1px var(--theme) inset;
}
.center_view .el-select-dropdown__item.is-selected {
    color: var(--theme);
    font-weight: 700;
}
/**end**/

/**日期选择**/
.center_view .el-form-item__content .list_date{
    line-height: 36px;
    box-sizing: border-box;
    width: 100%;
    background: rgb(255, 255, 255);
    font-size: 16px;
    border-radius: 4px;
}
/**end**/

/**radio**/
.center_view .list_radio{
    display: flex;
    width: calc(100% - 120px);
    align-items: center;
    flex-wrap: wrap;
}
.center_view .list_radio .el-radio{
    width: 30%;
    margin: 0px;
    display: flex;
    justify-content: center;
    align-items: center;
}
.center_view .list_radio .el-radio .el-radio__inner{
    border-color: #999;
    background: #fff;
}
.center_view .list_radio .el-radio .el-radio__label{
    color: #999;
    font-size: 16px;
}
.center_view .list_radio .el-radio.is-checked .el-radio__inner{
    border-color: var(--theme);
    background: var(--theme);
}
.center_view .list_radio .el-radio.is-checked .el-radio__label{
    color: var(--theme);
    font-size: 16px;
}
/**end**/

/**checkbox**/
.center_view .list_checkbox{
    display: flex;
    width: calc(100% - 120px);
    flex-wrap: wrap;
    align-items: center;
}
.center_view .list_checkbox .el-checkbox{
    width: 20%;
    margin: 0px;
    display: flex;
    justify-content: center;
    align-items: center;
}
.center_view .list_checkbox .el-checkbox__inner{
    border-color: #999;
    background: #fff;
}
.center_view .list_checkbox .el-checkbox__label{
    color: #999;
    font-size: 16px;
}
.center_view .list_checkbox .el-checkbox.is-checked .el-checkbox__inner{
    border-color: var(--theme);
    background: var(--theme);
}
.center_view .list_checkbox .el-checkbox.is-checked .el-checkbox__label{
    color: var(--theme);
    font-size: 16px;
}
/**end**/

/**textarea**/
.center_view .list_textarea{
}
.center_view .list_textarea .el-textarea__inner{
    width: 100%;
    min-height: 150px;
    padding: 12px;
    /* border: 1px solid var(--theme); */
    border-radius: 0px;
    color: #666;
    font-size: 16px;
    border-radius: 4px;
}
/**end**/

/**图片上传**/
/* 盒子 */
.center_view .el-upload--picture-card{
    background-color: rgb(255, 255, 255);
    width: 100px;
    height: 90px;
    line-height: 100px;
    text-align: center;
    border:1px solid #ddd;
    border-radius: 4px;
    cursor: pointer;
}
/* 图标 */
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .el-upload--picture-card .el-icon{
    font-size: 32px;
    color: #999;
}
/* 提示语 */
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .img-uploader .el-upload__tip{
    font-size: 15px;
    color: #999;
    margin: 0;
}
.center_view .el-upload-list--picture-card .el-upload-list__item{
    border: none;
}
/**end**/

/**文件上传**/
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .el-upload--text .el-upload-dragger{
    background: none;
    border:1px solid #ddd;
    border-radius: 4px;
    box-sizing: border-box;
    width: 100%;
    height: auto;
    text-align: center;
    cursor: pointer;
    overflow: hidden;
    padding:0 0 10px;
    line-height: 1
}
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .el-upload--text .el-upload-dragger .el-icon--upload {
    color: var(--el-text-color-placeholder);
    font-size: 60px;
    line-height: 50px;
    margin-bottom: 10px;
}
/* 图标 */
.center_view .el-upload--text .el-upload-dragger .el-icon-upload{
    font-size: 60px;
    color: var(--theme);
    line-height: 1;
    margin-bottom: 0;
}
/* 提示语 */
.center_view .upload-demo .el-upload__tip{
    font-size: 15px;
    color: #999;
    margin: 10px 0 0;
    line-height:1;
    padding: 0;
}
/* 点击上传 */
.center_view .el-upload--text .el-upload-dragger em{
    color: var(--theme);
    font-size: 15px;
}
/**end**/

/**富文本**/
.center_view .list_editor{
    width: 100%;
    height: auto;
    margin: 0px;
    padding: 0px;
    border-radius: 0px;
    background: rgb(255, 255, 255);
    /* border: 1px solid var(--theme); */
    min-height: 300px;
}
/**end**/

/**按钮**/
.center_view .formModel_btn_box{
    width: 100%;
    padding: 10px 0px 10px 150px;
    margin: 40px 0px 0px;
    /* text-align: right; */
    display: flex;
    justify-content: center;
}
/**更新信息**/
.center_view .formModel_btn_box .formModel_confirm{
    margin: 0px 0px 0px 20px;
    padding: 0px 24px;
    width: auto;
    height: 40px;
    font-size: 16px;
    color: rgb(255, 255, 255);
    border-radius: 0px;
    border: 0px;
    cursor: pointer;
    background: var(--theme);
    border-radius: 4px;
}
.center_view .formModel_btn_box .formModel_confirm:hover{
    background: var(--theme);
}
/**退出登陆**/
.center_view .formModel_btn_box .formModel_cancel{
    margin: 0px 0px 0px 20px;
    padding: 0px 24px;
    width: auto;
    height: 40px;
    font-size: 16px;
    color: rgb(255, 255, 255);
    border-radius: 0px;
    border: 0px;
    cursor: pointer;
    background: rgba(142, 142, 142, 1);
    border-radius: 4px;
    order: 2;
}
.center_view .formModel_btn_box .formModel_cancel:hover{
    background: rgba(66, 66, 66,1);
}


.center_view .el-form-item .upload-demo {
    width: 360px;
}

/* nf9 */
/* 标题 */
.center_view .section_title {
    background-size: 100% 100%;
    color: #000000;
    font-size: 26px;
    line-height: 48px;
    width: 100%;
    margin: 30px auto;
    text-align: left;
    font-weight: 700;
background: #EBF2FD;
border-radius: 20px 20px 20px 20px;
height: 130px;
line-height:160px;
}
.center_view .section_title span{
    margin-left:15px;
    position:relative;
}
.center_view .section_title span::before{
    content:'Personal_Center';
    font-weight: 400;
font-size: 14px;
color: #0949F7;
    position:absolute;
    bottom:-20px;
    left:1px;;
}
.center_view .section_title span::after{
    content:'_________________________';
    font-weight: 400;
font-size: 14px;
color: #0949F7;
    position:absolute;
    bottom:-30px;
    left:1px;;
}

.center_view .usersView .usersBox .usersForm .el-form-item{
    margin:10px;
    display: flex;
    flex-direction:column;
  
  justify-content: flex-start; /* 左对齐 */
}
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__label{
    width: 150px !important;
    background: none;
    text-align: left;
    display: block;
   font-weight: 400;
font-size: 18px;
color: #585858;
    padding-left:10px;
}
.center_view .el-form-item .el-input__wrapper{
    height: 36px;
    line-height: 36px;
    padding: 0px 10px;
    box-sizing: border-box;

    font-size: 16px;
background: #F8F9FB;
border-radius: 10px 10px 10px 10px;
    box-shadow:none;
}
.center_view .el-select__wrapper{
    background: #F8F9FB;
border-radius: 10px 10px 10px 10px;
    box-shadow:none;
}

.center_view .el-textarea__inner{
       background: #F8F9FB;
border-radius: 10px 10px 10px 10px;
    box-shadow:none;

}
.center_view .el-upload-list--picture-card .el-upload-list__item{

border-radius:10px;
}
.center_view .el-upload--picture-card{
     background: #F8F9FB;
}
.center_view .usersView .usersBox .usersForm .el-form-item .el-form-item__content .el-upload--text .el-upload-dragger{
    border:none;
     background: #F8F9FB;
border-radius: 10px 10px 10px 10px;
}

.center_view .list_editor{
     background: #F8F9FB;
border-radius: 10px 10px 10px 10px;
}
.center_view .editor-box {
  border:none;
}
.center_view .w-e-bar{
    background:none;
}
.center_view .w-e-text-container{
 background:none;
}
.center_view .list_checkbox{
    background: #F8F9FB;
border-radius: 10px 10px 10px 10px;
}
.center_view .el-checkbox__input{
    display:none;
}
/**tab总盒子**/
.center_view .usersView .usersTabView{
    box-sizing: border-box;
    border-bottom: none;
    background: none;
    padding: 10px 0 0;
    display: flex;
    column-gap: 20px;
    flex-wrap: wrap;
    width: 220px;
    flex-direction: column;
    flex-shrink: 0;
    border-radius: 8px;
    box-shadow:none;
    border:none;
    margin-right: 50px;
    order: 0;
}
/**item**/
.center_view .usersView .usersTabView .usersTab{
    padding: 0px 0;
    box-sizing: border-box;
    cursor: pointer;
    color: #333;
    text-align: center;
    position: relative;
    line-height: 48px;
    background: #FFFFFF;
box-shadow: 0px 0px 5px 0px rgba(0,0,0,0.3);
border-radius: 0px 0px 0px 0px;
}
.center_view .usersView .usersTabView .usersTab:hover{
    background: var(--theme);
    color: #fff;
}
.center_view .usersView .usersTabView .usersTab.usersTabActive{
     background: #FFFFFF;
box-shadow: 0px 0px 5px 0px rgba(0,0,0,0.3);
border-radius: 0px 0px 0px 0px;
    border-left:5px solid var(--theme);
    color: var(--theme)
}

.usersTabView .usersTabHoverView {
    background: #fff;
    color: #000;
    z-index: 9;
}
.usersTabView .usersTabHoverTab {
    line-height: 44px;
    font-size: 14px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    color: #666;
    padding: 0;
    box-shadow: 0px 0px 5px 0px rgba(0,0,0,0.3);
border-radius: 0px 0px 0px 0px;
}

.usersTabView .usersTabHoverTab:hover {
    color: var(--theme);
}
</style>