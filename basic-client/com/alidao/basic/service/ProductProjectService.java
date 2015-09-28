package com.alidao.basic.service;

import java.util.List;

import com.alidao.basic.entity.ProductProject;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

public interface ProductProjectService {

	/** 添加 **/
	public abstract int save(ProductProject object);
	
	/** 修改 **/
	public abstract int mdfy(ProductProject object);
	
	/** 删除 **/
	public abstract int lose(String id);
	
	/** 删除 **/
	public abstract int lose(ProductProject object);
	
	/** 查找 **/
	public abstract ProductProject find(String id);
	
	/** 查找 **/
	public abstract ProductProject find(ProductProject object);
	
	/** 分页 **/
	public abstract Page<ProductProject> page(PageParam pageParam, ProductProject object);
	
	/** 列举 **/
	public abstract List<ProductProject> list(ProductProject object);
	
}
