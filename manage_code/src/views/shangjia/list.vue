<template>
	<div>
		<div class="center_view">
			<div class="list_search_view">
				<el-form :model="searchQuery" class="search_form" >
					<div class="search_view">
						<div class="search_label">
							商家账号：
						</div>
						<div class="search_box">
							<el-input class="search_inp" v-model="searchQuery.shangjiazhanghao" placeholder="商家账号"
								clearable>
							</el-input>
						</div>
					</div>
					<div class="search_view">
						<div class="search_label">
							审核状态：
						</div>
						<div class="search_box">
							<el-select
								class="search_sel"
								clearable
								v-model="searchQuery.sfsh"
								placeholder="审核状态"
								>
								<el-option v-for="item in approvalLists" :label="item" :value="item"></el-option>
							</el-select>
						</div>
					</div>
					<div class="search_btn_view">
						<el-button class="search_btn" type="primary" @click="searchClick()" size="small">搜索</el-button>
					</div>
				</el-form>
				<div class="btn_view">
					<el-button class="add_btn" type="success" @click="addClick" v-if="btnAuth('shangjia','新增')">
						新增
					</el-button>
					<el-button class="del_btn" type="danger" :disabled="selRows.length?false:true" @click="delClick(null)"  v-if="btnAuth('shangjia','删除')">
						删除
					</el-button>
				</div>
			</div>
			<el-table
				v-loading="listLoading" :stripe='true'
				@selection-change="handleSelectionChange"
				ref="table"
				v-if="btnAuth('shangjia','查看')"
				:data="list"
				@row-click="listChange">
				<el-table-column :resizable='true' align="left" header-align="left" type="selection" width="55" />
				<el-table-column label="序号" width="70" :resizable='true' align="left" header-align="left">
					<template #default="scope">{{ (listQuery.page-1)*listQuery.limit+scope.$index + 1}}</template>
				</el-table-column>
				<el-table-column min-width="140"
					:resizable='true'
					:sortable='false'
					align="left"
					header-align="left"
					prop="shangjiazhanghao"
					label="商家账号">
					<template #default="scope">
						{{scope.row.shangjiazhanghao}}
					</template>
				</el-table-column>
				<el-table-column min-width="140"
					:resizable='true'
					:sortable='false'
					align="left"
					header-align="left"
					prop="shangjiamingcheng"
					label="商家名称">
					<template #default="scope">
						{{scope.row.shangjiamingcheng}}
					</template>
				</el-table-column>
				<el-table-column label="头像" min-width="140" width="120" :resizable='true' :sortable='false' align="left" header-align="left">
					<template #default="scope">
						<div v-if="scope.row.touxiang">
							<el-image v-if="scope.row.touxiang.substring(0,4)=='http'" preview-teleported
								:preview-src-list="[scope.row.touxiang.split(',')[0]]"
								:src="scope.row.touxiang.split(',')[0]" style="width:100px;height:100px"></el-image>
							<el-image v-else preview-teleported
								:preview-src-list="[$config.url+scope.row.touxiang.split(',')[0]]"
								:src="$config.url+scope.row.touxiang.split(',')[0]" style="width:100px;height:100px">
							</el-image>
						</div>
						<div v-else>无图片</div>
					</template>
				</el-table-column>
				<el-table-column min-width="140"
					:resizable='true'
					:sortable='false'
					align="left"
					header-align="left"
					prop="youxiang"
					label="邮箱">
					<template #default="scope">
						{{scope.row.youxiang}}
					</template>
				</el-table-column>
				<el-table-column min-width="140"
					:resizable='true'
					:sortable='false'
					align="left"
					header-align="left"
					prop="lianxifangshi"
					label="联系方式">
					<template #default="scope">
						{{scope.row.lianxifangshi}}
					</template>
				</el-table-column>
				<el-table-column min-width="140"
					:resizable='true'
					:sortable='false'
					align="left"
					header-align="left"
					prop="shenfenzheng"
					label="身份证">
					<template #default="scope">
						{{scope.row.shenfenzheng}}
					</template>
				</el-table-column>
				<el-table-column label="营业资质" min-width="140" :resizable='true' :sortable='false' align="left" header-align="left">
					<template #default="scope">
						<el-button v-if="scope.row.yingyezizhi" size="small" @click="download(scope.row.yingyezizhi)">下载</el-button>
						<el-button v-else disabled link size="small">无</el-button>
					</template>
				</el-table-column>
				<el-table-column min-width="140"
					:resizable='true'
					:sortable='false'
					align="left"
					header-align="left"
					prop="zhuceshijian"
					label="注册时间">
					<template #default="scope">
						{{scope.row.zhuceshijian}}
					</template>
				</el-table-column>
				<el-table-column label="审核回复" min-width="140" :resizable='true' :sortable='false' align="left" header-align="left">
					<template #default="scope">
						{{scope.row.shhf}}
					</template>
				</el-table-column>
				<el-table-column prop="sfsh" label="审核状态" min-width="140" :resizable='true' :sortable='false' align="left" header-align="left">
					<template #default="scope">
                        <div v-if="scope.row.sfsh=='是'" style="text-align: center">
                            <img src="@/assets/img/pass.png" style="width: 50px;"/>
                            <div>通过</div>
                        </div>
                        <div v-else-if="scope.row.sfsh=='否'" style="text-align: center">
                            <img src="@/assets/img/reject.png" style="width: 50px;"/>
                            <div>未通过</div>
                        </div>
                        <div v-else-if="scope.row.sfsh=='待审核'" style="text-align: center">
                            <img src="@/assets/img/wait.png" style="width: 50px;"/>
                            <div>待审核</div>
                        </div>
					</template>
				</el-table-column>
				<el-table-column label="审核" v-if="btnAuth('shangjia','审核')" :resizable='true' :sortable='false' align="left" header-align="left">
					<template #default="scope">
						<el-button v-if="scope.row.sfsh=='待审核'" size="small" @click="approvalClick(scope.row)">审核</el-button>
					</template>
				</el-table-column>
                <el-table-column v-if="btnAuth('shangjia','修改')" label="禁用账号" :resizable='true' :sortable='false' align="left" header-align="left">
                    <template #default="scope">
                        <el-switch v-model="scope.row.isLocked"
                                   :active-value="1"
                                   :inactive-value="0"
                                   active-color="red"
                                   @change="updateItem(scope.row)"></el-switch>
                    </template>
                </el-table-column>
				<el-table-column label="操作" class-name="operation-cell" width="300" fixed="right" :resizable='true' :sortable='false' align="left" header-align="left">
					<template #default="scope">
						<el-button class="view_btn" type="info" v-if=" btnAuth('shangjia','查看')" @click="infoClick(scope.row.id)">
							详情
						</el-button>
						<el-button class="edit_btn" type="primary" @click="editClick(scope.row.id)" v-if=" btnAuth('shangjia','修改')">
							修改						</el-button>
						<el-button class="del_btn" type="danger" @click="delClick(scope.row.id)"  v-if="btnAuth('shangjia','删除')">
							删除						</el-button>
                        <el-button class="operate_btn" v-if="btnAuth('shangjia','私信')" type="success" @click="chatClick(scope.row)">
                          私信
                        </el-button>
					</template>
				</el-table-column>
			</el-table>
			<el-pagination
				background
				:layout="layouts.join(',')"
				:total="total"
				:page-size="listQuery.limit"
                v-model:current-page="listQuery.page"
				prev-text="<"
				next-text=">"
				:hide-on-single-page="true"
				:page-sizes="[10, 20, 30, 40, 50, 100]"
				@size-change="sizeChange"
				@current-change="currentChange"  />
		</div>
		<formModel ref="formRef" @formModelChange="formModelChange"></formModel>
		<Approval ref="approvalRef" @approvalSave="approvalSave" :tableName="tableName">
		</Approval>
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
	</div>
</template>
<script setup>
	import axios from 'axios'
	const moment = window.moment
	import {
		reactive,
		ref,
		getCurrentInstance,
		nextTick,
		onMounted,
		watch,
		computed,
	} from 'vue'
	import {
		useRoute,
		useRouter
	} from 'vue-router'
	import {
		useStore
	} from 'vuex';
	const store = useStore()
	const user = computed(()=>store.getters['user/session'])
	const avatar = ref(store.state.user.avatar)
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const baseUrl = ref(context.$config.url)
	import formModel from './formModel.vue'
	//基础信息
	const tableName = 'shangjia'
	const formName = '商家'
	const route = useRoute()
    const router = useRouter()
	const role = context.$toolUtil.storageGet('sessionTable')
	//基础信息
	onMounted(()=>{
	})
	//列表数据
	const list = ref(null)
	const table = ref(null)
	const listQuery = ref({
		page: 1,
		limit: 20,
		sort: 'id',
		order: 'desc'
	})
	const searchQuery = ref({})
	const selRows = ref([])
	const listLoading = ref(false)
	const listChange = (row) =>{
		nextTick(()=>{
			//table.value.clearSelection()
			table.value.toggleRowSelection(row)
		})
	}
	//列表
	const getList = () => {
		listLoading.value = true
		let params = JSON.parse(JSON.stringify(listQuery.value))
		params['sort'] = 'id'
		params['order'] = 'desc'
		if(searchQuery.value.shangjiazhanghao&&searchQuery.value.shangjiazhanghao!=''){
			params['shangjiazhanghao'] = '%' + searchQuery.value.shangjiazhanghao + '%'
		}
		if(searchQuery.value.sfsh && searchQuery.value.sfsh!=''){
			params['sfsh'] = searchQuery.value.sfsh
		}
		context.$http({
			url: `${tableName}/page`,
			method: 'get',
			params: params
		}).then(res => {
			listLoading.value = false
			list.value = res.data.data.list
			total.value = Number(res.data.data.total)
		})
	}
	//删
	const delClick = (id) => {
		let ids = []
		if (id) {
			ids = [id]
		} else {
			if (selRows.value.length) {
				for (let x in selRows.value) {
					ids.push(selRows.value[x].id)
				}
			} else {
				return false
			}
		}
		ElMessageBox.confirm(`是否删除选中${formName}`, '提示', {
			confirmButtonText: '是',
			cancelButtonText: '否',
			type: 'warning',
		}).then(() => {
			context.$http({
				url: `${tableName}/delete`,
				method: 'post',
				data: ids
			}).then(res => {
				context?.$toolUtil.message('删除成功', 'success',()=>{
					getList()
				})
			})
		}).catch(_ => {})
	}
	//多选
	const handleSelectionChange = (e) => {
		selRows.value = e
	}
	//列表数据
	//分页
	const total = ref(0)
	const layouts = ref(["total","prev","pager","next","jumper"])
	const sizeChange = (size) => {
		listQuery.value.limit = size
		getList()
	}
	const currentChange = (page) => {
		listQuery.value.page = page
		getList()
	}
	//分页
	//权限验证
	const btnAuth = (e,a)=>{
		return context?.$toolUtil.isAuth(e,a)
	}
    const approvalSave = async (form)=>{
		context.$http.post(`${tableName}/update`,form).then(res => {
            context.$message.success('审核成功')
            approvalRef.value.approvalVisible = false
			searchClick()
        })
    }
	//搜索
	const searchClick = () => {
		listQuery.value.page = 1
		getList()
	}
	//表单
	const formRef = ref(null)
	const formModelChange=()=>{
		searchClick()
	}
	const addClick = ()=>{
		formRef.value.init()
	}
	const editClick = (id=null)=>{
		if(id){
			formRef.value.init(id,'edit')
			return
		}
		if(selRows.value.length){
			formRef.value.init(selRows.value[0].id,'edit')
		}
	}

	const infoClick = (id=null)=>{
		if(id){
			formRef.value.init(id,'info')
		}
		else if(selRows.value.length){
			formRef.value.init(selRows.value[0].id,'info')
		}
	}
	// 表单
	// 预览文件
	const preClick = (file) =>{
		if(!file){
			context?.$toolUtil.message('文件不存在','error')
		}
		window.open(context?.$config.url + file)
	}
	// 下载文件
	const download = (file) => {
		if(!file){
			context?.$toolUtil.message('文件不存在','error')
		}
		let arr = file.replace(new RegExp('file/', "g"), "")
		axios.get((location.href.split(context?.$config.name).length>1 ? location.href.split(context?.$config.name)[0] :'') + context?.$config.name + '/file/download?fileName=' + arr, {
			headers: {
				token: context?.$toolUtil.storageGet('Token')
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
	//审核
	import Approval from '@/components/common/approval.vue'
	const approvalRef = ref(null)
	const approvalClick = (row) => {
		nextTick(() => {
			approvalRef.value.approvalClick(row )
		})
	}
	//查询审核状态列表
	const approvalLists = ref([])
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
    const chatVisible = ref(false)
    const nowfid = ref(0)
    const nowfpic = ref('')
    const nowfname = ref('')
    const chatList = ref([])
    const chatForm = ref({
        content: ''
    })
    const chatTimer = ref(null)
    const uploadUrl = context?.$config.url + 'file/upload'
    const chatClick = (row) => {
        if (row.id == user.value.id) {
            context.$toolUtil.message('不能给自己发消息！','error')
            return false
        }
        nowfid.value = row.id
        if (row.touxiang) {
            nowfpic.value = row.touxiang.split(',')[0]
        } else if (row.headportrait) {
            nowfpic.value = row.headportrait.split(',')[0]
        }
        if (row.shangjiazhanghao) {
            nowfname.value = row.shangjiazhanghao
        }
        scrollFlag.value = true
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
        chatList.value = []
        getList()
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
                            tablename: 'shangjia',
                        }).then(res => {
                            context.$http.post('chatfriend/add', {
                                uid: nowfid.value,
                                fid: user.value.id,
                                type: 2,
                                tablename: 'shangjia',
                                name: context.$toolUtil.storageGet('adminName'),
                                picture: avatar.value,
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
                        tablename:  'shangjia',
                    }).then(res => {
                        context.$http.post('chatfriend/add', {
                            uid: nowfid.value,
                            fid: user.value.id,
                            type: 2,
                            tablename: localStorage.getItem('sessionTable'),
                            name: context.$toolUtil.storageGet('adminName'),
                            picture: avatar.value,
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
    const updateItem = (row)=>{
        context.$http.post(`${tableName}/update`,row).then(res=>{
            if(res.data.code==0){
                context.$message.success("更新成功")
            }
        })
    }
	//初始化
	const init = () => {
        approvalLists.value = "是,否,待审核".split(',');
		getList()
	}
	init()
</script>
<style lang="scss" scoped>
	// 表格样式
	.el-table {
		:deep(.el-table__body-wrapper) {
			tbody {
				tr.el-table__row--striped {
					td {
						background: #FAFAFA;
					}
				}
			}
		}
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