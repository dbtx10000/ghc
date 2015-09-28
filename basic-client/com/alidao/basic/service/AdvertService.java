package com.alidao.basic.service;

import java.util.List;

import com.alidao.basic.entity.Advert;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

/**
 * 广告业务层接口
 */
public interface AdvertService {

	public abstract int save(Advert object);
	
	public abstract int lose(String id);
	
	public abstract Advert find(Advert object);
	
	public abstract Advert find(String id);
	
	public abstract List<Advert> list(Advert object);
	
	public abstract Page<Advert> page(PageParam pageParam, Advert object);
	
}
