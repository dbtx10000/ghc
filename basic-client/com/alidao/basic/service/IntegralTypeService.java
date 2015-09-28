package com.alidao.basic.service;

import com.alidao.basic.entity.IntegralType;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;

public interface IntegralTypeService {

    public  abstract int save(IntegralType object);

    public  abstract int save(List<IntegralType> objects);

    public  abstract int lose(Long id);

    public  abstract int lose(IntegralType object);

    public  abstract int mdfy(IntegralType object);

    public  abstract IntegralType find(Long id);

    public  abstract IntegralType find(IntegralType object);

    public  abstract Page<IntegralType> page(PageParam pageParam, IntegralType object);

    public  abstract List<IntegralType> list(IntegralType object);
}