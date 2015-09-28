package com.alidao.basic.entity;

import com.alidao.jxe.model.SpkModel;

public class QuestionnaireRecord extends SpkModel  {

    private static final long serialVersionUID = 1L;

    private String questionnaireId;

    private String questionnaireTitle;

    private String topicId;

    private String topicName;

    private String userId;

    private String username;

    private String optionId;

    private String optionOrdinal;

    private String optionName;

    private String userAccount;
    public void beforeInsert() {

    }

    public void beforeUpdate() {

    }

    public String getQuestionnaireId() {
        return questionnaireId;
    }

    public void setQuestionnaireId(String questionnaireId) {
        this.questionnaireId = questionnaireId == null ? null : questionnaireId.trim();
    }

    public String getQuestionnaireTitle() {
        return questionnaireTitle;
    }

    public void setQuestionnaireTitle(String questionnaireTitle) {
        this.questionnaireTitle = questionnaireTitle == null ? null : questionnaireTitle.trim();
    }

    public String getTopicId() {
        return topicId;
    }

    public void setTopicId(String topicId) {
        this.topicId = topicId == null ? null : topicId.trim();
    }

    public String getTopicName() {
        return topicName;
    }

    public void setTopicName(String topicName) {
        this.topicName = topicName == null ? null : topicName.trim();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username == null ? null : username.trim();
    }

    public String getOptionId() {
        return optionId;
    }

    public void setOptionId(String optionId) {
        this.optionId = optionId == null ? null : optionId.trim();
    }

    public String getOptionOrdinal() {
        return optionOrdinal;
    }

    public void setOptionOrdinal(String optionOrdinal) {
        this.optionOrdinal = optionOrdinal == null ? null : optionOrdinal.trim();
    }

    public String getOptionName() {
        return optionName;
    }

    public void setOptionName(String optionName) {
        this.optionName = optionName == null ? null : optionName.trim();
    }

	public String getUserAccount() {
		return userAccount;
	}

	public void setUserAccount(String userAccount) {
		this.userAccount = userAccount;
	}
    
}