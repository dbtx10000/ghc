package com.alidao.wxapi.service;

import java.util.List;

import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.wxapi.entity.WxapiMenus;

public interface WxapiMenusService {

	public abstract int save(WxapiMenus object);
	
	public abstract int mdfy(WxapiMenus object);
	
	public abstract int lose(Long id);
	
	public abstract int lose(WxapiMenus object);
	
	public abstract WxapiMenus find(Long id);
	
	public abstract WxapiMenus find(WxapiMenus object);
	
	public abstract Page<WxapiMenus> page(PageParam pageParam, WxapiMenus object);
	
	public abstract List<WxapiMenus> list(WxapiMenus object);
	
}
