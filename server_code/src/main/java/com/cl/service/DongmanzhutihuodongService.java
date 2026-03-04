package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.DongmanzhutihuodongEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.DongmanzhutihuodongView;


/**
 * 动漫主题活动
 *
 * @author 
 * @email 
 * @date 2025-12-15 17:24:22
 */
public interface DongmanzhutihuodongService extends IService<DongmanzhutihuodongEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<DongmanzhutihuodongView> selectListView(Wrapper<DongmanzhutihuodongEntity> wrapper);
   	
   	DongmanzhutihuodongView selectView(@Param("ew") Wrapper<DongmanzhutihuodongEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<DongmanzhutihuodongEntity> wrapper);
   	
   
}

