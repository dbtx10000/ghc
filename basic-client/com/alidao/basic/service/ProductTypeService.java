package com.alidao.basic.service;

import java.util.List;

import com.alidao.basic.entity.ProductType;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

public interface ProductTypeService {

	/** 添加 **/
	public abstract int save(ProductType object);
	
	/** 修改 **/
	public abstract int mdfy(ProductType object);
	
	/** 删除 **/
	public abstract int lose(String id);
	
	/** 删除 **/
	public abstract int lose(ProductType object);
	
	/** 查找 **/
	public abstract ProductType find(String id);
	
	/** 查找 **/
	public abstract ProductType find(ProductType object);
	
	/** 分页 **/
	public abstract Page<ProductType> page(PageParam pageParam, ProductType object);
	
	/** 列举 **/
	public abstract List<ProductType> list(ProductType object);
	
}
