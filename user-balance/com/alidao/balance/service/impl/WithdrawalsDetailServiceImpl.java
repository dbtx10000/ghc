package com.alidao.balance.service.impl;

import com.alidao.balance.dao4mybatis.WithdrawalsDetailDao;
import com.alidao.balance.entity.WithdrawalsDetail;
import com.alidao.balance.service.WithdrawalsDetailService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WithdrawalsDetailServiceImpl implements WithdrawalsDetailService {

     @Autowired 
     private WithdrawalsDetailDao withdrawalsDetailDao;


    public int save(WithdrawalsDetail object) {
        return withdrawalsDetailDao.insert(object);
    }

    public int save(List<WithdrawalsDetail> objects) {
        int result = 0;
        for (WithdrawalsDetail object : objects) {
            result &= withdrawalsDetailDao.insert(object);
        }
        return result;
    }

    public int lose(Long id) {
        return withdrawalsDetailDao.deleteByPrimaryKey(id);
    }

    public int lose(WithdrawalsDetail object) {
        return withdrawalsDetailDao.delete(object);
    }

    public int mdfy(WithdrawalsDetail object) {
        return withdrawalsDetailDao.update(object);
    }

    public WithdrawalsDetail find(Long id) {
        return withdrawalsDetailDao.selectByPrimaryKey(id);
    }

    public WithdrawalsDetail find(WithdrawalsDetail object) {
        return withdrawalsDetailDao.select(object);
    }

    public Page<WithdrawalsDetail> page(PageParam pageParam, WithdrawalsDetail object) {
        return withdrawalsDetailDao.queryForPage(pageParam,object);
    }

    public List<WithdrawalsDetail> list(WithdrawalsDetail object) {
        return withdrawalsDetailDao.queryForList(object);
    }
}