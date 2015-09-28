package com.alidao.users.service.impl;

import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.authorizing.UseridTracker;
import com.alidao.users.dao4mybatis.UserRiskEvaluationDao;
import com.alidao.users.entity.UserRiskEvaluation;
import com.alidao.users.service.UserRiskEvaluationService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserRiskEvaluationServiceImpl implements UserRiskEvaluationService {

     @Autowired 
     private UserRiskEvaluationDao userRiskEvaluationDao;


    public int save(UserRiskEvaluation object) {
    	UserRiskEvaluation userRiskEvaluation=new UserRiskEvaluation();
    	userRiskEvaluation.setUserId(UseridTracker.get());
    	userRiskEvaluationDao.delete(userRiskEvaluation);
    	object.setUserId(UseridTracker.get());
        return userRiskEvaluationDao.insert(object);
    }

    public int save(List<UserRiskEvaluation> objects) {
        int result = 0;
        for (UserRiskEvaluation object : objects) {
            result &= userRiskEvaluationDao.insert(object);
        }
        return result;
    }

    public int lose(String id) {
        return userRiskEvaluationDao.deleteByPrimaryKey(id);
    }

    public int lose(UserRiskEvaluation object) {
        return userRiskEvaluationDao.delete(object);
    }

    public int mdfy(UserRiskEvaluation object) {
        return userRiskEvaluationDao.update(object);
    }

    public UserRiskEvaluation find(String id) {
        return userRiskEvaluationDao.selectByPrimaryKey(id);
    }

    public UserRiskEvaluation find(UserRiskEvaluation object) {
        return userRiskEvaluationDao.select(object);
    }

    public Page<UserRiskEvaluation> page(PageParam pageParam, UserRiskEvaluation object) {
        return userRiskEvaluationDao.queryForPage(pageParam,object);
    }

    public List<UserRiskEvaluation> list(UserRiskEvaluation object) {
        return userRiskEvaluationDao.queryForList(object);
    }
    
    public Map<String, Object> index() {
		UserRiskEvaluation userRiskEvaluation=new UserRiskEvaluation();
		userRiskEvaluation.setUserId(UseridTracker.get());
		int score=0;
		String result="";
		Map<String,Object> map=new HashMap<String,Object>();
		List<UserRiskEvaluation> list=userRiskEvaluationDao.queryForList(userRiskEvaluation);
		for(UserRiskEvaluation object:list){
			score+=object.getScore();
		}
		if(13<=score&&score<=20){
			result="保守型";
		}else if(21<=score&&score<=29){
			result="稳健型";
		}else if(30<=score&&score<=39){
			result="平衡型";
		}else if(40<=score&&score<=49){
			result="进取型";
		}else if(50<=score&&score<=58){
			result="激进型";
		}
		userRiskEvaluation=userRiskEvaluationDao.select(userRiskEvaluation);
		if(userRiskEvaluation!=null){
			map.put("date", userRiskEvaluation.getCreateTime());
			map.put("result", result);
			map.put("score", score);
			return map;
		}
		return null;
	}
}