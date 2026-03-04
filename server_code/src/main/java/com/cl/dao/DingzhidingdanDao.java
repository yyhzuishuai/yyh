package com.cl.dao;

import com.cl.entity.DingzhidingdanEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.DingzhidingdanView;


/**
 * 定制订单
 * 
 * @author 
 * @email 
 * @date 2025-12-15 17:24:22
 */
public interface DingzhidingdanDao extends BaseMapper<DingzhidingdanEntity> {
	
	List<DingzhidingdanView> selectListView(@Param("ew") Wrapper<DingzhidingdanEntity> wrapper);

	List<DingzhidingdanView> selectListView(Pagination page,@Param("ew") Wrapper<DingzhidingdanEntity> wrapper);
	
	DingzhidingdanView selectView(@Param("ew") Wrapper<DingzhidingdanEntity> wrapper);


}
