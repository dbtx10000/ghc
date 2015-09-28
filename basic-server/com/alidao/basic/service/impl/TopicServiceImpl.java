package com.alidao.basic.service.impl;

import com.alidao.basic.dao4mybatis.OptionDao;
import com.alidao.basic.dao4mybatis.QuestionnaireDao;
import com.alidao.basic.dao4mybatis.TopicDao;
import com.alidao.basic.entity.Option;
import com.alidao.basic.entity.Questionnaire;
import com.alidao.basic.entity.Topic;
import com.alidao.basic.service.TopicService;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class TopicServiceImpl implements TopicService {

     @Autowired 
     private TopicDao topicDao;
     
     @Autowired
     private QuestionnaireDao questionnaireDao;

     @Autowired
     private OptionDao optionDao;
    public int save(Topic object,String [] ordinal,String [] topicName,Integer [] topicSeq) {
    	topicDao.insert(object);
    	for(int i=0;i<ordinal.length;i++){
    		Option option=new Option();
    		option.setTopicId(object.getId());
    		option.setOrdinal(ordinal[i]);
    		option.setName(topicName[i]);
    		option.setSeq(topicSeq[i]);
    		optionDao.insert(option);
    	}
    	Questionnaire questionnaire=new Questionnaire();
    	questionnaire.setId(object.getQuestionnaireId());
    	questionnaire.setTopicCount(1);
        return questionnaireDao.modifyCounts(questionnaire);
    }

    public int save(List<Topic> objects) {
        int result = 0;
        for (Topic object : objects) {
            result &= topicDao.insert(object);
        }
        return result;
    }

    public int lose(String id) {
    	Topic topic =topicDao.selectByPrimaryKey(id);
    	Option option =new Option();
    	option.setTopicId(topic.getId());
    	optionDao.delete(option);
    	Questionnaire questionnaire=new Questionnaire();
    	questionnaire.setId(topic.getQuestionnaireId());
    	questionnaire.setTopicCount(-1);
    	questionnaireDao.modifyCounts(questionnaire);
        return topicDao.deleteByPrimaryKey(id);
    }

    public int lose(Topic object) {
        return topicDao.delete(object);
    }

    public int mdfy(Topic object,String [] ordinal,String [] optionName,Integer [] optionSeq) {
    	Option option =new Option();
    	option.setTopicId(object.getId());
    	optionDao.delete(option);
    	for(int i=0;i<ordinal.length;i++){
    		Option optionNew=new Option();
    		optionNew.setTopicId(object.getId());
    		optionNew.setOrdinal(ordinal[i]);
    		optionNew.setName(optionName[i]);
    		optionNew.setSeq(optionSeq[i]);
    		optionDao.insert(optionNew);
    	}
        return topicDao.update(object);
    }

    public Topic find(String id) {
        return topicDao.selectByPrimaryKey(id);
    }

    public Topic find(Topic object) {
        return topicDao.select(object);
    }

    public Page<Topic> page(PageParam pageParam, Topic object) {
        return topicDao.queryForPage(pageParam,object);
    }

    public List<Topic> list(Topic object) {
        return topicDao.queryForList(object);
    }
}