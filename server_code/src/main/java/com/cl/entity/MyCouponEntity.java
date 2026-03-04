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
 * 我的优惠券
 * 数据库通用操作实体类（普通增删改查）
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
@TableName("my_coupon")
public class MyCouponEntity<T> implements Serializable {
	private static final long serialVersionUID = 1L;


	public MyCouponEntity() {
		
	}
	
	public MyCouponEntity(T t) {
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
	 * 优惠券id
	 */
					
	private Long couponId;
	
	/**
	 * 优惠券名称
	 */
					
	private String couponName;
	
	/**
	 * 券编号
	 */
					
	private String couponNumber;
	
	/**
	 * 优惠券类型
	 */
					
	private String couponType;
	
	/**
	 * 满额
	 */
					
	private Double fullAmount;
	
	/**
	 * 优惠额
	 */
					
	private Double discountAmount;
	
	/**
	 * 生效时间
	 */
				
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat 		
	private Date effectTime;
	
	/**
	 * 过期时间
	 */
				
	@JsonFormat(locale="zh", timezone="GMT+8", pattern="yyyy-MM-dd HH:mm:ss")
	@DateTimeFormat 		
	private Date expireTime;
	
	/**
	 * 备注
	 */
					
	private String remark;
	
	/**
	 * 使用状态
	 */
					
	private String status;
	
	/**
	 * 用户id
	 */
					
	private Long userid;
	
	/**
	 * 商户名称
	 */
					
	private String shangjiazhanghao;
	

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
	 * 设置：优惠券id
	 */
	public void setCouponId(Long couponId) {
		this.couponId = couponId;
	}
	/**
	 * 获取：优惠券id
	 */
	public Long getCouponId() {
		return couponId;
	}
	/**
	 * 设置：优惠券名称
	 */
	public void setCouponName(String couponName) {
		this.couponName = couponName;
	}
	/**
	 * 获取：优惠券名称
	 */
	public String getCouponName() {
		return couponName;
	}
	/**
	 * 设置：券编号
	 */
	public void setCouponNumber(String couponNumber) {
		this.couponNumber = couponNumber;
	}
	/**
	 * 获取：券编号
	 */
	public String getCouponNumber() {
		return couponNumber;
	}
	/**
	 * 设置：优惠券类型
	 */
	public void setCouponType(String couponType) {
		this.couponType = couponType;
	}
	/**
	 * 获取：优惠券类型
	 */
	public String getCouponType() {
		return couponType;
	}
	/**
	 * 设置：满额
	 */
	public void setFullAmount(Double fullAmount) {
		this.fullAmount = fullAmount;
	}
	/**
	 * 获取：满额
	 */
	public Double getFullAmount() {
		return fullAmount;
	}
	/**
	 * 设置：优惠额
	 */
	public void setDiscountAmount(Double discountAmount) {
		this.discountAmount = discountAmount;
	}
	/**
	 * 获取：优惠额
	 */
	public Double getDiscountAmount() {
		return discountAmount;
	}
	/**
	 * 设置：生效时间
	 */
	public void setEffectTime(Date effectTime) {
		this.effectTime = effectTime;
	}
	/**
	 * 获取：生效时间
	 */
	public Date getEffectTime() {
		return effectTime;
	}
	/**
	 * 设置：过期时间
	 */
	public void setExpireTime(Date expireTime) {
		this.expireTime = expireTime;
	}
	/**
	 * 获取：过期时间
	 */
	public Date getExpireTime() {
		return expireTime;
	}
	/**
	 * 设置：备注
	 */
	public void setRemark(String remark) {
		this.remark = remark;
	}
	/**
	 * 获取：备注
	 */
	public String getRemark() {
		return remark;
	}
	/**
	 * 设置：使用状态
	 */
	public void setStatus(String status) {
		this.status = status;
	}
	/**
	 * 获取：使用状态
	 */
	public String getStatus() {
		return status;
	}
	/**
	 * 设置：用户id
	 */
	public void setUserid(Long userid) {
		this.userid = userid;
	}
	/**
	 * 获取：用户id
	 */
	public Long getUserid() {
		return userid;
	}
	/**
	 * 设置：商户名称
	 */
	public void setShangjiazhanghao(String shangjiazhanghao) {
		this.shangjiazhanghao = shangjiazhanghao;
	}
	/**
	 * 获取：商户名称
	 */
	public String getShangjiazhanghao() {
		return shangjiazhanghao;
	}

}
