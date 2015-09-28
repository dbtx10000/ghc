package com.alidao.basic.service.impl;

import com.alidao.basic.dao4mybatis.QuestionnaireDao;
import com.alidao.basic.entity.Questionnaire;
import com.alidao.basic.service.QuestionnaireService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class QuestionnaireServiceImpl implements QuestionnaireService {

     @Autowired 
     private QuestionnaireDao questionnaireDao;


    public int save(Questionnaire object) {
    	object.beforeInsert();
        return questionnaireDao.insert(object);
    }

    public int save(List<Questionnaire> objects) {
        int result = 0;
        for (Questionnaire object : objects) {
            result &= questionnaireDao.insert(object);
        }
        return result;
    }

    public int lose(String id) {
        return questionnaireDao.deleteByPrimaryKey(id);
    }

    public int lose(Questionnaire object) {
        return questionnaireDao.delete(object);
    }

    public int mdfy(Questionnaire object) {
        return questionnaireDao.update(object);
    }

    public Questionnaire find(String id) {
        return questionnaireDao.selectByPrimaryKey(id);
    }

    public Questionnaire find(Questionnaire object) {
        return questionnaireDao.select(object);
    }

    public Page<Questionnaire> page(PageParam pageParam, Questionnaire object) {
        return questionnaireDao.queryForPage(pageParam,object);
    }

    public List<Questionnaire> list(Questionnaire object) {
        return questionnaireDao.queryForList(object);
    }
}