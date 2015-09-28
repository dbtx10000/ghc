package com.alidao.basic.service;

import java.util.List;

import com.alidao.basic.entity.Product;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

public interface ProductService {

	/** 添加 **/
	public abstract int save(Product object, String[] zdyname, String[] zdynote);
	
	/** 修改 **/
	public abstract int mdfy(Product object, String[] zdyname, String[] zdynote);
	
	/** 删除 **/
	public abstract int lose(String id);
	
	/** 删除 **/
	public abstract int lose(Product object);
	
	/** 查找 **/
	public abstract Product find(String id);
	
	/** 查找 **/
	public abstract Product find(Product object);
	
	/** 分页 **/
	public abstract Page<Product> page(PageParam pageParam, Product object);
	
	/** 列举 **/
	public abstract List<Product> list(Product object);
	
}
