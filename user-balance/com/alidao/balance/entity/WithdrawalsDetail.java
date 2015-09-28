package com.alidao.balance.entity;

import com.alidao.jxe.model.LpkModel;


public class WithdrawalsDetail extends LpkModel  {

    private static final long serialVersionUID = 1L;
    
    /** 提交申请 **/
    public static final int STATUS_SUBMIT_APPLY = 1;
    /** 处理中 **/
    public static final int STATUS_DISPOSEING = 2;
    /** 处理成功 **/
    public static final int STATUS_DISPOSE_SUCCESS = 3;
    /** 处理失败 **/
    public static final int STATUS_DISPOSE_FAIL = 4;

    private Long withdrawalsId;

    private Integer status;

    private String note;

    public void beforeInsert() {

    }

    public void beforeUpdate() {

    }

    public Long getWithdrawalsId() {
        return withdrawalsId;
    }

    public void setWithdrawalsId(Long withdrawalsId) {
        this.withdrawalsId = withdrawalsId;
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
}