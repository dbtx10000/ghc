package com.alidao.users.service;

import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.entity.BuyProductRecord;
import java.util.List;

public interface BuyProductRecordService {

    public  abstract int save(BuyProductRecord object);

    public  abstract int save(List<BuyProductRecord> objects);

    public  abstract int lose(String id);

    public  abstract int lose(BuyProductRecord object);

    public  abstract int mdfy(BuyProductRecord object);

    public  abstract BuyProductRecord find(String id);

    public  abstract BuyProductRecord find(BuyProductRecord object);

    public  abstract Page<BuyProductRecord> page(PageParam pageParam, BuyProductRecord object);

    public  abstract List<BuyProductRecord> list(BuyProductRecord object);
}