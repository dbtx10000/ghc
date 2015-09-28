package com.alidao.gifts.service.impl;

import com.alidao.gifts.dao4mybatis.AwardDao;
import com.alidao.gifts.entity.Award;
import com.alidao.gifts.service.AwardService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AwardServiceImpl implements AwardService {

     @Autowired 
     private AwardDao awardDao;


    public int save(Award object) {
        return awardDao.insert(object);
    }

    public int save(List<Award> objects) {
        int result = 0;
        for (Award object : objects) {
            result &= awardDao.insert(object);
        }
        return result;
    }

    public int lose(String id) {
        return awardDao.deleteByPrimaryKey(id);
    }

    public int lose(Award object) {
        return awardDao.delete(object);
    }

    public int mdfy(Award object) {
        return awardDao.update(object);
    }

    public Award find(String id) {
        return awardDao.selectByPrimaryKey(id);
    }

    public Award find(Award object) {
        return awardDao.select(object);
    }

    public Page<Award> page(PageParam pageParam, Award object) {
        return awardDao.queryForPage(pageParam,object);
    }

    public List<Award> list(Award object) {
        return awardDao.queryForList(object);
    }
}