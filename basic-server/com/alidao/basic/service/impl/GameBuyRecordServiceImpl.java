package com.alidao.basic.service.impl;

import com.alidao.basic.dao4mybatis.GameBuyRecordDao;
import com.alidao.basic.entity.GameBuyRecord;
import com.alidao.basic.service.GameBuyRecordService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GameBuyRecordServiceImpl implements GameBuyRecordService {

     @Autowired 
     private GameBuyRecordDao gameBuyRecordDao;


    public int save(GameBuyRecord object) {
        return gameBuyRecordDao.insert(object);
    }

    public int save(List<GameBuyRecord> objects) {
        int result = 0;
        for (GameBuyRecord object : objects) {
            result &= gameBuyRecordDao.insert(object);
        }
        return result;
    }

    public int lose(String id) {
        return gameBuyRecordDao.deleteByPrimaryKey(id);
    }

    public int lose(GameBuyRecord object) {
        return gameBuyRecordDao.delete(object);
    }

    public int mdfy(GameBuyRecord object) {
        return gameBuyRecordDao.update(object);
    }

    public GameBuyRecord find(String id) {
        return gameBuyRecordDao.selectByPrimaryKey(id);
    }

    public GameBuyRecord find(GameBuyRecord object) {
        return gameBuyRecordDao.select(object);
    }

    public Page<GameBuyRecord> page(PageParam pageParam, GameBuyRecord object) {
        return gameBuyRecordDao.queryForPage(pageParam,object);
    }

    public List<GameBuyRecord> list(GameBuyRecord object) {
        return gameBuyRecordDao.queryForList(object);
    }
}