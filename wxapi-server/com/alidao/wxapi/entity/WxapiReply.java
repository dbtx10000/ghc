package com.alidao.wxapi.entity;

import com.alidao.jxe.model.LpkModel;

public class WxapiReply extends LpkModel {

	private static final long serialVersionUID = -5028716595692555249L;
	
	/** 关注时回复 **/
	public static final int MODE_SUB = 1;
	
	/** 无应答回复 **/
	public static final int MODE_NOT = 2;

	/** 自定义回复 **/
	public static final int MODE_KEY = 3;

	private String tags;

    private Integer mode;

    private Integer type;

    private Integer newsNumber;

    private Integer queryCount;

    private String txt;

    private String url;

    public void beforeInsert() {
    	if (this.newsNumber == null) {
    		this.newsNumber = 0;
    	}
		if (this.queryCount == null) {
			this.queryCount = 0;
		}
	}

    public String getTags() {
        return tags;
    }

    public void setTags(String tags) {
        this.tags = tags == null ? null : tags.trim();
    }

    public Integer getMode() {
        return mode;
    }

    public void setMode(Integer mode) {
        this.mode = mode;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Integer getNewsNumber() {
        return newsNumber;
    }

    public void setNewsNumber(Integer newsNumber) {
        this.newsNumber = newsNumber;
    }

    public Integer getQueryCount() {
        return queryCount;
    }

    public void setQueryCount(Integer queryCount) {
        this.queryCount = queryCount;
    }

    public String getTxt() {
        return txt;
    }

    public void setTxt(String txt) {
        this.txt = txt == null ? null : txt.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

}