package com.cl.entity.view;

import com.cl.entity.ZhoubiandingzhiEntity;

import com.baomidou.mybatisplus.annotations.TableName;
import org.apache.commons.beanutils.BeanUtils;
import java.lang.reflect.InvocationTargetException;
import java.math.BigDecimal;

import java.io.Serializable;
import com.cl.utils.EncryptUtil;
 

/**
 * 周边定制
 * 后端返回视图实体辅助类   
 * （通常后端关联的表或者自定义的字段需要返回使用）
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
@TableName("zhoubiandingzhi")
public class ZhoubiandingzhiView  extends ZhoubiandingzhiEntity implements Serializable {
	private static final long serialVersionUID = 1L;

	public ZhoubiandingzhiView(){
	}
 
 	public ZhoubiandingzhiView(ZhoubiandingzhiEntity zhoubiandingzhiEntity){
 	try {
			BeanUtils.copyProperties(this, zhoubiandingzhiEntity);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
 		
	}



}
