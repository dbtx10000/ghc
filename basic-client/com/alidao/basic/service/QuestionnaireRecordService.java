package com.alidao.basic.service;

import com.alidao.basic.entity.QuestionnaireRecord;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;

public interface QuestionnaireRecordService {

    public  abstract int save(QuestionnaireRecord object);

    public  abstract int save(List<QuestionnaireRecord> objects);

    public  abstract int lose(String id);

    public  abstract int lose(QuestionnaireRecord object);

    public  abstract int mdfy(QuestionnaireRecord object);

    public  abstract QuestionnaireRecord find(String id);

    public  abstract QuestionnaireRecord find(QuestionnaireRecord object);

    public  abstract Page<QuestionnaireRecord> page(PageParam pageParam, QuestionnaireRecord object);

    public  abstract List<QuestionnaireRecord> list(QuestionnaireRecord object);

	public abstract int save(String questionnaireId, String[] topicId,
			String[] optionId);
}