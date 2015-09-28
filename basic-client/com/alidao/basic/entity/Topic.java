package com.alidao.basic.entity;

import java.util.List;

import com.alidao.jxe.model.SpkModel;

public class Topic extends SpkModel  {

    private static final long serialVersionUID = 1L;

    private String questionnaireId;

    private String name;

    private Integer seq;

    private Integer choose;

    private Integer type;

    private List<Option> optionList;
    
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

    public Integer getChoose() {
        return choose;
    }

    public void setChoose(Integer choose) {
        this.choose = choose;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

	public List<Option> getOptionList() {
		return optionList;
	}

	public void setOptionList(List<Option> optionList) {
		this.optionList = optionList;
	}
    
}