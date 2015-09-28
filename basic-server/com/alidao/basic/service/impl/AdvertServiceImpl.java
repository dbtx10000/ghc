package com.alidao.basic.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.basic.dao4mybatis.AdvertDao;
import com.alidao.basic.dao4mybatis.ManagerDao;
import com.alidao.basic.entity.Advert;
import com.alidao.basic.entity.Manager;
import com.alidao.basic.service.AdvertService;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

/**
 * 广告业务层实现
 */
@Service
public class AdvertServiceImpl implements AdvertService {

	@Autowired
	private AdvertDao advertDao;
	
	@Autowired
	private ManagerDao managerDao;
	public int save(Advert object) {
		if (StringUtil.isEmpty(object.getId())) {
			return advertDao.insert(object);
		} else {
			return advertDao.update(object);
		}
	}

	public Advert find(Advert object) {
		Advert advert = advertDao.select(object);
		return advert;
	}

	public Page<Advert> page(PageParam pageParam, Advert object) {
		Page<Advert> page = advertDao.queryForPage(pageParam, object);
		List<Advert> list = page.getTableList();
		for (int i = 0; list != null && i < list.size(); i++) {
			Advert advert = list.get(i);
			// 设置添加者关联信息
			Manager manager = new Manager();
			manager.setId(advert.getCreaterId());
			advert.setCreater(managerDao.select(manager));
		}
		return page;
	}

	public int lose(String id) {
		return advertDao.deleteByPrimaryKey(id);
	}

	public Advert find(String id) {
		return advertDao.selectByPrimaryKey(id);
	}

	public List<Advert> list(Advert object) {
		return advertDao.queryForList(object);
	}
}
