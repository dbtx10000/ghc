package com.alidao.basic.entity;

import com.alidao.jxe.model.SpkModel;


public class GameRecord extends SpkModel  {

    private static final long serialVersionUID = 1L;

    private String gameId;

    private String userId;

    private String userAccount;

    private String userName;

    private String userImage;

    private Integer score;

    private String shareSn;

    private Integer friendScore;
    
    private Integer ranking;
    
    private Double income;
    
    private Integer friendCount;
    
    public void beforeInsert() {

    }

    public void beforeUpdate() {

    }

    public String getGameId() {
        return gameId;
    }

    public void setGameId(String gameId) {
        this.gameId = gameId == null ? null : gameId.trim();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId == null ? null : userId.trim();
    }

    public String getUserAccount() {
        return userAccount;
    }

    public void setUserAccount(String userAccount) {
        this.userAccount = userAccount == null ? null : userAccount.trim();
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName == null ? null : userName.trim();
    }

    public String getUserImage() {
        return userImage;
    }

    public void setUserImage(String userImage) {
        this.userImage = userImage == null ? null : userImage.trim();
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public String getShareSn() {
        return shareSn;
    }

    public void setShareSn(String shareSn) {
        this.shareSn = shareSn == null ? null : shareSn.trim();
    }

	public Integer getFriendScore() {
		return friendScore;
	}

	public void setFriendScore(Integer friendScore) {
		this.friendScore = friendScore;
	}

	public Integer getRanking() {
		return ranking;
	}

	public void setRanking(Integer ranking) {
		this.ranking = ranking;
	}

	public Double getIncome() {
		return income;
	}

	public void setIncome(Double income) {
		this.income = income;
	}

	public Integer getFriendCount() {
		return friendCount;
	}

	public void setFriendCount(Integer friendCount) {
		this.friendCount = friendCount;
	}
    
}