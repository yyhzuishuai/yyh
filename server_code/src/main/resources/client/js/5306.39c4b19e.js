"use strict";
(self["webpackChunkvue3_nf0"] = self["webpackChunkvue3_nf0"] || []).push([[5306],{

/***/ 5306:
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

// ESM COMPAT FLAG
__webpack_require__.r(__webpack_exports__);

// EXPORTS
__webpack_require__.d(__webpack_exports__, {
  "default": function() { return /* binding */ formAdd; }
});

// EXTERNAL MODULE: ../../../../../../../node_modules_front/4/node_modules/@vue/runtime-core/dist/runtime-core.esm-bundler.js
var runtime_core_esm_bundler = __webpack_require__(9171);
// EXTERNAL MODULE: ../../../../../../../node_modules_front/4/node_modules/@vue/shared/dist/shared.esm-bundler.js
var shared_esm_bundler = __webpack_require__(3972);
// EXTERNAL MODULE: ../../../../../../../node_modules_front/4/node_modules/@vue/reactivity/dist/reactivity.esm-bundler.js
var reactivity_esm_bundler = __webpack_require__(7387);
// EXTERNAL MODULE: ../../../../../../../node_modules_front/4/node_modules/vue-router/dist/vue-router.esm-bundler.js
var vue_router_esm_bundler = __webpack_require__(2984);
// EXTERNAL MODULE: ../../../../../../../node_modules_front/4/node_modules/vuex/dist/vuex.esm-bundler.js + 5 modules
var vuex_esm_bundler = __webpack_require__(7191);
;// CONCATENATED MODULE: ../../../../../../../node_modules_front/4/node_modules/thread-loader/dist/cjs.js!../../../../../../../node_modules_front/4/node_modules/babel-loader/lib/index.js??clonedRuleSet-40.use[1]!../../../../../../../node_modules_front/4/node_modules/vue-loader/dist/index.js??ruleSet[0].use[0]!./src/views/pages/dongmanshangpin/formAdd.vue?vue&type=script&setup=true&lang=js

const _hoisted_1 = {
  class: "edit_view"
};
const _hoisted_2 = {
  class: "breadcrumb-wrapper",
  style: {
    "width": "100%"
  }
};
const _hoisted_3 = {
  class: "bread_view"
};
const _hoisted_4 = {
  class: "formModel_btn_box"
};



const tableName = 'dongmanshangpin';
const formName = '动漫商品';
//基础信息

/* harmony default export */ var formAddvue_type_script_setup_true_lang_js = ({
  __name: 'formAdd',
  setup(__props) {
    const store = (0,vuex_esm_bundler/* useStore */.oR)();
    const user = (0,runtime_core_esm_bundler/* computed */.Fl)(() => store.getters['user/session']);
    const moment = window.moment;
    const context = (0,runtime_core_esm_bundler/* getCurrentInstance */.FN)()?.appContext.config.globalProperties;
    const route = (0,vue_router_esm_bundler/* useRoute */.yj)();
    const router = (0,vue_router_esm_bundler/* useRouter */.tv)();
    //基础信息
    const breadList = (0,reactivity_esm_bundler/* ref */.iH)([{
      name: formName
    }]);
    //获取唯一标识
    const getUUID = () => {
      return new Date().getTime();
    };
    //form表单
    const form = (0,reactivity_esm_bundler/* ref */.iH)({
      shangpinmingcheng: '',
      shangpinleixing: '',
      shangpintupian: '',
      dongmanpinpai: '',
      dongmanip: '',
      guige: '',
      dongmancaizhi: '',
      shangpinxiangqing: '',
      score: '0',
      shhf: '',
      isShelves: '1',
      clicktime: '',
      shangjiazhanghao: '',
      shangjiamingcheng: ''
    });
    const formRef = (0,reactivity_esm_bundler/* ref */.iH)(null);
    const id = (0,reactivity_esm_bundler/* ref */.iH)(0);
    const type = (0,reactivity_esm_bundler/* ref */.iH)('');
    const disabledForm = (0,reactivity_esm_bundler/* ref */.iH)({
      shangpinmingcheng: false,
      shangpinleixing: false,
      shangpintupian: false,
      dongmanpinpai: false,
      dongmanip: false,
      guige: false,
      dongmancaizhi: false,
      shangpinxiangqing: false,
      score: false,
      onelimittimes: false,
      alllimittimes: false,
      sfsh: false,
      shhf: false,
      storeupNumber: false,
      discussNumber: false,
      price: false,
      isShelves: false,
      thumbsupNumber: false,
      crazilyNumber: false,
      clicktime: false,
      shangjiazhanghao: false,
      shangjiamingcheng: false
    });
    const isAdd = (0,reactivity_esm_bundler/* ref */.iH)(false);
    //表单验证
    const rules = (0,reactivity_esm_bundler/* ref */.iH)({
      shangpinmingcheng: [{
        required: true,
        message: '请输入',
        trigger: 'blur'
      }],
      shangpinleixing: [],
      shangpintupian: [],
      dongmanpinpai: [],
      dongmanip: [],
      guige: [],
      dongmancaizhi: [],
      shangpinxiangqing: [],
      score: [{
        validator: context.$toolUtil.validator.number,
        trigger: 'blur'
      }],
      onelimittimes: [{
        validator: context.$toolUtil.validator.intNumber,
        trigger: 'blur'
      }],
      alllimittimes: [{
        validator: context.$toolUtil.validator.intNumber,
        trigger: 'blur'
      }],
      sfsh: [],
      shhf: [],
      storeupNumber: [{
        validator: context.$toolUtil.validator.intNumber,
        trigger: 'blur'
      }],
      discussNumber: [{
        validator: context.$toolUtil.validator.intNumber,
        trigger: 'blur'
      }],
      price: [{
        validator: context.$toolUtil.validator.number,
        trigger: 'blur'
      }],
      isShelves: [{
        validator: context.$toolUtil.validator.intNumber,
        trigger: 'blur'
      }],
      thumbsupNumber: [{
        validator: context.$toolUtil.validator.intNumber,
        trigger: 'blur'
      }],
      crazilyNumber: [{
        validator: context.$toolUtil.validator.intNumber,
        trigger: 'blur'
      }],
      clicktime: [],
      shangjiazhanghao: [],
      shangjiamingcheng: []
    });
    //商品类型列表
    const shangpinleixingLists = (0,reactivity_esm_bundler/* ref */.iH)([]);
    //商品图片上传回调
    const shangpintupianUploadSuccess = e => {
      form.value.shangpintupian = e;
    };
    //获取info
    const getInfo = () => {
      context?.$http({
        url: `${tableName}/info/${id.value}`,
        method: 'get'
      }).then(res => {
        let reg = new RegExp('../../../file', 'g');
        res.data.data.shangpinxiangqing = res.data.data.shangpinxiangqing.replace(reg, '../../../cl445746174/file');
        form.value = res.data.data;
      });
    };
    const crossRow = (0,reactivity_esm_bundler/* ref */.iH)('');
    const crossTable = (0,reactivity_esm_bundler/* ref */.iH)('');
    const crossTips = (0,reactivity_esm_bundler/* ref */.iH)('');
    const crossColumnName = (0,reactivity_esm_bundler/* ref */.iH)('');
    const crossColumnValue = (0,reactivity_esm_bundler/* ref */.iH)('');
    //初始化
    const init = (formId = null, formType = 'add', formNames = '', row = null, table = null, statusColumnName = null, tips = null, statusColumnValue = null) => {
      if (formId) {
        id.value = formId;
        type.value = formType;
      }
      if (formType == 'add') {
        isAdd.value = true;
      } else if (formType == 'info') {
        isAdd.value = false;
        getInfo();
      } else if (formType == 'edit') {
        isAdd.value = true;
        getInfo();
      } else if (formType == 'cross') {
        isAdd.value = true;
        // getInfo()
        for (let x in row) {
          if (x == 'shangpinmingcheng') {
            form.value.shangpinmingcheng = row[x];
            disabledForm.value.shangpinmingcheng = true;
            continue;
          }
          if (x == 'shangpinleixing') {
            form.value.shangpinleixing = row[x];
            disabledForm.value.shangpinleixing = true;
            continue;
          }
          if (x == 'shangpintupian') {
            form.value.shangpintupian = row[x];
            disabledForm.value.shangpintupian = true;
            continue;
          }
          if (x == 'dongmanpinpai') {
            form.value.dongmanpinpai = row[x];
            disabledForm.value.dongmanpinpai = true;
            continue;
          }
          if (x == 'dongmanip') {
            form.value.dongmanip = row[x];
            disabledForm.value.dongmanip = true;
            continue;
          }
          if (x == 'guige') {
            form.value.guige = row[x];
            disabledForm.value.guige = true;
            continue;
          }
          if (x == 'dongmancaizhi') {
            form.value.dongmancaizhi = row[x];
            disabledForm.value.dongmancaizhi = true;
            continue;
          }
          if (x == 'shangpinxiangqing') {
            form.value.shangpinxiangqing = row[x];
            disabledForm.value.shangpinxiangqing = true;
            continue;
          }
          if (x == 'score') {
            form.value.score = row[x];
            disabledForm.value.score = true;
            continue;
          }
          if (x == 'onelimittimes') {
            form.value.onelimittimes = row[x];
            disabledForm.value.onelimittimes = true;
            continue;
          }
          if (x == 'alllimittimes') {
            form.value.alllimittimes = row[x];
            disabledForm.value.alllimittimes = true;
            continue;
          }
          if (x == 'storeupNumber') {
            form.value.storeupNumber = row[x];
            disabledForm.value.storeupNumber = true;
            continue;
          }
          if (x == 'discussNumber') {
            form.value.discussNumber = row[x];
            disabledForm.value.discussNumber = true;
            continue;
          }
          if (x == 'price') {
            form.value.price = row[x];
            disabledForm.value.price = true;
            continue;
          }
          if (x == 'isShelves') {
            form.value.isShelves = row[x];
            disabledForm.value.isShelves = true;
            continue;
          }
          if (x == 'thumbsupNumber') {
            form.value.thumbsupNumber = row[x];
            disabledForm.value.thumbsupNumber = true;
            continue;
          }
          if (x == 'crazilyNumber') {
            form.value.crazilyNumber = row[x];
            disabledForm.value.crazilyNumber = true;
            continue;
          }
          if (x == 'clicktime') {
            form.value.clicktime = row[x];
            disabledForm.value.clicktime = true;
            continue;
          }
          if (x == 'shangjiazhanghao') {
            form.value.shangjiazhanghao = row[x];
            disabledForm.value.shangjiazhanghao = true;
            continue;
          }
          if (x == 'shangjiamingcheng') {
            form.value.shangjiamingcheng = row[x];
            disabledForm.value.shangjiamingcheng = true;
            continue;
          }
        }
        if (row) {
          crossRow.value = row;
        }
        if (table) {
          crossTable.value = table;
        }
        if (tips) {
          crossTips.value = tips;
        }
        if (statusColumnName) {
          crossColumnName.value = statusColumnName;
        }
        if (statusColumnValue) {
          crossColumnValue.value = statusColumnValue;
        }
        form.value.score = '0';
        form.value.isShelves = '1';
      }
      context?.$http({
        url: `${context?.$toolUtil.storageGet('frontSessionTable')}/session`,
        method: 'get'
      }).then(res => {
        var json = res.data.data;
        if (context?.$toolUtil.storageGet("frontSessionTable") != "users") {
          disabledForm.value.score = true;
        }
        if (json.hasOwnProperty('shangjiazhanghao') && context?.$toolUtil.storageGet("frontSessionTable") != "users") {
          form.value.shangjiazhanghao = json.shangjiazhanghao;
          disabledForm.value.shangjiazhanghao = true;
        }
        if (json.hasOwnProperty('shangjiamingcheng') && context?.$toolUtil.storageGet("frontSessionTable") != "users") {
          form.value.shangjiamingcheng = json.shangjiamingcheng;
          disabledForm.value.shangjiamingcheng = true;
        }
        if (localStorage.getItem('autoSave')) {
          localStorage.removeItem('autoSave');
          save();
        }
      });
      context?.$http({
        url: `option/shangpinleixing/shangpinleixing`,
        method: 'get'
      }).then(res => {
        shangpinleixingLists.value = res.data.data;
      });
    };
    //初始化
    //取消
    const backClick = () => {
      history.back();
    };
    //富文本数据回调
    const editorChange = (e, name) => {
      form.value[name] = e;
    };
    //提交
    const save = () => {
      if (form.value.shangpintupian != null) {
        form.value.shangpintupian = form.value.shangpintupian.replace(new RegExp(context?.$config.url, "g"), "");
      }
      var table = crossTable.value;
      var objcross = JSON.parse(JSON.stringify(crossRow.value));
      let crossUserId = '';
      let crossRefId = '';
      let crossOptNum = '';
      formRef.value.validate(async valid => {
        if (valid) {
          if (type.value == 'cross') {
            if (crossColumnName.value != '') {
              if (!crossColumnName.value.startsWith('[')) {
                for (let o in objcross) {
                  if (o == crossColumnName.value) {
                    objcross[o] = crossColumnValue.value;
                  }
                }
                //修改跨表数据
                await changeCrossData(objcross);
              } else {
                crossUserId = context?.$toolUtil.storageGet('userid');
                crossRefId = objcross['id'];
                crossOptNum = crossColumnName.value.replace(/\[/, "").replace(/\]/, "");
              }
            }
          }
          if (crossUserId && crossRefId) {
            //限制用户操作次数
            form.value.crossuserid = crossUserId;
            form.value.crossrefid = crossRefId;
            let params = {
              page: 1,
              limit: 1000,
              crossuserid: form.value.crossuserid,
              crossrefid: form.value.crossrefid
            };
            context?.$http({
              url: `${tableName}/page`,
              method: 'get',
              params: params
            }).then(async res => {
              if (res.data.data.total >= crossOptNum) {
                context?.$toolUtil.message(`${crossTips.value}`, 'error');
                return false;
              } else {
                context?.$http({
                  url: `${tableName}/${!form.value.id ? "save" : "update"}`,
                  method: 'post',
                  data: form.value
                }).then(async res => {
                  context?.$toolUtil.message(`操作成功`, 'success');
                  history.back();
                });
              }
            });
          } else {
            context?.$http({
              url: `${tableName}/${!form.value.id ? "save" : "update"}`,
              method: 'post',
              data: form.value
            }).then(async res => {
              context?.$toolUtil.message(`操作成功`, 'success');
              history.back();
            });
          }
        }
      });
    };
    //修改跨表数据
    const changeCrossData = (row, key) => {
      if (type.value == 'cross') {
        let data = row;
        if (key) {
          //如果有指定key，则只更新key属性
          data = {
            id: row.id
          };
          data[key] = row[key];
        }
        context?.$http({
          url: `${crossTable.value}/update`,
          method: 'post',
          data: data
        }).then(res => {});
      }
    };
    (0,runtime_core_esm_bundler/* onMounted */.bv)(() => {
      type.value = route.query.type ? route.query.type : 'add';
      let row = null;
      let table = null;
      let statusColumnName = null;
      let tips = null;
      let statusColumnValue = null;
      if (type.value == 'cross') {
        row = context?.$toolUtil.storageGet('crossObj') ? JSON.parse(context?.$toolUtil.storageGet('crossObj')) : {};
        table = context?.$toolUtil.storageGet('crossTable');
        statusColumnName = context?.$toolUtil.storageGet('crossStatusColumnName');
        tips = context?.$toolUtil.storageGet('crossTips');
        statusColumnValue = context?.$toolUtil.storageGet('crossStatusColumnValue');
      }
      init(route.query.id ? route.query.id : null, type.value, '', row, table, statusColumnName, tips, statusColumnValue);
    });
    (0,runtime_core_esm_bundler/* onUnmounted */.Ah)(() => {
      Object.keys(localStorage).map(item => {
        if (item.startsWith('cross')) {
          localStorage.removeItem(item);
        }
      });
    });
    return (_ctx, _cache) => {
      const _component_el_breadcrumb_item = (0,runtime_core_esm_bundler/* resolveComponent */.up)("el-breadcrumb-item");
      const _component_el_breadcrumb = (0,runtime_core_esm_bundler/* resolveComponent */.up)("el-breadcrumb");
      const _component_el_input = (0,runtime_core_esm_bundler/* resolveComponent */.up)("el-input");
      const _component_el_form_item = (0,runtime_core_esm_bundler/* resolveComponent */.up)("el-form-item");
      const _component_el_col = (0,runtime_core_esm_bundler/* resolveComponent */.up)("el-col");
      const _component_el_option = (0,runtime_core_esm_bundler/* resolveComponent */.up)("el-option");
      const _component_el_select = (0,runtime_core_esm_bundler/* resolveComponent */.up)("el-select");
      const _component_uploads = (0,runtime_core_esm_bundler/* resolveComponent */.up)("uploads");
      const _component_editor = (0,runtime_core_esm_bundler/* resolveComponent */.up)("editor");
      const _component_el_row = (0,runtime_core_esm_bundler/* resolveComponent */.up)("el-row");
      const _component_el_button = (0,runtime_core_esm_bundler/* resolveComponent */.up)("el-button");
      const _component_el_form = (0,runtime_core_esm_bundler/* resolveComponent */.up)("el-form");
      return (0,runtime_core_esm_bundler/* openBlock */.wg)(), (0,runtime_core_esm_bundler/* createElementBlock */.iD)("div", _hoisted_1, [(0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_2, [(0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_3, [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_breadcrumb, {
        separator: ">",
        class: "breadcrumb"
      }, {
        default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_breadcrumb_item, {
          class: "first_breadcrumb",
          to: {
            path: '/'
          }
        }, {
          default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => _cache[13] || (_cache[13] = [(0,runtime_core_esm_bundler/* createTextVNode */.Uk)("首页", -1)])),
          _: 1,
          __: [13]
        }), ((0,runtime_core_esm_bundler/* openBlock */.wg)(true), (0,runtime_core_esm_bundler/* createElementBlock */.iD)(runtime_core_esm_bundler/* Fragment */.HY, null, (0,runtime_core_esm_bundler/* renderList */.Ko)(breadList.value, (item, index) => {
          return (0,runtime_core_esm_bundler/* openBlock */.wg)(), (0,runtime_core_esm_bundler/* createBlock */.j4)(_component_el_breadcrumb_item, {
            class: "second_breadcrumb",
            key: index
          }, {
            default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createTextVNode */.Uk)((0,shared_esm_bundler/* toDisplayString */.zw)(item.name), 1)]),
            _: 2
          }, 1024);
        }), 128))]),
        _: 1
      })])]), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_form, {
        ref_key: "formRef",
        ref: formRef,
        model: form.value,
        class: "add_form",
        "label-width": "120px",
        rules: rules.value
      }, {
        default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_row, null, {
          default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_col, {
            span: 12
          }, {
            default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_form_item, {
              label: "商品名称",
              prop: "shangpinmingcheng"
            }, {
              default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_input, {
                class: "list_inp",
                modelValue: form.value.shangpinmingcheng,
                "onUpdate:modelValue": _cache[0] || (_cache[0] = $event => form.value.shangpinmingcheng = $event),
                placeholder: "商品名称",
                type: "text",
                readonly: !isAdd.value || disabledForm.value.shangpinmingcheng ? true : false
              }, null, 8, ["modelValue", "readonly"])]),
              _: 1
            })]),
            _: 1
          }), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_col, {
            span: 12
          }, {
            default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_form_item, {
              label: "商品类型",
              prop: "shangpinleixing"
            }, {
              default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_select, {
                class: "list_sel",
                disabled: !isAdd.value || disabledForm.value.shangpinleixing ? true : false,
                modelValue: form.value.shangpinleixing,
                "onUpdate:modelValue": _cache[1] || (_cache[1] = $event => form.value.shangpinleixing = $event),
                placeholder: "请选择商品类型",
                style: {
                  "width": "100%"
                }
              }, {
                default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [((0,runtime_core_esm_bundler/* openBlock */.wg)(true), (0,runtime_core_esm_bundler/* createElementBlock */.iD)(runtime_core_esm_bundler/* Fragment */.HY, null, (0,runtime_core_esm_bundler/* renderList */.Ko)(shangpinleixingLists.value, (item, index) => {
                  return (0,runtime_core_esm_bundler/* openBlock */.wg)(), (0,runtime_core_esm_bundler/* createBlock */.j4)(_component_el_option, {
                    label: item,
                    value: item
                  }, null, 8, ["label", "value"]);
                }), 256))]),
                _: 1
              }, 8, ["disabled", "modelValue"])]),
              _: 1
            })]),
            _: 1
          }), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_col, {
            span: 12
          }, {
            default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_form_item, {
              label: "商品图片",
              prop: "shangpintupian"
            }, {
              default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_uploads, {
                disabled: !isAdd.value || disabledForm.value.shangpintupian ? true : false,
                action: "file/upload",
                tip: "请上传商品图片",
                style: {
                  "width": "100%",
                  "text-align": "left"
                },
                fileUrls: form.value.shangpintupian ? form.value.shangpintupian : '',
                onChange: shangpintupianUploadSuccess
              }, null, 8, ["disabled", "fileUrls"])]),
              _: 1
            })]),
            _: 1
          }), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_col, {
            span: 12
          }, {
            default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_form_item, {
              label: "动漫品牌",
              prop: "dongmanpinpai"
            }, {
              default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_input, {
                class: "list_inp",
                modelValue: form.value.dongmanpinpai,
                "onUpdate:modelValue": _cache[2] || (_cache[2] = $event => form.value.dongmanpinpai = $event),
                placeholder: "动漫品牌",
                type: "text",
                readonly: !isAdd.value || disabledForm.value.dongmanpinpai ? true : false
              }, null, 8, ["modelValue", "readonly"])]),
              _: 1
            })]),
            _: 1
          }), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_col, {
            span: 12
          }, {
            default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_form_item, {
              label: "动漫IP",
              prop: "dongmanip"
            }, {
              default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_input, {
                class: "list_inp",
                modelValue: form.value.dongmanip,
                "onUpdate:modelValue": _cache[3] || (_cache[3] = $event => form.value.dongmanip = $event),
                placeholder: "动漫IP",
                type: "text",
                readonly: !isAdd.value || disabledForm.value.dongmanip ? true : false
              }, null, 8, ["modelValue", "readonly"])]),
              _: 1
            })]),
            _: 1
          }), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_col, {
            span: 12
          }, {
            default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_form_item, {
              label: "规格",
              prop: "guige"
            }, {
              default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_input, {
                class: "list_inp",
                modelValue: form.value.guige,
                "onUpdate:modelValue": _cache[4] || (_cache[4] = $event => form.value.guige = $event),
                placeholder: "规格",
                type: "text",
                readonly: !isAdd.value || disabledForm.value.guige ? true : false
              }, null, 8, ["modelValue", "readonly"])]),
              _: 1
            })]),
            _: 1
          }), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_col, {
            span: 12
          }, {
            default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_form_item, {
              label: "动漫材质",
              prop: "dongmancaizhi"
            }, {
              default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_input, {
                class: "list_inp",
                modelValue: form.value.dongmancaizhi,
                "onUpdate:modelValue": _cache[5] || (_cache[5] = $event => form.value.dongmancaizhi = $event),
                placeholder: "动漫材质",
                type: "text",
                readonly: !isAdd.value || disabledForm.value.dongmancaizhi ? true : false
              }, null, 8, ["modelValue", "readonly"])]),
              _: 1
            })]),
            _: 1
          }), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_col, {
            span: 12
          }, {
            default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_form_item, {
              label: "评分",
              prop: "score"
            }, {
              default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_input, {
                class: "list_inp",
                modelValue: form.value.score,
                "onUpdate:modelValue": _cache[6] || (_cache[6] = $event => form.value.score = $event),
                modelModifiers: {
                  number: true
                },
                placeholder: "评分",
                type: "number",
                readonly: !isAdd.value || disabledForm.value.score ? true : false
              }, null, 8, ["modelValue", "readonly"])]),
              _: 1
            })]),
            _: 1
          }), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_col, {
            span: 12
          }, {
            default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_form_item, {
              label: "单限",
              prop: "onelimittimes"
            }, {
              default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_input, {
                class: "list_inp",
                modelValue: form.value.onelimittimes,
                "onUpdate:modelValue": _cache[7] || (_cache[7] = $event => form.value.onelimittimes = $event),
                modelModifiers: {
                  number: true
                },
                placeholder: "单限",
                type: "text",
                readonly: !isAdd.value || disabledForm.value.onelimittimes ? true : false
              }, null, 8, ["modelValue", "readonly"])]),
              _: 1
            })]),
            _: 1
          }), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_col, {
            span: 12
          }, {
            default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_form_item, {
              label: "库存",
              prop: "alllimittimes"
            }, {
              default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_input, {
                class: "list_inp",
                modelValue: form.value.alllimittimes,
                "onUpdate:modelValue": _cache[8] || (_cache[8] = $event => form.value.alllimittimes = $event),
                modelModifiers: {
                  number: true
                },
                placeholder: "库存",
                type: "text",
                readonly: !isAdd.value || disabledForm.value.alllimittimes ? true : false
              }, null, 8, ["modelValue", "readonly"])]),
              _: 1
            })]),
            _: 1
          }), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_col, {
            span: 12
          }, {
            default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_form_item, {
              label: "价格",
              prop: "price"
            }, {
              default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_input, {
                class: "list_inp",
                modelValue: form.value.price,
                "onUpdate:modelValue": _cache[9] || (_cache[9] = $event => form.value.price = $event),
                modelModifiers: {
                  number: true
                },
                placeholder: "价格",
                type: "number",
                readonly: !isAdd.value || disabledForm.value.price ? true : false
              }, null, 8, ["modelValue", "readonly"])]),
              _: 1
            })]),
            _: 1
          }), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_col, {
            span: 12
          }, {
            default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_form_item, {
              label: "商家账号",
              prop: "shangjiazhanghao"
            }, {
              default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_input, {
                class: "list_inp",
                modelValue: form.value.shangjiazhanghao,
                "onUpdate:modelValue": _cache[10] || (_cache[10] = $event => form.value.shangjiazhanghao = $event),
                placeholder: "商家账号",
                type: "text",
                readonly: !isAdd.value || disabledForm.value.shangjiazhanghao ? true : false
              }, null, 8, ["modelValue", "readonly"])]),
              _: 1
            })]),
            _: 1
          }), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_col, {
            span: 12
          }, {
            default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_form_item, {
              label: "商家名称",
              prop: "shangjiamingcheng"
            }, {
              default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_input, {
                class: "list_inp",
                modelValue: form.value.shangjiamingcheng,
                "onUpdate:modelValue": _cache[11] || (_cache[11] = $event => form.value.shangjiamingcheng = $event),
                placeholder: "商家名称",
                type: "text",
                readonly: !isAdd.value || disabledForm.value.shangjiamingcheng ? true : false
              }, null, 8, ["modelValue", "readonly"])]),
              _: 1
            })]),
            _: 1
          }), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_col, {
            span: 24
          }, {
            default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_form_item, {
              label: "商品详情",
              prop: "shangpinxiangqing"
            }, {
              default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [((0,runtime_core_esm_bundler/* openBlock */.wg)(), (0,runtime_core_esm_bundler/* createBlock */.j4)(_component_editor, {
                class: "list_editor",
                value: form.value.shangpinxiangqing,
                placeholder: "请输入商品详情",
                readonly: !isAdd.value || disabledForm.value.shangpinxiangqing ? true : false,
                key: !isAdd.value,
                onChange: _cache[12] || (_cache[12] = e => editorChange(e, 'shangpinxiangqing'))
              }, null, 8, ["value", "readonly"]))]),
              _: 1
            })]),
            _: 1
          })]),
          _: 1
        }), (0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_4, [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_button, {
          class: "formModel_cancel",
          onClick: backClick
        }, {
          default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => _cache[14] || (_cache[14] = [(0,runtime_core_esm_bundler/* createTextVNode */.Uk)("取消", -1)])),
          _: 1,
          __: [14]
        }), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_button, {
          class: "formModel_confirm",
          onClick: save,
          type: "success"
        }, {
          default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => _cache[15] || (_cache[15] = [(0,runtime_core_esm_bundler/* createTextVNode */.Uk)(" 保存 ", -1)])),
          _: 1,
          __: [15]
        })])]),
        _: 1
      }, 8, ["model", "rules"])]);
    };
  }
});
;// CONCATENATED MODULE: ./src/views/pages/dongmanshangpin/formAdd.vue?vue&type=script&setup=true&lang=js
 
;// CONCATENATED MODULE: ../../../../../../../node_modules_front/4/node_modules/mini-css-extract-plugin/dist/loader.js??clonedRuleSet-22.use[0]!../../../../../../../node_modules_front/4/node_modules/css-loader/dist/cjs.js??clonedRuleSet-22.use[1]!../../../../../../../node_modules_front/4/node_modules/vue-loader/dist/stylePostLoader.js!../../../../../../../node_modules_front/4/node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-22.use[2]!../../../../../../../node_modules_front/4/node_modules/sass-loader/dist/cjs.js??clonedRuleSet-22.use[3]!../../../../../../../node_modules_front/4/node_modules/vue-loader/dist/index.js??ruleSet[0].use[0]!./src/views/pages/dongmanshangpin/formAdd.vue?vue&type=style&index=0&id=6f5adbed&lang=scss&scoped=true
// extracted by mini-css-extract-plugin

;// CONCATENATED MODULE: ./src/views/pages/dongmanshangpin/formAdd.vue?vue&type=style&index=0&id=6f5adbed&lang=scss&scoped=true

;// CONCATENATED MODULE: ../../../../../../../node_modules_front/4/node_modules/mini-css-extract-plugin/dist/loader.js??clonedRuleSet-22.use[0]!../../../../../../../node_modules_front/4/node_modules/css-loader/dist/cjs.js??clonedRuleSet-22.use[1]!../../../../../../../node_modules_front/4/node_modules/vue-loader/dist/stylePostLoader.js!../../../../../../../node_modules_front/4/node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-22.use[2]!../../../../../../../node_modules_front/4/node_modules/sass-loader/dist/cjs.js??clonedRuleSet-22.use[3]!../../../../../../../node_modules_front/4/node_modules/vue-loader/dist/index.js??ruleSet[0].use[0]!./src/views/pages/dongmanshangpin/formAdd.vue?vue&type=style&index=1&id=6f5adbed&lang=scss
// extracted by mini-css-extract-plugin

;// CONCATENATED MODULE: ./src/views/pages/dongmanshangpin/formAdd.vue?vue&type=style&index=1&id=6f5adbed&lang=scss

// EXTERNAL MODULE: ../../../../../../../node_modules_front/4/node_modules/vue-loader/dist/exportHelper.js
var exportHelper = __webpack_require__(8574);
;// CONCATENATED MODULE: ./src/views/pages/dongmanshangpin/formAdd.vue



;



const __exports__ = /*#__PURE__*/(0,exportHelper/* default */.Z)(formAddvue_type_script_setup_true_lang_js, [['__scopeId',"data-v-6f5adbed"]])

/* harmony default export */ var formAdd = (__exports__);

/***/ })

}]);
//# sourceMappingURL=5306.39c4b19e.js.map