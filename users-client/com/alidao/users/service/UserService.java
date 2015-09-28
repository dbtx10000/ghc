package com.alidao.users.service;

import java.util.List;

import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.entity.User;
import com.alidao.users.entity.UserBind;

public interface UserService {

	public abstract int save(User object) throws Exception ;
	
	public abstract int mdfy(User object);
	
	public abstract int lose(String id);
	
	public abstract int lose(User object);
	
	public abstract User find(String id);
	
	public abstract User find(User object);
	
	public abstract Page<User> page(PageParam pageParam, User object);
	
	public abstract List<User> list(User object);
	
	// 方法扩展写下面
	
	public abstract int plus(User object);
	
	public abstract int bind(String id, String openid, Integer type);
	
	public abstract int bind(String id, String openid, Integer type, Boolean login);
	
	public abstract int drop(String id, String openid, Integer type);
	
	public abstract int over(String id, String openid, Integer type);
	
	public abstract User find(String openid, Integer type);
	
	public abstract int send(String id);	//邀请赠送金币

	public abstract int give(User object);	//后台赠送金币
	
	public abstract UserBind findUserBind(String id, int type);
	
}
