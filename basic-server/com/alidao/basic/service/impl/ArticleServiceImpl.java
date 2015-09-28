package com.alidao.basic.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.basic.dao4mybatis.ArticleDao;
import com.alidao.basic.entity.Article;
import com.alidao.basic.service.ArticleService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

@Service
public class ArticleServiceImpl implements ArticleService {

	@Autowired
	private ArticleDao articleNewsDao;
	
	public int save(Article object) {
		return articleNewsDao.insert(object);
	}
	
	public int mdfy(Article object) {
		return articleNewsDao.update(object);
	}
	
	public int lose(Long id) {
		return articleNewsDao.deleteByPrimaryKey(id);
	}

	public int lose(Article object) {
		return articleNewsDao.delete(object);
	}
	
	public Article find(Long id) {
		return articleNewsDao.selectByPrimaryKey(id);
	}
	
	public Article find(Article object) {
		return articleNewsDao.select(object);
	}

	public Page<Article> page(PageParam pageParam, Article object) {
		return articleNewsDao.queryForPage(pageParam, object);
	}

	public List<Article> list(Article object) {
		return articleNewsDao.queryForList(object);
	}

}
