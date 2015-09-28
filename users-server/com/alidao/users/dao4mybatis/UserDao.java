package com.alidao.users.dao4mybatis;

import org.springframework.stereotype.Repository;

import com.alidao.jxe.ibatis.BaseDao;
import com.alidao.users.entity.User;

@Repository
public class UserDao extends BaseDao<User> {

	// 扩展方法写下面

	public int modifyCounts(User object) {
		return super.update("modifyCounts", object);
	}
	
	//解除与销售用户的关系
	public int relieveSaler(User object) {
		return super.update("relieveSaler", object);
	}
	
}
