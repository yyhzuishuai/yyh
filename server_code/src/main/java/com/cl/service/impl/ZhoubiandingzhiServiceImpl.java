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


import com.cl.dao.ZhoubiandingzhiDao;
import com.cl.entity.ZhoubiandingzhiEntity;
import com.cl.service.ZhoubiandingzhiService;
import com.cl.entity.view.ZhoubiandingzhiView;

@Service("zhoubiandingzhiService")
public class ZhoubiandingzhiServiceImpl extends ServiceImpl<ZhoubiandingzhiDao, ZhoubiandingzhiEntity> implements ZhoubiandingzhiService {

    	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<ZhoubiandingzhiEntity> page = this.selectPage(
                new Query<ZhoubiandingzhiEntity>(params).getPage(),
                new EntityWrapper<ZhoubiandingzhiEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<ZhoubiandingzhiEntity> wrapper) {
		  Page<ZhoubiandingzhiView> page =new Query<ZhoubiandingzhiView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
	@Override
	public List<ZhoubiandingzhiView> selectListView(Wrapper<ZhoubiandingzhiEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public ZhoubiandingzhiView selectView(Wrapper<ZhoubiandingzhiEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}
	
	


}
