package com.alidao.wxapi.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.wxapi.dao4mybatis.WxapiReplyDao;
import com.alidao.wxapi.entity.WxapiReply;
import com.alidao.wxapi.service.WxapiReplyService;

@Service
public class WxapiReplyServiceImpl implements WxapiReplyService {

	@Autowired
	private WxapiReplyDao wxapiReplyDao;
	
	public int save(WxapiReply object) {
		object.beforeInsert();
		return wxapiReplyDao.insert(object);
	}
	
	public int mdfy(WxapiReply object) {
		return wxapiReplyDao.update(object);
	}
	
	public int lose(Long id) {
		return wxapiReplyDao.deleteByPrimaryKey(id);
	}

	public int lose(WxapiReply object) {
		return wxapiReplyDao.delete(object);
	}
	
	public WxapiReply find(Long id) {
		return wxapiReplyDao.selectByPrimaryKey(id);
	}
	
	public WxapiReply find(WxapiReply object) {
		return wxapiReplyDao.select(object);
	}

	public Page<WxapiReply> page(PageParam pageParam, WxapiReply object) {
		return wxapiReplyDao.queryForPage(pageParam, object);
	}

	public List<WxapiReply> list(WxapiReply object) {
		return wxapiReplyDao.queryForList(object);
	}

}
