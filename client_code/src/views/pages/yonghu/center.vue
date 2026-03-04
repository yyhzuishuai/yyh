<template>
	<div class="center-container">
		<div class="left-menu glass-card">
			
			<div class="menu-item" :class="{'is-active': tabIndex==='center'}" @click="tabClick({tableName:'center'})">
				<i class="iconfont icon-user"></i>
				<span>个人中心</span>
			</div>
			<div class="menu-item" :class="{'is-active': tabIndex==='updatePassword'}" @click="tabClick({tableName:'updatePassword'})">
				<i class="iconfont icon-password"></i>
				<span>修改密码</span>
			</div>
			<div class="menu-item" :class="{'is-active': tabIndex==='chat'}" @click="tabClick({tableName:'chat'})">
				<i class="iconfont icon-chat"></i>
				<span>聊天记录</span>
			</div>
			<div class="menu-item" v-if="btnAuth('storeup','查看')" @click="tabClick({tableName:'storeup',type:1})">
				<i class="iconfont icon-star"></i>
				<span>我的收藏</span>
			</div>
			<template v-for="(item,index) in menuList">
				<div v-if="hasBack(item.child[0])" class="menu-item" @click="tabClick(item.child[0])">
					<i class="iconfont" :class="item.child[0].icon"></i>
					<span>{{item.child[0].menu}}</span>
				</div>
			</template>
		</div>

		<div class="right-content">
			<div class="content-box glass-card" v-if="tabIndex==='center'">
				<div class="card-title">个人资料</div>
				<el-form class="usersForm" ref="userFormRef" :model="userForm" label-width="120px" :rules="rules">
					<el-row>
						<el-col :span="12">
							<el-form-item prop="yonghuzhanghao" label="用户账号">
								<el-input class="list_inp" v-model="userForm.yonghuzhanghao" placeholder="用户账号" readonly></el-input>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item prop="nicheng" label="昵称">
								<el-input class="list_inp" v-model="userForm.nicheng" placeholder="昵称" ></el-input>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item label="性别" prop="xingbie">
								<el-radio-group class="list_radio" v-model="userForm.xingbie">
									<el-radio v-for="item in xingbieLists" :label="item"
										size="large">{{item}}</el-radio>
								</el-radio-group>
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
							<el-form-item prop="shouji" label="手机">
								<el-input class="list_inp" v-model="userForm.shouji" placeholder="手机" ></el-input>
							</el-form-item>
						</el-col>
						<el-col :span="12">
							<el-form-item prop="shenfenzheng" label="身份证">
								<el-input class="list_inp" v-model="userForm.shenfenzheng" placeholder="身份证" ></el-input>
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
							<el-form-item prop="money" label="余额">
								<div class="vip_item">
									<el-input class="vip_inp" v-model="userForm.money" placeholder="余额" readonly></el-input>
									<el-button class="vip_btn btn-gradient" @click="rechargeClick">点我充值</el-button>
								</div>
							</el-form-item>
						</el-col>
					</el-row>
					<div class="formModel_btn_box">
						<el-button class="formModel_confirm btn-gradient" @click="updateSession">更新信息</el-button>
						<el-button class="formModel_cancel btn-plain" @click="loginout" type="danger">退出登录</el-button>
					</div>
				</el-form>
			</div>
			<div class="content-box glass-card" v-if="tabIndex==='updatePassword'">
				<div class="card-title">修改密码</div>
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
						<el-button class="formModel_confirm btn-gradient" @click="updatePassword">修改密码</el-button>
					</div>
				</el-form>
			</div>
			<div class="content-box glass-card" v-if="tabIndex==='chat'">
				<div class="card-title">聊天记录</div>
				<div class="z-box" :style='{"width":"100%","padding":"0","margin":"0"}'>
					<div class="section-content" v-for="item in recordList" :key="item.id" @click="chatClick(item)"
                         style="justify-content: space-between;">
                        <div style="display: flex;align-items: center;">
                            <img :src="item.picture?$config.url + item.picture:require('@/assets/avatar.png')" style="width: 60px;height:60px;border-radius: 50%;object-fit: cover;"
                                 alt="">
                            <div style="margin: 0 0 0 10px;display: flex;flex-direction: column;align-items: flex-start;">
                                <div :style='{"fontSize":"14px","color":"#fff","flex":"1","fontWeight":"bold"}'
                                     class="item-style">{{item.name}}</div>
                                <div :style='{"color":"rgba(255,255,255,0.7)","flex":"1","fontSize":"14px","lineHeight":"1.5","display":"flex","alignItems":"center"}'
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
			<div class="content-box glass-card" v-if="tabIndex==='myCoupon'">
			  <div class="card-title">我的优惠券</div>
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
		<el-dialog v-model="rechargeVisible" :title="'用户充值'" width="50%" destroy-on-close class="rechargeDialog">
			<div class="centerPayInpView">
				<el-input class="pay_inp" v-model.number="rechargeForm.money" placeholder="充值金额" :min="1"></el-input>
			</div>
			<div class="centerPayList">
				<div class="centerPayView">
					<el-radio v-model="payType" label="1"><img src="@/assets/pay/weixin.png" alt>微信支付</el-radio>
				</div>
				<div class="centerPayView">
					<el-radio v-model="payType" label="2"><img src="@/assets/pay/zhifubao.png" alt>支付宝支付</el-radio>
				</div>
				<div class="centerPayView">
					<el-radio v-model="payType" label="3"><img src="@/assets/pay/yinhangka.png" alt>银行卡支付<el-icon :class="payType==3?'active':''"><ArrowDown /></el-icon></el-radio>
				</div>
				<el-collapse-transition>
					<div class="yinhang_view" v-show="payType==3">
						<div class="centerPayView">
							<el-radio v-model="payType1" label="1"><img src="@/assets/pay/zhonghang.png" alt>中国银行</el-radio>
						</div>
						<div class="centerPayView">
							<el-radio v-model="payType1" label="2"><img src="@/assets/pay/nongye.png" alt>中国农业银行</el-radio>
						</div>
						<div class="centerPayView">
							<el-radio v-model="payType1" label="3"><img src="@/assets/pay/jianshe.png" alt>中国建设银行</el-radio>
						</div>
						<div class="centerPayView">
							<el-radio v-model="payType1" label="4"><img src="@/assets/pay/gonghang.png" alt>中国工商银行</el-radio>
						</div>
						<div class="centerPayView">
							<el-radio v-model="payType1" label="5"><img src="@/assets/pay/jiaotong.png" alt>交通银行</el-radio>
						</div>
					</div>
				</el-collapse-transition>
				<div class="centerPayView">
					<el-radio v-model="payType" label="4"><img src="@/assets/pay/yunshanfu.png" alt>云闪付</el-radio>
				</div>
			</div>
			<template #footer>
				<span class="dialog-footer">
					<el-button @click="rechargeVisible=false">取消</el-button>
					<el-button type="primary" @click="rechargeSave">
						充值
					</el-button>
				</span>
			</template>
		</el-dialog>
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
	const tableName = 'yonghu'
	const formName = '个人中心'
	//基础信息
	const uploadUrl = context.$config.url + 'file/upload'
	//个人信息
	const userFormRef = ref(null)
	const userForm = ref({})
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
		yonghuzhanghao: [
			{required: true,message: '请输入',trigger: 'blur'},
		],
		mima: [
			{required: true,message: '请输入',trigger: 'blur'},
		],
		nicheng: [
			{required: true,message: '请输入',trigger: 'blur'},
		],
		xingbie: [
			{required: true,message: '请输入',trigger: 'blur'},
		],
		touxiang: [
			{required: true,message: '请输入',trigger: 'blur'},
		],
		youxiang: [
			{required: true,message: '请输入',trigger: 'blur'},
			{ validator: context.$toolUtil.validator.email, trigger: 'blur' },
		],
		shouji: [
			{required: true,message: '请输入',trigger: 'blur'},
			{ validator: context.$toolUtil.validator.mobile, trigger: 'blur' },
		],
		shenfenzheng: [
			{required: true,message: '请输入',trigger: 'blur'},
			{ validator: context.$toolUtil.validator.idCard, trigger: 'blur' },
		],
		zhuceshijian: [
		],
		money: [
			{ validator: context.$toolUtil.validator.number, trigger: 'blur' },
		],
	})
	const getSession = () =>{
		context?.$http({
			url: `${context?.$toolUtil.storageGet('frontSessionTable')}/session`,
			method:'get'
		}).then(res=>{
			context?.$toolUtil.storageSet('userid',res.data.data.id)
			context?.$toolUtil.storageSet("frontName", res.data.data.yonghuzhanghao)
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
				if(passwordForm.value.mima != userForm.value.mima){
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
				userForm.value.mima = passwordForm.value.newmima
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
	//性别列表
	const xingbieLists = ref([])
	//头像上传回调
	const touxiangUploadSuccess=(e)=>{
		userForm.value.touxiang = e
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
		xingbieLists.value = "男,女".split(',')
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
	//付款方式
	const payType = ref('')
	const payType1 = ref('')
	//充值
	const rechargeVisible = ref(false)
	const rechargeForm = ref({
		money:''
	})
	const rechargeClick = () => {
		payType.value = ''
		payType1.value = ''
		rechargeForm.value = {
			money:''
		}
		rechargeVisible.value = true
	}
	//充值保存
	const rechargeSave = () => {
		if(rechargeForm.value.money==''){
			context?.$toolUtil.message('请输入充值金额','error')
			return false
		}
		if(rechargeForm.value.money<=0){
			context?.$toolUtil.message('请输入正确充值金额','error')
			return false
		}
		if(typeof rechargeForm.value.money !== 'number'){
			context?.$toolUtil.message('请输入正确充值金额','error')
			return false
		}
		if(payType.value==''){
			context?.$toolUtil.message('请选择充值方式','error')
			return false
		}
		if(payType.value==3&&payType1.value==''){
			context?.$toolUtil.message('请选择充值银行','error')
			return false
		}
		let params = JSON.parse(JSON.stringify(userForm.value))
		params.money = parseFloat(params.money) + parseFloat(rechargeForm.value.money)
		store.dispatch('user/update',params).then(res=>{
			if(res?.data&&res.data.code==0){
                context.$http.post('rechargerecord/save',{
                    username:localStorage.getItem('frontName'),
                    role:localStorage.getItem('frontRole'),
                    amount:rechargeForm.value.money,
                    userid:store.state.user.session.id,
                })
                let loading = context.$loading("")
                setTimeout(()=>{
                    loading.close()
                    context?.$toolUtil.message('充值成功','success')
                    rechargeVisible.value = false
                },1000)
				getSession()
			}
		})
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

.center-container {
    min-height: 100vh;
    background: #0d0d1a;
    display: flex;
    gap: 24px;
    padding: 32px;
    box-sizing: border-box;
    position: relative;

    &::before {
        content: '';
        position: fixed;
        top: -200px;
        left: -200px;
        width: 600px;
        height: 600px;
        border-radius: 50%;
        background: radial-gradient(circle, rgba(255,107,157,0.08), transparent 70%);
        pointer-events: none;
        z-index: 0;
    }

    &::after {
        content: '';
        position: fixed;
        bottom: -150px;
        right: -150px;
        width: 500px;
        height: 500px;
        border-radius: 50%;
        background: radial-gradient(circle, rgba(0,212,255,0.07), transparent 70%);
        pointer-events: none;
        z-index: 0;
    }

    .left-menu {
        width: 200px;
        min-width: 200px;
        background: rgba(255, 255, 255, 0.04);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 107, 157, 0.15);
        border-radius: 20px;
        padding: 24px 16px;
        height: fit-content;
        position: sticky;
        top: 32px;
        z-index: 1;

        .menu-item:nth-of-type(3) {
            border-bottom: 1px solid rgba(255,255,255,0.06);
            margin-bottom: 8px;
            padding-bottom: 12px;
        }

        .menu-item {
            display: block;
            width: 100%;
            padding: 11px 20px;
            border-radius: 10px;
            color: rgba(255, 255, 255, 0.6);
            font-size: 14px;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-bottom: 4px;
            background: transparent;
            border: none;
            text-align: left;
            box-sizing: border-box;

            .iconfont {
                margin-right: 10px;
                font-size: 16px;
                width: 1.2em;
            }

            &:hover:not(.is-active) {
                color: white;
                background: rgba(255, 107, 157, 0.1);
                padding-left: 26px;
            }

            &.is-active {
                color: #ff6b9d;
                background: rgba(255, 107, 157, 0.12);
                border-left: 3px solid #ff6b9d;
                padding-left: 17px;
                font-weight: 600;
            }

            &:first-of-type.is-active {
                display: block;
                width: 100%;
                padding: 12px 20px;
                border-radius: 12px;
                background: linear-gradient(135deg, #ff6b9d, #00d4ff);
                color: white;
                font-weight: 700;
                font-size: 15px;
                text-align: center;
                margin-bottom: 8px;
                border: none;
                box-shadow: 0 8px 20px rgba(255, 107, 157, 0.3);

                .iconfont {
                    margin-right: 0;
                }
            }
        }
    }

    .right-content {
        flex: 1;
        background: rgba(255, 255, 255, 0.04);
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border: 1px solid rgba(255, 107, 157, 0.15);
        border-radius: 20px;
        padding: 36px 40px;
        position: relative;
        overflow-y: auto;
        z-index: 1;

        &::-webkit-scrollbar {
            width: 4px;
        }
        &::-webkit-scrollbar-thumb {
            background: rgba(255, 107, 157, 0.3);
            border-radius: 2px;
        }

        &::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 2px;
            background: linear-gradient(90deg, #ff6b9d, #00d4ff);
            z-index: 2;
        }

        &::after {
            content: '';
            position: absolute;
            top: -80px;
            right: -80px;
            width: 250px;
            height: 250px;
            border-radius: 50%;
            background: radial-gradient(circle, rgba(0, 212, 255, 0.08), transparent 70%);
            pointer-events: none;
            z-index: 2;
        }

        .content-box {
            background: transparent;
            padding: 0;
            border-radius: 0;
            border: none;
            backdrop-filter: none;
            margin-bottom: 0;

            .card-title {
                font-size: 22px;
                font-weight: bold;
                margin-bottom: 30px;
                padding-bottom: 15px;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
                color: rgba(255, 255, 255, 0.9);
            }

            .usersForm {
                .el-form-item {
                    margin-bottom: 25px;
                    
                    :deep(.el-form-item__label) {
                        color: rgba(255, 255, 255, 0.55);
                        font-size: 13px;
                        font-weight: 500;
                    }
                    
                    &.is-required :deep(.el-form-item__label)::before {
                        color: #ff6b9d !important;
                    }
                }

                :deep(.el-input__wrapper) {
                    background: rgba(255, 255, 255, 0.06) !important;
                    border: 1px solid rgba(255, 255, 255, 0.1) !important;
                    border-radius: 10px !important;
                    height: 44px !important;
                    transition: all 0.3s ease !important;
                    box-shadow: none !important;

                    &:focus-within {
                        border-color: #ff6b9d !important;
                        background: rgba(255, 107, 157, 0.06) !important;
                        box-shadow: 0 0 0 3px rgba(255, 107, 157, 0.12) !important;
                    }
                }

                :deep(.el-input__inner) {
                    color: white !important;
                    &::placeholder {
                        color: rgba(255, 255, 255, 0.2) !important;
                    }
                }

                :deep(.el-input.is-disabled .el-input__wrapper) {
                    background: rgba(255, 255, 255, 0.03) !important;
                    border-color: rgba(255, 255, 255, 0.06) !important;
                    cursor: default !important;
                }
                
                :deep(.el-input.is-disabled .el-input__inner) {
                    color: rgba(255, 255, 255, 0.35) !important;
                    cursor: default !important;
                }

                .list_radio {
                    :deep(.el-radio__label) {
                        color: rgba(255, 255, 255, 0.75) !important;
                    }
                    :deep(.el-radio__inner) {
                        background: rgba(255,255,255,0.08) !important;
                        border-color: rgba(255,255,255,0.2) !important;
                    }
                    :deep(.el-radio__input.is-checked .el-radio__inner) {
                        background: #ff6b9d !important;
                        border-color: #ff6b9d !important;
                    }
                    :deep(.el-radio__input.is-checked + .el-radio__label) {
                        color: #ff6b9d !important;
                    }
                }

                :deep(.el-upload-list--picture-card .el-upload-list__item) {
                    width: 100px !important;
                    height: 100px !important;
                    border-radius: 16px !important;
                    border: 2px solid rgba(255, 107, 157, 0.4) !important;
                    box-shadow: 0 0 20px rgba(255, 107, 157, 0.2) !important;
                    transition: all 0.3s ease !important;
                    background: transparent !important;
                    margin: 0 8px 8px 0 !important;

                    img {
                        object-fit: cover;
                        border-radius: 12px;
                    }

                    &:hover {
                        border-color: #ff6b9d !important;
                        box-shadow: 0 0 28px rgba(255, 107, 157, 0.4) !important;
                        transform: scale(1.04);
                    }
                }

                :deep(.el-upload--picture-card) {
                    width: 100px !important;
                    height: 100px !important;
                    border-radius: 16px !important;
                    border: 2px dashed rgba(255, 107, 157, 0.35) !important;
                    background: rgba(255, 107, 157, 0.05) !important;
                    transition: all 0.3s ease !important;
                    
                    .el-icon {
                        font-size: 28px !important;
                        color: rgba(255, 107, 157, 0.5) !important;
                        transition: all 0.3s ease !important;
                    }

                    &:hover {
                        border-color: #ff6b9d !important;
                        background: rgba(255, 107, 157, 0.1) !important;
                        box-shadow: 0 0 16px rgba(255, 107, 157, 0.2) !important;

                        .el-icon {
                            color: #ff6b9d !important;
                        }
                    }
                }

                :deep(.el-upload__tip) {
                    color: rgba(255, 255, 255, 0.3) !important;
                    font-size: 12px !important;
                    margin-top: 8px !important;
                    line-height: 1.5;
                }

                .list_inp,
                .list_date {
                    width: 100%;
                }

                .vip_item {
                    display: flex;
                    align-items: center;
                    gap: 10px;

                    .vip_inp {
                        flex: 1;
                    }

                    .vip_btn {
                        height: 40px;
                        padding: 0 24px;
                        border-radius: 10px;
                        background: rgba(0, 212, 255, 0.15) !important;
                        border: 1px solid rgba(0, 212, 255, 0.4) !important;
                        color: #00d4ff !important;
                        font-weight: 600 !important;
                        transition: all 0.3s ease !important;

                        &:hover {
                            background: rgba(0, 212, 255, 0.25) !important;
                            box-shadow: 0 0 16px rgba(0, 212, 255, 0.35) !important;
                        }
                    }
                }

                .formModel_btn_box {
                    display: flex;
                    justify-content: flex-end;
                    gap: 15px;
                    margin-top: 30px;

                    .formModel_confirm {
                        height: 44px;
                        padding: 0 32px;
                        border-radius: 10px;
                        background: linear-gradient(135deg, #ff6b9d, #00d4ff) !important;
                        border: none !important;
                        color: white !important;
                        font-weight: 600 !important;
                        font-size: 14px !important;
                        transition: all 0.3s ease !important;

                        &:hover {
                            box-shadow: 0 8px 20px rgba(255, 107, 157, 0.4) !important;
                            transform: translateY(-2px) !important;
                        }
                    }

                    .formModel_cancel {
                        height: 44px;
                        padding: 0 32px;
                        border-radius: 10px;
                        background: rgba(255, 255, 255, 0.05) !important;
                        border: 1px solid rgba(255, 255, 255, 0.12) !important;
                        color: rgba(255, 255, 255, 0.55) !important;
                        font-size: 14px !important;
                        transition: all 0.3s ease !important;

                        &:hover {
                            border-color: rgba(255, 107, 157, 0.4) !important;
                            color: #ff6b9d !important;
                            background: rgba(255, 107, 157, 0.08) !important;
                        }
                    }
                }
            }

            .coupon-list {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
                gap: 20px;

                .item {
                    background: linear-gradient(135deg, #1a1a2e, #16213e);
                    border-radius: 10px;
                    padding: 20px;
                    border: 1px solid rgba(255, 107, 157, 0.2);
                    box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                    transition: all 0.3s;

                    &:hover {
                        transform: translateY(-5px);
                        box-shadow: 0 6px 20px rgba(0, 212, 255, 0.3);
                        border-color: rgba(0, 212, 255, 0.5);
                    }

                    &.disabled {
                        filter: grayscale(1);
                        opacity: 0.5;
                    }
                }
            }
        }
    }
}

.glass-card {
    background: rgba(255, 255, 255, 0.7);
    backdrop-filter: blur(15px);
    border: 1px solid rgba(255, 255, 255, 0.2);
}

.btn-gradient {
    background: linear-gradient(135deg, var(--theme-color, #409eff), var(--theme-color-dark, #66b1ff));
    border: none;
    color: #fff;
    transition: all 0.3s;

    &:hover {
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
    }
}

.btn-plain {
    background: transparent;
    border: 1px solid var(--theme-color, #409eff);
    color: var(--theme-color, #409eff);

    &:hover {
        background: var(--theme-color, #409eff);
        color: #fff;
    }
}

.noList {
    text-align: center;
    color: #999;
    padding: 40px 0;
}

:deep(.el-dialog.rechargeDialog) {
    border-radius: 15px;

    .el-dialog__header {
        padding-bottom: 15px;
        border-bottom: 1px solid #eee;
    }

    .el-dialog__body {
        padding: 30px;
    }
}

:deep(.el-dialog.chat-dialog) {
    .chat-content {
        height: 400px;
    }
}
</style>
