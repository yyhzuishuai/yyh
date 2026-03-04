package com.cl.dao;

import com.cl.entity.DongmanzhutihuodongEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.DongmanzhutihuodongView;


/**
 * 动漫主题活动
 * 
 * @author 
 * @email 
 * @date 2025-12-15 17:24:22
 */
public interface DongmanzhutihuodongDao extends BaseMapper<DongmanzhutihuodongEntity> {
	
	List<DongmanzhutihuodongView> selectListView(@Param("ew") Wrapper<DongmanzhutihuodongEntity> wrapper);

	List<DongmanzhutihuodongView> selectListView(Pagination page,@Param("ew") Wrapper<DongmanzhutihuodongEntity> wrapper);
	
	DongmanzhutihuodongView selectView(@Param("ew") Wrapper<DongmanzhutihuodongEntity> wrapper);


}
