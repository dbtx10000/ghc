package com.alidao.balance.service;

import com.alidao.balance.entity.BalanceRecord;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;

public interface BalanceRecordService {

    public  abstract int save(BalanceRecord object);

    public  abstract int save(List<BalanceRecord> objects);

    public  abstract int lose(Long id);

    public  abstract int lose(BalanceRecord object);

    public  abstract int mdfy(BalanceRecord object);

    public  abstract BalanceRecord find(Long id);

    public  abstract BalanceRecord find(BalanceRecord object);

    public  abstract Page<BalanceRecord> page(PageParam pageParam, BalanceRecord object);

    public  abstract List<BalanceRecord> list(BalanceRecord object);
}