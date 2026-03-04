package com.cl.entity.view;

import com.cl.entity.RechargeRecordEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;

import java.io.Serializable;
import com.cl.utils.EncryptUtil;
 

/**
 * 充值记录
 * 后端返回视图实体辅助类   
 * （通常后端关联的表或者自定义的字段需要返回使用）
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
@TableName("recharge_record")
public class RechargeRecordView  extends RechargeRecordEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public RechargeRecordView(){
	}
 
 	public RechargeRecordView(RechargeRecordEntity rechargeRecordEntity){
 	try {
			BeanUtils.copyProperties(this, rechargeRecordEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		
	}



}
