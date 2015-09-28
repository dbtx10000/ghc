package com.alidao.gifts.entity;

import com.alidao.jxe.model.LpkModel;

public class GiftsOrder extends LpkModel  {

    private static final long serialVersionUID = 1L;
    
    // 状态{0.已取消|1.未发货,2.已发货,3.已收货|1.未使用,2.已使用}'
    
    public static final int CLOSED = 0;

    public static final int UN_DELIVER = 1;
    public static final int DELIVER_ED = 2;
    public static final int RECEIVE_ED = 3;
    
    public static final int UN_USE = 1;
    public static final int USE_ED = 2;

    private String orderNo;

    private Integer integral;

    private String integralSourceId;

    private String userId;

    private String username;

    private String realname;

    private String mobile;

    private String giftId;

    private String giftname;

    private Integer gifttype;

    private String images;

    private Integer nums;

    private String note;

    private String address;

    private Integer status;

    public void beforeInsert() {

    }

    public void beforeUpdate() {

    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo == null ? null : orderNo.trim();
    }

    public Integer getIntegral() {
        return integral;
    }

    public void setIntegral(Integer integral) {
        this.integral = integral;
    }

    public String getIntegralSourceId() {
        return integralSourceId;
    }

    public void setIntegralSourceId(String integralSourceId) {
        this.integralSourceId = integralSourceId == null ? null : integralSourceId.trim();
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

    public String getRealname() {
        return realname;
    }

    public void setRealname(String realname) {
        this.realname = realname == null ? null : realname.trim();
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile == null ? null : mobile.trim();
    }

    public String getGiftId() {
        return giftId;
    }

    public void setGiftId(String giftId) {
        this.giftId = giftId == null ? null : giftId.trim();
    }

    public String getGiftname() {
        return giftname;
    }

    public void setGiftname(String giftname) {
        this.giftname = giftname == null ? null : giftname.trim();
    }

    public Integer getGifttype() {
        return gifttype;
    }

    public void setGifttype(Integer gifttype) {
        this.gifttype = gifttype;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images == null ? null : images.trim();
    }

    public Integer getNums() {
        return nums;
    }

    public void setNums(Integer nums) {
        this.nums = nums;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note == null ? null : note.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}