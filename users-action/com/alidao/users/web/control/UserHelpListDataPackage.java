package com.alidao.users.web.control;

import java.util.List;

import com.alidao.users.entity.UserHelper;

public class UserHelpListDataPackage {

	public List<UserHelper> list;
	
	public List<UserHelper> getList() {
		return list;
	}

	public void setList(List<UserHelper> list) {
		this.list = list;
	}

}
