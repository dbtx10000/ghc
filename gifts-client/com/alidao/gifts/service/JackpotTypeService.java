package com.alidao.gifts.service;

import com.alidao.basic.entity.Product;
import com.alidao.basic.entity.ProductType;
import com.alidao.gifts.entity.JackpotType;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;

public interface JackpotTypeService {

    public  abstract int save(JackpotType object);

    public  abstract int save(List<JackpotType> objects);

    public  abstract int lose(String id);

    public  abstract int lose(JackpotType object);

    public  abstract int mdfy(JackpotType object);

    public  abstract JackpotType find(String id);

    public  abstract JackpotType find(JackpotType object);

    public  abstract Page<JackpotType> page(PageParam pageParam, JackpotType object);

    public  abstract List<JackpotType> list(JackpotType object);

	public abstract List<ProductType> productTypeList(ProductType object);

	public abstract List<Product> productList(Product object);
}