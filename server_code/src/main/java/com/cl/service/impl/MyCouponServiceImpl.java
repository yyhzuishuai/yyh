package com.cl.service.impl;

import org.springframework.stereotype.Service;
import java.util.Map;
import java.util.List;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.cl.utils.PageUtils;
import com.cl.utils.Query;


import com.cl.dao.MyCouponDao;
import com.cl.entity.MyCouponEntity;
import com.cl.service.MyCouponService;
import com.cl.entity.view.MyCouponView;

@Service("myCouponService")
public class MyCouponServiceImpl extends ServiceImpl<MyCouponDao, MyCouponEntity> implements MyCouponService {

    	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<MyCouponEntity> page = this.selectPage(
                new Query<MyCouponEntity>(params).getPage(),
                new EntityWrapper<MyCouponEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<MyCouponEntity> wrapper) {
		  Page<MyCouponView> page =new Query<MyCouponView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
	@Override
	public List<MyCouponView> selectListView(Wrapper<MyCouponEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public MyCouponView selectView(Wrapper<MyCouponEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}
	
	


}
