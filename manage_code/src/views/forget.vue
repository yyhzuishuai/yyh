<template>
	<div class="forget_view">
<div class="form" style="z-index: 1;">
    <div class="pageTitle">{{pageTitle}}</div>
				<div class="tab_view">
					<div class="tab" :class="pageType==1?'tab_active':''">输入账号</div>
					<div class="tab" :class="pageType==2?'tab_active tab_active1':''"> 输入密保</div>
					<div class="tab" :class="pageType==3?'tab_active tab_active1 tab_active2':''">重置密码</div>
				</div>

			<div class="form-box">
			</div>

    <div class="back" @click="close" style="cursor: pointer;">已有账号，直接登录</div>
                    <el-button v-if="pageType==1" class="get_btn" @click="getSecurity">获取密保</el-button>
                    <el-button v-if="pageType==2" class="valid_btn" @click="validateSecurity">确认密保</el-button>
					<el-button v-if="pageType==3" class="update_btn" @click="updatePassword">重置密码</el-button>

</div>
	</div>
</template>
<script setup>
	import {
		ref,
		getCurrentInstance,
		nextTick,
        onMounted,
		computed,
	} from 'vue';
    import { useRoute } from 'vue-router'
    const route = useRoute()
	const context = getCurrentInstance()?.appContext.config.globalProperties;
	const projectName = context.$project.projectName
    onMounted(()=>{
    })
	const pageType = ref(1)
	const pageTitle = computed(()=>{
		return pageType.value==1?'输入账号':pageType.value==2?'输入密保':'重置密码'
	})
	const forgetForm = ref({})
	const userForm = ref({})
	//返回登录
	const close = () => {
		context?.$router.push({
			path: "/login"
		});
	}
</script>

<style lang="scss">
	.forget_view {
        background-image: url("http://clfile.zggen.cn/20251108/9837400cabf94fd89e360c3ab75d5f1d.webp")!important;
	}
.forget_view {
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: flex-end;
    position: relative;
    overflow: hidden;
    background-size: 70vh 100vh;
    background-repeat: no-repeat;
    background-position: 10% 0;
}

.forget_view .form {
    text-align: center;
    padding: 50px 30px;
    position: relative;
    overflow: hidden;
    width: 500px;
    border-radius: 10px;
    display: flex;
    flex-direction: column;
    margin-right: 15%;
}

.forget_view .projectName {
    font-size: 24px;
    font-weight: 700;
    width: 100%;
    text-align: center;
    margin-top: 20px;
}
.forget_view .logo {
    background: url(http://clfile.zggen.cn/20250725/889d208e5ddd4107bce6600713cdf6d1.webp);
    background-size: 100% 100%;
    width: 80px;
    height: 80px;
    animation: float 3s ease-in-out infinite;
    margin: 0 auto;
}

.forget_view .circle1 {
    position: absolute;
    left: 100px;
    top: 100px;
    background: #daf4dc;
    width: 200px;
    height: 200px;
    border-radius: 50%;
    z-index: 1;
    animation: float 4s ease-in-out infinite;
}

.forget_view .circle2 {
    position: absolute;
    right: 100px;
    bottom: 100px;
    background: #EBEFD9;
    width: 300px;
    height: 300px;
    border-radius: 50%;
    z-index: 0;
    animation: float 5s ease-in-out infinite;
}
.forget_view .form-circle1 {
    position: absolute;
    right: -34px;
    top: -32px;
    background: #dff6e9;
    width: 140px;
    height: 140px;
    border-radius: 50%;
    z-index: -1;
}

.forget_view .form-circle2 {
    position: absolute;
    left: -34px;
    bottom: -32px;
    background: #f7efeb;
    width: 140px;
    height: 140px;
    border-radius: 50%;
    z-index: -1;
}


.forget_view .register_form {
    text-align: left;
    display: flex;
    flex-direction: column;
    gap: 20px;
    margin-top: 40px;
    padding: 0 50px;
}

.forget_view .list_item {
    display: flex;
    align-items: center;
    padding: 10px;
    margin-top: 20px;
    background: #fff;
    color: #000;
    border-radius: 6px;
    border: 1px solid var(--theme);
}

.forget_view .item_label {
    min-width: 100px;
    text-align: right;
}

.forget_view .register {
    background: var(--theme);
    border: none;
    color: #fff;
    width: 60%;
    margin-top: 30px;
    height: 40px;
    font-size: 18px;
}

.forget_view .back {
    width: 100%;
    margin-top: 20px;
    color: var(--theme);
}

.forget_view .tab {
    width: 30%;
    padding: 8px 0px;
    box-sizing: border-box;
    text-align: center;
    
    border: 1px solid var(--theme);
    border-radius: 6px;
    
}
.forget_view .tab.tab_active {
    
    
    box-sizing: border-box;
    text-align: center;
    
    background: var(--theme);
    color: rgb(255, 255, 255);
}
.forget_view .tab_view {
    width: 100%;
    display: flex;
    align-items: center;
    padding: 10px 20px;
    font-size: 16px;
    justify-content: space-between;
    
    border: 1px solid var(--theme);
    border-radius: 6px;
}

.forget_view .pageTitle {
    font-size: 24px;
    font-weight: 700;
    width: 100%;
    text-align: center;
    margin-top: 0px;
    padding-bottom: 20px;
    
}

.forget_view .el-input.list_inp {
    height: 40px;
}

.forget_view .el-select__wrapper {
    height: 40px;
    box-shadow: none!important;
}

.forget_view button.el-button {
    width: 100%;
    margin-top: 20px;
    height: 50px;
    background: var(--theme);
    color: #fff;
    font-size: 18px;
    border-radius: 6px;
    border: none;
    margin-left: auto;
}

.forget_view .el-input__wrapper {
    box-shadow: none!important;
}

</style>