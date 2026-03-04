package com.cl.entity.view;

import com.cl.entity.DongmanshangpinEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;

import java.io.Serializable;
import com.cl.utils.EncryptUtil;
 

/**
 * 动漫商品
 * 后端返回视图实体辅助类   
 * （通常后端关联的表或者自定义的字段需要返回使用）
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
@TableName("dongmanshangpin")
public class DongmanshangpinView  extends DongmanshangpinEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public DongmanshangpinView(){
	}
 
 	public DongmanshangpinView(DongmanshangpinEntity dongmanshangpinEntity){
 	try {
			BeanUtils.copyProperties(this, dongmanshangpinEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		
	}



}
