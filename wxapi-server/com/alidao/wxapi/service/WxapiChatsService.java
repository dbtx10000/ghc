package com.alidao.wxapi.service;

import java.util.List;

import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.wxapi.entity.WxapiChats;

public interface WxapiChatsService {

	public abstract int save(WxapiChats object);
	
	public abstract int mdfy(WxapiChats object);
	
	public abstract int lose(Long id);
	
	public abstract int lose(WxapiChats object);
	
	public abstract WxapiChats find(Long id);
	
	public abstract WxapiChats find(WxapiChats object);
	
	public abstract Page<WxapiChats> page(PageParam pageParam, WxapiChats object);
	
	public abstract List<WxapiChats> list(WxapiChats object);
	
}
