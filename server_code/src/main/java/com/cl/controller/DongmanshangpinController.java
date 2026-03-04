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

import com.cl.entity.DongmanshangpinEntity;
import com.cl.entity.view.DongmanshangpinView;

import com.cl.service.DongmanshangpinService;
import com.cl.service.TokenService;
import com.cl.service.StoreupService;
import com.cl.entity.StoreupEntity;

/**
 * 动漫商品
 * 后端接口
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
@RestController
@RequestMapping("/dongmanshangpin")
public class DongmanshangpinController {
    @Autowired
    private DongmanshangpinService dongmanshangpinService;

    @Autowired
    private StoreupService storeupService;








    /**
     * 后台列表
     */
    @RequestMapping("/page")
    public R page(@RequestParam Map<String, Object> params,DongmanshangpinEntity dongmanshangpin,
                                                                                                                                                                                                                                                                        @RequestParam(required = false) Double priceStart,
                    @RequestParam(required = false) Double priceEnd,
                                                                                                        HttpServletRequest request){
                    String tableName = request.getSession().getAttribute("tableName").toString();
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            if(tableName.equals("shangjia")) {
                    dongmanshangpin.setShangjiazhanghao((String)request.getSession().getAttribute("username"));
                                    }
                                                                                            EntityWrapper<DongmanshangpinEntity> ew = new EntityWrapper<DongmanshangpinEntity>();
                                                                                                                                                                                                                                                                                                                                                                                                                            if(priceStart!=null) ew.ge("price", priceStart);
                    if(priceEnd!=null) ew.le("price", priceEnd);
                                                                                                                                                            
        
        
        PageUtils page = dongmanshangpinService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, dongmanshangpin), params), params));
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
    public R list(@RequestParam Map<String, Object> params,DongmanshangpinEntity dongmanshangpin,
                @RequestParam(required = false) Double priceStart,
                @RequestParam(required = false) Double priceEnd,
		HttpServletRequest request){
        EntityWrapper<DongmanshangpinEntity> ew = new EntityWrapper<DongmanshangpinEntity>();
                if(priceStart!=null) ew.ge("price", priceStart);
                if(priceEnd!=null) ew.le("price", priceEnd);

		PageUtils page = dongmanshangpinService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, dongmanshangpin), params), params));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(page,deSens);
        return R.ok().put("data", page);
    }

	/**
     * 列表
     */
    @RequestMapping("/lists")
    public R list( DongmanshangpinEntity dongmanshangpin){
       	EntityWrapper<DongmanshangpinEntity> ew = new EntityWrapper<DongmanshangpinEntity>();
      	ew.allEq(MPUtil.allEQMapPre( dongmanshangpin, MPUtil.camelToSnake("dongmanshangpin")));
        return R.ok().put("data", dongmanshangpinService.selectListView(ew));
    }

	 /**
     * 查询
     */
    @RequestMapping("/query")
    public R query(DongmanshangpinEntity dongmanshangpin){
        EntityWrapper< DongmanshangpinEntity> ew = new EntityWrapper< DongmanshangpinEntity>();
 		ew.allEq(MPUtil.allEQMapPre( dongmanshangpin, MPUtil.camelToSnake("dongmanshangpin")));
		DongmanshangpinView dongmanshangpinView =  dongmanshangpinService.selectView(ew);
		return R.ok("查询动漫商品成功").put("data", dongmanshangpinView);
    }
	
    /**
     * 后端详情
     */
    @RequestMapping("/info/{id}")
    public R info(@PathVariable("id") Long id){
        DongmanshangpinEntity dongmanshangpin = dongmanshangpinService.selectById(id);
		dongmanshangpin.setClicktime(new Date());
		dongmanshangpinService.updateById(dongmanshangpin);
		dongmanshangpin = dongmanshangpinService.selectView(new EntityWrapper<DongmanshangpinEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(dongmanshangpin,deSens);
        return R.ok().put("data", dongmanshangpin);
    }

    /**
     * 前端详情
     */
	@IgnoreAuth
    @RequestMapping("/detail/{id}")
    public R detail(@PathVariable("id") Long id){
        DongmanshangpinEntity dongmanshangpin = dongmanshangpinService.selectById(id);
		dongmanshangpin.setClicktime(new Date());
		dongmanshangpinService.updateById(dongmanshangpin);
		dongmanshangpin = dongmanshangpinService.selectView(new EntityWrapper<DongmanshangpinEntity>().eq("id", id));
        Map<String, String> deSens = new HashMap<>();
        //给需要脱敏的字段脱敏
        DeSensUtil.desensitize(dongmanshangpin,deSens);
        return R.ok().put("data", dongmanshangpin);
    }
    


    /**
     * 赞或踩
     */
    @RequestMapping("/thumbsup/{id}")
    public R vote(@PathVariable("id") String id,String type){
        DongmanshangpinEntity dongmanshangpin = dongmanshangpinService.selectById(id);
        if(type.equals("1")) {
        	dongmanshangpin.setThumbsupNumber(dongmanshangpin.getThumbsupNumber()+1);
        } else {
        	dongmanshangpin.setCrazilyNumber(dongmanshangpin.getCrazilyNumber()+1);
        }
        dongmanshangpinService.updateById(dongmanshangpin);
        return R.ok("投票成功");
    }

    /**
     * 后端保存
     */
    @RequestMapping("/save")
    @SysLog("新增动漫商品")
    public R save(@RequestBody DongmanshangpinEntity dongmanshangpin, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(dongmanshangpin);
        dongmanshangpinService.insert(dongmanshangpin);
        return R.ok().put("data",dongmanshangpin.getId());
    }
    
    /**
     * 前端保存
     */
    @SysLog("新增动漫商品")
    @RequestMapping("/add")
    public R add(@RequestBody DongmanshangpinEntity dongmanshangpin, HttpServletRequest request){
    	//ValidatorUtils.validateEntity(dongmanshangpin);
        dongmanshangpinService.insert(dongmanshangpin);
        return R.ok();
    }


    /**
     * 修改
     */
    @RequestMapping("/update")
    @Transactional
    @SysLog("修改动漫商品")
    public R update(@RequestBody DongmanshangpinEntity dongmanshangpin, HttpServletRequest request){
        //ValidatorUtils.validateEntity(dongmanshangpin);
        dongmanshangpinService.updateById(dongmanshangpin);//全部更新
        return R.ok();
    }

    /**
     * 审核
     */
    @RequestMapping("/shBatch")
    @Transactional
    @SysLog("审核动漫商品")
    public R update(@RequestBody Long[] ids, @RequestParam String sfsh, @RequestParam String shhf){
        List<DongmanshangpinEntity> list = new ArrayList<DongmanshangpinEntity>();
        for(Long id : ids) {
            DongmanshangpinEntity dongmanshangpin = dongmanshangpinService.selectById(id);
            dongmanshangpin.setSfsh(sfsh);
            dongmanshangpin.setShhf(shhf);
            list.add(dongmanshangpin);
        }
        dongmanshangpinService.updateBatchById(list);
        return R.ok();
    }


    

    /**
     * 删除
     */
    @RequestMapping("/delete")
    @SysLog("删除动漫商品")
    public R delete(@RequestBody Long[] ids){
        dongmanshangpinService.deleteBatchIds(Arrays.asList(ids));
        return R.ok();
    }

    	
	/**
     * 前端智能排序
     */
	@IgnoreAuth
    @RequestMapping("/autoSort")
    public R autoSort(@RequestParam Map<String, Object> params,DongmanshangpinEntity dongmanshangpin, HttpServletRequest request,String pre){
        EntityWrapper<DongmanshangpinEntity> ew = new EntityWrapper<DongmanshangpinEntity>();
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
		PageUtils page = dongmanshangpinService.queryPage(params, MPUtil.sort(MPUtil.between(MPUtil.likeOrEq(ew, dongmanshangpin), params), params));
        return R.ok().put("data", page);
    }








}
