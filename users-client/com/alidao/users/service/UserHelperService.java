package com.alidao.users.service;

import java.util.List;

import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.entity.UserHelper;

public interface UserHelperService {

	public abstract int save(UserHelper object);
	
	public abstract int mdfy(UserHelper object);
	
	public abstract int lose(Long id);
	
	public abstract int lose(UserHelper object);
	
	public abstract UserHelper find(Long id);
	
	public abstract UserHelper find(UserHelper object);
	
	public abstract Page<UserHelper> page(PageParam pageParam, UserHelper object);
	
	public abstract List<UserHelper> list(UserHelper object);
	
}
