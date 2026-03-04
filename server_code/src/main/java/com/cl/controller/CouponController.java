package com.cl.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import java.util.*;
import java.lang.*;
import java.math.*;
import java.util.stream.Collectors;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;

import com.cl.utils.*;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.cl.annotation.IgnoreAuth;
import com.cl.annotation.SysLog;

import com.cl.entity.CouponEntity;
import com.cl.entity.view.CouponView;

import com.cl.service.CouponService;
import com.cl.service.TokenService;

/**
 * 优惠券
 * 后端接口
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
@RestController
@RequestMapping("/coupon")
public class CouponController {
    @Autowired
    private CouponService couponService;









    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,CouponEntity coupon,
                                                                                                                                                                HttpServletRequest request){
                    String tableName = request.getSession().getAttribute("tableName").toString();
                                                                                                                                                                                                                                                                            if(tableName.equals("shangjia")) {
                    coupon.setShangjiazhanghao((String)request.getSession().getAttribute("username"));
                                    }
                                        else {
                        if(!request.getSession().getAttribute("role").toString().equals("管理员")) {
                            coupon.setUserid((Long)request.getSession().getAttribute("userId"));
                        }
                    }
                                                                EntityWrapper<CouponEntity> ew = new EntityWrapper<CouponEntity>();
                                                                                                                                                                                                                                                    
        
        
        PageUtils page = couponService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, coupon), params), params));
        Map<String, String> deSens = new HashMap<>();
                                                                                                                                                                                                    //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }







    /**
     * 前端列表
     */
	@IgnoreAuth
    @RequestMapping("/list")
    public R list(@RequestParam Map<String, Object> params,CouponEntity coupon,
		HttpServletRequest request){
        EntityWrapper<CouponEntity> ew = new EntityWrapper<CouponEntity>();

		PageUtils page = couponService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, coupon), params), params));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( CouponEntity coupon){
       	EntityWrapper<CouponEntity> ew = new EntityWrapper<CouponEntity>();
      	ew.allEq(MPUtil.allEQMapPre( coupon, MPUtil.camelToSnake("coupon")));
        return R.ok().put("data", couponService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(CouponEntity coupon){
        EntityWrapper< CouponEntity> ew = new EntityWrapper< CouponEntity>();
 		ew.allEq(MPUtil.allEQMapPre( coupon, MPUtil.camelToSnake("coupon")));
		CouponView couponView =  couponService.selectView(ew);
		return R.ok("查询优惠券成功").put("data", couponView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        CouponEntity coupon = couponService.selectById(id);
		coupon = couponService.selectView(new EntityWrapper<CouponEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(coupon,deSens);
        return R.ok().put("data", coupon);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        CouponEntity coupon = couponService.selectById(id);
		coupon = couponService.selectView(new EntityWrapper<CouponEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(coupon,deSens);
        return R.ok().put("data", coupon);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    @SysLog("新增优惠券")
    public R save(@RequestBody CouponEntity coupon, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(coupon);
    	coupon.setUserid((Long)request.getSession().getAttribute("userId"));
        couponService.insert(coupon);
        return R.ok().put("data",coupon.getId());
    }
    
    /**
     * 前端保存
     */
    @SysLog("新增优惠券")
    @RequestMapping("/add")
    public R add(@RequestBody CouponEntity coupon, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(coupon);
        couponService.insert(coupon);
        return R.ok();
    }


    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    @SysLog("修改优惠券")
    public R update(@RequestBody CouponEntity coupon, HttpServletRequest request){
        //ValidatorUtils.validateEntity(coupon);
        couponService.updateById(coupon);//全部更新
        return R.ok();
    }



    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @SysLog("删除优惠券")
    public R delete(@RequestBody Long[] ids){
        couponService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }

    	








}
