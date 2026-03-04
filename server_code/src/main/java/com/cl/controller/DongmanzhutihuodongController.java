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

import com.cl.entity.DongmanzhutihuodongEntity;
import com.cl.entity.view.DongmanzhutihuodongView;

import com.cl.service.DongmanzhutihuodongService;
import com.cl.service.TokenService;

/**
 * 动漫主题活动
 * 后端接口
 * @author 
 * @email 
 * @date 2025-12-15 17:24:22
 */
@RestController
@RequestMapping("/dongmanzhutihuodong")
public class DongmanzhutihuodongController {
    @Autowired
    private DongmanzhutihuodongService dongmanzhutihuodongService;









    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,DongmanzhutihuodongEntity dongmanzhutihuodong,
                                                                                                                                                                    HttpServletRequest request){
                                    EntityWrapper<DongmanzhutihuodongEntity> ew = new EntityWrapper<DongmanzhutihuodongEntity>();
                                                                                                                                                                                                                                                                
        
        
        PageUtils page = dongmanzhutihuodongService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, dongmanzhutihuodong), params), params));
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
    public R list(@RequestParam Map<String, Object> params,DongmanzhutihuodongEntity dongmanzhutihuodong,
		HttpServletRequest request){
        EntityWrapper<DongmanzhutihuodongEntity> ew = new EntityWrapper<DongmanzhutihuodongEntity>();

		PageUtils page = dongmanzhutihuodongService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, dongmanzhutihuodong), params), params));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( DongmanzhutihuodongEntity dongmanzhutihuodong){
       	EntityWrapper<DongmanzhutihuodongEntity> ew = new EntityWrapper<DongmanzhutihuodongEntity>();
      	ew.allEq(MPUtil.allEQMapPre( dongmanzhutihuodong, MPUtil.camelToSnake("dongmanzhutihuodong")));
        return R.ok().put("data", dongmanzhutihuodongService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(DongmanzhutihuodongEntity dongmanzhutihuodong){
        EntityWrapper< DongmanzhutihuodongEntity> ew = new EntityWrapper< DongmanzhutihuodongEntity>();
 		ew.allEq(MPUtil.allEQMapPre( dongmanzhutihuodong, MPUtil.camelToSnake("dongmanzhutihuodong")));
		DongmanzhutihuodongView dongmanzhutihuodongView =  dongmanzhutihuodongService.selectView(ew);
		return R.ok("查询动漫主题活动成功").put("data", dongmanzhutihuodongView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        DongmanzhutihuodongEntity dongmanzhutihuodong = dongmanzhutihuodongService.selectById(id);
		dongmanzhutihuodong = dongmanzhutihuodongService.selectView(new EntityWrapper<DongmanzhutihuodongEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(dongmanzhutihuodong,deSens);
        return R.ok().put("data", dongmanzhutihuodong);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        DongmanzhutihuodongEntity dongmanzhutihuodong = dongmanzhutihuodongService.selectById(id);
		dongmanzhutihuodong = dongmanzhutihuodongService.selectView(new EntityWrapper<DongmanzhutihuodongEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(dongmanzhutihuodong,deSens);
        return R.ok().put("data", dongmanzhutihuodong);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    @SysLog("新增动漫主题活动")
    public R save(@RequestBody DongmanzhutihuodongEntity dongmanzhutihuodong, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(dongmanzhutihuodong);
        dongmanzhutihuodongService.insert(dongmanzhutihuodong);
        return R.ok().put("data",dongmanzhutihuodong.getId());
    }
    
    /**
     * 前端保存
     */
    @SysLog("新增动漫主题活动")
    @RequestMapping("/add")
    public R add(@RequestBody DongmanzhutihuodongEntity dongmanzhutihuodong, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(dongmanzhutihuodong);
        dongmanzhutihuodongService.insert(dongmanzhutihuodong);
        return R.ok();
    }


    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    @SysLog("修改动漫主题活动")
    public R update(@RequestBody DongmanzhutihuodongEntity dongmanzhutihuodong, HttpServletRequest request){
        //ValidatorUtils.validateEntity(dongmanzhutihuodong);
        dongmanzhutihuodongService.updateById(dongmanzhutihuodong);//全部更新
        return R.ok();
    }



    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @SysLog("删除动漫主题活动")
    public R delete(@RequestBody Long[] ids){
        dongmanzhutihuodongService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }

    	








}
