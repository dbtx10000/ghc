package com.alidao.basic.entity;

import com.alidao.jxe.model.SpkModel;

public class Proverb extends SpkModel  {

    private static final long serialVersionUID = 1L;

    private String content;

    public void beforeInsert() {

    }

    public void beforeUpdate() {

    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content == null ? null : content.trim();
    }
}