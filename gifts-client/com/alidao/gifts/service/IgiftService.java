package com.alidao.gifts.service;

import java.util.List;

import com.alidao.gifts.entity.Igift;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

public interface IgiftService {

    public abstract int save(Igift object);

    public abstract int save(List<Igift> objects);

    public abstract int lose(String id);

    public abstract int lose(Igift object);

    public abstract int mdfy(Igift object);

    public abstract Igift find(String id);

    public abstract Igift find(Igift object);

    public abstract Page<Igift> page(PageParam pageParam, Igift object);

    public abstract List<Igift> list(Igift object);
    
    // 扩展方法
    
    public abstract int plus(Igift object);
    
}