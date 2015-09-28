package com.alidao.gifts.service;

import com.alidao.gifts.entity.Award;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;

public interface AwardService {

    public  abstract int save(Award object);

    public  abstract int save(List<Award> objects);

    public  abstract int lose(String id);

    public  abstract int lose(Award object);

    public  abstract int mdfy(Award object);

    public  abstract Award find(String id);

    public  abstract Award find(Award object);

    public  abstract Page<Award> page(PageParam pageParam, Award object);

    public  abstract List<Award> list(Award object);
}