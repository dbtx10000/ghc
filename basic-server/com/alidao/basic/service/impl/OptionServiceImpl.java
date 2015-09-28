package com.alidao.basic.service.impl;

import com.alidao.basic.dao4mybatis.OptionDao;
import com.alidao.basic.entity.Option;
import com.alidao.basic.service.OptionService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OptionServiceImpl implements OptionService {

     @Autowired 
     private OptionDao optionDao;


    public int save(Option object) {
        return optionDao.insert(object);
    }

    public int save(List<Option> objects) {
        int result = 0;
        for (Option object : objects) {
            result &= optionDao.insert(object);
        }
        return result;
    }

    public int lose(String id) {
        return optionDao.deleteByPrimaryKey(id);
    }

    public int lose(Option object) {
        return optionDao.delete(object);
    }

    public int mdfy(Option object) {
        return optionDao.update(object);
    }

    public Option find(String id) {
        return optionDao.selectByPrimaryKey(id);
    }

    public Option find(Option object) {
        return optionDao.select(object);
    }

    public Page<Option> page(PageParam pageParam, Option object) {
        return optionDao.queryForPage(pageParam,object);
    }

    public List<Option> list(Option object) {
        return optionDao.queryForList(object);
    }
}