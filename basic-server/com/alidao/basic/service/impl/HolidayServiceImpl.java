package com.alidao.basic.service.impl;

import com.alidao.basic.dao4mybatis.HolidayDao;
import com.alidao.basic.entity.Holiday;
import com.alidao.basic.service.HolidayService;
import com.alidao.jse.util.DateUtil;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HolidayServiceImpl implements HolidayService {

     @Autowired 
     private HolidayDao holidayDao;


    public int save(Holiday object) {
        return holidayDao.insert(object);
    }
    
    public int saveBussiness(Holiday object) {
    	String year = DateUtil.formatDate(object.getStartTime(),"yyyy-MM-dd").substring(0,4);
    	object.setYear(Integer.parseInt(year));
        return holidayDao.insert(object);
    }

    public int save(List<Holiday> objects) {
        int result = 0;
        for (Holiday object : objects) {
            result &= holidayDao.insert(object);
        }
        return result;
    }

    public int lose(String id) {
        return holidayDao.deleteByPrimaryKey(id);
    }

    public int lose(Holiday object) {
        return holidayDao.delete(object);
    }

    public int mdfy(Holiday object) {
        return holidayDao.update(object);
    }
    
    public int mdfyBussiness(Holiday object) {
    	String year = DateUtil.formatDate(object.getStartTime(),"yyyy-MM-dd").substring(0,4);
    	object.setYear(Integer.parseInt(year));
        return holidayDao.update(object);
    }

    public Holiday find(String id) {
        return holidayDao.selectByPrimaryKey(id);
    }

    public Holiday find(Holiday object) {
        return holidayDao.select(object);
    }

    public Page<Holiday> page(PageParam pageParam, Holiday object) {
        return holidayDao.queryForPage(pageParam,object);
    }

    public List<Holiday> list(Holiday object) {
        return holidayDao.queryForList(object);
    }
}