package com.alidao.users.entity;

import com.alidao.jxe.model.LpkModel;

public class UserHelper extends LpkModel {

	private static final long serialVersionUID = -7519408962185936246L;

	private Integer userType;
	
	private String typeName;

    private String detail;

    public Integer getUserType() {
        return userType;
    }

    public void setUserType(Integer userType) {
        this.userType = userType;
    }

    public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getDetail() {
        return detail;
    }

    public void setDetail(String detail) {
        this.detail = detail == null ? null : detail.trim();
    }
    
}