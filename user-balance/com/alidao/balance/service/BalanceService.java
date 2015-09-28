package com.alidao.balance.service;

import com.alidao.balance.entity.Balance;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;

public interface BalanceService {

    public  abstract int save(Balance object);

    public  abstract int save(List<Balance> objects);

    public  abstract int lose(Long id);

    public  abstract int lose(Balance object);

    public  abstract int mdfy(Balance object);

    public  abstract Balance find(Long id);

    public  abstract Balance find(Balance object);

    public  abstract Page<Balance> page(PageParam pageParam, Balance object);

    public  abstract List<Balance> list(Balance object);
}