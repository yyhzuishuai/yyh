package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.MyCouponEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.MyCouponView;


/**
 * 我的优惠券
 *
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
public interface MyCouponService extends IService<MyCouponEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<MyCouponView> selectListView(Wrapper<MyCouponEntity> wrapper);
   	
   	MyCouponView selectView(@Param("ew") Wrapper<MyCouponEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<MyCouponEntity> wrapper);
   	
   
}

