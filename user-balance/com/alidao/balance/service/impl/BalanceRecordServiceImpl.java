package com.alidao.balance.service.impl;

import com.alidao.balance.dao4mybatis.BalanceRecordDao;
import com.alidao.balance.entity.BalanceRecord;
import com.alidao.balance.service.BalanceRecordService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BalanceRecordServiceImpl implements BalanceRecordService {

     @Autowired 
     private BalanceRecordDao balanceRecordDao;


    public int save(BalanceRecord object) {
        return balanceRecordDao.insert(object);
    }

    public int save(List<BalanceRecord> objects) {
        int result = 0;
        for (BalanceRecord object : objects) {
            result &= balanceRecordDao.insert(object);
        }
        return result;
    }

    public int lose(Long id) {
        return balanceRecordDao.deleteByPrimaryKey(id);
    }

    public int lose(BalanceRecord object) {
        return balanceRecordDao.delete(object);
    }

    public int mdfy(BalanceRecord object) {
        return balanceRecordDao.update(object);
    }

    public BalanceRecord find(Long id) {
        return balanceRecordDao.selectByPrimaryKey(id);
    }

    public BalanceRecord find(BalanceRecord object) {
        return balanceRecordDao.select(object);
    }

    public Page<BalanceRecord> page(PageParam pageParam, BalanceRecord object) {
        return balanceRecordDao.queryForPage(pageParam,object);
    }

    public List<BalanceRecord> list(BalanceRecord object) {
        return balanceRecordDao.queryForList(object);
    }
}