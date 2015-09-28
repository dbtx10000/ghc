package com.alidao.basic.entity;

import com.alidao.jxe.model.SpkModel;

public class SigninRecord extends SpkModel  {

    private static final long serialVersionUID = 1L;

    private String userId;

    private String userName;

    private Integer integral;

    public void beforeInsert() {

    }

    public void beforeUpdate() {

    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public Integer getIntegral() {
        return integral;
    }

    public void setIntegral(Integer integral) {
        this.integral = integral;
    }
}