package com.alidao.basic.service.impl;

import com.alidao.basic.dao4mybatis.GameRecordDao;
import com.alidao.basic.entity.GameRecord;
import com.alidao.basic.service.GameRecordService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GameRecordServiceImpl implements GameRecordService {

     @Autowired 
     private GameRecordDao gameRecordDao;


    public int save(GameRecord object) {
        return gameRecordDao.insert(object);
    }

    public int save(List<GameRecord> objects) {
        int result = 0;
        for (GameRecord object : objects) {
            result &= gameRecordDao.insert(object);
        }
        return result;
    }

    public int lose(String id) {
        return gameRecordDao.deleteByPrimaryKey(id);
    }

    public int lose(GameRecord object) {
        return gameRecordDao.delete(object);
    }

    public int mdfy(GameRecord object) {
        return gameRecordDao.update(object);
    }

    public GameRecord find(String id) {
        return gameRecordDao.selectByPrimaryKey(id);
    }

    public GameRecord find(GameRecord object) {
        return gameRecordDao.select(object);
    }

    public Page<GameRecord> page(PageParam pageParam, GameRecord object) {
        return gameRecordDao.queryForPage(pageParam,object);
    }

    public List<GameRecord> list(GameRecord object) {
        return gameRecordDao.queryForList(object);
    }
}