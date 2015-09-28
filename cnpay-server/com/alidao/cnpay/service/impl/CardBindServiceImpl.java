package com.alidao.cnpay.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.balance.dao4mybatis.CardBindRecordDao;
import com.alidao.balance.dao4mybatis.CardBindRecordDetailDao;
import com.alidao.balance.entity.CardBindRecord;
import com.alidao.balance.entity.CardBindRecordDetail;
import com.alidao.cnpay.dao4mybatis.CardBindDao;
import com.alidao.cnpay.entity.CardBind;
import com.alidao.cnpay.service.CardBindService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

@Service
public class CardBindServiceImpl implements CardBindService {

     @Autowired 
     private CardBindDao cardBindDao;
     
     @Autowired
     private CardBindRecordDao cardBindRecordDao;
     
     @Autowired
     private CardBindRecordDetailDao bindRecordDetailDao;


    public int save(CardBind object) {
        return cardBindDao.insert(object);
    }
    
    public long saveBusiness(CardBind object) {
    	CardBindRecord cardBindRecord = new CardBindRecord();
    	cardBindRecord.setUserId(object.getUserId());
    	cardBindRecord.setUsername("");
    	cardBindRecord.setRealname("");
    	cardBindRecord.setSerial(object.getSerial());
    	cardBindRecord.setMobile(object.getMobile());
    	cardBindRecord.setGender(object.getGender());
    	cardBindRecord.setUserName(object.getUserName());//开户人
    	cardBindRecord.setCertType(object.getCertType());
    	cardBindRecord.setCertId(object.getCertId());
    	cardBindRecord.setCardNo(object.getCardNo());
    	cardBindRecord.setOpenBankId(object.getOpenBankId());
    	cardBindRecord.setOpenBankName(object.getOpenBankName());
    	cardBindRecord.setStatus(CardBindRecord.CARD_BIND);
    	cardBindRecordDao.insert(cardBindRecord);
    	CardBindRecordDetail bindRecordDetail = new CardBindRecordDetail();
    	bindRecordDetail.setCardBindRecordId(cardBindRecord.getId());
    	bindRecordDetail.setStatus(CardBindRecordDetail.BIND_SUBMIT);
    	bindRecordDetailDao.insert(bindRecordDetail);
    	cardBindDao.insert(object);
        return cardBindRecord.getId();
    }
    
    public int save(List<CardBind> objects) {
        int result = 0;
        for (CardBind object : objects) {
            result &= cardBindDao.insert(object);
        }
        return result;
    }

    public int lose(Long id) {
        return cardBindDao.deleteByPrimaryKey(id);
    }

    public int lose(CardBind object) {
        return cardBindDao.delete(object);
    }

    public int mdfy(CardBind object) {
        return cardBindDao.update(object);
    }

    public CardBind find(Long id) {
        return cardBindDao.selectByPrimaryKey(id);
    }

    public CardBind find(CardBind object) {
        return cardBindDao.select(object);
    }

    public Page<CardBind> page(PageParam pageParam, CardBind object) {
        return cardBindDao.queryForPage(pageParam,object);
    }

    public List<CardBind> list(CardBind object) {
        return cardBindDao.queryForList(object);
    }
}