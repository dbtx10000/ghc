package com.alidao.balance.service.impl;

import com.alidao.balance.dao4mybatis.CardBindRecordDao;
import com.alidao.balance.entity.CardBindRecord;
import com.alidao.balance.service.CardBindRecordService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CardBindRecordServiceImpl implements CardBindRecordService {

     @Autowired 
     private CardBindRecordDao cardBindRecordDao;


    public int save(CardBindRecord object) {
        return cardBindRecordDao.insert(object);
    }

    public int save(List<CardBindRecord> objects) {
        int result = 0;
        for (CardBindRecord object : objects) {
            result &= cardBindRecordDao.insert(object);
        }
        return result;
    }

    public int lose(Long id) {
        return cardBindRecordDao.deleteByPrimaryKey(id);
    }

    public int lose(CardBindRecord object) {
        return cardBindRecordDao.delete(object);
    }

    public int mdfy(CardBindRecord object) {
        return cardBindRecordDao.update(object);
    }

    public CardBindRecord find(Long id) {
        return cardBindRecordDao.selectByPrimaryKey(id);
    }

    public CardBindRecord find(CardBindRecord object) {
        return cardBindRecordDao.select(object);
    }

    public Page<CardBindRecord> page(PageParam pageParam, CardBindRecord object) {
        return cardBindRecordDao.queryForPage(pageParam,object);
    }

    public List<CardBindRecord> list(CardBindRecord object) {
        return cardBindRecordDao.queryForList(object);
    }
}