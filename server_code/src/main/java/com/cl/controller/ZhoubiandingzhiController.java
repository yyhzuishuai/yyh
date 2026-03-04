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

import com.cl.entity.ZhoubiandingzhiEntity;
import com.cl.entity.view.ZhoubiandingzhiView;

import com.cl.service.ZhoubiandingzhiService;
import com.cl.service.TokenService;

/**
 * 周边定制
 * 后端接口
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
@RestController
@RequestMapping("/zhoubiandingzhi")
public class ZhoubiandingzhiController {
    @Autowired
    private ZhoubiandingzhiService zhoubiandingzhiService;









    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,ZhoubiandingzhiEntity zhoubiandingzhi,
                                                                                            HttpServletRequest request){
                    String tableName = request.getSession().getAttribute("tableName").toString();
                                            if(tableName.equals("shangjia")) {
                    zhoubiandingzhi.setShangjiazhanghao((String)request.getSession().getAttribute("username"));
                                    }
                                                                                                                                                                                EntityWrapper<ZhoubiandingzhiEntity> ew = new EntityWrapper<ZhoubiandingzhiEntity>();
                                                                                                                                        
        
        
        PageUtils page = zhoubiandingzhiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, zhoubiandingzhi), params), params));
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
    public R list(@RequestParam Map<String, Object> params,ZhoubiandingzhiEntity zhoubiandingzhi,
		HttpServletRequest request){
        EntityWrapper<ZhoubiandingzhiEntity> ew = new EntityWrapper<ZhoubiandingzhiEntity>();

		PageUtils page = zhoubiandingzhiService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, zhoubiandingzhi), params), params));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( ZhoubiandingzhiEntity zhoubiandingzhi){
       	EntityWrapper<ZhoubiandingzhiEntity> ew = new EntityWrapper<ZhoubiandingzhiEntity>();
      	ew.allEq(MPUtil.allEQMapPre( zhoubiandingzhi, MPUtil.camelToSnake("zhoubiandingzhi")));
        return R.ok().put("data", zhoubiandingzhiService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(ZhoubiandingzhiEntity zhoubiandingzhi){
        EntityWrapper< ZhoubiandingzhiEntity> ew = new EntityWrapper< ZhoubiandingzhiEntity>();
 		ew.allEq(MPUtil.allEQMapPre( zhoubiandingzhi, MPUtil.camelToSnake("zhoubiandingzhi")));
		ZhoubiandingzhiView zhoubiandingzhiView =  zhoubiandingzhiService.selectView(ew);
		return R.ok("查询周边定制成功").put("data", zhoubiandingzhiView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        ZhoubiandingzhiEntity zhoubiandingzhi = zhoubiandingzhiService.selectById(id);
		zhoubiandingzhi = zhoubiandingzhiService.selectView(new EntityWrapper<ZhoubiandingzhiEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(zhoubiandingzhi,deSens);
        return R.ok().put("data", zhoubiandingzhi);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        ZhoubiandingzhiEntity zhoubiandingzhi = zhoubiandingzhiService.selectById(id);
		zhoubiandingzhi = zhoubiandingzhiService.selectView(new EntityWrapper<ZhoubiandingzhiEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(zhoubiandingzhi,deSens);
        return R.ok().put("data", zhoubiandingzhi);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    @SysLog("新增周边定制")
    public R save(@RequestBody ZhoubiandingzhiEntity zhoubiandingzhi, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(zhoubiandingzhi);
        zhoubiandingzhiService.insert(zhoubiandingzhi);
        return R.ok().put("data",zhoubiandingzhi.getId());
    }
    
    /**
     * 前端保存
     */
    @SysLog("新增周边定制")
    @RequestMapping("/add")
    public R add(@RequestBody ZhoubiandingzhiEntity zhoubiandingzhi, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(zhoubiandingzhi);
        zhoubiandingzhiService.insert(zhoubiandingzhi);
        return R.ok();
    }


    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    @SysLog("修改周边定制")
    public R update(@RequestBody ZhoubiandingzhiEntity zhoubiandingzhi, HttpServletRequest request){
        //ValidatorUtils.validateEntity(zhoubiandingzhi);
        zhoubiandingzhiService.updateById(zhoubiandingzhi);//全部更新
        return R.ok();
    }



    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @SysLog("删除周边定制")
    public R delete(@RequestBody Long[] ids){
        zhoubiandingzhiService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }

    	








}
