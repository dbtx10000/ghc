package com.alidao.basic.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.basic.dao4mybatis.IntroDao;
import com.alidao.basic.entity.Intro;
import com.alidao.basic.service.IntroService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

@Service
public class IntroServiceImpl implements IntroService {

	@Autowired
	private IntroDao introDao;
	
	public int save(Intro object) {
		return introDao.insert(object);
	}
	
	public int mdfy(Intro object) {
		return introDao.update(object);
	}
	
	public int lose(Long id) {
		return introDao.deleteByPrimaryKey(id);
	}

	public int lose(Intro object) {
		return introDao.delete(object);
	}
	
	public Intro find(Long id) {
		return introDao.selectByPrimaryKey(id);
	}
	
	public Intro find(Intro object) {
		return introDao.select(object);
	}

	public Page<Intro> page(PageParam pageParam, Intro object) {
		return introDao.queryForPage(pageParam, object);
	}

	public List<Intro> list(Intro object) {
		return introDao.queryForList(object);
	}

}
