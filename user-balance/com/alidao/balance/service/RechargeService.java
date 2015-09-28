package com.alidao.balance.service;

import com.alidao.balance.entity.Recharge;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;
import java.util.Map;

public interface RechargeService {

    public  abstract int save(Recharge object);

    public  abstract int save(List<Recharge> objects);

    public  abstract int lose(Long id);

    public  abstract int lose(Recharge object);

    public  abstract int mdfy(Recharge object);

    public  abstract Recharge find(Long id);

    public  abstract Recharge find(Recharge object);

    public  abstract Page<Recharge> page(PageParam pageParam, Recharge object);

    public  abstract List<Recharge> list(Recharge object);
    /**余额充值**/
	public abstract int recharge(Long cardId, Double money,String userId);
}