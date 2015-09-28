package com.alidao.basic.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.basic.dao4mybatis.ProductProjectDao;
import com.alidao.basic.entity.ProductProject;
import com.alidao.basic.service.ProductProjectService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

@Service
public class ProductProjectServiceImpl implements ProductProjectService {

	@Autowired
	private ProductProjectDao productProjectDao;
	
	public int save(ProductProject object) {
		return productProjectDao.insert(object);
	}
	
	public int mdfy(ProductProject object) {
		return productProjectDao.update(object);
	}

	public int lose(String id) {
		return productProjectDao.deleteByPrimaryKey(id);
	}

	public int lose(ProductProject object) {
		return productProjectDao.delete(object);
	}
	
	public ProductProject find(String id) {
		return productProjectDao.selectByPrimaryKey(id);
	}

	public ProductProject find(ProductProject object) {
		return productProjectDao.select(object);
	}

	public Page<ProductProject> page(PageParam pageParam, ProductProject object) {
		Page<ProductProject> page = productProjectDao.queryForPage(pageParam, object);
		List<ProductProject> list = page.getTableList();
		for (int i = 0; list != null && i < list.size(); i++) {	
			//ProductProject productProject = list.get(i);
		}
		return page;
	}

	public List<ProductProject> list(ProductProject object) {
		return productProjectDao.queryForList(object);
	}
}
