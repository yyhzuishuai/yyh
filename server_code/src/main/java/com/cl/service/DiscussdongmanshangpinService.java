package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.DiscussdongmanshangpinEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.DiscussdongmanshangpinView;


/**
 * 动漫商品评论表
 *
 * @author 
 * @email 
 * @date 2025-12-15 17:24:22
 */
public interface DiscussdongmanshangpinService extends IService<DiscussdongmanshangpinEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<DiscussdongmanshangpinView> selectListView(Wrapper<DiscussdongmanshangpinEntity> wrapper);
   	
   	DiscussdongmanshangpinView selectView(@Param("ew") Wrapper<DiscussdongmanshangpinEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<DiscussdongmanshangpinEntity> wrapper);
   	
   
}

