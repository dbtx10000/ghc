package com.alidao.basic.service;

import com.alidao.basic.entity.FriendGameRecord;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;

public interface FriendGameRecordService {

    public  abstract int save(FriendGameRecord object);

    public  abstract int save(List<FriendGameRecord> objects);

    public  abstract int lose(String id);

    public  abstract int lose(FriendGameRecord object);

    public  abstract int mdfy(FriendGameRecord object);

    public  abstract FriendGameRecord find(String id);

    public  abstract FriendGameRecord find(FriendGameRecord object);

    public  abstract Page<FriendGameRecord> page(PageParam pageParam, FriendGameRecord object);

    public  abstract List<FriendGameRecord> list(FriendGameRecord object);
}