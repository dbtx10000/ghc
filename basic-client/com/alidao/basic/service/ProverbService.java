package com.alidao.basic.service;

import com.alidao.basic.entity.Proverb;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;

public interface ProverbService {

    public  abstract int save(Proverb object);

    public  abstract int save(List<Proverb> objects);

    public  abstract int lose(String id);

    public  abstract int lose(Proverb object);

    public  abstract int mdfy(Proverb object);

    public  abstract Proverb find(String id);

    public  abstract Proverb find(Proverb object);

    public  abstract Page<Proverb> page(PageParam pageParam, Proverb object);

    public  abstract List<Proverb> list(Proverb object);
}