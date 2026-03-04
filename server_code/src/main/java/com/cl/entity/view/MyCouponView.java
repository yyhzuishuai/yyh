package com.cl.entity.view;

import com.cl.entity.MyCouponEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;

import java.io.Serializable;
import com.cl.utils.EncryptUtil;
 

/**
 * 我的优惠券
 * 后端返回视图实体辅助类   
 * （通常后端关联的表或者自定义的字段需要返回使用）
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
@TableName("my_coupon")
public class MyCouponView  extends MyCouponEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public MyCouponView(){
	}
 
 	public MyCouponView(MyCouponEntity myCouponEntity){
 	try {
			BeanUtils.copyProperties(this, myCouponEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		
	}



}
