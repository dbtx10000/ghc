package com.alidao.basic.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.alidao.basic.dao4mybatis.FcodeDao;
import com.alidao.basic.dao4mybatis.ManagerDao;
import com.alidao.basic.dao4mybatis.ProductDao;
import com.alidao.basic.entity.Fcode;
import com.alidao.basic.entity.Product;
import com.alidao.basic.service.FcodeService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.dao4mybatis.UserDao;
import com.alidao.users.entity.User;

@Service
public class FcodeServiceImpl implements FcodeService {

	@Autowired
	private FcodeDao fcodeDao;
	
	@Autowired
	private ManagerDao managerDao;
	
	@Autowired
	private ProductDao productDao;
	
	@Autowired
	private UserDao userDao;
	
	public int save(Fcode object, Integer nums) {
		int result = 1;
		for (int i = 0; i < nums; i++) {
			Fcode fcode = new Fcode();
			fcode.setFcode(object.getFcode());
			fcode.setEndTime(object.getEndTime());
			fcode.beforeInsert();
			result &= fcodeDao.insert(fcode);;
		}
		return result;
	}
	
	public int mdfy(Fcode object) {
		return fcodeDao.update(object);
	}

	public int lose(String id) {
		return fcodeDao.deleteByPrimaryKey(id);
	}

	public int lose(Fcode object) {
		return fcodeDao.delete(object);
	}
	
	public Fcode find(String id) {
		return fcodeDao.selectByPrimaryKey(id);
	}

	public Fcode find(Fcode object) {
		return fcodeDao.select(object);
	}

	public Page<Fcode> page(PageParam pageParam, Fcode object) {
		Page<Fcode> page = fcodeDao.queryForPage(pageParam, object);
		List<Fcode> list = page.getTableList();
		for (int i = 0; list != null && i < list.size(); i++) {	
			Fcode fcode = list.get(i);
			//关联创建人信息
			fcode.setManager(managerDao.selectByPrimaryKey(fcode.getCreateUser()));
			//关联产品信息
			Product product = productDao.selectByPrimaryKey(fcode.getProductId());
			if (product != null) {
				fcode.setProduct(product);
			} else {
				product = new Product();
				product.setName("");
				fcode.setProduct(product);
			}
			//关联用户信息
			User user = userDao.selectByPrimaryKey(fcode.getUserId());
			if (user != null) {
				fcode.setUser(user);
			} else {
				user = new User();
				user.setRealname("");
				fcode.setUser(user);
			}
		}
		return page;
	}

	public List<Fcode> list(Fcode object) {
		return fcodeDao.queryForList(object);
	}
}
