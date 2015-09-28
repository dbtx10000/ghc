package com.alidao.basic.service;

import com.alidao.basic.entity.Proverb;
import com.alidao.basic.entity.SigninRecord;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;
import java.util.Map;

public interface SigninRecordService {

    public  abstract int save(SigninRecord object);

    public  abstract int save(List<SigninRecord> objects);

    public  abstract int lose(String id);

    public  abstract int lose(SigninRecord object);

    public  abstract int mdfy(SigninRecord object);

    public  abstract SigninRecord find(String id);

    public  abstract SigninRecord find(SigninRecord object);

    public  abstract Page<SigninRecord> page(PageParam pageParam, SigninRecord object);

    public  abstract List<SigninRecord> list(SigninRecord object);
    /**签到*/
	public abstract Map<String,Object> signin(String userId);
	/**本周签到记录*/
	public abstract int thisWeekSigninRecord(String userId);

	public abstract Proverb findProverb();
}	