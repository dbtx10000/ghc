package com.alidao.basic.entity;

import com.alidao.jxe.model.LpkModel;

public class Const extends LpkModel  {

    private static final long serialVersionUID = 1L;

    private Integer regisIntegral;

    private Integer buyIntegral;

    private Integer inviteIntegral;

    private Integer inviteBuyIntegral;

    private Integer buyIntegralLimit;

    private Integer inviteIntegralLimit;

    private Integer inviteBuyIntegralLimit;

    public void beforeInsert() {

    }

    public void beforeUpdate() {

    }

    public Integer getRegisIntegral() {
        return regisIntegral;
    }

    public void setRegisIntegral(Integer regisIntegral) {
        this.regisIntegral = regisIntegral;
    }

    public Integer getBuyIntegral() {
        return buyIntegral;
    }

    public void setBuyIntegral(Integer buyIntegral) {
        this.buyIntegral = buyIntegral;
    }

    public Integer getInviteIntegral() {
        return inviteIntegral;
    }

    public void setInviteIntegral(Integer inviteIntegral) {
        this.inviteIntegral = inviteIntegral;
    }

    public Integer getInviteBuyIntegral() {
        return inviteBuyIntegral;
    }

    public void setInviteBuyIntegral(Integer inviteBuyIntegral) {
        this.inviteBuyIntegral = inviteBuyIntegral;
    }

    public Integer getBuyIntegralLimit() {
        return buyIntegralLimit;
    }

    public void setBuyIntegralLimit(Integer buyIntegralLimit) {
        this.buyIntegralLimit = buyIntegralLimit;
    }

    public Integer getInviteIntegralLimit() {
        return inviteIntegralLimit;
    }

    public void setInviteIntegralLimit(Integer inviteIntegralLimit) {
        this.inviteIntegralLimit = inviteIntegralLimit;
    }

    public Integer getInviteBuyIntegralLimit() {
        return inviteBuyIntegralLimit;
    }

    public void setInviteBuyIntegralLimit(Integer inviteBuyIntegralLimit) {
        this.inviteBuyIntegralLimit = inviteBuyIntegralLimit;
    }
    
}