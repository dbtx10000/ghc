package com.alidao.gifts.service;

import com.alidao.gifts.entity.RedPackageEvent;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;

public interface RedPackageEventService {

    public  abstract int save(RedPackageEvent object);

    public  abstract int save(List<RedPackageEvent> objects);

    public  abstract int lose(String id);

    public  abstract int lose(RedPackageEvent object);

    public  abstract int mdfy(RedPackageEvent object);

    public  abstract RedPackageEvent find(String id);

    public  abstract RedPackageEvent find(RedPackageEvent object);

    public  abstract Page<RedPackageEvent> page(PageParam pageParam, RedPackageEvent object);

    public  abstract List<RedPackageEvent> list(RedPackageEvent object);
}