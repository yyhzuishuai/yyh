"use strict";
(self["webpackChunkvue3_nf0"] = self["webpackChunkvue3_nf0"] || []).push([[6287],{

/***/ 6287:
/***/ (function(__unused_webpack_module, __webpack_exports__, __webpack_require__) {

// ESM COMPAT FLAG
__webpack_require__.r(__webpack_exports__);

// EXPORTS
__webpack_require__.d(__webpack_exports__, {
  "default": function() { return /* binding */ cart; }
});

// EXTERNAL MODULE: ../../../../../../../node_modules_front/4/node_modules/@vue/runtime-core/dist/runtime-core.esm-bundler.js
var runtime_core_esm_bundler = __webpack_require__(9171);
// EXTERNAL MODULE: ../../../../../../../node_modules_front/4/node_modules/@vue/shared/dist/shared.esm-bundler.js
var shared_esm_bundler = __webpack_require__(3972);
// EXTERNAL MODULE: ../../../../../../../node_modules_front/4/node_modules/@vue/runtime-dom/dist/runtime-dom.esm-bundler.js
var runtime_dom_esm_bundler = __webpack_require__(8693);
// EXTERNAL MODULE: ../../../../../../../node_modules_front/4/node_modules/@vue/reactivity/dist/reactivity.esm-bundler.js
var reactivity_esm_bundler = __webpack_require__(7387);
// EXTERNAL MODULE: ../../../../../../../node_modules_front/4/node_modules/vue-router/dist/vue-router.esm-bundler.js
var vue_router_esm_bundler = __webpack_require__(2984);
// EXTERNAL MODULE: ../../../../../../../node_modules_front/4/node_modules/vuex/dist/vuex.esm-bundler.js + 5 modules
var vuex_esm_bundler = __webpack_require__(7191);
;// CONCATENATED MODULE: ../../../../../../../node_modules_front/4/node_modules/thread-loader/dist/cjs.js!../../../../../../../node_modules_front/4/node_modules/babel-loader/lib/index.js??clonedRuleSet-40.use[1]!../../../../../../../node_modules_front/4/node_modules/vue-loader/dist/index.js??ruleSet[0].use[0]!./src/views/pages/shop_order/cart.vue?vue&type=script&setup=true&lang=js

const _hoisted_1 = {
  class: "cart-page"
};
const _hoisted_2 = {
  class: "breadcrumb-wrapper",
  style: {
    "width": "100%"
  }
};
const _hoisted_3 = {
  class: "back_view"
};
const _hoisted_4 = ["src"];
const _hoisted_5 = {
  class: "cart_confirm"
};
const _hoisted_6 = {
  class: "cart_price"
};
const _hoisted_7 = {
  class: "number"
};



const tableName = 'cart';
const formName = '购物车';
/* harmony default export */ var cartvue_type_script_setup_true_lang_js = ({
  __name: 'cart',
  setup(__props) {
    const store = (0,vuex_esm_bundler/* useStore */.oR)();
    const user = (0,runtime_core_esm_bundler/* computed */.Fl)(() => store.getters['user/session']);
    const context = (0,runtime_core_esm_bundler/* getCurrentInstance */.FN)()?.appContext.config.globalProperties;
    const router = (0,vue_router_esm_bundler/* useRouter */.tv)();
    const route = (0,vue_router_esm_bundler/* useRoute */.yj)();
    //基础信息
    const table = (0,reactivity_esm_bundler/* ref */.iH)(null);
    const selRows = (0,reactivity_esm_bundler/* ref */.iH)([]);
    const list = (0,reactivity_esm_bundler/* ref */.iH)([]);
    const listLoading = (0,reactivity_esm_bundler/* ref */.iH)(false);
    const listQuery = (0,reactivity_esm_bundler/* ref */.iH)({
      page: 1,
      limit: 20,
      userid: context?.$toolUtil.storageGet('userid')
    });
    //基础信息
    //判断是否从个人中心跳转
    const centerType = (0,reactivity_esm_bundler/* ref */.iH)(false);
    //返回
    const backClick = () => {
      if (centerType.value) {
        history.back();
      } else {
        router.push(`/index/${context?.$toolUtil.storageGet('frontSessionTable')}Center`);
      }
    };

    //获取列表
    const getList = () => {
      listLoading.value = true;
      context?.$http({
        url: 'cart/list',
        method: 'get',
        params: listQuery.value
      }).then(res => {
        listLoading.value = false;
        list.value = res.data.data.list;
        list.value.forEach(item => {
          item.realPrice = item.price;
        });
      });
    };
    //跳转商品详情
    const detailClick = row => {
      router.push(`/index/${row.tablename}Detail?id=${row.goodid}`);
    };
    //多选
    const handleSelectionChange = e => {
      selRows.value = e;
    };
    //单击选中某行
    const listChange = row => {
      (0,runtime_core_esm_bundler/* nextTick */.Y3)(() => {
        table.value.clearSelection();
        table.value.toggleRowSelection(row);
      });
    };
    //移除购物车
    const delClick = (id = null) => {
      if (id) {
        ElMessageBox.confirm(`是否删除选中${formName}`, '提示', {
          confirmButtonText: '是',
          cancelButtonText: '否',
          type: 'warning'
        }).then(() => {
          context?.$http({
            url: 'cart/delete',
            method: 'post',
            data: [id]
          }).then(res => {
            context?.$toolUtil.message('删除成功', 'success', () => {
              getList();
            });
          });
        }).catch(_ => {});
      }
    };
    const numberChange = row => {
      context?.$http({
        url: `${row.tablename}/detail/${row.goodid}`,
        method: 'get'
      }).then(res => {
        if (res.data.data.onelimittimes && res.data.data.onelimittimes > 0 && row.buynumber > res.data.data.onelimittimes) {
          row.buynumber = res.data.data.onelimittimes;
          context?.$toolUtil.message(`每人单次只能购买${res.data.data.onelimittimes}件`, 'error');
          return false;
        }
        context?.$http({
          url: `cart/update`,
          method: 'post',
          data: row
        }).then(obj => {});
      });
    };
    //统计总价
    const allPrice = () => {
      let price = 0;
      for (let x in selRows.value) {
        price += Number(selRows.value[x].realPrice * selRows.value[x].buynumber);
      }
      return Number(price).toFixed(2);
    };
    const payClick = async () => {
      if (selRows.value.length) {
        let data = [];
        for (let x in selRows.value) {
          let res = await context?.$http({
            url: `${selRows.value[x].tablename}/detail/${selRows.value[x].goodid}`,
            method: 'get'
          });
          if (selRows.value[x].buynumber > res.data.data.alllimittimes) {
            context?.$toolUtil.message(`${selRows.value[x].goodname}库存不足`, 'error');
            return false;
          }
          if (x == selRows.value.length - 1) {
            confirmOrder();
          }
        }
      } else {
        context?.$toolUtil.message('请选择需要购买的商品', 'error');
      }
    };
    const confirmOrder = () => {
      context?.$toolUtil.storageSet('orders_good', JSON.stringify(selRows.value));
      router.push('/index/order_confirm');
    };
    //初始化
    const init = () => {
      if (route.query.centerType) {
        centerType.value = true;
      }
      getList();
    };
    init();
    return (_ctx, _cache) => {
      const _component_el_button = (0,runtime_core_esm_bundler/* resolveComponent */.up)("el-button");
      const _component_el_table_column = (0,runtime_core_esm_bundler/* resolveComponent */.up)("el-table-column");
      const _component_el_input_number = (0,runtime_core_esm_bundler/* resolveComponent */.up)("el-input-number");
      const _component_el_table = (0,runtime_core_esm_bundler/* resolveComponent */.up)("el-table");
      const _directive_loading = (0,runtime_core_esm_bundler/* resolveDirective */.Q2)("loading");
      return (0,runtime_core_esm_bundler/* openBlock */.wg)(), (0,runtime_core_esm_bundler/* createElementBlock */.iD)("div", _hoisted_1, [(0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_2, [(0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_3, [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_button, {
        class: "back_btn",
        onClick: backClick
      }, {
        default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => _cache[1] || (_cache[1] = [(0,runtime_core_esm_bundler/* createTextVNode */.Uk)("返回", -1)])),
        _: 1,
        __: [1]
      })])]), (0,runtime_core_esm_bundler/* createElementVNode */._)("div", {
        class: "section_title"
      }, [(0,runtime_core_esm_bundler/* createElementVNode */._)("span", null, (0,shared_esm_bundler/* toDisplayString */.zw)(formName))]), _cache[9] || (_cache[9] = (0,runtime_core_esm_bundler/* createElementVNode */._)("br", null, null, -1)), (0,runtime_core_esm_bundler/* withDirectives */.wy)(((0,runtime_core_esm_bundler/* openBlock */.wg)(), (0,runtime_core_esm_bundler/* createBlock */.j4)(_component_el_table, {
        data: list.value,
        onSelectionChange: handleSelectionChange,
        ref_key: "table",
        ref: table,
        stripe: false,
        onRowClick: listChange
      }, {
        default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_table_column, {
          type: "selection",
          width: "55",
          resizable: false,
          align: "center",
          "header-align": "center"
        }), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_table_column, {
          label: "商品名称",
          resizable: false,
          align: "center",
          "header-align": "center"
        }, {
          default: (0,runtime_core_esm_bundler/* withCtx */.w5)(scope => [(0,runtime_core_esm_bundler/* createTextVNode */.Uk)((0,shared_esm_bundler/* toDisplayString */.zw)(scope.row.goodname), 1)]),
          _: 1
        }), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_table_column, {
          label: "商品图片",
          resizable: false,
          align: "center",
          "header-align": "center"
        }, {
          default: (0,runtime_core_esm_bundler/* withCtx */.w5)(scope => [(0,runtime_core_esm_bundler/* createElementVNode */._)("img", {
            src: scope.row.picture ? (scope.row.picture.startsWith('http') ? '' : _ctx.$config.url) + scope.row.picture : '',
            alt: "",
            style: {
              "width": "150px",
              "height": "150px"
            }
          }, null, 8, _hoisted_4)]),
          _: 1
        }), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_table_column, {
          label: "价格",
          resizable: false,
          align: "center",
          "header-align": "center"
        }, {
          default: (0,runtime_core_esm_bundler/* withCtx */.w5)(scope => [_cache[2] || (_cache[2] = (0,runtime_core_esm_bundler/* createElementVNode */._)("span", {
            style: {
              "font-size": "12px"
            }
          }, "￥", -1)), (0,runtime_core_esm_bundler/* createTextVNode */.Uk)((0,shared_esm_bundler/* toDisplayString */.zw)(scope.row.realPrice), 1)]),
          _: 1
        }), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_table_column, {
          label: "数量",
          resizable: false,
          align: "center",
          "header-align": "center"
        }, {
          default: (0,runtime_core_esm_bundler/* withCtx */.w5)(scope => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_input_number, {
            modelValue: scope.row.buynumber,
            "onUpdate:modelValue": $event => scope.row.buynumber = $event,
            min: 1,
            onChange: $event => numberChange(scope.row),
            onClick: _cache[0] || (_cache[0] = (0,runtime_dom_esm_bundler/* withModifiers */.iM)(() => {}, ["stop"]))
          }, null, 8, ["modelValue", "onUpdate:modelValue", "onChange"])]),
          _: 1
        }), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_table_column, {
          label: "总价",
          resizable: false,
          align: "center",
          "header-align": "center"
        }, {
          default: (0,runtime_core_esm_bundler/* withCtx */.w5)(scope => [_cache[3] || (_cache[3] = (0,runtime_core_esm_bundler/* createElementVNode */._)("span", {
            style: {
              "font-size": "12px"
            }
          }, "￥", -1)), (0,runtime_core_esm_bundler/* createTextVNode */.Uk)((0,shared_esm_bundler/* toDisplayString */.zw)((scope.row.realPrice * scope.row.buynumber).toFixed(2)), 1)]),
          _: 1
        }), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_table_column, {
          label: "操作",
          "class-name": "operation-cell",
          resizable: false,
          align: "center",
          "header-align": "center"
        }, {
          default: (0,runtime_core_esm_bundler/* withCtx */.w5)(scope => [(0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_button, {
            class: "view_btn",
            type: "primary",
            onClick: $event => detailClick(scope.row)
          }, {
            default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => _cache[4] || (_cache[4] = [(0,runtime_core_esm_bundler/* createTextVNode */.Uk)("查看详情", -1)])),
            _: 2,
            __: [4]
          }, 1032, ["onClick"]), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_button, {
            class: "del_btn",
            type: "danger",
            onClick: $event => delClick(scope.row.id)
          }, {
            default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => _cache[5] || (_cache[5] = [(0,runtime_core_esm_bundler/* createTextVNode */.Uk)("删除", -1)])),
            _: 2,
            __: [5]
          }, 1032, ["onClick"])]),
          _: 1
        })]),
        _: 1
      }, 8, ["data"])), [[_directive_loading, listLoading.value]]), _cache[10] || (_cache[10] = (0,runtime_core_esm_bundler/* createElementVNode */._)("br", null, null, -1)), (0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_5, [(0,runtime_core_esm_bundler/* createElementVNode */._)("div", _hoisted_6, [_cache[6] || (_cache[6] = (0,runtime_core_esm_bundler/* createTextVNode */.Uk)(" 总价：", -1)), _cache[7] || (_cache[7] = (0,runtime_core_esm_bundler/* createElementVNode */._)("span", {
        class: "unit"
      }, "￥", -1)), (0,runtime_core_esm_bundler/* createElementVNode */._)("span", _hoisted_7, (0,shared_esm_bundler/* toDisplayString */.zw)(allPrice()), 1)]), (0,runtime_core_esm_bundler/* createVNode */.Wm)(_component_el_button, {
        class: "confirm_btn",
        onClick: payClick,
        type: "success"
      }, {
        default: (0,runtime_core_esm_bundler/* withCtx */.w5)(() => _cache[8] || (_cache[8] = [(0,runtime_core_esm_bundler/* createTextVNode */.Uk)("提交订单", -1)])),
        _: 1,
        __: [8]
      })])]);
    };
  }
});
;// CONCATENATED MODULE: ./src/views/pages/shop_order/cart.vue?vue&type=script&setup=true&lang=js
 
;// CONCATENATED MODULE: ../../../../../../../node_modules_front/4/node_modules/mini-css-extract-plugin/dist/loader.js??clonedRuleSet-22.use[0]!../../../../../../../node_modules_front/4/node_modules/css-loader/dist/cjs.js??clonedRuleSet-22.use[1]!../../../../../../../node_modules_front/4/node_modules/vue-loader/dist/stylePostLoader.js!../../../../../../../node_modules_front/4/node_modules/postcss-loader/dist/cjs.js??clonedRuleSet-22.use[2]!../../../../../../../node_modules_front/4/node_modules/sass-loader/dist/cjs.js??clonedRuleSet-22.use[3]!../../../../../../../node_modules_front/4/node_modules/vue-loader/dist/index.js??ruleSet[0].use[0]!./src/views/pages/shop_order/cart.vue?vue&type=style&index=0&id=08e44a3a&lang=scss
// extracted by mini-css-extract-plugin

;// CONCATENATED MODULE: ./src/views/pages/shop_order/cart.vue?vue&type=style&index=0&id=08e44a3a&lang=scss

;// CONCATENATED MODULE: ./src/views/pages/shop_order/cart.vue



;

const __exports__ = cartvue_type_script_setup_true_lang_js;

/* harmony default export */ var cart = (__exports__);

/***/ })

}]);
//# sourceMappingURL=6287.f993859b.js.map