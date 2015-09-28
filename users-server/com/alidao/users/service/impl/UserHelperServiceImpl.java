package com.alidao.users.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.dao4mybatis.UserHelperDao;
import com.alidao.users.entity.UserHelper;
import com.alidao.users.service.UserHelperService;

@Service
public class UserHelperServiceImpl implements UserHelperService {

	@Autowired
	private UserHelperDao userHelperDao;
	
	public int save(UserHelper object) {
		return userHelperDao.insert(object);
	}
	
	public int mdfy(UserHelper object) {
		return userHelperDao.update(object);
	}
	
	public int lose(Long id) {
		return userHelperDao.deleteByPrimaryKey(id);
	}

	public int lose(UserHelper object) {
		return userHelperDao.delete(object);
	}
	
	public UserHelper find(Long id) {
		return userHelperDao.selectByPrimaryKey(id);
	}
	
	public UserHelper find(UserHelper object) {
		return userHelperDao.select(object);
	}

	public Page<UserHelper> page(PageParam pageParam, UserHelper object) {
		return userHelperDao.queryForPage(pageParam, object);
	}

	public List<UserHelper> list(UserHelper object) {
		return userHelperDao.queryForList(object);
	}

}
