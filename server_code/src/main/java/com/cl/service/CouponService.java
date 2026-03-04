package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.CouponEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.CouponView;


/**
 * 优惠券
 *
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
public interface CouponService extends IService<CouponEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<CouponView> selectListView(Wrapper<CouponEntity> wrapper);
   	
   	CouponView selectView(@Param("ew") Wrapper<CouponEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<CouponEntity> wrapper);
   	
   
}

