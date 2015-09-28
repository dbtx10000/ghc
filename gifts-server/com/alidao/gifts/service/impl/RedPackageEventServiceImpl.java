package com.alidao.gifts.service.impl;

import com.alidao.gifts.dao4mybatis.RedPackageEventDao;
import com.alidao.gifts.entity.RedPackageEvent;
import com.alidao.gifts.service.RedPackageEventService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RedPackageEventServiceImpl implements RedPackageEventService {

     @Autowired 
     private RedPackageEventDao redPackageEventDao;


    public int save(RedPackageEvent object) {
    	object.beforeInsert();
        return redPackageEventDao.insert(object);
    }

    public int save(List<RedPackageEvent> objects) {
        int result = 0;
        for (RedPackageEvent object : objects) {
            result &= redPackageEventDao.insert(object);
        }
        return result;
    }

    public int lose(String id) {
        return redPackageEventDao.deleteByPrimaryKey(id);
    }

    public int lose(RedPackageEvent object) {
        return redPackageEventDao.delete(object);
    }

    public int mdfy(RedPackageEvent object) {
        return redPackageEventDao.update(object);
    }

    public RedPackageEvent find(String id) {
        return redPackageEventDao.selectByPrimaryKey(id);
    }

    public RedPackageEvent find(RedPackageEvent object) {
        return redPackageEventDao.select(object);
    }

    public Page<RedPackageEvent> page(PageParam pageParam, RedPackageEvent object) {
        return redPackageEventDao.queryForPage(pageParam,object);
    }

    public List<RedPackageEvent> list(RedPackageEvent object) {
        return redPackageEventDao.queryForList(object);
    }
}