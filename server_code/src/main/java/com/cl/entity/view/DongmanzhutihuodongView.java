package com.cl.entity.view;

import com.cl.entity.DongmanzhutihuodongEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;

import java.io.Serializable;
import com.cl.utils.EncryptUtil;
 

/**
 * 动漫主题活动
 * 后端返回视图实体辅助类   
 * （通常后端关联的表或者自定义的字段需要返回使用）
 * @author 
 * @email 
 * @date 2025-12-15 17:24:22
 */
@TableName("dongmanzhutihuodong")
public class DongmanzhutihuodongView  extends DongmanzhutihuodongEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public DongmanzhutihuodongView(){
	}
 
 	public DongmanzhutihuodongView(DongmanzhutihuodongEntity dongmanzhutihuodongEntity){
 	try {
			BeanUtils.copyProperties(this, dongmanzhutihuodongEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		
	}



}
