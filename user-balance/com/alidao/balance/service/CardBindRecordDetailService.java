package com.alidao.balance.service;

import com.alidao.balance.entity.CardBindRecordDetail;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;

public interface CardBindRecordDetailService {

    public  abstract int save(CardBindRecordDetail object);

    public  abstract int save(List<CardBindRecordDetail> objects);

    public  abstract int lose(Long id);

    public  abstract int lose(CardBindRecordDetail object);

    public  abstract int mdfy(CardBindRecordDetail object);

    public  abstract CardBindRecordDetail find(Long id);

    public  abstract CardBindRecordDetail find(CardBindRecordDetail object);

    public  abstract Page<CardBindRecordDetail> page(PageParam pageParam, CardBindRecordDetail object);

    public  abstract List<CardBindRecordDetail> list(CardBindRecordDetail object);
}