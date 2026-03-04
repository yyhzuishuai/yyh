"use strict";
(self["webpackChunkvue3_nf0"] = self["webpackChunkvue3_nf0"] || []).push([[5033],{

/***/ 5033:
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

// ESM COMPAT FLAG
__webpack_require__.r(__webpack_exports__);

// EXPORTS
__webpack_require__.d(__webpack_exports__, {
  "default": function() { return /* binding */ register; }
});

// EXTERNAL MODULE: ../../../../../../../node_modules_front/4/node_modules/@vue/runtime-core/dist/runtime-core.esm-bundler.js
var runtime_core_esm_bundler = __webpack_require__(9171);
// EXTERNAL MODULE: ../../../../../../../node_modules_front/4/node_modules/@vue/shared/dist/shared.esm-bundler.js
var shared_esm_bundler = __webpack_require__(3972);
// EXTERNAL MODULE: ../../../../../../../node_modules_front/4/node_modules/@vue/reactivity/dist/reactivity.esm-bundler.js
var reactivity_esm_bundler = __webpack_require__(7387);
// EXTERNAL MODULE: ../../../../../../../node_modules_front/4/node_modules/vue-router/dist/vue-router.esm-bundler.js
var vue_router_esm_bundler = __webpack_require__(2984);
;// CONCATENATED MODULE: ../../../../../../../node_modules_front/4/node_modules/thread-loader/dist/cjs.js!../../../../../../../node_modules_front/4/node_modules/babel-loader/lib/index.js??clonedRuleSet-40.use[1]!../../../../../../../node_modules_front/4/node_modules/vue-loader/dist/index.js??ruleSet[0].use[0]!./src/views/pages/yonghu/register.vue?vue&type=script&setup=true&lang=js

const _hoisted_1 = {
  class: "register_view"
};
const _hoisted_2 = {
  class: "form",
  style: {
    "z-index": "1"
  }
};
const _hoisted_3 = {
  class: "projectName"
};
const _hoisted_4 = {
  class: "register_form"
};
const _hoisted_5 = {
  class: "list_item"
};
const _hoisted_6 = {
  class: "list_item"
};
const _hoisted_7 = {
  class: "list_item"
};
const _hoisted_8 = {
  class: "list_item"
};
const _hoisted_9 = {
  class: "list_item"
};
const _hoisted_10 = {
  class: "list_item"
};
const _hoisted_11 = {
  class: "list_file_list"
};
const _hoisted_12 = {
  class: "list_item"
};
const _hoisted_13 = {
  class: "list_item"
};
const _hoisted_14 = {
  class: "list_item"
};
const _hoisted_15 = {
  class: "btn"
};


/* harmony default export */ var registervue_type_script_setup_true_lang_js = ({
  __name: 'register',
  setup(__props) {
    const context = (0,runtime_core_esm_bundler/* getCurrentInstance */.FN)()?.appContext.config.globalProperties;
    const projectName = context.$project.projectName;
    //获取注册类型
    const route = (0,vue_router_esm_bundler/* useRoute */.yj)();
    const tableName = (0,reactivity_esm_bundler/* ref */.iH)('yonghu');

    //公共方法
    const getUUID = () => {
      return new Date().getTime();
    };
    const registerForm = (0,reactivity_esm_bundler/* ref */.iH)({});
    const yonghuxingbieLists = (0,reactivity_esm_bundler/* ref */.iH)([]);
    const init = () => {
      yonghuxingbieLists.value = "男,女".split(',');
      registerForm.value.zhuceshijian = context?.$toolUtil.getCurDateTime();
    };
    const touxiangUploadSuccess = fileUrls => {
      registerForm.value.touxiang = fileUrls;
    };

    //注册按钮
    const handleRegister = () => {
      let url = tableName.value + "/register";
      if (!registerForm.value.yonghuzhanghao) {
        context?.$toolUtil.message(`用户账号不能为空`, 'error');
        return false;
      }
      if (!registerForm.value.mima) {
        context?.$toolUtil.message(`密码不能为空`, 'error');
        return false;
      }
      if (registerForm.value.mima != registerForm.value.mima2) {
        context?.$toolUtil.message('两次密码输入不一致', 'error');
        return false;
      }
      if (!registerForm.value.nicheng) {
        context?.$toolUtil.message(`昵称不能为空`, 'error');
        return false;
      }
      if (!registerForm.value.xingbie) {
        context?.$toolUtil.message(`性别不能为空`, 'error');
        return false;
      }
      if (registerForm.value.touxiang != null) {
        registerForm.value.touxiang = registerForm.value.touxiang.replace(new RegExp(context?.$config.url, "g"), "");
      }
      if (!registerForm.value.touxiang) {
        context?.$toolUtil.message(`头像不能为空`, 'error');
        return false;
      }
      if (!registerForm.value.youxiang) {
        context?.$toolUtil.message(`邮箱不能为空`, 'error');
        return false;
      }
      if (registerForm.value.youxiang && !context?.$toolUtil.isEmail(registerForm.value.youxiang)) {
        context?.$toolUtil.message(`邮箱应输入邮件格式`, 'error');
        return false;
      }
      if (!registerForm.value.shouji) {
        context?.$toolUtil.message(`手机不能为空`, 'error');
        return false;
      }
      if (registerForm.value.shouji && !context?.$toolUtil.isMobile(registerForm.value.shouji)) {
        context?.$toolUtil.message(`手机应输入手机格式`, 'error');
        return false;
      }
      if (!registerForm.value.shenfenzheng) {
        context?.$toolUtil.message(`身份证不能为空`, 'error');
        return false;
      }
      if (registerForm.value.shenfenzheng && !context?.$toolUtil.checkIdCard(registerForm.value.shenfenzheng)) {
        context?.$toolUtil.message(`身份证应输入身份证格式`, 'error');
        return false;
      }
      if (registerForm.value.maxPasswordWrong && !context?.$toolUtil.isIntNumer(registerForm.value.maxPasswordWrong)) {
        context?.$toolUtil.message(`最大密码输错次数应输入整数`, 'error');
        return false;
      }
      if (registerForm.value.isLocked && !context?.$toolUtil.isIntNumer(registerForm.value.isLocked)) {
        context?.$toolUtil.message(`用户锁定状态应输入整数`, 'error');
        return false;
      }
      if (registerForm.value.money && !context?.$toolUtil.isNumber(registerForm.value.money)) {
        context?.$toolUtil.message(`余额应输入数字`, 'error');
        return false;
      }
      context?.$http({
        url: url,
        method: 'post',
        data: registerForm.value
      }).then(res => {
        context?.$toolUtil.message('注册成功', 'success', obj => {
          context?.$router.push({
            path: "/login"
          });
        });
      });
    };
    //返回登录
    const close = () => {
      context?.$router.push({
        path: "/login"
      });
    };
    init();
    (0,runtime_core_esm_bundler/* onMounted */.bv)(() => {});
    return (_ctx, _cache) => {
      const _component_el_input = (0,runtime_core_esm_bundler/* resolveComponent */.up)("el-input");
      const _component_el_radio = (0,runtime_core_esm_bundler/* resolveComponent */.up)("el-radio");
      const _component_el_radio_group = (0,runtime_core_esm_bundler/* resolveComponent */.up)("el-radio-group");
      const _component_uploads = (0,runtime_core_esm_bundler/* resolveComponent */.up)("uploads");
      const _component_el_button = (0,runtime_core_esm_bundler/* resolveComponent */.up)("el-button");
      return (0,runtime_core_esm_bundler/* openBlock */.wg)(), (0,runtime_core_esm_bundler/* createElementBlock */.iD)("div", _hoisted_1, [(0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_2, [_cache[18] || (_cache[18] = (0,runtime_core_esm_bundler/* createElementVNode */._)("div", {
        class: "logo"
      }, null, -1)), (0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_3, (0,shared_esm_bundler/* toDisplayString */.zw)((0,reactivity_esm_bundler/* unref */.SU)(projectName)) + "注册", 1), (0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_4, [(0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_5, [_cache[8] || (_cache[8] = (0,runtime_core_esm_bundler/* createElementVNode */._)("div", {
        class: "list_label"
      }, "用户账号：", -1)), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_input, {
        class: "list_inp",
        modelValue: registerForm.value.yonghuzhanghao,
        "onUpdate:modelValue": _cache[0] || (_cache[0] = $event => registerForm.value.yonghuzhanghao = $event),
        placeholder: "请输入用户账号",
        type: "text"
      }, null, 8, ["modelValue"])]), (0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_6, [_cache[9] || (_cache[9] = (0,runtime_core_esm_bundler/* createElementVNode */._)("div", {
        class: "list_label"
      }, "密码：", -1)), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_input, {
        class: "list_inp",
        modelValue: registerForm.value.mima,
        "onUpdate:modelValue": _cache[1] || (_cache[1] = $event => registerForm.value.mima = $event),
        placeholder: "请输入密码",
        type: "password",
        "show-password": ""
      }, null, 8, ["modelValue"])]), (0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_7, [_cache[10] || (_cache[10] = (0,runtime_core_esm_bundler/* createElementVNode */._)("div", {
        class: "list_label"
      }, "确认密码：", -1)), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_input, {
        class: "list_inp",
        modelValue: registerForm.value.mima2,
        "onUpdate:modelValue": _cache[2] || (_cache[2] = $event => registerForm.value.mima2 = $event),
        type: "password",
        placeholder: "请输入确认密码",
        "show-password": ""
      }, null, 8, ["modelValue"])]), (0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_8, [_cache[11] || (_cache[11] = (0,runtime_core_esm_bundler/* createElementVNode */._)("div", {
        class: "list_label"
      }, "昵称：", -1)), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_input, {
        class: "list_inp",
        modelValue: registerForm.value.nicheng,
        "onUpdate:modelValue": _cache[3] || (_cache[3] = $event => registerForm.value.nicheng = $event),
        placeholder: "请输入昵称",
        type: "text"
      }, null, 8, ["modelValue"])]), (0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_9, [_cache[12] || (_cache[12] = (0,runtime_core_esm_bundler/* createElementVNode */._)("div", {
        class: "list_label"
      }, "性别：", -1)), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_radio_group, {
        class: "list_radio",
        modelValue: registerForm.value.xingbie,
        "onUpdate:modelValue": _cache[4] || (_cache[4] = $event => registerForm.value.xingbie = $event)
      }, {
        default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [((0,runtime_core_esm_bundler/* openBlock */.wg)(true), (0,runtime_core_esm_bundler/* createElementBlock */.iD)(runtime_core_esm_bundler/* Fragment */.HY, null, (0,runtime_core_esm_bundler/* renderList */.Ko)(yonghuxingbieLists.value, item => {
          return (0,runtime_core_esm_bundler/* openBlock */.wg)(), (0,runtime_core_esm_bundler/* createBlock */.j4)(_component_el_radio, {
            label: item,
            size: "large"
          }, {
            default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createTextVNode */.Uk)((0,shared_esm_bundler/* toDisplayString */.zw)(item), 1)]),
            _: 2
          }, 1032, ["label"]);
        }), 256))]),
        _: 1
      }, 8, ["modelValue"])]), (0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_10, [_cache[13] || (_cache[13] = (0,runtime_core_esm_bundler/* createElementVNode */._)("div", {
        class: "list_label"
      }, "头像：", -1)), (0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_11, [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_uploads, {
        action: "file/upload",
        tip: "请上传头像",
        fileUrls: registerForm.value.touxiang ? registerForm.value.touxiang : '',
        onChange: touxiangUploadSuccess
      }, null, 8, ["fileUrls"])])]), (0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_12, [_cache[14] || (_cache[14] = (0,runtime_core_esm_bundler/* createElementVNode */._)("div", {
        class: "list_label"
      }, "邮箱：", -1)), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_input, {
        class: "list_inp",
        modelValue: registerForm.value.youxiang,
        "onUpdate:modelValue": _cache[5] || (_cache[5] = $event => registerForm.value.youxiang = $event),
        placeholder: "请输入邮箱",
        type: "text"
      }, null, 8, ["modelValue"])]), (0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_13, [_cache[15] || (_cache[15] = (0,runtime_core_esm_bundler/* createElementVNode */._)("div", {
        class: "list_label"
      }, "手机：", -1)), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_input, {
        class: "list_inp",
        modelValue: registerForm.value.shouji,
        "onUpdate:modelValue": _cache[6] || (_cache[6] = $event => registerForm.value.shouji = $event),
        placeholder: "请输入手机",
        type: "text"
      }, null, 8, ["modelValue"])]), (0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_14, [_cache[16] || (_cache[16] = (0,runtime_core_esm_bundler/* createElementVNode */._)("div", {
        class: "list_label"
      }, "身份证：", -1)), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_input, {
        class: "list_inp",
        modelValue: registerForm.value.shenfenzheng,
        "onUpdate:modelValue": _cache[7] || (_cache[7] = $event => registerForm.value.shenfenzheng = $event),
        placeholder: "请输入身份证",
        type: "text"
      }, null, 8, ["modelValue"])])]), (0,runtime_core_esm_bundler/* createElementVNode */._)("div", {
        class: "back",
        onClick: close
      }, "已有账号，直接登录"), (0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_15, [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_button, {
        class: "register",
        onClick: handleRegister
      }, {
        default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => _cache[17] || (_cache[17] = [(0,runtime_core_esm_bundler/* createTextVNode */.Uk)("注册", -1)])),
        _: 1,
        __: [17]
      })]), _cache[19] || (_cache[19] = (0,runtime_core_esm_bundler/* createElementVNode */._)("div", {
        class: "form-circle1"
      }, null, -1)), _cache[20] || (_cache[20] = (0,runtime_core_esm_bundler/* createElementVNode */._)("div", {
        class: "form-circle2"
      }, null, -1))]), _cache[21] || (_cache[21] = (0,runtime_core_esm_bundler/* createElementVNode */._)("div", {
        class: "circle1"
      }, null, -1)), _cache[22] || (_cache[22] = (0,runtime_core_esm_bundler/* createElementVNode */._)("div", {
        class: "circle2"
      }, null, -1))]);
    };
  }
});
;// CONCATENATED MODULE: ./src/views/pages/yonghu/register.vue?vue&type=script&setup=true&lang=js
 
;// CONCATENATED MODULE: ../../../../../../../node_modules_front/4/node_modules/mini-css-extract-plugin/dist/loader.js??clonedRuleSet-22.use[0]!../../../../../../../node_modules_front/4/node_modules/css-loader/dist/cjs.js??clonedRuleSet-22.use[1]!../../../../../../../node_modules_front/4/node_modules/vue-loader/dist/stylePostLoader.js!../../../../../../../node_modules_front/4/node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-22.use[2]!../../../../../../../node_modules_front/4/node_modules/sass-loader/dist/cjs.js??clonedRuleSet-22.use[3]!../../../../../../../node_modules_front/4/node_modules/vue-loader/dist/index.js??ruleSet[0].use[0]!./src/views/pages/yonghu/register.vue?vue&type=style&index=0&id=1e2b3bd0&lang=scss
// extracted by mini-css-extract-plugin

;// CONCATENATED MODULE: ./src/views/pages/yonghu/register.vue?vue&type=style&index=0&id=1e2b3bd0&lang=scss

;// CONCATENATED MODULE: ./src/views/pages/yonghu/register.vue



;

const __exports__ = registervue_type_script_setup_true_lang_js;

/* harmony default export */ var register = (__exports__);

/***/ })

}]);
//# sourceMappingURL=5033.7953275c.js.map