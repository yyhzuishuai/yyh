package com.cl.dao;

import com.cl.entity.DongmanshangpinEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.DongmanshangpinView;


/**
 * 动漫商品
 * 
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
public interface DongmanshangpinDao extends BaseMapper<DongmanshangpinEntity> {
	
	List<DongmanshangpinView> selectListView(@Param("ew") Wrapper<DongmanshangpinEntity> wrapper);

	List<DongmanshangpinView> selectListView(Pagination page,@Param("ew") Wrapper<DongmanshangpinEntity> wrapper);
	
	DongmanshangpinView selectView(@Param("ew") Wrapper<DongmanshangpinEntity> wrapper);


}
