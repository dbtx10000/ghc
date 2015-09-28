package com.alidao.users.entity;

import com.alidao.jxe.model.SpkModel;

public class UserRiskEvaluation extends SpkModel  {

    private static final long serialVersionUID = 1L;

    private String userId;

    private Integer score;

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

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }
}