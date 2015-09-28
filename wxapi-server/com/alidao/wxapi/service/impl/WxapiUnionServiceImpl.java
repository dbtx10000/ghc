package com.alidao.wxapi.service.impl;

import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.wxapi.dao4mybatis.WxapiUnionDao;
import com.alidao.wxapi.bean.UserForWxUnion;
import com.alidao.wxapi.service.WxapiUnionService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WxapiUnionServiceImpl implements WxapiUnionService {

     @Autowired 
     private WxapiUnionDao wxapiUnionDao;


    public int save(UserForWxUnion object) {
        return wxapiUnionDao.insert(object);
    }

    public int save(List<UserForWxUnion> objects) {
        int result = 0;
        for (UserForWxUnion object : objects) {
            result &= wxapiUnionDao.insert(object);
        }
        return result;
    }

    public int lose(Long id) {
        return wxapiUnionDao.deleteByPrimaryKey(id);
    }

    public int lose(UserForWxUnion object) {
        return wxapiUnionDao.delete(object);
    }

    public int mdfy(UserForWxUnion object) {
        return wxapiUnionDao.update(object);
    }

    public UserForWxUnion find(Long id) {
        return wxapiUnionDao.selectByPrimaryKey(id);
    }

    public UserForWxUnion find(UserForWxUnion object) {
        return wxapiUnionDao.select(object);
    }

    public Page<UserForWxUnion> page(PageParam pageParam, UserForWxUnion object) {
        return wxapiUnionDao.queryForPage(pageParam,object);
    }

    public List<UserForWxUnion> list(UserForWxUnion object) {
        return wxapiUnionDao.queryForList(object);
    }
}