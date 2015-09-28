package com.alidao.users.service.impl;

import com.alidao.jxe.help.PowerHelper;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.dao4mybatis.SalerDao;
import com.alidao.users.dao4mybatis.UserDao;
import com.alidao.users.entity.Saler;
import com.alidao.users.entity.User;
import com.alidao.users.service.SalerService;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SalerServiceImpl implements SalerService {

     @Autowired 
     private SalerDao salerDao;
     
     @Autowired
     private UserDao userDao;


    public int save(Saler object) {
        return salerDao.insert(object);
    }

    public int save(List<Saler> objects) {
        int result = 0;
        for (Saler object : objects) {
            result &= salerDao.insert(object);
        }
        return result;
    }

    public int lose(String id) {
        return salerDao.deleteByPrimaryKey(id);
    }

    public int lose(Saler object) {
        return salerDao.delete(object);
    }

    public int mdfy(Saler object) {
        return salerDao.update(object);
    }

    public Saler find(String id) {
        return salerDao.selectByPrimaryKey(id);
    }

    public Saler find(Saler object) {
        return salerDao.select(object);
    }

    public Page<Saler> page(PageParam pageParam, Saler object) {
        return salerDao.queryForPage(pageParam,object);
    }

    public List<Saler> list(Saler object) {
        return salerDao.queryForList(object);
    }

	public int beSaler(String userId) {
		int status = 1;
		User user = userDao.selectByPrimaryKey(userId);
		Saler object = new Saler();
		object.setUserId(userId);
		object.setAddress(user.getAddress());
		object.setAvatar(user.getAvatar());
		object.setCreateUser(PowerHelper.get());
		object.setCredentialsCode(user.getCredentialsCode());
		object.setCredentialsType(user.getCredentialsType());
		object.setEmail(user.getEmail());
		object.setIntro(user.getIntro());
		object.setMobile(user.getMobile());
		object.setPassword(user.getPassword());
		object.setRealname(user.getRealname());
		object.setUsername(user.getUsername());
		status = salerDao.insert(object);//保存销售用户
		user.setIsSaler(object.getId());
		status = userDao.update(user);//更新用户里是否是销售用户标识字段
		return status;
	}

	public int loseBusiness(String id) {
		User user = new User();
		user.setIsSaler(id);
		userDao.relieveSaler(user);
		return lose(id);
	}

	public int modifyCounts(Saler object) {
		return salerDao.modifyCounts(object);
	}
}