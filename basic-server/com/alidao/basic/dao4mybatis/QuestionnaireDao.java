package com.alidao.basic.dao4mybatis;

import com.alidao.basic.entity.Questionnaire;
import com.alidao.jxe.ibatis.BaseDao;
import org.springframework.stereotype.Repository;

@Repository
public class QuestionnaireDao extends BaseDao<Questionnaire> {
	public int modifyCounts(Questionnaire object) {
		return super.update("modifyCounts", object);
	}
}