package com.alidao.balance.service;

import com.alidao.balance.entity.WithdrawalsDetail;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.util.List;

public interface WithdrawalsDetailService {

    public  abstract int save(WithdrawalsDetail object);

    public  abstract int save(List<WithdrawalsDetail> objects);

    public  abstract int lose(Long id);

    public  abstract int lose(WithdrawalsDetail object);

    public  abstract int mdfy(WithdrawalsDetail object);

    public  abstract WithdrawalsDetail find(Long id);

    public  abstract WithdrawalsDetail find(WithdrawalsDetail object);

    public  abstract Page<WithdrawalsDetail> page(PageParam pageParam, WithdrawalsDetail object);

    public  abstract List<WithdrawalsDetail> list(WithdrawalsDetail object);
}