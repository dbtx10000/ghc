package com.alidao.users.service;

import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.entity.UserRiskEvaluation;
import java.util.List;
import java.util.Map;

public interface UserRiskEvaluationService {

    public  abstract int save(UserRiskEvaluation object);

    public  abstract int save(List<UserRiskEvaluation> objects);

    public  abstract int lose(String id);

    public  abstract int lose(UserRiskEvaluation object);

    public  abstract int mdfy(UserRiskEvaluation object);

    public  abstract UserRiskEvaluation find(String id);

    public  abstract UserRiskEvaluation find(UserRiskEvaluation object);

    public  abstract Page<UserRiskEvaluation> page(PageParam pageParam, UserRiskEvaluation object);

    public  abstract List<UserRiskEvaluation> list(UserRiskEvaluation object);

    public abstract Map<String,Object> index();
}