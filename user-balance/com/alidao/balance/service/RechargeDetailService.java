package com.alidao.balance.service;

import com.alidao.balance.entity.RechargeDetail;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;

public interface RechargeDetailService {

    public  abstract int save(RechargeDetail object);

    public  abstract int save(List<RechargeDetail> objects);

    public  abstract int lose(Long id);

    public  abstract int lose(RechargeDetail object);

    public  abstract int mdfy(RechargeDetail object);

    public  abstract RechargeDetail find(Long id);

    public  abstract RechargeDetail find(RechargeDetail object);

    public  abstract Page<RechargeDetail> page(PageParam pageParam, RechargeDetail object);

    public  abstract List<RechargeDetail> list(RechargeDetail object);
}