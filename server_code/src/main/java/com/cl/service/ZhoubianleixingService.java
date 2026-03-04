package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.ZhoubianleixingEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.ZhoubianleixingView;


/**
 * 周边类型
 *
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
public interface ZhoubianleixingService extends IService<ZhoubianleixingEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<ZhoubianleixingView> selectListView(Wrapper<ZhoubianleixingEntity> wrapper);
   	
   	ZhoubianleixingView selectView(@Param("ew") Wrapper<ZhoubianleixingEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<ZhoubianleixingEntity> wrapper);
   	
   
}

