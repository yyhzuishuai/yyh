package com.cl.entity.view;

import com.cl.entity.ZhoubianleixingEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;

import java.io.Serializable;
import com.cl.utils.EncryptUtil;
 

/**
 * 周边类型
 * 后端返回视图实体辅助类   
 * （通常后端关联的表或者自定义的字段需要返回使用）
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
@TableName("zhoubianleixing")
public class ZhoubianleixingView  extends ZhoubianleixingEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public ZhoubianleixingView(){
	}
 
 	public ZhoubianleixingView(ZhoubianleixingEntity zhoubianleixingEntity){
 	try {
			BeanUtils.copyProperties(this, zhoubianleixingEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		
	}



}
