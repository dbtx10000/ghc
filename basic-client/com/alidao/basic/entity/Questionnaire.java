package com.alidao.basic.entity;

import com.alidao.jxe.model.SpkModel;

public class Questionnaire extends SpkModel  {

    private static final long serialVersionUID = 1L;

    private String title;

    private String image;

    private Integer topicCount;

    private Integer userCount;

    private Integer integral;
    
    public void beforeInsert() {
    	if (this.topicCount == null) {
    		this.topicCount = 0;
    	}
    	if (this.userCount == null) {
    		this.userCount = 0;
    	}
    }

    public void beforeUpdate() {
    	
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title == null ? null : title.trim();
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image == null ? null : image.trim();
    }

    public Integer getTopicCount() {
        return topicCount;
    }

    public void setTopicCount(Integer topicCount) {
        this.topicCount = topicCount;
    }

    public Integer getUserCount() {
        return userCount;
    }

    public void setUserCount(Integer userCount) {
        this.userCount = userCount;
    }

	public Integer getIntegral() {
		return integral;
	}

	public void setIntegral(Integer integral) {
		this.integral = integral;
	}
    
}