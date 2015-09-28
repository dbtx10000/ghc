package com.alidao.wxapi.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.wxapi.dao4mybatis.WxapiMenusDao;
import com.alidao.wxapi.entity.WxapiMenus;
import com.alidao.wxapi.service.WxapiMenusService;

@Service
public class WxapiMenusServiceImpl implements WxapiMenusService {

	@Autowired
	private WxapiMenusDao wxapiMenusDao;
	
	public int save(WxapiMenus object) {
		return wxapiMenusDao.insert(object);
	}
	
	public int mdfy(WxapiMenus object) {
		return wxapiMenusDao.update(object);
	}
	
	public int lose(Long id) {
		return wxapiMenusDao.deleteByPrimaryKey(id);
	}

	public int lose(WxapiMenus object) {
		return wxapiMenusDao.delete(object);
	}
	
	public WxapiMenus find(Long id) {
		return wxapiMenusDao.selectByPrimaryKey(id);
	}
	
	public WxapiMenus find(WxapiMenus object) {
		return wxapiMenusDao.select(object);
	}

	public Page<WxapiMenus> page(PageParam pageParam, WxapiMenus object) {
		return wxapiMenusDao.queryForPage(pageParam, object);
	}

	public List<WxapiMenus> list(WxapiMenus object) {
		return wxapiMenusDao.queryForList(object);
	}
	
}
