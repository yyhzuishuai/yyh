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


import com.cl.dao.DongmanshangpinDao;
import com.cl.entity.DongmanshangpinEntity;
import com.cl.service.DongmanshangpinService;
import com.cl.entity.view.DongmanshangpinView;

@Service("dongmanshangpinService")
public class DongmanshangpinServiceImpl extends ServiceImpl<DongmanshangpinDao, DongmanshangpinEntity> implements DongmanshangpinService {

    	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<DongmanshangpinEntity> page = this.selectPage(
                new Query<DongmanshangpinEntity>(params).getPage(),
                new EntityWrapper<DongmanshangpinEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<DongmanshangpinEntity> wrapper) {
		  Page<DongmanshangpinView> page =new Query<DongmanshangpinView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
	@Override
	public List<DongmanshangpinView> selectListView(Wrapper<DongmanshangpinEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public DongmanshangpinView selectView(Wrapper<DongmanshangpinEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}
	
	


}
