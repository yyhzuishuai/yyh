package com.cl.entity;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import java.lang.reflect.InvocationTargetException;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.apache.commons.beanutils.BeanUtils;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.enums.FieldFill;
import com.baomidou.mybatisplus.enums.IdType;


/**
 * 周边定制
 * 数据库通用操作实体类（普通增删改查）
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
@TableName("zhoubiandingzhi")
public class ZhoubiandingzhiEntity<T> implements Serializable {
	private static final long serialVersionUID = 1L;


	public ZhoubiandingzhiEntity() {
		
	}
	
	public ZhoubiandingzhiEntity(T t) {
		try {
			BeanUtils.copyProperties(this, t);
		} catch (IllegalAccessException | InvocationTargetException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 主键id
	 */
	@TableId(type = IdType.AUTO)
	private Long id;
	/**
	 * 商家账号
	 */
					
	private String shangjiazhanghao;
	
	/**
	 * 商家名称
	 */
					
	private String shangjiamingcheng;
	
	/**
	 * 样品展示
	 */
					
	private String yangpinzhanshi;
	
	/**
	 * 定制价格
	 */
					
	private Double dingzhijiage;
	
	/**
	 * 定制介绍
	 */
					
	private String dingzhijieshao;
	

	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat
	private Date addtime;

	public Date getAddtime() {
		return addtime;
	}
	public void setAddtime(Date addtime) {
		this.addtime = addtime;
	}
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}
	/**
	 * 设置：商家账号
	 */
	public void setShangjiazhanghao(String shangjiazhanghao) {
		this.shangjiazhanghao = shangjiazhanghao;
	}
	/**
	 * 获取：商家账号
	 */
	public String getShangjiazhanghao() {
		return shangjiazhanghao;
	}
	/**
	 * 设置：商家名称
	 */
	public void setShangjiamingcheng(String shangjiamingcheng) {
		this.shangjiamingcheng = shangjiamingcheng;
	}
	/**
	 * 获取：商家名称
	 */
	public String getShangjiamingcheng() {
		return shangjiamingcheng;
	}
	/**
	 * 设置：样品展示
	 */
	public void setYangpinzhanshi(String yangpinzhanshi) {
		this.yangpinzhanshi = yangpinzhanshi;
	}
	/**
	 * 获取：样品展示
	 */
	public String getYangpinzhanshi() {
		return yangpinzhanshi;
	}
	/**
	 * 设置：定制价格
	 */
	public void setDingzhijiage(Double dingzhijiage) {
		this.dingzhijiage = dingzhijiage;
	}
	/**
	 * 获取：定制价格
	 */
	public Double getDingzhijiage() {
		return dingzhijiage;
	}
	/**
	 * 设置：定制介绍
	 */
	public void setDingzhijieshao(String dingzhijieshao) {
		this.dingzhijieshao = dingzhijieshao;
	}
	/**
	 * 获取：定制介绍
	 */
	public String getDingzhijieshao() {
		return dingzhijieshao;
	}

}
