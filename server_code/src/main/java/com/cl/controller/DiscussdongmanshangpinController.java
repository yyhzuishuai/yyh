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

import com.cl.entity.DiscussdongmanshangpinEntity;
import com.cl.entity.view.DiscussdongmanshangpinView;

import com.cl.service.DiscussdongmanshangpinService;
import com.cl.service.TokenService;

/**
 * 动漫商品评论表
 * 后端接口
 * @author 
 * @email 
 * @date 2025-12-15 17:24:22
 */
@RestController
@RequestMapping("/discussdongmanshangpin")
public class DiscussdongmanshangpinController {
    @Autowired
    private DiscussdongmanshangpinService discussdongmanshangpinService;









    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,DiscussdongmanshangpinEntity discussdongmanshangpin,
                                                                                                                                                                                                    HttpServletRequest request){
                                    EntityWrapper<DiscussdongmanshangpinEntity> ew = new EntityWrapper<DiscussdongmanshangpinEntity>();
                                                                                                                                                                                                                                                                                                                
        
        
        PageUtils page = discussdongmanshangpinService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, discussdongmanshangpin), params), params));
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
    public R list(@RequestParam Map<String, Object> params,DiscussdongmanshangpinEntity discussdongmanshangpin,
		HttpServletRequest request){
        EntityWrapper<DiscussdongmanshangpinEntity> ew = new EntityWrapper<DiscussdongmanshangpinEntity>();

		PageUtils page = discussdongmanshangpinService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, discussdongmanshangpin), params), params));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( DiscussdongmanshangpinEntity discussdongmanshangpin){
       	EntityWrapper<DiscussdongmanshangpinEntity> ew = new EntityWrapper<DiscussdongmanshangpinEntity>();
      	ew.allEq(MPUtil.allEQMapPre( discussdongmanshangpin, MPUtil.camelToSnake("discussdongmanshangpin")));
        return R.ok().put("data", discussdongmanshangpinService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(DiscussdongmanshangpinEntity discussdongmanshangpin){
        EntityWrapper< DiscussdongmanshangpinEntity> ew = new EntityWrapper< DiscussdongmanshangpinEntity>();
 		ew.allEq(MPUtil.allEQMapPre( discussdongmanshangpin, MPUtil.camelToSnake("discussdongmanshangpin")));
		DiscussdongmanshangpinView discussdongmanshangpinView =  discussdongmanshangpinService.selectView(ew);
		return R.ok("查询动漫商品评论表成功").put("data", discussdongmanshangpinView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        DiscussdongmanshangpinEntity discussdongmanshangpin = discussdongmanshangpinService.selectById(id);
		discussdongmanshangpin = discussdongmanshangpinService.selectView(new EntityWrapper<DiscussdongmanshangpinEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(discussdongmanshangpin,deSens);
        return R.ok().put("data", discussdongmanshangpin);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        DiscussdongmanshangpinEntity discussdongmanshangpin = discussdongmanshangpinService.selectById(id);
		discussdongmanshangpin = discussdongmanshangpinService.selectView(new EntityWrapper<DiscussdongmanshangpinEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(discussdongmanshangpin,deSens);
        return R.ok().put("data", discussdongmanshangpin);
    }
    



    /**
     * 后端保存
     */
    @RequestMapping("/save")
    @SysLog("新增动漫商品评论表")
    public R save(@RequestBody DiscussdongmanshangpinEntity discussdongmanshangpin, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(discussdongmanshangpin);
        discussdongmanshangpinService.insert(discussdongmanshangpin);
        return R.ok().put("data",discussdongmanshangpin.getId());
    }
    
    /**
     * 前端保存
     */
    @SysLog("新增动漫商品评论表")
    @RequestMapping("/add")
    public R add(@RequestBody DiscussdongmanshangpinEntity discussdongmanshangpin, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(discussdongmanshangpin);
        discussdongmanshangpinService.insert(discussdongmanshangpin);
        return R.ok();
    }
     /**
     * 获取用户密保
     */
    @RequestMapping("/security")
    @IgnoreAuth
    public R security(@RequestParam String username){
        DiscussdongmanshangpinEntity discussdongmanshangpin = discussdongmanshangpinService.selectOne(new EntityWrapper<DiscussdongmanshangpinEntity>().eq("", username));
        return R.ok().put("data", discussdongmanshangpin);
    }


    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    @IgnoreAuth
    public R update(@RequestBody DiscussdongmanshangpinEntity discussdongmanshangpin, HttpServletRequest request){
        //ValidatorUtils.validateEntity(discussdongmanshangpin);
        discussdongmanshangpinService.updateById(discussdongmanshangpin);//全部更新
        return R.ok();
    }



    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @SysLog("删除动漫商品评论表")
    public R delete(@RequestBody Long[] ids){
        discussdongmanshangpinService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }

    	
	/**
     * 前端智能排序
     */
	@IgnoreAuth
    @RequestMapping("/autoSort")
    public R autoSort(@RequestParam Map<String, Object> params,DiscussdongmanshangpinEntity discussdongmanshangpin, HttpServletRequest request,String pre){
        EntityWrapper<DiscussdongmanshangpinEntity> ew = new EntityWrapper<DiscussdongmanshangpinEntity>();
        Map<String, Object> newMap = new HashMap<String, Object>();
        Map<String, Object> param = new HashMap<String, Object>();
		Iterator<Map.Entry<String, Object>> it = param.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry<String, Object> entry = it.next();
			String key = entry.getKey();
			String newKey = entry.getKey();
			if (pre.endsWith(".")) {
				newMap.put(pre + newKey, entry.getValue());
			} else if (StringUtils.isEmpty(pre)) {
				newMap.put(newKey, entry.getValue());
			} else {
				newMap.put(pre + "." + newKey, entry.getValue());
			}
		}
		params.put("sort", "clicktime");
        params.put("order", "desc");
		PageUtils page = discussdongmanshangpinService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, discussdongmanshangpin), params), params));
        return R.ok().put("data", page);
    }








}
