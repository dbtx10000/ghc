package com.alidao.wxapi.bean;

import java.util.List;

public class WxChatResult {

	private String fromUserName;
	
	private String toUserName;
	
	private String msgType;
	
	private Long createTime;

	private String content;

	private Integer articleCount;
	
	private List<WxChatResultArticle> articles;
	
	public String getFromUserName() {
		return fromUserName;
	}

	public void setFromUserName(String fromUserName) {
		this.fromUserName = fromUserName;
	}

	public String getToUserName() {
		return toUserName;
	}

	public void setToUserName(String toUserName) {
		this.toUserName = toUserName;
	}

	public String getMsgType() {
		return msgType;
	}

	public void setMsgType(String msgType) {
		this.msgType = msgType;
	}

	public Long getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Long createTime) {
		this.createTime = createTime;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getArticleCount() {
		return articleCount;
	}

	public void setArticleCount(Integer articleCount) {
		this.articleCount = articleCount;
	}

	public List<WxChatResultArticle> getArticles() {
		return articles;
	}

	public void setArticles(List<WxChatResultArticle> articles) {
		this.articles = articles;
	}

}
