package com.alidao.basic.service.impl;

import com.alidao.basic.dao4mybatis.ProverbDao;
import com.alidao.basic.entity.Proverb;
import com.alidao.basic.service.ProverbService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ProverbServiceImpl implements ProverbService {

     @Autowired 
     private ProverbDao proverbDao;


    public int save(Proverb object) {
        return proverbDao.insert(object);
    }

    public int save(List<Proverb> objects) {
        int result = 0;
        for (Proverb object : objects) {
            result &= proverbDao.insert(object);
        }
        return result;
    }

    public int lose(String id) {
        return proverbDao.deleteByPrimaryKey(id);
    }

    public int lose(Proverb object) {
        return proverbDao.delete(object);
    }

    public int mdfy(Proverb object) {
        return proverbDao.update(object);
    }

    public Proverb find(String id) {
        return proverbDao.selectByPrimaryKey(id);
    }

    public Proverb find(Proverb object) {
        return proverbDao.select(object);
    }

    public Page<Proverb> page(PageParam pageParam, Proverb object) {
        return proverbDao.queryForPage(pageParam,object);
    }

    public List<Proverb> list(Proverb object) {
        return proverbDao.queryForList(object);
    }
}