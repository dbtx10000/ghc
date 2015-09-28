package com.alidao.gifts.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.gifts.dao4mybatis.IgiftDao;
import com.alidao.gifts.entity.Igift;
import com.alidao.gifts.service.IgiftService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

@Service
public class IgiftServiceImpl implements IgiftService {

	@Autowired 
	private IgiftDao igiftDao;

    public int save(Igift object) {
    	object.beforeInsert();
        return igiftDao.insert(object);
    }

    public int save(List<Igift> objects) {
        int result = 0;
        for (Igift object : objects) {
            result &= igiftDao.insert(object);
        }
        return result;
    }

    public int lose(String id) {
        return igiftDao.deleteByPrimaryKey(id);
    }

    public int lose(Igift object) {
        return igiftDao.delete(object);
    }

    public int mdfy(Igift object) {
        return igiftDao.update(object);
    }

    public Igift find(String id) {
        return igiftDao.selectByPrimaryKey(id);
    }

    public Igift find(Igift object) {
        return igiftDao.select(object);
    }

    public Page<Igift> page(PageParam pageParam, Igift object) {
        return igiftDao.queryForPage(pageParam,object);
    }

    public List<Igift> list(Igift object) {
        return igiftDao.queryForList(object);
    }

	public int plus(Igift object) {
		return igiftDao.modifyCounts(object);
	}

}