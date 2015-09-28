package com.alidao.users.service;

import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.entity.Saler;
import java.util.List;

public interface SalerService {

    public  abstract int save(Saler object);

    public  abstract int save(List<Saler> objects);

    public  abstract int lose(String id);
    
    public  abstract int loseBusiness(String id);//包含业务的删除方法

    public  abstract int lose(Saler object);

    public  abstract int mdfy(Saler object);

    public  abstract Saler find(String id);

    public  abstract Saler find(Saler object);

    public  abstract Page<Saler> page(PageParam pageParam, Saler object);

    public  abstract List<Saler> list(Saler object);
    
    public abstract int beSaler(String userId);
    
    public abstract int modifyCounts(Saler object);
}