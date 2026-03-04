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

import com.cl.entity.HuodongbaomingEntity;
import com.cl.entity.view.HuodongbaomingView;

import com.cl.service.HuodongbaomingService;
import com.cl.service.TokenService;

/**
 * 活动报名
 * 后端接口
 * @author 
 * @email 
 * @date 2025-12-15 17:24:22
 */
@RestController
@RequestMapping("/huodongbaoming")
public class HuodongbaomingController {
    @Autowired
    private HuodongbaomingService huodongbaomingService;









    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,HuodongbaomingEntity huodongbaoming,
                                                                                                                                                                                        HttpServletRequest request){
                    String tableName = request.getSession().getAttribute("tableName").toString();
                                                                                                                                                                                                                                                if(tableName.equals("yonghu")) {
                    huodongbaoming.setYonghuzhanghao((String)request.getSession().getAttribute("username"));
                                    }
                                                                                                                                                    EntityWrapper<HuodongbaomingEntity> ew = new EntityWrapper<HuodongbaomingEntity>();
                                                                                                                                                                                                                                                                                            
        
        
        PageUtils page = huodongbaomingService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, huodongbaoming), params), params));
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
    public R list(@RequestParam Map<String, Object> params,HuodongbaomingEntity huodongbaoming,
		HttpServletRequest request){
        EntityWrapper<HuodongbaomingEntity> ew = new EntityWrapper<HuodongbaomingEntity>();

		PageUtils page = huodongbaomingService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, huodongbaoming), params), params));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( HuodongbaomingEntity huodongbaoming){
       	EntityWrapper<HuodongbaomingEntity> ew = new EntityWrapper<HuodongbaomingEntity>();
      	ew.allEq(MPUtil.allEQMapPre( huodongbaoming, MPUtil.camelToSnake("huodongbaoming")));
        return R.ok().put("data", huodongbaomingService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(HuodongbaomingEntity huodongbaoming){
        EntityWrapper< HuodongbaomingEntity> ew = new EntityWrapper< HuodongbaomingEntity>();
 		ew.allEq(MPUtil.allEQMapPre( huodongbaoming, MPUtil.camelToSnake("huodongbaoming")));
		HuodongbaomingView huodongbaomingView =  huodongbaomingService.selectView(ew);
		return R.ok("查询活动报名成功").put("data", huodongbaomingView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        HuodongbaomingEntity huodongbaoming = huodongbaomingService.selectById(id);
		huodongbaoming = huodongbaomingService.selectView(new EntityWrapper<HuodongbaomingEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(huodongbaoming,deSens);
        return R.ok().put("data", huodongbaoming);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        HuodongbaomingEntity huodongbaoming = huodongbaomingService.selectById(id);
		huodongbaoming = huodongbaomingService.selectView(new EntityWrapper<HuodongbaomingEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(huodongbaoming,deSens);
        return R.ok().put("data", huodongbaoming);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    @SysLog("新增活动报名")
    public R save(@RequestBody HuodongbaomingEntity huodongbaoming, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(huodongbaoming);
        huodongbaomingService.insert(huodongbaoming);
        return R.ok().put("data",huodongbaoming.getId());
    }
    
    /**
     * 前端保存
     */
    @SysLog("新增活动报名")
    @RequestMapping("/add")
    public R add(@RequestBody HuodongbaomingEntity huodongbaoming, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(huodongbaoming);
        huodongbaomingService.insert(huodongbaoming);
        return R.ok();
    }


    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    @SysLog("修改活动报名")
    public R update(@RequestBody HuodongbaomingEntity huodongbaoming, HttpServletRequest request){
        //ValidatorUtils.validateEntity(huodongbaoming);
        huodongbaomingService.updateById(huodongbaoming);//全部更新
        return R.ok();
    }



    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @SysLog("删除活动报名")
    public R delete(@RequestBody Long[] ids){
        huodongbaomingService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }

    	








}
