package com.alidao.users.service;

import java.util.List;

import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.entity.UserIntegral;

public interface UserIntegralService {

	public abstract int save(UserIntegral object);
	
	public abstract int mdfy(UserIntegral object);
	
	public abstract int lose(Long id);
	
	public abstract int lose(UserIntegral object);
	
	public abstract UserIntegral find(Long id);
	
	public abstract UserIntegral find(UserIntegral object);
	
	public abstract Page<UserIntegral> page(PageParam pageParam, UserIntegral object);
	
	public abstract List<UserIntegral> list(UserIntegral object);
	
	public abstract int isum(String userId, Integer type);
	
	public abstract int read(String userId);
	
	public abstract boolean lnum(String userId, String relate, Integer limit, Integer type);
	
	/** 获取我的金币 **/
	public abstract Integer getMyVaildIntegral(String uid, String types, Long integralTypeId);
	
	/** 获取我的金币 **/
	public abstract Integer getMyVaildIntegral(String uid, String types);
	
	/** 获取我的已过期金币 **/
	public abstract Integer getMyOverdueIntegral(String uid, String types);
	
	/** 获取我的即将过期金币 **/
	public abstract Integer getMySoonOverdueIntegral(String uid, String types);
	
}
