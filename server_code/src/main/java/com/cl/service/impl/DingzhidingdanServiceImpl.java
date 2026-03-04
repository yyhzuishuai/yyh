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


import com.cl.dao.DingzhidingdanDao;
import com.cl.entity.DingzhidingdanEntity;
import com.cl.service.DingzhidingdanService;
import com.cl.entity.view.DingzhidingdanView;

@Service("dingzhidingdanService")
public class DingzhidingdanServiceImpl extends ServiceImpl<DingzhidingdanDao, DingzhidingdanEntity> implements DingzhidingdanService {

    	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<DingzhidingdanEntity> page = this.selectPage(
                new Query<DingzhidingdanEntity>(params).getPage(),
                new EntityWrapper<DingzhidingdanEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<DingzhidingdanEntity> wrapper) {
		  Page<DingzhidingdanView> page =new Query<DingzhidingdanView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
	@Override
	public List<DingzhidingdanView> selectListView(Wrapper<DingzhidingdanEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public DingzhidingdanView selectView(Wrapper<DingzhidingdanEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}
	
	


}
