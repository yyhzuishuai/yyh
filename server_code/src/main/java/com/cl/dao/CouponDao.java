package com.cl.dao;

import com.cl.entity.CouponEntity;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import java.util.List;
import java.util.Map;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.pagination.Pagination;

import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.CouponView;


/**
 * 优惠券
 * 
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
public interface CouponDao extends BaseMapper<CouponEntity> {
	
	List<CouponView> selectListView(@Param("ew") Wrapper<CouponEntity> wrapper);

	List<CouponView> selectListView(Pagination page,@Param("ew") Wrapper<CouponEntity> wrapper);
	
	CouponView selectView(@Param("ew") Wrapper<CouponEntity> wrapper);


}
