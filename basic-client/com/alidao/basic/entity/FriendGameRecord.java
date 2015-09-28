package com.alidao.basic.entity;

import com.alidao.jxe.model.SpkModel;


public class FriendGameRecord extends SpkModel  {

    private static final long serialVersionUID = 1L;

    private String shareSn;

    private String wxnickname;

    private String headImage;

    private String openid;

    private Integer score;

    private Integer maxScore;
    
    public void beforeInsert() {

    }

    public void beforeUpdate() {

    }

    public String getShareSn() {
        return shareSn;
    }

    public void setShareSn(String shareSn) {
        this.shareSn = shareSn == null ? null : shareSn.trim();
    }

    public String getWxnickname() {
        return wxnickname;
    }

    public void setWxnickname(String wxnickname) {
        this.wxnickname = wxnickname == null ? null : wxnickname.trim();
    }

    public String getHeadImage() {
        return headImage;
    }

    public void setHeadImage(String headImage) {
        this.headImage = headImage == null ? null : headImage.trim();
    }

    public String getOpenid() {
        return openid;
    }

    public void setOpenid(String openid) {
        this.openid = openid == null ? null : openid.trim();
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

	public Integer getMaxScore() {
		return maxScore;
	}

	public void setMaxScore(Integer maxScore) {
		this.maxScore = maxScore;
	}
    
}