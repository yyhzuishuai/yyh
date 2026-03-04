package com.cl.dao;

import com.cl.entity.MyCouponEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.MyCouponView;


/**
 * 我的优惠券
 * 
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
public interface MyCouponDao extends BaseMapper<MyCouponEntity> {
	
	List<MyCouponView> selectListView(@Param("ew") Wrapper<MyCouponEntity> wrapper);

	List<MyCouponView> selectListView(Pagination page,@Param("ew") Wrapper<MyCouponEntity> wrapper);
	
	MyCouponView selectView(@Param("ew") Wrapper<MyCouponEntity> wrapper);


}
