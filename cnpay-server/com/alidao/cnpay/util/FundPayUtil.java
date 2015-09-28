package com.alidao.cnpay.util;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.NameValuePair;
import org.apache.http.message.BasicNameValuePair;

import com.alibaba.fastjson.JSON;
import com.alidao.common.Constants;
import com.alidao.jse.util.BeanUtil;
import com.alidao.jse.util.StringUtil;
import com.alidao.jxe.util.PojoUtil;
import com.alidao.sst.tool.ClientUtil;

public final class FundPayUtil {

	private FundPayUtil() {}

	private static Log log = LogFactory.getLog(FundPayUtil.class);

	private static ClassLoader loader = FundPayUtil.class.getClassLoader();

	/**
	 * @throws IOException 
	 */
	public static FundPayBack pay(FundPayForm form) throws IOException {
		String mid = Constants.get("cnp.pay_mer");
		chinapay.PrivateKey prk = new chinapay.PrivateKey();
		String mpk = loader.getResource(
				Constants.get("cnp.pay_prk")).getFile();
		if (prk.buildKey(mid, 0, mpk)) {
			chinapay.SecureLink sec = new chinapay.SecureLink(prk);
			FundPayBean bean = PojoUtil.convert(form, FundPayBean.class);
			bean.setMerId(mid);
			String chk = sec.Sign(bean.message());
			bean.setChkValue(chk);
			Map<String, Object> pars = BeanUtil.bean2Map(bean, true);
			List<NameValuePair> nvps = new ArrayList<NameValuePair>();
			for (Map.Entry<String, Object> entry : pars.entrySet()) {
				nvps.add(
					new BasicNameValuePair(
						entry.getKey(), (String) entry.getValue()
					)
				);
			}
			String url = Constants.get("cnp.pay_url");
			String txt = ClientUtil.sendPost(url, nvps);
			if (true) {
				String[] kvs = txt.split("&");
				Map<String, String> m = new HashMap<String, String>();
				for (String kv : kvs) {
					m.put(kv.split("=")[0], kv.split("=")[1]);
				}
				FundPayBack back = 
						MapToObject.parse(m, FundPayBack.class);
				back.setTransDate(bean.getTransDate());
				back.setOrderNo(bean.getOrderNo());
				return back;
			}
		}
		return null;
	}
	
	/**
	 * @throws IOException 
	 */
	public static FundQryBack qry(FundQryForm form) throws IOException {
		String mid = Constants.get("cnp.pay_mer");
		chinapay.PrivateKey prk = new chinapay.PrivateKey();
		String mpk = loader.getResource(
				Constants.get("cnp.pay_prk")).getFile();
		if (prk.buildKey(mid, 0, mpk)) {
			chinapay.SecureLink sec = new chinapay.SecureLink(prk);
			FundQryBean bean = PojoUtil.convert(form, FundQryBean.class);
			bean.setMerId(mid);
			String chk = sec.Sign(bean.message());
			bean.setChkValue(chk);
			Map<String, Object> pars = BeanUtil.bean2Map(bean, true);
			List<NameValuePair> nvps = new ArrayList<NameValuePair>();
			for (Map.Entry<String, Object> entry : pars.entrySet()) {
				nvps.add(
					new BasicNameValuePair(
						entry.getKey(), (String) entry.getValue()
					)
				);
			}
			String url = Constants.get("cnp.qry_url");
			String txt = ClientUtil.sendPost(url, nvps);
			if (true) {
				String[] kvs = txt.split("&");
				Map<String, String> m = new HashMap<String, String>();
				for (String kv : kvs) {
					m.put(kv.split("=")[0], kv.split("=")[1]);
				}
				return MapToObject.parse(m, FundQryBack.class);
			}
		}
		return null;
	}
	
	/**
	 * @throws IOException 
	 */
	public static UsrOpenBack usr(UsrOpenForm form, String returnUrl) 
			throws IOException {
		String fundTransSerial = form.getSerial();
		UsrOpenInfo info = new UsrOpenInfo();
		info.setInstuId(Constants.get("cnp.usr_mer"));
		info.setFundMerId(Constants.get("cnp.usr_mer"));
		info.setTransType("1010");
		info.setFundTransDate(fundTransSerial.substring(0, 8));
		info.setFundTransTime(fundTransSerial.substring(8, 14));
		info.setFundTransSerial(fundTransSerial);
		info.setProtocol("");
		info.setCardNo(form.getCardNo());
		info.setUserName(form.getUserName());
		info.setUserType(form.getCardNo().length() < 20 ? "9" : "0");
		info.setCertType(form.getCertType());
		info.setCertId(form.getCertId());
		info.setOpenBankName(form.getOpenBankName());
		info.setSubOpenBankName("");
		info.setOpenBankProvince("");
		info.setOpenBankCity("");
		info.setGender(form.getGender());
		info.setEmail("");
		info.setMobile(form.getMobile());
		info.setFundType("");
		info.setFundCode("");
		info.setResv1("");
		info.setResv2("");
		info.setResv3("");
		info.setResv4("");
		
		String encMsg = info.serial();
		String sgnMsg = encMsg;
		
		log.info("数据明文：" + info.serial());
		
		chinapay.PrivateKey pbk = new chinapay.PrivateKey();
		String pg_pubk = Constants.get("cnp.usr_pbk");
		String ppk = loader.getResource(pg_pubk).getFile();
		if (pbk.buildKey(Constants.get("cnp.usr_cnp"), 0, ppk)) {
			chinapay.SecureLink sec = new chinapay.SecureLink(pbk);
			sec.newEncData_J_Client(encMsg.getBytes("GBK"));
			encMsg = sec.getEncMsg();
			log.info("银联号：" + Constants.get("cnp.usr_cnp"));
			log.info("银联公钥路径：" + Constants.get("cnp.usr_pbk"));
			log.info("EncMsg：" + encMsg + 
					",MsgLen：" + encMsg.length());
		} else {
			return null;
		}
		
		chinapay.PrivateKey prk = new chinapay.PrivateKey();
		String mer_prk = Constants.get("cnp.usr_prk");
		String mpk = loader.getResource(mer_prk).getFile();
		if (prk.buildKey(Constants.get("cnp.usr_mer"), 0, mpk)) {
			chinapay.SecureLink sec = new chinapay.SecureLink(prk);
			sec.newSignData_J_Client(0, sgnMsg.getBytes("GBK"));
			sec.newEncData_J_Client(sgnMsg.getBytes("GBK"));
			sgnMsg = sec.getCheckValue();
			log.info("商户号：" + Constants.get("cnp.usr_mer"));
			log.info("商户私钥路径：" + Constants.get("cnp.usr_prk"));
			log.info("SgnMsg：" + sgnMsg + 
					",SgnMsg：" + sgnMsg.length());
		} else {
			return null;
		}
		
		UsrOpenBean bean = new UsrOpenBean();
		bean.setVersion("20040616");
		bean.setFundTransTime(fundTransSerial.substring(0, 14));
		bean.setInstuId(Constants.get("cnp.usr_mer"));
		bean.setFundMerId(Constants.get("cnp.usr_mer"));
		bean.setTransType("1010");
		bean.setReturnUrl(returnUrl);
		bean.setEncMsg(encMsg);
		bean.setSignMsg(sgnMsg);
		
		Map<String, Object> pars = BeanUtil.bean2Map(bean, true);
		List<NameValuePair> nvps = new ArrayList<NameValuePair>();
		for (Map.Entry<String, Object> entry : pars.entrySet()) {
			nvps.add(
				new BasicNameValuePair(
					entry.getKey(), (String) entry.getValue()
				)
			);
		}
		String url = Constants.get("cnp.usr_url");
		String txt = ClientUtil.sendPost(url, nvps);
		
		log.info("返回数据：" + txt);
		
		if (StringUtil.isNotBlank(txt)) {
			String[] kvs = txt.split("&");
			Map<String, String> m = new HashMap<String, String>();
			for (String kv : kvs) {
				int idx = kv.indexOf('=');
				String key = kv.substring(0, idx);
				String val = kv.substring(idx + 1);
				if (StringUtil.isNotBlank(val)) {
					m.put(key, val);
				}
			}
			bean = MapToObject.parse(m, UsrOpenBean.class);
			if (bean != null && bean.getEncMsg() != null) {
				prk = new chinapay.PrivateKey();
				if (prk.buildKey(Constants.get("cnp.usr_mer"), 0, mpk)) {
					chinapay.SecureLink sec = new chinapay.SecureLink(prk);
					sec.newDecData_J_Client(bean.getEncMsg());
					String decMsg = new String(sec.getDecMsg(), "GBK");
					log.info("DecMsg：" + decMsg + 
							",DecMsg：" + decMsg.length());
					UsrOpenBack back = UsrOpenBack.entity(decMsg);
					log.info(JSON.toJSONString(back));
					return back;
				} else {
					return null;
				}
			}
		}
		return null;
	}
	
	public static void main(String[] args) throws IOException {
		UsrOpenForm form = new UsrOpenForm();
		form.setCardNo("6226900200218154");
		form.setCertId("211103198405122331");
		form.setCertType("01");
		form.setGender("M");
		form.setMobile("13812345678");
		form.setOpenBankId("0302");
		form.setOpenBankName("中信银行");
		form.setSerial("20150524201519");
		form.setUserName("朱江");
		String returnUrl = "http://lee1240.eicp.net/ghc/cnpay/sokey";
		usr(form, returnUrl);
	}
	
}
