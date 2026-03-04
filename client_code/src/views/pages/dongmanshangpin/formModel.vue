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
			<div class="swiper_view">
				<mySwiper :data="bannerList" :type="3"
					:loop="true"
					:navigation="true"
					:pagination="true"
					:paginationType="4"
					:scrollbar="false"
					:slidesPerView="1"
					:spaceBetween="20"
					:autoHeight="true"
					:centeredSlides="true"
					:freeMode="false"
					:effectType="5"
					direction="horizontal"
					:autoplay="true"
					:slidesPerColumn="1">
					<template #default="scope">
						<img :src="scope.row?(scope.row.startsWith('http')?'':baseUrl) + scope.row:''">
					</template>
				</mySwiper>
			</div>
			<div class="thumbs_view">
				<template v-if="!thumbsupOrCrazilyInfo.type">
					<div class="zan_view" @click="thumbsupOrCrazilyClick(21)">
						<i class="iconfont icon-thumb-up-line1"></i>
						<span>赞({{detail.thumbsupNumber}})</span>
					</div>
					<div class="zan_view can_view" @click="thumbsupOrCrazilyClick(22)">
						<i class="iconfont icon-thumb-down-line1"></i>
						<span>踩({{detail.crazilyNumber}})</span>
					</div>
				</template>
				<template v-else>
					<div class="zan_view zanActive" v-if="thumbsupOrCrazilyInfo.type==21" @click="cancelThumbsupOrCrazilyClick(21)">
						<i class="iconfont iconfontActive icon-thumb-up-fill1"></i>
						<span class="textActive">取消赞({{detail.thumbsupNumber}})</span>
					</div>
					<div class="zan_view can_view zanActive" v-else @click="cancelThumbsupOrCrazilyClick(22)">
						<i class="iconfont iconfontActive icon-thumb-down-fill1"></i>
						<span class="textActive">取消踩({{detail.crazilyNumber}})</span>
					</div>
				</template>
			</div>
			<div class="info_view">
				<div class="title_view">
					<div class="detail_title">
						<span>{{detail.dongmanpinpai}}</span>
					</div>
					<div class="collect_view" v-if="!collectType" @click="collectClick(1)">
						<i class="iconfont icon-likeline1"></i>
						<span>收藏</span>
					</div>
					<div class="collect_view" v-if="collectType" @click="collectClick(-1)">
						<i class="iconfont iconfontActive icon-likeline1"></i>
						<span class="textActive">取消收藏</span>
					</div>
				</div>
				<div class="coupon-view">
					<el-button type="warning" size="small" @click="couponClick">优惠券</el-button>
				</div>
				<div class="info_item">
					<div class="info_label">价格</div>
					<div class="info_price"><span>￥</span>{{detail.price}}</div>
				</div>
				<div class="info_item" v-if="detail.jf">
					<div class="info_label">积分</div>
					<div class="info_price">{{detail.jf}}</div>
				</div>
                <div class="info_item">
                    <div class="info_label">单次购买</div>
                    <div class="info_text">{{detail.onelimittimes}}</div>
                </div>
				<div class="info_item">
					<div class="info_label">库存</div>
					<div class="info_text">{{detail.alllimittimes}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">商品名称</div>

					<div  class="info_text" >{{detail.shangpinmingcheng}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">商品类型</div>

					<div  class="info_text" >{{detail.shangpinleixing}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">动漫品牌</div>

					<div  class="info_text" >{{detail.dongmanpinpai}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">动漫IP</div>

					<div  class="info_text" >{{detail.dongmanip}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">规格</div>

					<div  class="info_text" >{{detail.guige}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">动漫材质</div>

					<div  class="info_text" >{{detail.dongmancaizhi}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">评分</div>

					<div  class="info_text" >{{detail.score}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">收藏数</div>

					<div  class="info_text" >{{detail.storeupNumber}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">评论数</div>

					<div  class="info_text" >{{detail.discussNumber}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">商家账号</div>
                    <div class="info_link" @click="merchantClick()" style="cursor: pointer">{{detail.shangjiazhanghao}}</div>
				</div>
				<div class="info_item">
					<div class="info_label">商家名称</div>

					<div  class="info_text" >{{detail.shangjiamingcheng}}</div>
				</div>
				<div class="info_item" v-if="centerType">
					<div class="info_label">是否审核</div>
					<div class="info_text">{{detail.sfsh}}</div>
				</div>
				<div class="info_item" v-if="centerType">
					<div class="info_label">回复内容</div>
					<div class="info_text">{{detail.shhf}}</div>
				</div>
				<div class="btn_view">
					<el-input-number class="inputNumber" v-model="buyNumber" :min="1" v-if="detail.alllimittimes"></el-input-number>
                    <div class="break"></div>
					<el-button class="addCart_btn" v-if="detail.alllimittimes" type="primary" @click="addCart">加入购物车</el-button>
					<el-button class="buyNow_btn" v-if="detail.alllimittimes" type="primary" @click="buyNow">立即购买</el-button>
				</div>
				<div class="btn_view">
					<el-button class="edit_btn" type="primary" v-if="btnAuth('dongmanshangpin','私信')" @click="chatClick">联系TA</el-button>
					<el-button class="approval_btn" v-if="btnAuth('dongmanshangpin','审核')&&detail.sfsh=='待审核'" type="warning" @click="approvalClick()">审核</el-button>
                    <el-button :class="detail.isShelves==1?'del_btn':'edit_btn'" v-if="centerType" @click="isShelvesClick" type="primary">{{detail.isShelves==1?'下架':'上架'}}</el-button>
					<el-button class="edit_btn" v-if="centerType&&btnAuth('dongmanshangpin','修改')" type="primary" @click="editClick">修改</el-button>
					<el-button class="del_btn" v-if="centerType&&btnAuth('dongmanshangpin','删除')" type="danger" @click="delClick">删除</el-button>
				</div>
			</div>
		</div>
		<el-tabs type="border-card" v-model="activeName" class="tabs_view">
			<el-tab-pane label="商品详情" name="first">
				<div v-html="detail.shangpinxiangqing"></div>
			</el-tab-pane>
			<el-tab-pane label="评论" name="commentActive">
				<div class="my_comment_view">
					<el-form ref="commentFormRef" :model="commentForm" class="my_comment_form"
						:rules="commentRules">
						<el-form-item prop="content">
                            <editor :value="commentForm.content" placeholder="善语结善缘,恶语伤人心"
                                    class="list_editor" @change="contentChange"></editor>
						</el-form-item>
                        <el-form-item label="评分" class="rate">
                            <el-rate v-model="commentForm.score"  prop="score"/>
                        </el-form-item>
					</el-form>
					<div class="comment_btn">
						<el-button class="add_btn" type="primary" @click="commentSave">立即评论</el-button>
						<el-button class="reset_btn" @click="resetForm">重置</el-button>
					</div>
				</div>
				<div class="comment_list">
					<div class="comment" v-for="(item,index) in commentList" :key="index">
						<div class="comment_top">
							<div class="comment_user">
								<div class="comment_user_img">
                                    <img v-if="item.avatarurl" :src="baseUrl + item.avatarurl" alt="">
                                    <img v-else src="@/assets/avatar.png" alt="">
								</div>
								<div class="comment_user_info">
									{{item.nickname}}
								</div>
							</div>
							<div class="comment_time">{{item.addtime}}</div>
                            <div class="istop" v-if="item.istop">
                                <span class="iconfont icon-flight-takeoff-fill"></span>置顶
                            </div>
                            <div class="zancai-box">
                                <div class="zan-item active" v-if="commentHasZan(item,1)" @click="commentZanCaiClick(item,1)" style="cursor: pointer;">
                                    <span class="iconfont icon-thumb-up-fill2"></span>
                                    <span class="label">赞</span>
                                    <span class="num">({{item.thumbsupnum}})</span>
                                </div>
                                <div class="zan-item" v-else @click="commentZanCaiClick(item,1)" style="cursor: pointer;">
                                    <span class="iconfont icon-thumb-up-line2"></span>
                                    <span class="label">赞</span>
                                    <span class="num">({{item.thumbsupnum}})</span>
                                </div>
                                <div class="cai-item active" v-if="commentHasCai(item,1)" @click="commentZanCaiClick(item,-1)" style="cursor: pointer;">
                                    <span class="iconfont icon-thumb-down-fill2"></span>
                                    <span class="label">踩</span>
                                    <span class="num">({{item.crazilynum}})</span>
                                </div>
                                <div class="cai-item" v-else @click="commentZanCaiClick(item,-1)" style="cursor: pointer;">
                                    <span class="iconfont icon-thumb-down-line2"></span>
                                    <span class="label">踩</span>
                                    <span class="num">({{item.crazilynum}})</span>
                                </div>
                            </div>
						</div>
						<div class="comment_bottom">
                            <div class="comment_content" v-html="item.content"></div>
                            <div class="comment_score" v-if="item.score">
                                <el-rate v-model="item.score" disabled />
                            </div>
							<div class="comment_reply" v-if="item.reply">
								回复：<span v-html="item.reply"></span>
							</div>
						</div>
					</div>
				</div>
				<el-pagination
					background
					:layout="layouts.join(',')"
					:total="commentTotal"
					:page-size="commentQuery.limit"
					prev-text="上一页"
					next-text="下一页"
					:hide-on-single-page="false"
					@size-change="commentSizeChange"
					@current-change="commentCurrentChange" />
			</el-tab-pane>
		</el-tabs>
        <div class="share_view">
            <span>分享到：</span>
            <div class="share" @click="shareToMicroblog">
                <img src="@/assets/weibo.png" alt="">
            </div>
            <div class="share" @click="shareToQQRom">
                <img src="@/assets/qq.png" alt="">
            </div>
        </div>
		<Approval ref="approvalRef" @approvalSave="approvalSave" :tableName="tableName"></Approval>
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
                        <el-button class="change_btn" @click="sendGoods">详情图发送</el-button>
                        <el-button class="send" type="primary" @click="addChat">发送</el-button>
                    </div>
                </div>
            </div>
		</el-dialog>
		<el-dialog class="detail-coupon-dialog" title="优惠券" v-model="couponVisible" width="85%">
			<div class="coupon-list">
				<div class="item" v-for="(item,index) in couponList" :key="index">
					<div class="box1">
						<div class="coupon-name">{{item.couponName}}</div>
						<div class="coupon-condition">满{{item.fullAmount}}减{{item.discountAmount}}</div>
						<div class="coupon-term">{{item.effectTime}}-{{item.expireTime}}</div>
						<div class="coupon-remark">{{item.remark}}</div>
						<div class="coupon-limit" v-if="item.shangjiazhanghao">仅限 {{item.shangjiazhanghao}} 商品可使用</div>
						<div class="coupon-limit" v-else>全品类商品可使用</div>
					</div>
					<div class="box2">
						<div class="price">￥<span class="num">{{item.discountAmount}}</span></div>
						<div class="btn" @click="getCoupon(item)">立即领取</div>
					</div>
				</div>
				<div class="noList" v-if="!couponList.length">
					暂无优惠券
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
	const tableName = 'dongmanshangpin'
	const formName = '动漫商品'
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
    const activeName = ref('first')
	const getDetail = () => {
		context?.$http({
			url: `${tableName}/detail/${route.query.id}`,
			method: 'get'
		}).then(res => {
            bannerList.value = res.data.data.shangpintupian?res.data.data.shangpintupian.split(','):[]
            title.value = res.data.data.dongmanpinpai
			if(res.data.data.touxiang){
				nowfpic.value = res.data.data.touxiang.split(',')[0]
			}else if(res.data.data.headportrait){
				nowfpic.value = res.data.data.headportrait.split(',')[0]
			}
			detail.value = res.data.data
			getInCartList();
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
		// 赞踩状态
		getThumbsupOrCrazily()
		// 收藏
		getCollect()
		// 评论
		getCommentList()
	}
	// 赞or踩
	const thumbsupOrCrazilyInfo = ref({})
	// 获取赞踩状态
	const getThumbsupOrCrazily = () => {
		if (context?.$toolUtil.storageGet('frontToken')) {
			context?.$http({
				url: 'storeup/page',
				method: 'get',
				params: {
					page: 1,
					refid: route.query.id,
					tablename: tableName,
					userid: context?.$toolUtil.storageGet('userid')
				}
			}).then(res => {
				let list = res.data.data.list.filter(item=>(item.type==21||item.type==22))
				if(!list.length){
					thumbsupOrCrazilyInfo.value = {}
				}else{
					thumbsupOrCrazilyInfo.value = list[0]
				}
			})
		}
	}
	// 赞踩按钮
	const thumbsupOrCrazilyClick = (type) => {
		let params = {
			name: title.value,
			picture: bannerList.value[0],
			refid: detail.value.id,
			type: type,
			tablename: tableName,
			userid: context?.$toolUtil.storageGet('userid')
		}
		context?.$http({
			url: 'storeup/add',
			method: 'post',
			data: params
		}).then(res => {
			if (type == 21) detail.value.thumbsupNumber += 1
			if (type == 22) detail.value.crazilyNumber += 1
			context?.$http({
				url: `${tableName}/update`,
				method: 'post',
				data: detail.value
			})
			getThumbsupOrCrazily()
			context?.$toolUtil.message('操作成功', 'success')
		})
	}
	//取消赞踩按钮
	const cancelThumbsupOrCrazilyClick = (type) => {
		let ids = []
		ids.push(thumbsupOrCrazilyInfo.value.id)
		context?.$http({
			url: 'storeup/delete',
			method: 'post',
			data: ids
		}).then(res => {
			if (type == 21 && detail.value.thumbsupNumber>0) detail.value.thumbsupNumber -= 1
			if (type == 22 && detail.value.crazilyNumber>0) detail.value.crazilyNumber -= 1
			context?.$http({
				url: `${tableName}/update`,
				method: 'post',
				data: detail.value
			})
			getThumbsupOrCrazily()
			context?.$toolUtil.message('取消成功', 'success')
		})
	}
	// 收藏
	const collectType = ref(false)
	const collectInfo = ref({})
	const getCollect = () => {
		if (context?.$toolUtil.storageGet('frontToken')) {
			context?.$http({
				url: 'storeup/list',
				method: 'get',
				params: {
					page: 1,
					limit: 1,
					type: 1,
					refid: route.query.id,
					tablename: tableName,
					userid: context?.$toolUtil.storageGet('userid')
				}
			}).then(res => {
				if (res.data.data.list.length) {
					collectType.value = true
					collectInfo.value = res.data.data.list[0]
				}else{
					collectType.value = false
					collectInfo.value = {}
				}
			})
		}
	}
	// 收藏按钮
	const collectClick = (type) => {
		if (type == 1 && !collectType.value) {
			let params = {
				name: title.value,
				picture: bannerList.value[0],
				refid: detail.value.id,
				type: type,
				tablename: tableName,
				userid: context?.$toolUtil.storageGet('userid')
			}
			context?.$http({
				url: 'storeup/add',
				method: 'post',
				data: params
			}).then(res => {
				detail.value.storeupNumber += 1
				context?.$http({
					url: `${tableName}/update`,
					method: 'post',
					data: detail.value
				})
				collectType.value = true
				getCollect()
				context?.$toolUtil.message('收藏成功', 'success')
			})
		}
		else if (type == -1 && collectType.value) {
			let ids = []
			ids.push(collectInfo.value.id)
			context?.$http({
				url: 'storeup/delete',
				method: 'post',
				data: ids
			}).then(res => {
				detail.value.storeupNumber -= 1
				context?.$http({
					url: `${tableName}/update`,
					method: 'post',
					data: detail.value
				})
				collectInfo.value = {}
				collectType.value = false
				context?.$toolUtil.message('取消成功', 'success')
			})
		}
	}
    const contentChange = (e)=>{
        commentForm.value.content = e
    }
	//评论
	const commentForm = ref({
		content: '',
		refid: route.query.id,
		userid: context?.$toolUtil.storageGet('userid'),
		nickname: context?.$toolUtil.storageGet('frontName'),
		avatarurl: context?.$toolUtil.storageGet('headportrait') ? context?.$toolUtil.storageGet('headportrait') : '',
        score:0
	})
	const commentRules = ref({
		content: [{
			required: true,
			message: '请输入',
			trigger: 'blur'
		}, ]
	})
	const commentQuery = ref({
		page: 1,
		limit: 10,
		refid: route.query.id,
        sort: 'istop',
        order: 'desc',
	})
	const layouts = ref(["total","prev","pager","next","sizes"])
	const commentList = ref([])
	const commentTotal = ref(0)
	const commentFormRef = ref(null)
	const commentSizeChange = (size) =>{
		commentQuery.value.limit = size
		getCommentList()
	}
	const commentCurrentChange = (page) =>{
		commentQuery.value.page = page
		getCommentList()
	}
	const getCommentList = () => {
		context?.$http({
			url: `discuss${tableName}/list`,
			params: commentQuery.value,
			method: 'get'
		}).then(res => {
			commentList.value = res.data.data.list
			commentTotal.value = res.data.data.total

		})
	}
	//提交评论
	const commentSave = async () => {
        let res = await context.$http(`discuss${tableName}/page?userid=${user.value.id}&refid=${detail.value.id}`)
        if(res.data.data.list.length){
            return context.$message.error("您已经点评过了")
        }
        if(!commentForm.value.content ||commentForm.value.content=='<p><br></p>'){
            return context.$message.error("请输入评论内容")
        }
        if(!commentForm.value.score){
            return context.$message.error("评分不能为空")
        }
		commentFormRef.value.validate((valid) => {
			if (valid) {
				context?.$http({url:'orders/list',method:'get',params:{page:1,limit:1,status:'已完成',goodid:detail.value.id,userid:context?.$toolUtil.storageGet('userid')}}).then(res=>{
					if(res.data.data.list.length==0){
						context?.$toolUtil.message('请完成订单后再评论！','error')
						return false
					}
					context?.$http({
						url: `discuss${tableName}/add`,
						method: 'post',
						data: commentForm.value
					}).then(res => {
                        context.$http.get(`${tableName}/info/${detail.value.id}`).then(res=>{
                            let detail = res.data.data
                            detail.score = Number(((detail.score*detail.discussNumber+commentForm.value.score)/(detail.discussNumber+1)).toFixed(1))
                            detail.discussNumber++
                            context.$http.post(`${tableName}/update`,detail).then(()=>{
                                getDetail()
                            })
                        })

						context?.$toolUtil.message('评论成功', 'success')
                        resetForm()
                        getCommentList()
					})
				})
			}
		})
	}
	const resetForm = () => {
		commentFormRef.value.resetFields()
	}
    const commentZanCaiClick = (item,type)=>{
        if(!user.value.id)return context.$message.error("请先登录")
        if(type==1){    //赞
            if(item.tuserids){
                let arr = item.tuserids.split(',')
                let index = arr.indexOf(`${user.value.id}`)
                if(index!=-1){
                    arr.splice(index,1)
                    item.thumbsupnum--
                }else{
                    arr.push(`${user.value.id}`)
                    item.thumbsupnum++
                }
                item.tuserids = arr.join(',')
            }else {
                item.tuserids = `${user.value.id}`
                item.thumbsupnum++
            }
            if(item.cuserids){
                let arr = item.cuserids.split(',')
                let index = arr.indexOf(`${user.value.id}`)
                if(index!=-1){  //点赞需要取消踩
                    arr.splice(index,1)
                    item.crazilynum--
                }
                item.cuserids = arr.join(',')
            }
        }else{  //踩
            if(item.cuserids){
                let arr = item.cuserids.split(',')
                let index = arr.indexOf(`${user.value.id}`)
                console.log(arr,user.value.id)
                if(index!=-1){
                    arr.splice(index,1)
                    item.crazilynum--
                }else{
                    arr.push(`${user.value.id}`)
                    item.crazilynum++
                }
                item.cuserids = arr.join(',')
            }else {
                item.cuserids = `${user.value.id}`
                item.crazilynum++
            }
            if(item.tuserids){
                let arr = item.tuserids.split(',')
                let index = arr.indexOf(`${user.value.id}`)
                if(index!=-1){  //点踩需要取消赞
                    arr.splice(index,1)
                    item.thumbsupnum--
                }
                item.tuserids = arr.join(',')
            }
        }
        context.$http.post(`discuss${tableName}/update`,item).then(res=>{
            getCommentList()
        })
    }
    const commentHasZan = (item,type)=>{
        if(!user.value.id)return false
        if(!item.tuserids)return false
        let arr = item.tuserids.split(',')
        return arr.includes(`${user.value.id}`)
    }
    const commentHasCai = (item,type)=>{
        if(!user.value.id)return false
        if(!item.cuserids)return false
        let arr = item.cuserids.split(',')
        return arr.includes(`${user.value.id}`)
    }
	//审核
	import Approval from '@/components/approval.vue'
	const approvalRef = ref(null)
	const approvalClick = (btnType='审核') => {
		if(!context?.$toolUtil.storageGet('frontToken')){
			context?.$toolUtil.message('请登录后再操作！','error')
			return false
		}
		if(!btnAuth('dongmanshangpin',btnType)){
			context?.$toolUtil.message('暂无权限操作！','error')
			return false
		}
		let row = detail.value
		nextTick(() => {
			approvalRef.value.approvalClick(row)
		})
	}
	//查找是否已添加购物车
	const isInCart = ref(false)
	const getInCartList = () => {
        if(!context?.$toolUtil.storageGet('frontToken'))return
		context?.$http({url:'cart/list',method:'get',params:{userid:context?.$toolUtil.storageGet('userid'),tablename:tableName,goodid: detail.value.id}}).then(res=>{
			if(res.data.data.list.length){
				isInCart.value = true
			}else{
				isInCart.value = false
			}
		})
	}
	const cartForm = ref({
		userid:context?.$toolUtil.storageGet('userid')
	})
	const addCart = () => {
		//单次购买限制
		if(detail.value.onelimittimes > 0 && detail.value.onelimittimes < buyNumber.value){
			context?.$toolUtil.message(`每人只能购买${detail.value.onelimittimes}件商品`,'error')
			return false
		}
		//库存不足
		if(detail.value.alllimittimes <= 0){
			context?.$toolUtil.message('商品售罄','error')
			return false
		}
		//库存限制
		if(detail.value.alllimittimes > 0 && detail.value.alllimittimes < buyNumber.value){
			context?.$toolUtil.message('库存不足','error')
			return false
		}
		if(isInCart.value){
			context?.$toolUtil.message('该商品已在购物车，请前往购买','error')
			return false
		}
		cartForm.value.buynumber = buyNumber.value
		cartForm.value.goodid = detail.value.id
		cartForm.value.goodname = title.value
		cartForm.value.tablename = tableName
		cartForm.value.picture = bannerList.value[0]
		cartForm.value.shangjiazhanghao = detail.value.shangjiazhanghao
        cartForm.value.price = detail.value.price
		context?.$http({
			url: 'cart/save',
			method: 'post',
			data:cartForm.value
		}).then(res=>{
			context?.$toolUtil.message('添加成功','success')
			getInCartList()
		})
	}
	const buyNumber = ref(1)
	//立即购买
	const buyNow = () => {
		//单次购买限制
		if(detail.value.onelimittimes > 0 && detail.value.onelimittimes < buyNumber.value){
			context?.$toolUtil.message(`每人只能购买${detail.value.onelimittimes}件商品`,'error')
			return false
		}
		//库存不足
		if(detail.value.alllimittimes <= 0){
			context?.$toolUtil.message('商品售罄','error')
			return false
		}
		//库存限制
		if(detail.value.alllimittimes > 0 && detail.value.alllimittimes < buyNumber.value){
			context?.$toolUtil.message('库存不足','error')
			return false
		}
		let data = {
			tablename: tableName,
			goodid: detail.value.id,
			goodname: title.value,
			buynumber: buyNumber.value,
			userid: context?.$toolUtil.storageGet('userid'),
			discountprice: detail.value.vipprice,
			shangjiazhanghao: detail.value.shangjiazhanghao,
			picture: bannerList.value[0],
			price: detail.value.price
		}
		context?.$toolUtil.storageSet('orders_good',JSON.stringify([data]))
		let query = {
			type: 1
		}
		router.push({path: '/index/order_confirm', query: query})
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
		if(detail.value.shangjiazhanghao == user.value.shangjiazhanghao){
			context.$toolUtil.message('不能给自己发信息','error')
			return false
		}
		context.$http.get('shangjia/query', {
			params: {
				shangjiazhanghao: detail.value.shangjiazhanghao
			}
		}).then(res => {
			if (res.data && res.data.code == 0) {
				nowfid.value = res.data.data.id
				nowfname.value = res.data.data.shangjiazhanghao
				if (res.data.data.touxiang) {
					nowfpic.value = res.data.data.touxiang.split(',')[0]
				} else if (res.data.data.headportrait) {
					nowfpic.value = res.data.data.headportrait.split(',')[0]
				}
				getChatList()
				chatVisible.value = true
			}
		})
	}
	const sendGoods = ()=>{
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
					tablename:  'shangjia' ,
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
					content: bannerList.value[0],
					format: 2
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
						tablename:  'shangjia' ,
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
						tablename:  'shangjia' ,
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
	const couponVisible = ref(false)
	const couponList = ref([])
	const couponClick = ()=>{
		couponList.value = []
		couponVisible.value = true
		getCouponList()
	}
	const getCouponList = ()=> {
		context.$http.get('coupon/lists').then(res => {
			if (res.data && res.data.code == 0) {
				for (let x in res.data.data) {
					if (changeCoupon(res.data.data[x])) {
						couponList.value.push(res.data.data[x])
					}
				}
			}
		})
	}
	const changeCoupon = (row)=> {
		if(moment()<moment(row.effectTime)||moment()>moment(row.expireTime)){//当前时间<生效时间||当前时间>过期时间
			return false
		}
		if(row.shangjiazhanghao == ''){
			return true
		}
		if(detail.value.shangjiazhanghao != row.shangjiazhanghao){
			return false
		}
		return true
	}
	const getCoupon = (item)=> {
		context.$http.get('mycoupon/page', {
			params: {
				page: 1,
				couponId: item.id
			}
		}).then(res => {
			if (res.data && res.data.code == 0) {
				if (res.data.data.list.length) {
					context?.$toolUtil.message('已领取该优惠券，请前往使用','error')
					return false
				}
				let data = {
					...item,
					userid: localStorage.getItem('userid'),
					couponId: item.id,
					status:'可使用',
					shangjiazhanghao: item.shangjiazhanghao
				}
				data.couponNumber = new Date().getTime()
				delete data.id
				delete data.addtime
				context.$http.post('mycoupon/add', data).then(res => {
					if (res.data && res.data.code == 0) {
						context?.$toolUtil.message('领取成功！','success')
					}
				})
			}
		})
	}
    const merchantClick = ()=>{
        context.$http.get('shangjia/query',{params: {
            shangjiazhanghao: detail.value.shangjiazhanghao
        }}).then(res=>{
            let params = {
                id: res.data.data.id
            }
            if(centerType.value){
                params.centerType = 1
            }
            router.push({path: '/index/shangjiaDetail', query: params});
        })
    }
    const isShelvesClick = ()=>{
        context.$confirm(`是否${detail.value.isShelves==1?'下架':'上架'}？`).then(() => {
            detail.value.isShelves = (detail.value.isShelves==1?0:1)
            context.$http.post('${tableName}/update',detail.value).then(rs=>{
                context.$message.success('操作成功！')
            })
        }).catch(() => {});
    }
    // 分享微博
    const shareToMicroblog = ()=>{
        //跳转地址
        window.open(`https://service.weibo.com/share/share.php?url=${encodeURIComponent(location.href)}&title=${title.value}`);
    }
    // 分享qq空间
    const shareToQQRom = ()=>{
        //跳转地址
        window.open(`https://sns.qzone.qq.com/cgi-bin/qzshare/cgi_qzshare_onekey?url=${encodeURIComponent(location.href)}&title=${title.value}&summary=${title.value}`);
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
	.coupon-list {
		width: 100%;
		display: flex;
		flex-wrap: wrap;
		.item {
			width: 31%;
			background: url('http://clfile.zggen.cn/20240817/3d727f394907414795e8d931697d43c2.webp');
			background-repeat: no-repeat;
			background-position: center center;
			background-size: cover;
			padding: 60px 30px;
			display: flex;
			align-items: center;
			margin: 0 1% 20px;
			position: relative;
			.box1 {
				flex: 1;
				color: #000;
				.coupon-name,coupon-condition {
					font-size: 22px;
					line-height: 1.5;
				}
				.coupon-term,coupon-term,coupon-remark {
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
					cursor: pointer;
				}
			}
		}
		.noList {
			color: #9e9e9e;
			width: 100%;
			text-align: center;
			padding: 60px 0;
		}
	}
    .share_view {
        display: flex;
        align-items: center;
    }
</style>