package com.alidao.cnpay.wap.control;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.fastjson.JSON;
import com.alidao.balance.entity.CardBindRecordDetail;
import com.alidao.balance.service.CardBindRecordDetailService;
import com.alidao.basic.entity.Order;
import com.alidao.basic.entity.Product;
import com.alidao.basic.service.OrderService;
import com.alidao.basic.service.SmsService;
import com.alidao.cnpay.entity.CardBind;
import com.alidao.cnpay.service.CardBindService;
import com.alidao.cnpay.util.ChkOpenBean;
import com.alidao.cnpay.util.FundPayBack;
import com.alidao.cnpay.util.FundPayForm;
import com.alidao.cnpay.util.FundPayUtil;
import com.alidao.cnpay.util.FundQryBack;
import com.alidao.cnpay.util.FundQryForm;
import com.alidao.cnpay.util.UnicodeUtil;
import com.alidao.cnpay.util.UsrOpenBack;
import com.alidao.cnpay.util.UsrOpenForm;
import com.alidao.common.Constants;
import com.alidao.jse.util.BeanUtil;
import com.alidao.jse.util.Crypto;
import com.alidao.jse.util.DateUtil;
import com.alidao.jse.util.StringUtil;
import com.alidao.jse.util.URLDecoder;
import com.alidao.jse.util.URLEncoder;
import com.alidao.jxe.control.WebCtrl;
import com.alidao.jxe.model.ResponseForAjax;
import com.alidao.jxe.util.HttpUtil;
import com.alidao.sst.tool.Signature;
import com.alidao.users.authorizing.UseridTracker;
import com.alidao.users.entity.BuyProductRecord;
import com.alidao.users.entity.User;
import com.alidao.users.service.BuyProductRecordService;
import com.alidao.users.service.UserService;
import com.alidao.wxapi.bean.TokenForWxapis;
import com.alidao.wxapi.util.OpenidTracker;
import com.alidao.wxapi.util.WxapiUtil;

@Controller
@RequestMapping("wap/cnpay")
public class CnpayCtrl extends WebCtrl {
	
	private static ClassLoader loader = CnpayCtrl.class.getClassLoader();
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CardBindService cardBindService;

	@Autowired
	private OrderService orderService;
	
	@Autowired
	private SmsService smsService;
	
	@Autowired
	private BuyProductRecordService buyProductRecordService;
	
	@Autowired
	private CardBindRecordDetailService bindRecordDetailService;
	
	@RequestMapping(value = "sopen", method = RequestMethod.GET)
	public String sopen(Model model, String redirect_uri) {
		User user = userService.find(UseridTracker.get());
		if (user != null) {
			model.addAttribute("usrName", user.getRealname());
			model.addAttribute("certType", user.getCredentialsType());
			model.addAttribute("certId", user.getCredentialsCode());
			model.addAttribute("mobile", user.getMobile());
		}
		if (StringUtil.isNotBlank(redirect_uri)) {
			redirect_uri = URLDecoder.decode(redirect_uri);
		}
		model.addAttribute("redirect_uri", redirect_uri);
		return "wap/cnpay/open";
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "sopen", method = RequestMethod.POST)
	public String sopen(HttpServletRequest request, Model model,
			UsrOpenForm form, String redirect_uri) throws Exception {
		
		synchronized (this.getClass()) {
			Thread.sleep(1 * 1000);

			String returnUrl = HttpUtil.getWebAppUrl(request) + "/wap/cnpay/sokey";
			String serial = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
			
			CardBind cardBind = new CardBind();
			cardBind.setId(Long.parseLong(serial));
			cardBind.setCardNo(form.getCardNo());
			cardBind.setCertId(form.getCertId());
			cardBind.setCertType(form.getCertType());
			cardBind.setGender(form.getGender());
			cardBind.setMobile(form.getMobile());
			cardBind.setOpenBankId(form.getOpenBankId());
			cardBind.setOpenBankName(form.getOpenBankName());
			cardBind.setSerial(serial);
			cardBind.setStatus(0);
			cardBind.setUserName(form.getUserName());
			cardBind.setUserId(UseridTracker.get());
			long cardBindRecordId = cardBindService.saveBusiness(cardBind);
			
			form.setSerial(serial);
			UsrOpenBack back = FundPayUtil.usr(form, returnUrl);
			if (back != null && "000".equals(back.getResponseCode())) {
				CardBindRecordDetail bindRecordDetail = new CardBindRecordDetail();
				bindRecordDetail.setCardBindRecordId(cardBindRecordId);
				bindRecordDetail.setStatus(CardBindRecordDetail.BIND_SUCC);
				bindRecordDetailService.save(bindRecordDetail);//如果绑卡成功，插入一条绑卡记录详细
				ChkOpenBean bean = new ChkOpenBean();
				bean.setMerchantId(back.getFundMerId());
				bean.setMerchantOrderId(back.getFundTransSerial());
				String mot = back.getFundTransDate() + back.getFundTransTime();
				bean.setMerchantOrderTime(mot);
				bean.setOrderKey(back.getOrderKey());
				String url = HttpUtil.getWebAppUrl(request) + "/wap/cnpay/sbind?";
				url += ("openid=" + OpenidTracker.get());
				if (StringUtil.isNotBlank(redirect_uri)) {
					url += "&redirect_uri=" + URLEncoder.encode(redirect_uri);
				}
				bean.setPgRetUrl(URLEncoder.encode(url));
				String sign = bean.getMerchantId() + bean.getMerchantOrderId() 
						+ bean.getMerchantOrderTime() + bean.getOrderKey();
				chinapay.PrivateKey prk = new chinapay.PrivateKey();
				String mer_prk = Constants.get("cnp.usr_prk");
				String mpk = loader.getResource(mer_prk).getFile();
				if (prk.buildKey(Constants.get("cnp.usr_mer"), 0, mpk)) {
					chinapay.SecureLink sec = new chinapay.SecureLink(prk);
					sec.newSignData_J_Client(0, sign.getBytes());
					sec.newEncData_J_Client(sign.getBytes());
					sign = sec.getCheckValue();
					log.info("sign：" + sign + ",sign：" + sign.length());
				}
				bean.setSign(sign);
				Map map = BeanUtil.bean2Map(bean, true);
				String params = Signature.para(map);
				String chkUrl = Constants.get("cnp.chk_url");
				chkUrl = "redirect:" + chkUrl + "?" + params;
				log.info("chkUrl:" + chkUrl);
				return chkUrl;
			} else {
				User user = userService.find(UseridTracker.get());
				if (user != null) {
					model.addAttribute("usrName", user.getRealname());
					model.addAttribute("certType", user.getCredentialsType());
					model.addAttribute("certId", user.getCredentialsCode());
					model.addAttribute("mobile", user.getMobile());
				}
				model.addAttribute("redirect_uri", redirect_uri);
				model.addAttribute("form", form);
				CardBindRecordDetail bindRecordDetail = new CardBindRecordDetail();
				bindRecordDetail.setCardBindRecordId(cardBindRecordId);
				bindRecordDetail.setStatus(CardBindRecordDetail.BIND_FAIL);
				if (back == null) {
					bindRecordDetail.setNote("银行卡信息不正确");
					model.addAttribute("errmsg", "银行卡信息不正确");
				} else {
					bindRecordDetail.setNote(UnicodeUtil.toUnicode(back.getMessage()));
					model.addAttribute("errmsg", back.getMessage());
				}
				bindRecordDetailService.save(bindRecordDetail);//如果绑卡失败，插入一条绑卡记录详细
				return "wap/cnpay/open";
			}
		}
		
	}

	@RequestMapping("sokey")
	public void sokey(HttpServletRequest request, 
			HttpServletResponse response) throws IOException {
		Map<String, String[]> map = request.getParameterMap();
		log.info(JSON.toJSONString(map));
		response.getWriter().print("chinapayok");
	}
	
	@RequestMapping("sbind")
	public String sbind(HttpServletRequest request, 
			String redirect_uri, Model model) throws Exception {
		/*
		merId	字符型	定长，15位	必填字段，15位，基金公司商户号
		merOrdId	数字型	变长	必填字段，取值当日不可重复
		merOrdTime	字符型	定长，14位	必填字段，YYYYMMDDHHmmss
		respCode	字符型	变长 	必填字段，响应码 
		respMsg	字符型	变长	必填字段，响应描述
		*/
		String merId = request.getParameter("merId");
		log.info("merId：" + merId);
		String merOrdId = request.getParameter("merOrdId");
		log.info("merOrdId：" + merOrdId);
		String merOrdTime = request.getParameter("merOrdTime");
		log.info("merOrdTime：" + merOrdTime);
		String respCode = request.getParameter("respCode");
		log.info("respCode：" + respCode);
		String respMsg = request.getParameter("respMsg");
		log.info("respMsg：" + respMsg);
		if ("1001".equals(respCode)) {
			Long id = Long.parseLong(merOrdId);
			CardBind object = cardBindService.find(id);
			object.setStatus(1);
			cardBindService.mdfy(object);
			String userId = UseridTracker.get();
			User user = userService.find(userId);
			if (user != null) {
				CardBind cdt = new CardBind();
				cdt.setCardNo(object.getCardNo());
				cdt.addCondition("status", CardBind.CDT_IN, 
					"(1,2)", CardBind.SEP_AND);
				List<CardBind> list = cardBindService.list(cdt);
				if (list == null || list.size() < 2) {
					userService.send(userId);
				}
				String payPassword = user.getPayPassword();
				boolean hasPayPassword = StringUtil.isNotBlank(payPassword);
				user = new User();
				user.setId(userId);
				user.setCards(1);
				userService.plus(user);
				if (StringUtil.isNotBlank(redirect_uri)) {
					redirect_uri = URLDecoder.decode(redirect_uri);
					if (hasPayPassword) {
						return "redirect:" + redirect_uri;
					} else {
						String url = "/wap/user/payset/1?openid=";
						url += OpenidTracker.get();
						redirect_uri = URLEncoder.encode(redirect_uri);
						url += "&redirect_uri=" + redirect_uri;
						log.info("url:" + url);
						return "redirect:" + url;
					}
				} else {
					model.addAttribute("hasPayPassword", hasPayPassword);
				}
			}
			return "wap/cnpay/okey";
		} else {
			if (StringUtil.isNotBlank(redirect_uri)) {
				redirect_uri = URLEncoder.encode(redirect_uri);
				model.addAttribute("redirect_uri", redirect_uri);
			}
			model.addAttribute("errmsg", respMsg);
			return "wap/cnpay/fail";
		}
		
	}

	@RequestMapping("sgate")
	public String sgate(String order_no, Model model) {
		User user = userService.find(UseridTracker.get());
		if (user != null) {
			model.addAttribute("hasPayPassword", 
					StringUtil.isNotBlank(user.getPayPassword()));
			model.addAttribute("usrName", user.getRealname());
			model.addAttribute("certType", user.getCredentialsType());
			model.addAttribute("certId", user.getCredentialsCode());
			model.addAttribute("mobile", user.getMobile());
			
			// 查询我的银行卡
			CardBind card = new CardBind();
			card.setUserId(user.getId());
			card.setStatus(1);
			card.addOrderBy("create_time desc");
			List<CardBind> list = cardBindService.list(card);
			model.addAttribute("list", list);
		}
		model.addAttribute("order_no", order_no);
		Order order = orderService.find(order_no);
		if (order != null) {
			Integer trans_amt = order.getInvestMoney();
			trans_amt = trans_amt - order.getUseIntegral() - order.getCashMoney();
			if(order.getProductType()==Product.TYPE_SPECIAL&&order.getType()==0){//特权本金1元支付
				trans_amt=order.getActualMoney();
			}
			model.addAttribute("order_inf", order.getProduct().getName());
			model.addAttribute("trans_amt", trans_amt);
		}
		return "wap/cnpay/gate";
	}
	
	@RequestMapping("spaid")
	public void spaid(FundPayForm pForm, String payPassword, 
			String token, String mobile, HttpServletResponse response, 
			Long cardId) throws Exception {
		synchronized (CnpayCtrl.class) {
			ResponseForAjax resp = new ResponseForAjax();
			User user = userService.find(UseridTracker.get());
			if (StringUtil.isNotBlank(user.getPayPassword())) {
				if (user.getPayPassword().equals(Crypto.MD5(payPassword))) {
					if (!smsService.isok(mobile, token)) {
						resp.setMessage("手机验证码已过期!");
						resp.setResult(0);
					} else {
						CardBind card = cardBindService.find(cardId);
						pForm.setCardNo(card.getCardNo());
						pForm.setOpenBankId(card.getOpenBankId());
						pForm.setUsrName(card.getUserName());
						pForm.setCertType(card.getCertType());
						pForm.setCertId(card.getCertId());
						pForm.setUsrName(UnicodeUtil.toUnicode(pForm.getUsrName()));
						Order order = orderService.find(pForm.getOrderNo());
						if (order != null) {
							if (order.getStatus() == 1) {
								resp.setMessage("该订单已支付,请勿重新支付!");
								resp.setResult(0);
							} else if (order.getStatus() == 2) {
								resp.setMessage("该订单已关闭,发起支付失败!");
								resp.setResult(0);
							} else {
								String transAmt = Constants.get("def.pay_cost");
								if (Constants.PRODUCT.equals(Constants.get("main.status"))) {
									Integer money = order.getInvestMoney();	// 元
									money = money - order.getUseIntegral() - order.getCashMoney();
									if (order.getProductType() == Product.TYPE_SPECIAL && order.getType() ==0) {//特权本金1元支付
										money = order.getActualMoney();
									}
									transAmt = String.valueOf(money * 100);	// 分
								}
								SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmsss");
								order.setPayNo(sdf.format(new Date()) + new Random().nextInt(10));
								orderService.mdfy(order);
								pForm.setOrderNo(order.getPayNo());
								pForm.setTransAmt(transAmt);	// 设置支付金额
								FundPayBack pBack = FundPayUtil.pay(pForm);
								if ("00".equals(pBack.getResponseCode())) {	// 交易成功
									order.setStatus(1);
									order.setPayTime(new Date());
									order.setPayType(4);
									
									order.setCmerId(pBack.getMerId());
									order.setCardNo(card.getCardNo());
									order.setOpenBankId(card.getOpenBankId());
									order.setUserName(card.getUserName());
									order.setCertType(card.getCertType());
									order.setCertId(card.getCertId());
									
									orderService.mdfy(order);
									
									if (order.getProductType() == 1) {
										//交易确认模版推送
										String json_data = "";
										//组装json_data数据
										json_data = "{\"first\": {\"value\":\"您好，您的认购申请已确认。\",\"color\":\"#173177\"}," +
												"\"confirmDate\":{\"value\":\"" + DateUtil.getDateSampleString(new Date(), "yyyy-MM-dd") + "\",\"color\":\"#173177\"}," +
												"\"confirmMsg\": {\"value\":\"支付成功\",\"color\":\"#173177\"}," +
												"\"confirmMoney\": {\"value\":\"" + (order.getInvestMoney() - order.getUseIntegral() - order.getCashMoney()) + "元\",\"color\":\"#173177\"}," +
												"\"confirmAmount\": {\"value\":\"" + order.getInvestMoney() + "元\",\"color\":\"#173177\"}," +
												"\"remark\": {\"value\":\"如有疑问，请拨打咨询热线400-6196-805。\",\"color\":\"#173177\"}}";
										String paysuccTemplateId = Constants.get("paysucc.templateId");
										TokenForWxapis tokenForWxapis = WxapiUtil.getWxapisToken(Constants.get("wxapi.appid"), Constants.get("wxapi.appsecret"));
										//推送消息模版
										//这边不去查询UserBind表，因为这里直接可以拿到openid，所以不能和其他推送代码一样去查询用户绑定记录，直接这里获取当前的openid去推送
										WxapiUtil.sendTM2WxUser(tokenForWxapis.getAccess_token(), OpenidTracker.get(), paysuccTemplateId, "", json_data);
									}
									
									try {
										smsService.used(token);
									} catch (Exception e) {
										log.error("sms", e);
									}
									
									resp.setMessage(pBack.getMessage());
									resp.setResult(1);
								} else {
									String ts = pBack.getTransStat();
									if ("2000".equals(ts) || 
											"2045".equals(ts) || "2009".equals(ts)) {
										FundQryForm qForm = new FundQryForm(); 
										qForm.setOrderNo(pBack.getOrderNo());
										qForm.setTransDate(pBack.getTransDate());
										FundQryBack qBack = FundPayUtil.qry(qForm);
										if ("00".equals(qBack.getResponseCode())) {
											order.setStatus(1);
											order.setPayTime(new Date());
											order.setPayType(4);
											
											order.setCmerId(qBack.getMerId());
											order.setCardNo(qBack.getCardNo());
											order.setOpenBankId(qBack.getOpenBankId());
											order.setUserName(qBack.getUsrNme());
											order.setCertType(qBack.getCertType());
											order.setCertId(qBack.getCertId());
											
											orderService.mdfy(order);
											
											if (order.getProductType() == 1) {
												//交易确认模版推送
												String json_data = "";
												//组装json_data数据
												json_data = "{\"first\": {\"value\":\"您好，您的认购申请已确认。\",\"color\":\"#173177\"}," +
															"\"confirmDate\":{\"value\":\"" + DateUtil.getDateSampleString(new Date(), "yyyy-MM-dd") + "\",\"color\":\"#173177\"}," +
															"\"confirmMsg\": {\"value\":\"支付成功\",\"color\":\"#173177\"}," +
															"\"confirmMoney\": {\"value\":\"" + (order.getInvestMoney() - order.getUseIntegral() - order.getCashMoney()) + "元\",\"color\":\"#173177\"}," +
															"\"confirmAmount\": {\"value\":\"" + order.getInvestMoney() + "元\",\"color\":\"#173177\"}," +
															"\"remark\": {\"value\":\"如有疑问，请拨打咨询热线400-6196-805。\",\"color\":\"#173177\"}}";
												String paysuccTemplateId = Constants.get("paysucc.templateId");
												TokenForWxapis tokenForWxapis = WxapiUtil.getWxapisToken(Constants.get("wxapi.appid"), Constants.get("wxapi.appsecret"));
												//推送消息模版
												//这边不去查询UserBind表，因为这里直接可以拿到openid，所以不能和其他推送代码一样去查询用户绑定记录，直接这里获取当前的openid去推送
												WxapiUtil.sendTM2WxUser(tokenForWxapis.getAccess_token(), OpenidTracker.get(), paysuccTemplateId, "", json_data);
											}
												
											try {
												smsService.used(token);
											} catch (Exception e) {
												log.error("sms", e);
											}
											
											resp.setMessage(qBack.getMessage());
											resp.setResult(1);
										} else {
											resp.setMessage("支付已提交银行,请等待系统提醒!");
											resp.setResult(0);
										}
									} else {
										resp.setMessage(pBack.getMessage());
										resp.setResult(0);
									}
								}
							}
						} else {
							resp.setMessage("未找到该订单,发起支付失败!");
							resp.setResult(0);
						}
					}
				} else {
					resp.setMessage("支付密码不正确");
					resp.setResult(2);
				}
			} else {
				resp.setMessage("还未设置支付密码");
				resp.setResult(3);
			}
			resp.jsonOut(response);
		}
	}
	
	@RequestMapping("succ")
	public String succ(String orderNo, Model model) {
		Order object = orderService.find(orderNo);
		if(object.getProductType() == Order.PRODUCT_TYPE_SPECIAL){
			model.addAttribute("object", object);
			return "wap/product/succ";
		}
		// 判断用户是否可以抽奖
		String productId = object.getProductId();
		String userId = object.getUserId();
		BuyProductRecord record = new BuyProductRecord();
		record.setProductId(productId);
		record.setUserId(userId);
		record.setStatus(0);
		record.setReaded(0);
		record = buyProductRecordService.find(record);
		Integer jackpot = 0;
		if (record != null) {
			jackpot = 1;
			record.setReaded(1);
			buyProductRecordService.mdfy(record);
		}
		model.addAttribute("jackpot", jackpot);
		model.addAttribute("object", object);
		return "wap/cnpay/succ";
	}
	
	/**
	 * 确认银行卡信息
	 * @param form
	 * @param model
	 */
	@RequestMapping("ssure")
	public String sure(UsrOpenForm form, Model model, String redirect_uri,String payPassword) {
		model.addAttribute("form", form);
		model.addAttribute("redirect_uri", redirect_uri);
		model.addAttribute("user", userService.find(UseridTracker.get()));
		return "wap/cnpay/sure";
	}

}
