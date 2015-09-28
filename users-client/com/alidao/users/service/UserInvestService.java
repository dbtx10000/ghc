package com.alidao.users.service;

import java.util.List;

import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.entity.UserInvest;

public interface UserInvestService {

	public abstract int save(UserInvest object);
	
	public abstract int mdfy(UserInvest object);
	
	public abstract void updateReaded(UserInvest object);
	
	public abstract int lose(Long id);
	
	public abstract int lose(UserInvest object);
	
	public abstract UserInvest find(Long id);
	
	public abstract UserInvest find(UserInvest object);
	
	public abstract Page<UserInvest> page(PageParam pageParam, UserInvest object);
	
	public abstract List<UserInvest> list(UserInvest object);
	
	public abstract int isum(String userId, Integer status);
	
	public abstract Double gsum(String userId, Integer status);
	
	/** 定时改变投资记录状态 **/
	public abstract void sset() throws Exception ;
	
}
