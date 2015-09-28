package com.alidao.basic.service.impl;

import com.alidao.basic.dao4mybatis.IntegralTypeDao;
import com.alidao.basic.entity.IntegralType;
import com.alidao.basic.service.IntegralTypeService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class IntegralTypeServiceImpl implements IntegralTypeService {

     @Autowired 
     private IntegralTypeDao integralTypeDao;


    public int save(IntegralType object) {
        return integralTypeDao.insert(object);
    }

    public int save(List<IntegralType> objects) {
        int result = 0;
        for (IntegralType object : objects) {
            result &= integralTypeDao.insert(object);
        }
        return result;
    }

    public int lose(Long id) {
        return integralTypeDao.deleteByPrimaryKey(id);
    }

    public int lose(IntegralType object) {
        return integralTypeDao.delete(object);
    }

    public int mdfy(IntegralType object) {
        return integralTypeDao.update(object);
    }

    public IntegralType find(Long id) {
        return integralTypeDao.selectByPrimaryKey(id);
    }

    public IntegralType find(IntegralType object) {
        return integralTypeDao.select(object);
    }

    public Page<IntegralType> page(PageParam pageParam, IntegralType object) {
        return integralTypeDao.queryForPage(pageParam,object);
    }

    public List<IntegralType> list(IntegralType object) {
        return integralTypeDao.queryForList(object);
    }
}