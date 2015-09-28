package com.alidao.balance.service;

import com.alidao.balance.entity.CardBindRecord;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;

public interface CardBindRecordService {

    public  abstract int save(CardBindRecord object);

    public  abstract int save(List<CardBindRecord> objects);

    public  abstract int lose(Long id);

    public  abstract int lose(CardBindRecord object);

    public  abstract int mdfy(CardBindRecord object);

    public  abstract CardBindRecord find(Long id);

    public  abstract CardBindRecord find(CardBindRecord object);

    public  abstract Page<CardBindRecord> page(PageParam pageParam, CardBindRecord object);

    public  abstract List<CardBindRecord> list(CardBindRecord object);
}