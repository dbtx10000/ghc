package com.alidao.basic.service;

import com.alidao.basic.entity.Holiday;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import java.util.List;

public interface HolidayService {

    public  abstract int save(Holiday object);
    
    public  abstract int saveBussiness(Holiday object);

    public  abstract int save(List<Holiday> objects);

    public  abstract int lose(String id);

    public  abstract int lose(Holiday object);

    public  abstract int mdfy(Holiday object);
    
    public  abstract int mdfyBussiness(Holiday object);

    public  abstract Holiday find(String id);

    public  abstract Holiday find(Holiday object);

    public  abstract Page<Holiday> page(PageParam pageParam, Holiday object);

    public  abstract List<Holiday> list(Holiday object);
}