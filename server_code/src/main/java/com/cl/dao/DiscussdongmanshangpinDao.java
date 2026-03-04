package com.cl.dao;

import com.cl.entity.DiscussdongmanshangpinEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.DiscussdongmanshangpinView;


/**
 * 动漫商品评论表
 * 
 * @author 
 * @email 
 * @date 2025-12-15 17:24:22
 */
public interface DiscussdongmanshangpinDao extends BaseMapper<DiscussdongmanshangpinEntity> {
	
	List<DiscussdongmanshangpinView> selectListView(@Param("ew") Wrapper<DiscussdongmanshangpinEntity> wrapper);

	List<DiscussdongmanshangpinView> selectListView(Pagination page,@Param("ew") Wrapper<DiscussdongmanshangpinEntity> wrapper);
	
	DiscussdongmanshangpinView selectView(@Param("ew") Wrapper<DiscussdongmanshangpinEntity> wrapper);


}
