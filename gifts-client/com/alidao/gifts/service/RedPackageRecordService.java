package com.alidao.gifts.service;

import java.util.List;

import com.alidao.gifts.entity.RedPackageRecord;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

public interface RedPackageRecordService {

    public  abstract int save(RedPackageRecord object);

    public  abstract int save(List<RedPackageRecord> objects);

    public  abstract int lose(String id);

    public  abstract int lose(RedPackageRecord object);

    public  abstract int mdfy(RedPackageRecord object);

    public  abstract RedPackageRecord find(String id);

    public  abstract RedPackageRecord find(RedPackageRecord object);

    public  abstract Page<RedPackageRecord> page(PageParam pageParam, RedPackageRecord object);

    public  abstract List<RedPackageRecord> list(RedPackageRecord object);

	public abstract RedPackageRecord save(String redPackageEventId, String userId,Integer integral);

	public abstract RedPackageRecord bindAndGet(String redPackageEventId, String mobile, String openid);
}