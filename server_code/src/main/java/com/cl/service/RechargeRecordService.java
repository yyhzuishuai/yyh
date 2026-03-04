package com.cl.service;

import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.IService;
import com.cl.utils.PageUtils;
import com.cl.entity.RechargeRecordEntity;
import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.cl.entity.view.RechargeRecordView;


/**
 * 充值记录
 *
 * @author 
 * @email 
 * @date 2025-12-15 17:24:21
 */
public interface RechargeRecordService extends IService<RechargeRecordEntity> {

    PageUtils queryPage(Map<String, Object> params);
    
   	List<RechargeRecordView> selectListView(Wrapper<RechargeRecordEntity> wrapper);
   	
   	RechargeRecordView selectView(@Param("ew") Wrapper<RechargeRecordEntity> wrapper);
   	
   	PageUtils queryPage(Map<String, Object> params,Wrapper<RechargeRecordEntity> wrapper);
   	
   
}

