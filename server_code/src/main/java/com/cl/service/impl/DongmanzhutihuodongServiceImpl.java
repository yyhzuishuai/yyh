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


import com.cl.dao.DongmanzhutihuodongDao;
import com.cl.entity.DongmanzhutihuodongEntity;
import com.cl.service.DongmanzhutihuodongService;
import com.cl.entity.view.DongmanzhutihuodongView;

@Service("dongmanzhutihuodongService")
public class DongmanzhutihuodongServiceImpl extends ServiceImpl<DongmanzhutihuodongDao, DongmanzhutihuodongEntity> implements DongmanzhutihuodongService {

    	
    @Override
    public PageUtils queryPage(Map<String, Object> params) {
        Page<DongmanzhutihuodongEntity> page = this.selectPage(
                new Query<DongmanzhutihuodongEntity>(params).getPage(),
                new EntityWrapper<DongmanzhutihuodongEntity>()
        );
        return new PageUtils(page);
    }
    
    @Override
	public PageUtils queryPage(Map<String, Object> params, Wrapper<DongmanzhutihuodongEntity> wrapper) {
		  Page<DongmanzhutihuodongView> page =new Query<DongmanzhutihuodongView>(params).getPage();
	        page.setRecords(baseMapper.selectListView(page,wrapper));
	    	PageUtils pageUtil = new PageUtils(page);
	    	return pageUtil;
 	}
    
	@Override
	public List<DongmanzhutihuodongView> selectListView(Wrapper<DongmanzhutihuodongEntity> wrapper) {
		return baseMapper.selectListView(wrapper);
	}

	@Override
	public DongmanzhutihuodongView selectView(Wrapper<DongmanzhutihuodongEntity> wrapper) {
		return baseMapper.selectView(wrapper);
	}
	
	


}
