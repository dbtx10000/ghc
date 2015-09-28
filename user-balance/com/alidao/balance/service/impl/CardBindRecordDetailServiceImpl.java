package com.alidao.balance.service.impl;

import com.alidao.balance.dao4mybatis.CardBindRecordDao;
import com.alidao.balance.dao4mybatis.CardBindRecordDetailDao;
import com.alidao.balance.entity.CardBindRecordDetail;
import com.alidao.balance.service.CardBindRecordDetailService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CardBindRecordDetailServiceImpl implements CardBindRecordDetailService {

     @Autowired 
     private CardBindRecordDetailDao cardBindRecordDetailDao;

     @Autowired
     private CardBindRecordDao cardBindRecordDao;

    public int save(CardBindRecordDetail object) {
        return cardBindRecordDetailDao.insert(object);
    }

    public int save(List<CardBindRecordDetail> objects) {
        int result = 0;
        for (CardBindRecordDetail object : objects) {
            result &= cardBindRecordDetailDao.insert(object);
        }
        return result;
    }

    public int lose(Long id) {
        return cardBindRecordDetailDao.deleteByPrimaryKey(id);
    }

    public int lose(CardBindRecordDetail object) {
        return cardBindRecordDetailDao.delete(object);
    }

    public int mdfy(CardBindRecordDetail object) {
        return cardBindRecordDetailDao.update(object);
    }

    public CardBindRecordDetail find(Long id) {
        return cardBindRecordDetailDao.selectByPrimaryKey(id);
    }

    public CardBindRecordDetail find(CardBindRecordDetail object) {
        return cardBindRecordDetailDao.select(object);
    }

    public Page<CardBindRecordDetail> page(PageParam pageParam, CardBindRecordDetail object) {
    	Page<CardBindRecordDetail> page=cardBindRecordDetailDao.queryForPage(pageParam,object);
    	List<CardBindRecordDetail> list=page.getTableList();
    	for(CardBindRecordDetail detail:list){
    		detail.setCardBindRecord(cardBindRecordDao.selectByPrimaryKey(detail.getCardBindRecordId()));
    	}
        return page;
    }

    public List<CardBindRecordDetail> list(CardBindRecordDetail object) {
        return cardBindRecordDetailDao.queryForList(object);
    }
}