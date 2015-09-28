package com.alidao.balance.service;

import com.alidao.balance.entity.BalanceRecord;
import com.alidao.balance.entity.Withdrawals;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import java.util.List;

public interface WithdrawalsService {

    public  abstract int save(Withdrawals object);
    
    public  abstract int saveBussiness(BalanceRecord balanceRecord,Withdrawals object);//带有业务的保存方法

    public  abstract int save(List<Withdrawals> objects);

    public  abstract int lose(Long id);

    public  abstract int lose(Withdrawals object);

    public  abstract int mdfy(Withdrawals object);
    
    public  abstract int mdfyBussiness(Withdrawals object);//带有业务的修改方法

    public  abstract Withdrawals find(Long id);

    public  abstract Withdrawals find(Withdrawals object);

    public  abstract Page<Withdrawals> page(PageParam pageParam, Withdrawals object);

    public  abstract List<Withdrawals> list(Withdrawals object);
}