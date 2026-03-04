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

import com.cl.entity.ZhoubianleixingEntity;
import com.cl.entity.view.ZhoubianleixingView;

import com.cl.service.ZhoubianleixingService;
import com.cl.service.TokenService;

/**
 * 周边类型
 * 后端接口
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
@RestController
@RequestMapping("/zhoubianleixing")
public class ZhoubianleixingController {
    @Autowired
    private ZhoubianleixingService zhoubianleixingService;









    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,ZhoubianleixingEntity zhoubianleixing,
                                            HttpServletRequest request){
                                    EntityWrapper<ZhoubianleixingEntity> ew = new EntityWrapper<ZhoubianleixingEntity>();
                                                        
        
        
        PageUtils page = zhoubianleixingService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, zhoubianleixing), params), params));
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
    public R list(@RequestParam Map<String, Object> params,ZhoubianleixingEntity zhoubianleixing,
		HttpServletRequest request){
        EntityWrapper<ZhoubianleixingEntity> ew = new EntityWrapper<ZhoubianleixingEntity>();

		PageUtils page = zhoubianleixingService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, zhoubianleixing), params), params));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( ZhoubianleixingEntity zhoubianleixing){
       	EntityWrapper<ZhoubianleixingEntity> ew = new EntityWrapper<ZhoubianleixingEntity>();
      	ew.allEq(MPUtil.allEQMapPre( zhoubianleixing, MPUtil.camelToSnake("zhoubianleixing")));
        return R.ok().put("data", zhoubianleixingService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(ZhoubianleixingEntity zhoubianleixing){
        EntityWrapper< ZhoubianleixingEntity> ew = new EntityWrapper< ZhoubianleixingEntity>();
 		ew.allEq(MPUtil.allEQMapPre( zhoubianleixing, MPUtil.camelToSnake("zhoubianleixing")));
		ZhoubianleixingView zhoubianleixingView =  zhoubianleixingService.selectView(ew);
		return R.ok("查询周边类型成功").put("data", zhoubianleixingView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        ZhoubianleixingEntity zhoubianleixing = zhoubianleixingService.selectById(id);
		zhoubianleixing = zhoubianleixingService.selectView(new EntityWrapper<ZhoubianleixingEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(zhoubianleixing,deSens);
        return R.ok().put("data", zhoubianleixing);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        ZhoubianleixingEntity zhoubianleixing = zhoubianleixingService.selectById(id);
		zhoubianleixing = zhoubianleixingService.selectView(new EntityWrapper<ZhoubianleixingEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(zhoubianleixing,deSens);
        return R.ok().put("data", zhoubianleixing);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    @SysLog("新增周边类型")
    public R save(@RequestBody ZhoubianleixingEntity zhoubianleixing, HttpServletRequest request){
        if(zhoubianleixingService.selectCount(new EntityWrapper<ZhoubianleixingEntity>().eq("zhoubianleixing", zhoubianleixing.getZhoubianleixing()))>0) {
            return R.error("周边类型已存在");
        }
    	//ValidatorUtils.validateEntity(zhoubianleixing);
        zhoubianleixingService.insert(zhoubianleixing);
        return R.ok().put("data",zhoubianleixing.getId());
    }
    
    /**
     * 前端保存
     */
    @SysLog("新增周边类型")
    @RequestMapping("/add")
    public R add(@RequestBody ZhoubianleixingEntity zhoubianleixing, HttpServletRequest request){
        if(zhoubianleixingService.selectCount(new EntityWrapper<ZhoubianleixingEntity>().eq("zhoubianleixing", zhoubianleixing.getZhoubianleixing()))>0) {
            return R.error("周边类型已存在");
        }
    	//ValidatorUtils.validateEntity(zhoubianleixing);
        zhoubianleixingService.insert(zhoubianleixing);
        return R.ok();
    }


    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    @SysLog("修改周边类型")
    public R update(@RequestBody ZhoubianleixingEntity zhoubianleixing, HttpServletRequest request){
        //ValidatorUtils.validateEntity(zhoubianleixing);
        zhoubianleixingService.updateById(zhoubianleixing);//全部更新
        return R.ok();
    }



    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @SysLog("删除周边类型")
    public R delete(@RequestBody Long[] ids){
        zhoubianleixingService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }

    	








}
