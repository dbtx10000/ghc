package com.alidao.basic.service;

import java.util.List;

import com.alidao.basic.entity.Const;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

public interface ConstService {

	public abstract int save(Const object);
	
	public abstract int mdfy(Const object);
	
	public abstract int lose(Long id);
	
	public abstract int lose(Const object);
	
	public abstract Const find(Long id);
	
	public abstract Const find(Const object);
	
	public abstract Page<Const> page(PageParam pageParam, Const object);
	
	public abstract List<Const> list(Const object);
	
}
