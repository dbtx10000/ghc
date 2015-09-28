package com.alidao.wxapi.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.wxapi.dao4mybatis.WxapiChatsDao;
import com.alidao.wxapi.entity.WxapiChats;
import com.alidao.wxapi.service.WxapiChatsService;

@Service
public class WxapiChatsServiceImpl implements WxapiChatsService {

	@Autowired
	private WxapiChatsDao wxapiChatsDao;
	
	public int save(WxapiChats object) {
		return wxapiChatsDao.insert(object);
	}
	
	public int mdfy(WxapiChats object) {
		return wxapiChatsDao.update(object);
	}
	
	public int lose(Long id) {
		return wxapiChatsDao.deleteByPrimaryKey(id);
	}

	public int lose(WxapiChats object) {
		return wxapiChatsDao.delete(object);
	}
	
	public WxapiChats find(Long id) {
		return wxapiChatsDao.selectByPrimaryKey(id);
	}
	
	public WxapiChats find(WxapiChats object) {
		return wxapiChatsDao.select(object);
	}

	public Page<WxapiChats> page(PageParam pageParam, WxapiChats object) {
		return wxapiChatsDao.queryForPage(pageParam, object);
	}

	public List<WxapiChats> list(WxapiChats object) {
		return wxapiChatsDao.queryForList(object);
	}

}
