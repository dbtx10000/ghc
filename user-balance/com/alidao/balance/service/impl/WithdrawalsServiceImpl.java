package com.alidao.balance.service.impl;

import com.alidao.balance.dao4mybatis.BalanceDao;
import com.alidao.balance.dao4mybatis.BalanceRecordDao;
import com.alidao.balance.dao4mybatis.WithdrawalsDao;
import com.alidao.balance.dao4mybatis.WithdrawalsDetailDao;
import com.alidao.balance.entity.Balance;
import com.alidao.balance.entity.BalanceRecord;
import com.alidao.balance.entity.Withdrawals;
import com.alidao.balance.entity.WithdrawalsDetail;
import com.alidao.balance.service.WithdrawalsService;
import com.alidao.cnpay.util.FundRtPayBack;
import com.alidao.cnpay.util.FundRtPayForm;
import com.alidao.cnpay.util.FundRtPayUtil;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class WithdrawalsServiceImpl implements WithdrawalsService {

     @Autowired 
     private WithdrawalsDao withdrawalsDao;
     
     @Autowired
     private BalanceRecordDao balanceRecordDao;
     
     @Autowired
     private WithdrawalsDetailDao withdrawalsDetailDao;
     
     @Autowired
     private BalanceDao balanceDao;
     

    public int save(Withdrawals object) {
        return withdrawalsDao.insert(object);
    }

    public int save(List<Withdrawals> objects) {
        int result = 0;
        for (Withdrawals object : objects) {
            result &= withdrawalsDao.insert(object);
        }
        return result;
    }

    public int lose(Long id) {
        return withdrawalsDao.deleteByPrimaryKey(id);
    }

    public int lose(Withdrawals object) {
        return withdrawalsDao.delete(object);
    }

    public int mdfy(Withdrawals object) {
        return withdrawalsDao.update(object);
    }

    public Withdrawals find(Long id) {
        return withdrawalsDao.selectByPrimaryKey(id);
    }

    public Withdrawals find(Withdrawals object) {
        return withdrawalsDao.select(object);
    }

    public Page<Withdrawals> page(PageParam pageParam, Withdrawals object) {
        return withdrawalsDao.queryForPage(pageParam,object);
    }

    public List<Withdrawals> list(Withdrawals object) {
        return withdrawalsDao.queryForList(object);
    }

	public int saveBussiness(BalanceRecord balanceRecord, Withdrawals object) {
		Balance balance=new Balance();
		balance.setUserId(balanceRecord.getUserId());
		balance=balanceDao.select(balance);
		balance.setSurplusBalance(balance.getSurplusBalance()-balanceRecord.getMoney());
		balance.setFreezingBalance(balance.getFreezingBalance()+balanceRecord.getMoney());
		balance.setLastModify(new Date().getTime());
		balanceDao.update(balance);
		
		balanceRecordDao.insert(balanceRecord);
		withdrawalsDao.insert(object);
		WithdrawalsDetail withdrawalsDetail = new WithdrawalsDetail();
		withdrawalsDetail.setWithdrawalsId(object.getId());
		withdrawalsDetail.setStatus(WithdrawalsDetail.STATUS_SUBMIT_APPLY);
		withdrawalsDetail.setNote("");
		return withdrawalsDetailDao.insert(withdrawalsDetail);
	}

	public int mdfyBussiness(Withdrawals object) {
		int status = 0;
		FundRtPayForm form = new FundRtPayForm();
		form.setCardNo(object.getBankCardNo());
		form.setCity(object.getBankUserCity());
		form.setMerSeqId(object.getSerial());
		form.setOpenBank(object.getOpenBankName());
		form.setProv(object.getBankUserProv());
		form.setPurpose(FundRtPayUtil.USE_WITHDRAWALS);
		form.setTransAmt(String.valueOf(object.getMoney()*100));
		form.setUsrName(object.getBankUserName());
		try {
			FundRtPayBack back = FundRtPayUtil.pay(form);
			Withdrawals  withdrawals = new Withdrawals();
			withdrawals.setId(object.getId());
			withdrawals.setMoney(object.getMoney());
			withdrawals.setAfterBalance(object.getMoney());
			WithdrawalsDetail withdrawalsDetail = new WithdrawalsDetail();
			withdrawalsDetail.setWithdrawalsId(object.getId());
			Balance balance = new Balance();
			balance.setUserId(object.getUserId());
			balance = balanceDao.select(balance);
			BalanceRecord balanceRecord = new BalanceRecord();
			balanceRecord.setUserId(object.getUserId());
			balanceRecord.setUsername(object.getUsername());
			balanceRecord.setRealname(object.getRealname());
			balanceRecord.setType(BalanceRecord.TYPE_WITHDRAWALS);
			balanceRecord.setMoney(object.getMoney());
			balanceRecord.setBeforeBalance(balance.getSurplusBalance());
			balanceRecord.setAfterBalance(balance.getSurplusBalance() + object.getMoney());
			balance.setTotalBalance(balance.getTotalBalance());
			balance.setFreezingBalance(balance.getFreezingBalance());
			balance.setSurplusBalance(balance.getSurplusBalance());
			balance.setLastModify(new Date().getTime());
			if(back.getStat().equals("s")) {//交易成功
				withdrawals.setStatus(Withdrawals.STATUS_DISPOSE_SUCCESS);
				withdrawalsDetail.setStatus(WithdrawalsDetail.STATUS_DISPOSE_SUCCESS);
				balanceRecord.setStatus(BalanceRecord.STATUS_DISPOSEING);
			} else {
				withdrawals.setStatus(Withdrawals.STATUS_DISPOSE_FAIL);
				withdrawals.setNote(FundRtPayUtil.parseStat(back.getStat()));
				withdrawalsDetail.setStatus(WithdrawalsDetail.STATUS_DISPOSE_FAIL);
				balanceRecord.setStatus(BalanceRecord.STATUS_DISPOSE_FAIL);
			}
			status = withdrawalsDao.update(withdrawals);//更新提现表
			status = withdrawalsDetailDao.insert(withdrawalsDetail);//插入一条提现详细表
			status = balanceRecordDao.insert(balanceRecord);//插入一条余额变动记录
			status = balanceDao.updateMoney(balance);//更新余额表
		} catch (IOException e) {
			e.printStackTrace();
		}
		return status;
	}
}