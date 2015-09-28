package com.alidao.basic.entity;

import com.alidao.jxe.model.SpkModel;

public class Option extends SpkModel  {

    private static final long serialVersionUID = 1L;

    private String topicId;

    private String ordinal;

    private String name;

    private Integer seq;

    public void beforeInsert() {

    }

    public void beforeUpdate() {

    }

    public String getTopicId() {
        return topicId;
    }

    public void setTopicId(String topicId) {
        this.topicId = topicId == null ? null : topicId.trim();
    }

    public String getOrdinal() {
        return ordinal;
    }

    public void setOrdinal(String ordinal) {
        this.ordinal = ordinal == null ? null : ordinal.trim();
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }
}