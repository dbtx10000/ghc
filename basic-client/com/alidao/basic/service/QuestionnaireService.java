package com.alidao.basic.service;

import com.alidao.basic.entity.Questionnaire;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;

public interface QuestionnaireService {

    public  abstract int save(Questionnaire object);

    public  abstract int save(List<Questionnaire> objects);

    public  abstract int lose(String id);

    public  abstract int lose(Questionnaire object);

    public  abstract int mdfy(Questionnaire object);

    public  abstract Questionnaire find(String id);

    public  abstract Questionnaire find(Questionnaire object);

    public  abstract Page<Questionnaire> page(PageParam pageParam, Questionnaire object);

    public  abstract List<Questionnaire> list(Questionnaire object);
}