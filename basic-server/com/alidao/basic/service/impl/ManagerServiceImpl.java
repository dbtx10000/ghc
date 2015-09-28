package com.alidao.basic.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.basic.dao4mybatis.ManagerDao;
import com.alidao.basic.entity.Manager;
import com.alidao.basic.service.ManagerService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

@Service
public class ManagerServiceImpl implements ManagerService {

	@Autowired
	private ManagerDao managerDao;
	
	public int save(Manager object) {
		object.beforeInsert();
		return managerDao.insert(object);
	}
	
	public int mdfy(Manager object) {
		object.beforeUpdate();
		return managerDao.update(object);
	}

	public int lose(String id) {
		return managerDao.deleteByPrimaryKey(id);
	}

	public int lose(Manager object) {
		return managerDao.delete(object);
	}
	
	public Manager find(String id) {
		return managerDao.selectByPrimaryKey(id);
	}

	public Manager find(Manager object) {
		return managerDao.select(object);
	}

	public Page<Manager> page(PageParam pageParam, Manager object) {
		return managerDao.queryForPage(pageParam, object);
	}

}
