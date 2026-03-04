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
 * 定制订单
 * 数据库通用操作实体类（普通增删改查）
 * @author 
 * @email 
 * @date 2025-12-15 17:24:22
 */
@TableName("dingzhidingdan")
public class DingzhidingdanEntity<T> implements Serializable {
	private static final long serialVersionUID = 1L;


	public DingzhidingdanEntity() {
		
	}
	
	public DingzhidingdanEntity(T t) {
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
	 * 订单编号
	 */
					
	private String dingdanbianhao;
	
	/**
	 * 周边名称
	 */
					
	private String zhoubianmingcheng;
	
	/**
	 * 设计图案
	 */
					
	private String shejituan;
	
	/**
	 * 周边类型
	 */
					
	private String zhoubianleixing;
	
	/**
	 * 颜色
	 */
					
	private String yanse;
	
	/**
	 * 尺寸
	 */
					
	private String chicun;
	
	/**
	 * 材质
	 */
					
	private String caizhi;
	
	/**
	 * 设计描述
	 */
					
	private String shejimiaoshu;
	
	/**
	 * 商家账号
	 */
					
	private String shangjiazhanghao;
	
	/**
	 * 商家名称
	 */
					
	private String shangjiamingcheng;
	
	/**
	 * 用户账号
	 */
					
	private String yonghuzhanghao;
	
	/**
	 * 昵称
	 */
					
	private String nicheng;
	
	/**
	 * 是否支付
	 */
					
	private String ispay;
	

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
	 * 设置：订单编号
	 */
	public void setDingdanbianhao(String dingdanbianhao) {
		this.dingdanbianhao = dingdanbianhao;
	}
	/**
	 * 获取：订单编号
	 */
	public String getDingdanbianhao() {
		return dingdanbianhao;
	}
	/**
	 * 设置：周边名称
	 */
	public void setZhoubianmingcheng(String zhoubianmingcheng) {
		this.zhoubianmingcheng = zhoubianmingcheng;
	}
	/**
	 * 获取：周边名称
	 */
	public String getZhoubianmingcheng() {
		return zhoubianmingcheng;
	}
	/**
	 * 设置：设计图案
	 */
	public void setShejituan(String shejituan) {
		this.shejituan = shejituan;
	}
	/**
	 * 获取：设计图案
	 */
	public String getShejituan() {
		return shejituan;
	}
	/**
	 * 设置：周边类型
	 */
	public void setZhoubianleixing(String zhoubianleixing) {
		this.zhoubianleixing = zhoubianleixing;
	}
	/**
	 * 获取：周边类型
	 */
	public String getZhoubianleixing() {
		return zhoubianleixing;
	}
	/**
	 * 设置：颜色
	 */
	public void setYanse(String yanse) {
		this.yanse = yanse;
	}
	/**
	 * 获取：颜色
	 */
	public String getYanse() {
		return yanse;
	}
	/**
	 * 设置：尺寸
	 */
	public void setChicun(String chicun) {
		this.chicun = chicun;
	}
	/**
	 * 获取：尺寸
	 */
	public String getChicun() {
		return chicun;
	}
	/**
	 * 设置：材质
	 */
	public void setCaizhi(String caizhi) {
		this.caizhi = caizhi;
	}
	/**
	 * 获取：材质
	 */
	public String getCaizhi() {
		return caizhi;
	}
	/**
	 * 设置：设计描述
	 */
	public void setShejimiaoshu(String shejimiaoshu) {
		this.shejimiaoshu = shejimiaoshu;
	}
	/**
	 * 获取：设计描述
	 */
	public String getShejimiaoshu() {
		return shejimiaoshu;
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
	 * 设置：用户账号
	 */
	public void setYonghuzhanghao(String yonghuzhanghao) {
		this.yonghuzhanghao = yonghuzhanghao;
	}
	/**
	 * 获取：用户账号
	 */
	public String getYonghuzhanghao() {
		return yonghuzhanghao;
	}
	/**
	 * 设置：昵称
	 */
	public void setNicheng(String nicheng) {
		this.nicheng = nicheng;
	}
	/**
	 * 获取：昵称
	 */
	public String getNicheng() {
		return nicheng;
	}
	/**
	 * 设置：是否支付
	 */
	public void setIspay(String ispay) {
		this.ispay = ispay;
	}
	/**
	 * 获取：是否支付
	 */
	public String getIspay() {
		return ispay;
	}

}
