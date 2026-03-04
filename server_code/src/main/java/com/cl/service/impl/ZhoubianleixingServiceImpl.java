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


import com.cl.dao.ZhoubianleixingDao;
import com.cl.entity.ZhoubianleixingEntity;
import com.cl.service.ZhoubianleixingService;
import com.cl.entity.view.ZhoubianleixingView;

@Service("zhoubianleixingService")
public class ZhoubianleixingServiceImpl extends ServiceImpl<ZhoubianleixingDao, ZhoubianleixingEntity> implements ZhoubianleixingService {

    	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<ZhoubianleixingEntity> page = this.selectPage(
                new Query<ZhoubianleixingEntity>(params).getPage(),
                new EntityWrapper<ZhoubianleixingEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<ZhoubianleixingEntity> wrapper) {
		  Page<ZhoubianleixingView> page =new Query<ZhoubianleixingView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
	@Override
	public List<ZhoubianleixingView> selectListView(Wrapper<ZhoubianleixingEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public ZhoubianleixingView selectView(Wrapper<ZhoubianleixingEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}
	
	


}
