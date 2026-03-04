package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.ZhoubiandingzhiEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.ZhoubiandingzhiView;


/**
 * 周边定制
 *
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
public interface ZhoubiandingzhiService extends IService<ZhoubiandingzhiEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<ZhoubiandingzhiView> selectListView(Wrapper<ZhoubiandingzhiEntity> wrapper);
   	
   	ZhoubiandingzhiView selectView(@Param("ew") Wrapper<ZhoubiandingzhiEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<ZhoubiandingzhiEntity> wrapper);
   	
   
}

