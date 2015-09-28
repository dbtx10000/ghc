package com.alidao.users.service.impl;

import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.dao4mybatis.BuyProductRecordDao;
import com.alidao.users.entity.BuyProductRecord;
import com.alidao.users.service.BuyProductRecordService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BuyProductRecordServiceImpl implements BuyProductRecordService {

     @Autowired 
     private BuyProductRecordDao buyProductRecordDao;


    public int save(BuyProductRecord object) {
        return buyProductRecordDao.insert(object);
    }

    public int save(List<BuyProductRecord> objects) {
        int result = 0;
        for (BuyProductRecord object : objects) {
            result &= buyProductRecordDao.insert(object);
        }
        return result;
    }

    public int lose(String id) {
        return buyProductRecordDao.deleteByPrimaryKey(id);
    }

    public int lose(BuyProductRecord object) {
        return buyProductRecordDao.delete(object);
    }

    public int mdfy(BuyProductRecord object) {
        return buyProductRecordDao.update(object);
    }

    public BuyProductRecord find(String id) {
        return buyProductRecordDao.selectByPrimaryKey(id);
    }

    public BuyProductRecord find(BuyProductRecord object) {
        return buyProductRecordDao.select(object);
    }

    public Page<BuyProductRecord> page(PageParam pageParam, BuyProductRecord object) {
        return buyProductRecordDao.queryForPage(pageParam,object);
    }

    public List<BuyProductRecord> list(BuyProductRecord object) {
        return buyProductRecordDao.queryForList(object);
    }
}