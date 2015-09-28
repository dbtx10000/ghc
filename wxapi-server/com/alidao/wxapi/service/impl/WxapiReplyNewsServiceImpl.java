package com.alidao.wxapi.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.wxapi.dao4mybatis.WxapiReplyNewsDao;
import com.alidao.wxapi.entity.WxapiReplyNews;
import com.alidao.wxapi.service.WxapiReplyNewsService;

@Service
public class WxapiReplyNewsServiceImpl implements WxapiReplyNewsService {

	@Autowired
	private WxapiReplyNewsDao wxapiReplyNewsDao;
	
	public int save(WxapiReplyNews object) {
		return wxapiReplyNewsDao.insert(object);
	}
	
	public int mdfy(WxapiReplyNews object) {
		return wxapiReplyNewsDao.update(object);
	}
	
	public int lose(Long id) {
		return wxapiReplyNewsDao.deleteByPrimaryKey(id);
	}

	public int lose(WxapiReplyNews object) {
		return wxapiReplyNewsDao.delete(object);
	}
	
	public WxapiReplyNews find(Long id) {
		return wxapiReplyNewsDao.selectByPrimaryKey(id);
	}
	
	public WxapiReplyNews find(WxapiReplyNews object) {
		return wxapiReplyNewsDao.select(object);
	}

	public Page<WxapiReplyNews> page(PageParam pageParam, WxapiReplyNews object) {
		return wxapiReplyNewsDao.queryForPage(pageParam, object);
	}

	public List<WxapiReplyNews> list(WxapiReplyNews object) {
		return wxapiReplyNewsDao.queryForList(object);
	}

}
