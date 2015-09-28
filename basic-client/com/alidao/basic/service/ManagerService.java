package com.alidao.basic.service;


import com.alidao.basic.entity.Manager;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

public interface ManagerService {

	/** 添加 **/
	public abstract int save(Manager object);
	
	/** 修改 **/
	public abstract int mdfy(Manager object);
	
	/** 删除 **/
	public abstract int lose(String id);
	
	/** 删除 **/
	public abstract int lose(Manager object);
	
	/** 查找 **/
	public abstract Manager find(String id);
	
	/** 查找 **/
	public abstract Manager find(Manager object);
	
	/** 分页 **/
	public abstract Page<Manager> page(PageParam pageParam, Manager object);
	
	
	
}
