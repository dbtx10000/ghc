package com.alidao.balance.entity;

import com.alidao.jxe.model.LpkModel;


public class CardBindRecordDetail extends LpkModel  {

    private static final long serialVersionUID = 1L;
    
    public static final int BIND_SUBMIT = 11;//提交绑定
    
    public static final int BIND_SUCC = 12;//绑定成功
    
    public static final int BIND_FAIL = 13;//绑定失败
    
    public static final int UNBIND_SUBMIT = 21;//提交解绑
    
    public static final int UNBIND_SUCC = 22;//解绑成功
    
    public static final int UNBIND_FAIL = 23;//解绑失败

    private Long cardBindRecordId;

    private Integer status;

    private String note;

    private CardBindRecord cardBindRecord;
    
    public void beforeInsert() {

    }

    public void beforeUpdate() {

    }

    public Long getCardBindRecordId() {
        return cardBindRecordId;
    }

    public void setCardBindRecordId(Long cardBindRecordId) {
        this.cardBindRecordId = cardBindRecordId;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note == null ? null : note.trim();
    }

	public CardBindRecord getCardBindRecord() {
		return cardBindRecord;
	}

	public void setCardBindRecord(CardBindRecord cardBindRecord) {
		this.cardBindRecord = cardBindRecord;
	}
    
}