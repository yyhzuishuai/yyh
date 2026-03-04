package com.cl.dao;

import com.cl.entity.ZhoubiandingzhiEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.ZhoubiandingzhiView;


/**
 * 周边定制
 * 
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
public interface ZhoubiandingzhiDao extends BaseMapper<ZhoubiandingzhiEntity> {
	
	List<ZhoubiandingzhiView> selectListView(@Param("ew") Wrapper<ZhoubiandingzhiEntity> wrapper);

	List<ZhoubiandingzhiView> selectListView(Pagination page,@Param("ew") Wrapper<ZhoubiandingzhiEntity> wrapper);
	
	ZhoubiandingzhiView selectView(@Param("ew") Wrapper<ZhoubiandingzhiEntity> wrapper);


}
