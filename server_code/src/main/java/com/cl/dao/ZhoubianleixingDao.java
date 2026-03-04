package com.cl.dao;

import com.cl.entity.ZhoubianleixingEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.ZhoubianleixingView;


/**
 * 周边类型
 * 
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
public interface ZhoubianleixingDao extends BaseMapper<ZhoubianleixingEntity> {
	
	List<ZhoubianleixingView> selectListView(@Param("ew") Wrapper<ZhoubianleixingEntity> wrapper);

	List<ZhoubianleixingView> selectListView(Pagination page,@Param("ew") Wrapper<ZhoubianleixingEntity> wrapper);
	
	ZhoubianleixingView selectView(@Param("ew") Wrapper<ZhoubianleixingEntity> wrapper);


}
