package com.alidao.cnpay.service;

import java.util.List;

import com.alidao.cnpay.entity.CardBind;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

public interface CardBindService {

    public  abstract int save(CardBind object);
    
    public  abstract long saveBusiness(CardBind object);

    public  abstract int save(List<CardBind> objects);

    public  abstract int lose(Long id);

    public  abstract int lose(CardBind object);

    public  abstract int mdfy(CardBind object);

    public  abstract CardBind find(Long id);

    public  abstract CardBind find(CardBind object);

    public  abstract Page<CardBind> page(PageParam pageParam, CardBind object);

    public  abstract List<CardBind> list(CardBind object);
}