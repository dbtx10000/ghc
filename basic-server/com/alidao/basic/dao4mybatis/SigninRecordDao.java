package com.alidao.basic.dao4mybatis;

import com.alidao.basic.entity.SigninRecord;
import com.alidao.jxe.ibatis.BaseDao;
import org.springframework.stereotype.Repository;

@Repository
public class SigninRecordDao extends BaseDao<SigninRecord> {

	public SigninRecord thisWeekSigninRecord(String userId) {
		return super.select("thisWeekSigninRecord",userId);
	}

}