package com.alidao.balance.service.impl;

import com.alidao.balance.dao4mybatis.BalanceDao;
import com.alidao.balance.dao4mybatis.BalanceRecordDao;
import com.alidao.balance.dao4mybatis.RechargeDao;
import com.alidao.balance.dao4mybatis.RechargeDetailDao;
import com.alidao.balance.entity.Balance;
import com.alidao.balance.entity.BalanceRecord;
import com.alidao.balance.entity.Recharge;
import com.alidao.balance.entity.RechargeDetail;
import com.alidao.balance.service.RechargeService;
import com.alidao.cnpay.dao4mybatis.CardBindDao;
import com.alidao.cnpay.entity.CardBind;
import com.alidao.cnpay.util.FundPayBack;
import com.alidao.cnpay.util.FundPayForm;
import com.alidao.cnpay.util.FundPayUtil;
import com.alidao.cnpay.util.FundQryBack;
import com.alidao.cnpay.util.FundQryForm;
import com.alidao.cnpay.util.UnicodeUtil;
import com.alidao.common.Constants;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.dao4mybatis.UserDao;
import com.alidao.users.entity.User;
import java.util.Date;
import java.util.List;
import java.util.Random;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class RechargeServiceImpl implements RechargeService {
	private Log log = LogFactory.getLog(this.getClass());
     @Autowired 
     private RechargeDao rechargeDao;

     @Autowired
     private UserDao userDao;
     
     @Autowired
     private CardBindDao cardBindDao;

     @Autowired
     private BalanceDao balanceDao;
     
     @Autowired
     private BalanceRecordDao balanceRecordDao;
     
     @Autowired
     private RechargeDetailDao rechargeDetailDao;
     
    public int save(Recharge object) {
        return rechargeDao.insert(object);
    }

    public int save(List<Recharge> objects) {
        int result = 0;
        for (Recharge object : objects) {
            result &= rechargeDao.insert(object);
        }
        return result;
    }

    public int lose(Long id) {
        return rechargeDao.deleteByPrimaryKey(id);
    }

    public int lose(Recharge object) {
        return rechargeDao.delete(object);
    }

    public int mdfy(Recharge object) {
        return rechargeDao.update(object);
    }

    public Recharge find(Long id) {
        return rechargeDao.selectByPrimaryKey(id);
    }

    public Recharge find(Recharge object) {
        return rechargeDao.select(object);
    }

    public Page<Recharge> page(PageParam pageParam, Recharge object) {
        return rechargeDao.queryForPage(pageParam,object);
    }

    public List<Recharge> list(Recharge object) {
        return rechargeDao.queryForList(object);
    }

	public int recharge(Long cardId, Double money,String userId) {
		FundPayForm pForm=new FundPayForm ();
		Balance balance=new Balance();
		balance.setUserId(userId);
		balance=balanceDao.select(balance);
		User user=userDao.selectByPrimaryKey(userId);
		CardBind card=cardBindDao.selectByPrimaryKey(cardId);
		String transAmt = Constants.get("def.pay_cost");
		if (Constants.PRODUCT.equals(Constants.get("main.status"))) {
			transAmt = String.valueOf(money * 100);	// 分
		}
		if(card!=null){
			BalanceRecord balanceRecord=new BalanceRecord();
			balanceRecord.setUserId(userId);
			balanceRecord.setUsername(user.getMobile());
			balanceRecord.setRealname(user.getRealname());
			balanceRecord.setType(BalanceRecord.TYPE_RECHARGE);//充值
			balanceRecord.setMoney(money);
			balanceRecord.setStatus(BalanceRecord.STATUS_SUBMIT_APPLY);//提交申请
			balanceRecord.setBeforeBalance(balance.getSurplusBalance());
			balanceRecord.setAfterBalance(balance.getSurplusBalance()+money);
			balanceRecordDao.insert(balanceRecord);
			
			Recharge recharge=new Recharge();
			recharge.setSerial(StringUtil.genMsecSerial().substring(2) + new Random().nextInt(10));//流水号
			recharge.setUserId(userId);
			recharge.setUsername(user.getMobile());
			recharge.setRealname(user.getRealname());
			recharge.setMoney(money);
			recharge.setStatus(Recharge.STATUS_SUBMIT_APPLY);
			recharge.setBeforeBalance(balance.getSurplusBalance());
			recharge.setAfterBalance(balance.getSurplusBalance()+money);
			recharge.setOpenBankId(card.getOpenBankId());
			recharge.setOpenBankName(card.getOpenBankName());
			recharge.setBankCardNo(card.getCardNo());
			recharge.setBankUserName(card.getUserName());
			recharge.setBankCertId(card.getCertId());
			recharge.setBankCertType(card.getCertType());
			recharge.setBankUserProv("");//开户行省
			recharge.setBankUserCity("");//开户行市
			rechargeDao.insert(recharge);
			
			RechargeDetail rechargeDetail=new RechargeDetail();
			rechargeDetail.setRechargeId(recharge.getId());
			rechargeDetail.setStatus(RechargeDetail.STATUS_SUBMIT_APPLY);
			rechargeDetail.setNote("提交申请");
			rechargeDetailDao.insert(rechargeDetail);
			
			pForm.setTransAmt(transAmt);
			pForm.setOrderNo(recharge.getSerial());
			pForm.setCardNo(card.getCardNo());
			pForm.setOpenBankId(card.getOpenBankId());
			pForm.setUsrName(card.getUserName());
			pForm.setCertType(card.getCertType());
			pForm.setCertId(card.getCertId());
			pForm.setUsrName(UnicodeUtil.toUnicode(pForm.getUsrName()));
			try {
				FundPayBack pBack = FundPayUtil.pay(pForm);
				if ("00".equals(pBack.getResponseCode())) {	//成功
					balance.setSurplusBalance(balance.getSurplusBalance()+money);
					balance.setTotalBalance(balance.getSurplusBalance()+balance.getFreezingBalance());
					balance.setLastModify(new Date().getTime());
					balanceDao.update(balance);
					
					updateRecordStatus(Recharge.STATUS_DISPOSE_SUCCESS, balanceRecord, recharge, rechargeDetail,recharge.getOpenBankName()+" 尾号"+recharge.getBankCardNo().substring(recharge.getBankCardNo().length()-4));
					return 1;
					
				} else {
					String ts = pBack.getTransStat();
					if ("2000".equals(ts) || 
							"2045".equals(ts) || "2009".equals(ts)) {
						FundQryForm qForm = new FundQryForm(); 
						qForm.setOrderNo(pBack.getOrderNo());
						qForm.setTransDate(pBack.getTransDate());
						FundQryBack qBack = FundPayUtil.qry(qForm);
						if ("00".equals(qBack.getResponseCode())) {//成功
							balance.setSurplusBalance(balance.getSurplusBalance()+money);
							balance.setTotalBalance(balance.getSurplusBalance()+balance.getFreezingBalance());
							balance.setLastModify(new Date().getTime());
							balanceDao.update(balance);
							
							updateRecordStatus(Recharge.STATUS_DISPOSE_SUCCESS, balanceRecord, recharge, rechargeDetail,recharge.getOpenBankName()+" 尾号"+recharge.getBankCardNo().substring(recharge.getBankCardNo().length()-4));
							return 1;
						} else {
							updateRecordStatus(Recharge.STATUS_DISPOSEING, balanceRecord, recharge, rechargeDetail,"处理中");
							
							return 0;
						}
					} else {//失败
						updateRecordStatus(Recharge.STATUS_DISPOSE_FAIL, balanceRecord, recharge, rechargeDetail,pBack.getMessage());
						
						return -1;
					}
				}
			} catch (Exception e) {
				log.error(e);
			}
		}
		return 0;
	}
	public void updateRecordStatus(Integer status,BalanceRecord balanceRecord,Recharge recharge,RechargeDetail rechargeDetail,String note){
		balanceRecord.setStatus(status);
		balanceRecord.setNote(note);
		balanceRecordDao.update(balanceRecord);
		
		recharge.setNote(note);
		recharge.setStatus(status);
		rechargeDao.update(recharge);
		
		rechargeDetail.setId(null);
		rechargeDetail.setNote(note);
		rechargeDetail.setStatus(status);
		rechargeDetailDao.insert(rechargeDetail);
	}
}