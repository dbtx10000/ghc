package com.alidao.basic.service;

import java.util.List;

import com.alidao.basic.entity.Fcode;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

public interface FcodeService {

	/** 添加 **/
	public abstract int save(Fcode object, Integer nums);
	
	/** 修改 **/
	public abstract int mdfy(Fcode object);
	
	/** 删除 **/
	public abstract int lose(String id);
	
	/** 删除 **/
	public abstract int lose(Fcode object);
	
	/** 查找 **/
	public abstract Fcode find(String id);
	
	/** 查找 **/
	public abstract Fcode find(Fcode object);
	
	/** 分页 **/
	public abstract Page<Fcode> page(PageParam pageParam, Fcode object);
	
	/** 列举 **/
	public abstract List<Fcode> list(Fcode object);
	
}
