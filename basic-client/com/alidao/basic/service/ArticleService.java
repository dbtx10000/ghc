package com.alidao.basic.service;

import java.util.List;

import com.alidao.basic.entity.Article;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

public interface ArticleService {

	public abstract int save(Article object);
	
	public abstract int mdfy(Article object);
	
	public abstract int lose(Long id);
	
	public abstract int lose(Article object);
	
	public abstract Article find(Long id);
	
	public abstract Article find(Article object);
	
	public abstract Page<Article> page(PageParam pageParam, Article object);
	
	public abstract List<Article> list(Article object);
	
}
