package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.DingzhidingdanEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.DingzhidingdanView;


/**
 * 定制订单
 *
 * @author 
 * @email 
 * @date 2025-12-15 17:24:22
 */
public interface DingzhidingdanService extends IService<DingzhidingdanEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<DingzhidingdanView> selectListView(Wrapper<DingzhidingdanEntity> wrapper);
   	
   	DingzhidingdanView selectView(@Param("ew") Wrapper<DingzhidingdanEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<DingzhidingdanEntity> wrapper);
   	
   
}

