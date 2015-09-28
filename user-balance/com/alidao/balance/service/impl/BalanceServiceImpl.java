package com.alidao.balance.service.impl;

import com.alidao.balance.dao4mybatis.BalanceDao;
import com.alidao.balance.entity.Balance;
import com.alidao.balance.service.BalanceService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BalanceServiceImpl implements BalanceService {

     @Autowired 
     private BalanceDao balanceDao;


    public int save(Balance object) {
        return balanceDao.insert(object);
    }

    public int save(List<Balance> objects) {
        int result = 0;
        for (Balance object : objects) {
            result &= balanceDao.insert(object);
        }
        return result;
    }

    public int lose(Long id) {
        return balanceDao.deleteByPrimaryKey(id);
    }

    public int lose(Balance object) {
        return balanceDao.delete(object);
    }

    public int mdfy(Balance object) {
        return balanceDao.update(object);
    }

    public Balance find(Long id) {
        return balanceDao.selectByPrimaryKey(id);
    }

    public Balance find(Balance object) {
        return balanceDao.select(object);
    }

    public Page<Balance> page(PageParam pageParam, Balance object) {
        return balanceDao.queryForPage(pageParam,object);
    }

    public List<Balance> list(Balance object) {
        return balanceDao.queryForList(object);
    }
}