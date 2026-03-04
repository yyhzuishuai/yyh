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


import com.cl.dao.RechargeRecordDao;
import com.cl.entity.RechargeRecordEntity;
import com.cl.service.RechargeRecordService;
import com.cl.entity.view.RechargeRecordView;

@Service("rechargeRecordService")
public class RechargeRecordServiceImpl extends ServiceImpl<RechargeRecordDao, RechargeRecordEntity> implements RechargeRecordService {

    	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<RechargeRecordEntity> page = this.selectPage(
                new Query<RechargeRecordEntity>(params).getPage(),
                new EntityWrapper<RechargeRecordEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<RechargeRecordEntity> wrapper) {
		  Page<RechargeRecordView> page =new Query<RechargeRecordView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
	@Override
	public List<RechargeRecordView> selectListView(Wrapper<RechargeRecordEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public RechargeRecordView selectView(Wrapper<RechargeRecordEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}
	
	


}
