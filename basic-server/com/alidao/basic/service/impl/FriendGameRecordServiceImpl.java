package com.alidao.basic.service.impl;

import com.alidao.basic.dao4mybatis.FriendGameRecordDao;
import com.alidao.basic.entity.FriendGameRecord;
import com.alidao.basic.service.FriendGameRecordService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FriendGameRecordServiceImpl implements FriendGameRecordService {

     @Autowired 
     private FriendGameRecordDao friendGameRecordDao;


    public int save(FriendGameRecord object) {
        return friendGameRecordDao.insert(object);
    }

    public int save(List<FriendGameRecord> objects) {
        int result = 0;
        for (FriendGameRecord object : objects) {
            result &= friendGameRecordDao.insert(object);
        }
        return result;
    }

    public int lose(String id) {
        return friendGameRecordDao.deleteByPrimaryKey(id);
    }

    public int lose(FriendGameRecord object) {
        return friendGameRecordDao.delete(object);
    }

    public int mdfy(FriendGameRecord object) {
        return friendGameRecordDao.update(object);
    }

    public FriendGameRecord find(String id) {
        return friendGameRecordDao.selectByPrimaryKey(id);
    }

    public FriendGameRecord find(FriendGameRecord object) {
        return friendGameRecordDao.select(object);
    }

    public Page<FriendGameRecord> page(PageParam pageParam, FriendGameRecord object) {
        return friendGameRecordDao.queryForPage(pageParam,object);
    }

    public List<FriendGameRecord> list(FriendGameRecord object) {
        return friendGameRecordDao.queryForList(object);
    }
}