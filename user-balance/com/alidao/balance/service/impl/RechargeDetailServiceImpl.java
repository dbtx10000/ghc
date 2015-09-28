package com.alidao.balance.service.impl;

import com.alidao.balance.dao4mybatis.RechargeDetailDao;
import com.alidao.balance.entity.RechargeDetail;
import com.alidao.balance.service.RechargeDetailService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RechargeDetailServiceImpl implements RechargeDetailService {

     @Autowired 
     private RechargeDetailDao rechargeDetailDao;


    public int save(RechargeDetail object) {
        return rechargeDetailDao.insert(object);
    }

    public int save(List<RechargeDetail> objects) {
        int result = 0;
        for (RechargeDetail object : objects) {
            result &= rechargeDetailDao.insert(object);
        }
        return result;
    }

    public int lose(Long id) {
        return rechargeDetailDao.deleteByPrimaryKey(id);
    }

    public int lose(RechargeDetail object) {
        return rechargeDetailDao.delete(object);
    }

    public int mdfy(RechargeDetail object) {
        return rechargeDetailDao.update(object);
    }

    public RechargeDetail find(Long id) {
        return rechargeDetailDao.selectByPrimaryKey(id);
    }

    public RechargeDetail find(RechargeDetail object) {
        return rechargeDetailDao.select(object);
    }

    public Page<RechargeDetail> page(PageParam pageParam, RechargeDetail object) {
        return rechargeDetailDao.queryForPage(pageParam,object);
    }

    public List<RechargeDetail> list(RechargeDetail object) {
        return rechargeDetailDao.queryForList(object);
    }
}