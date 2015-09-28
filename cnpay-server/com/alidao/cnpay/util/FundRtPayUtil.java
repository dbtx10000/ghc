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
import com.alidao.common.Constants;
import com.alidao.jse.util.BeanUtil;
import com.alidao.jxe.util.PojoUtil;
import com.alidao.sst.tool.ClientUtil;
/**
 * 银行向客户付款
 * @author huangyl
 *
 */
public final class FundRtPayUtil {

	private FundRtPayUtil() {}
	
	public static final String USE_RECHARGE = "充值";
	
	public static final String USE_WITHDRAWALS = "提现";
	 
	private static Log log = LogFactory.getLog(FundRtPayUtil.class);

	private static ClassLoader loader = FundRtPayUtil.class.getClassLoader();

	/**交易
	 * @throws IOException
	 */
	public static FundRtPayBack pay(FundRtPayForm form) throws IOException {
		String mid = Constants.get("cnp.rt_mer");
		chinapay.PrivateKey prk = new chinapay.PrivateKey();
		String mpk = loader.getResource(
				Constants.get("cnp.rt_prk")).getFile();
		if (prk.buildKey(mid, 0, mpk)) {
			chinapay.SecureLink sec = new chinapay.SecureLink(prk);
			FundRtPayBean bean = PojoUtil.convert(form, FundRtPayBean.class);
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
			String url = Constants.get("cnp.rt.pay_url");
			String txt = ClientUtil.sendPost(url, nvps);
			if (true) {
				String[] kvs = txt.split("&");
				Map<String, String> m = new HashMap<String, String>();
				for (String kv : kvs) {
					m.put(kv.split("=")[0], kv.split("=")[1]);
				}
				FundRtPayBack back = 
						MapToObject.parse(m, FundRtPayBack.class);
				return back;
			}
		}
		return null;
	}
	
	/**单笔查询
	 * @throws IOException 
	 */
	public static FundRtQryBack qry(FundRtQryForm form) throws IOException {
		String mid = Constants.get("cnp.rt_mer");
		chinapay.PrivateKey prk = new chinapay.PrivateKey();
		String mpk = loader.getResource(
				Constants.get("cnp.rt_prk")).getFile();
		if (prk.buildKey(mid, 0, mpk)) {
			chinapay.SecureLink sec = new chinapay.SecureLink(prk);
			FundRtQryBean bean = PojoUtil.convert(form, FundRtQryBean.class);
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
			String url = Constants.get("cnp.rt.qry_url");
			String txt = ClientUtil.sendPost(url, nvps);
			if (true) {
				String[] kvs = txt.split("&");
				Map<String, String> m = new HashMap<String, String>();
				for (String kv : kvs) {
					m.put(kv.split("=")[0], kv.split("=")[1]);
				}
				return MapToObject.parse(m, FundRtQryBack.class);
			}
		}
		return null;
	}
	
	public static String parseStat(String stat) {
		if("s".equals(stat)) {
			return "交易成功";
		} else if("2".equals(stat)) {
			return "处理中，交易已接受";
		}else if("3".equals(stat)) {
			return "财务已确认";
		}else if("4".equals(stat)) {
			return "财务处理中";
		}else if("5".equals(stat)) {
			return "已发往银行，ChinaPay已将代付交易发往银行。后续若银行返回结果，该状态会相应更新";
		}else if("6".equals(stat)) {
			return "银行退单，交易失败。";
		}else if("7".equals(stat)) {
			return "处理中，重汇已提交";
		}else if("8".equals(stat)) {
			return "处理中，重汇已发送，ChinaPay已将代付交易发往银行。后续若银行返回结果该状态会相应更新";
		}else if("9".equals(stat)) {
			return "银行对重汇的代付交易退单，交易失败。";
		}
		return "";
	}
	
	
	
	
	public static void main(String[] args) throws IOException {
		FundRtPayForm form = new FundRtPayForm();
		form.setCardNo("6214835710807387");
		form.setCity("杭州市");
		form.setMerSeqId("201508251546asdf");
		form.setOpenBank("招商银行");
		form.setProv("浙江省");
		form.setPurpose("商用");
		form.setTransAmt("1");
		form.setUsrName("黄玉林");
		FundRtPayBack back = FundRtPayUtil.pay(form);
		System.out.println(back.getResponseCode());
//		String s = "%E6%B5%99%E6%B1%9F%E7%9C%81";
//		System.out.println(s.length());
	}
	
}
