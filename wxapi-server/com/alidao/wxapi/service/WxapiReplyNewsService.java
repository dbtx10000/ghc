package com.alidao.wxapi.service;

import java.util.List;

import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.wxapi.entity.WxapiReplyNews;

public interface WxapiReplyNewsService {

	public abstract int save(WxapiReplyNews object);
	
	public abstract int mdfy(WxapiReplyNews object);
	
	public abstract int lose(Long id);
	
	public abstract int lose(WxapiReplyNews object);
	
	public abstract WxapiReplyNews find(Long id);
	
	public abstract WxapiReplyNews find(WxapiReplyNews object);
	
	public abstract Page<WxapiReplyNews> page(PageParam pageParam, WxapiReplyNews object);
	
	public abstract List<WxapiReplyNews> list(WxapiReplyNews object);
	
}
