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

import com.cl.entity.DingzhidingdanEntity;
import com.cl.entity.view.DingzhidingdanView;

import com.cl.service.DingzhidingdanService;
import com.cl.service.TokenService;

/**
 * 定制订单
 * 后端接口
 * @author 
 * @email 
 * @date 2025-12-15 17:24:22
 */
@RestController
@RequestMapping("/dingzhidingdan")
public class DingzhidingdanController {
    @Autowired
    private DingzhidingdanService dingzhidingdanService;









    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,DingzhidingdanEntity dingzhidingdan,
                                                                                                                                                                                                                HttpServletRequest request){
                    String tableName = request.getSession().getAttribute("tableName").toString();
                                                                                                                                                                                                                                                                            if(tableName.equals("shangjia")) {
                    dingzhidingdan.setShangjiazhanghao((String)request.getSession().getAttribute("username"));
                                    }
                                                                                                            if(tableName.equals("yonghu")) {
                    dingzhidingdan.setYonghuzhanghao((String)request.getSession().getAttribute("username"));
                                    }
                                                                                                                        EntityWrapper<DingzhidingdanEntity> ew = new EntityWrapper<DingzhidingdanEntity>();
                                                                                                                                                                                                                                                                                                                                    
        
        
        PageUtils page = dingzhidingdanService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, dingzhidingdan), params), params));
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
    public R list(@RequestParam Map<String, Object> params,DingzhidingdanEntity dingzhidingdan,
		HttpServletRequest request){
        EntityWrapper<DingzhidingdanEntity> ew = new EntityWrapper<DingzhidingdanEntity>();

		PageUtils page = dingzhidingdanService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, dingzhidingdan), params), params));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( DingzhidingdanEntity dingzhidingdan){
       	EntityWrapper<DingzhidingdanEntity> ew = new EntityWrapper<DingzhidingdanEntity>();
      	ew.allEq(MPUtil.allEQMapPre( dingzhidingdan, MPUtil.camelToSnake("dingzhidingdan")));
        return R.ok().put("data", dingzhidingdanService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(DingzhidingdanEntity dingzhidingdan){
        EntityWrapper< DingzhidingdanEntity> ew = new EntityWrapper< DingzhidingdanEntity>();
 		ew.allEq(MPUtil.allEQMapPre( dingzhidingdan, MPUtil.camelToSnake("dingzhidingdan")));
		DingzhidingdanView dingzhidingdanView =  dingzhidingdanService.selectView(ew);
		return R.ok("查询定制订单成功").put("data", dingzhidingdanView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        DingzhidingdanEntity dingzhidingdan = dingzhidingdanService.selectById(id);
		dingzhidingdan = dingzhidingdanService.selectView(new EntityWrapper<DingzhidingdanEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(dingzhidingdan,deSens);
        return R.ok().put("data", dingzhidingdan);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        DingzhidingdanEntity dingzhidingdan = dingzhidingdanService.selectById(id);
		dingzhidingdan = dingzhidingdanService.selectView(new EntityWrapper<DingzhidingdanEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(dingzhidingdan,deSens);
        return R.ok().put("data", dingzhidingdan);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    @SysLog("新增定制订单")
    public R save(@RequestBody DingzhidingdanEntity dingzhidingdan, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(dingzhidingdan);
        dingzhidingdanService.insert(dingzhidingdan);
        return R.ok().put("data",dingzhidingdan.getId());
    }
    
    /**
     * 前端保存
     */
    @SysLog("新增定制订单")
    @RequestMapping("/add")
    public R add(@RequestBody DingzhidingdanEntity dingzhidingdan, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(dingzhidingdan);
        dingzhidingdanService.insert(dingzhidingdan);
        return R.ok();
    }


    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    @SysLog("修改定制订单")
    public R update(@RequestBody DingzhidingdanEntity dingzhidingdan, HttpServletRequest request){
        //ValidatorUtils.validateEntity(dingzhidingdan);
        dingzhidingdanService.updateById(dingzhidingdan);//全部更新
        return R.ok();
    }



    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @SysLog("删除定制订单")
    public R delete(@RequestBody Long[] ids){
        dingzhidingdanService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }

    	








}
