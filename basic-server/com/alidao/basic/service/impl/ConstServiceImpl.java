package com.alidao.basic.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.basic.dao4mybatis.ConstDao;
import com.alidao.basic.entity.Const;
import com.alidao.basic.service.ConstService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

@Service
public class ConstServiceImpl implements ConstService {

	@Autowired
	private ConstDao constDao;
	
	public int save(Const object) {
		return constDao.insert(object);
	}
	
	public int mdfy(Const object) {
		return constDao.update(object);
	}
	
	public int lose(Long id) {
		return constDao.deleteByPrimaryKey(id);
	}

	public int lose(Const object) {
		return constDao.delete(object);
	}
	
	public Const find(Long id) {
		return constDao.selectByPrimaryKey(id);
	}
	
	public Const find(Const object) {
		return constDao.select(object);
	}

	public Page<Const> page(PageParam pageParam, Const object) {
		return constDao.queryForPage(pageParam, object);
	}

	public List<Const> list(Const object) {
		return constDao.queryForList(object);
	}

}
