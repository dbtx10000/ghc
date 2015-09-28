package com.alidao.wxapi.service;

import java.util.List;

import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.wxapi.entity.WxapiReply;

public interface WxapiReplyService {

	public abstract int save(WxapiReply object);
	
	public abstract int mdfy(WxapiReply object);
	
	public abstract int lose(Long id);
	
	public abstract int lose(WxapiReply object);
	
	public abstract WxapiReply find(Long id);
	
	public abstract WxapiReply find(WxapiReply object);
	
	public abstract Page<WxapiReply> page(PageParam pageParam, WxapiReply object);
	
	public abstract List<WxapiReply> list(WxapiReply object);
	
}
