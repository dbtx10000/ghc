package com.alidao.basic.service.impl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.basic.dao4mybatis.SmsDao;
import com.alidao.basic.entity.Sms;
import com.alidao.basic.service.SmsService;
import com.alidao.common.Constants;
import com.alidao.common.SmsSender;
import com.alidao.jse.global.TimeFormat;
import com.alidao.jse.util.Crypto;
import com.alidao.jse.util.StringUtil;
import com.alidao.jse.util.URLEncoder;

@Service
public class SmsServiceImpl implements SmsService {

	@Autowired
	private SmsDao smsDao;
	
	public int send(String mobile, Integer type, Map<String, String> map) {
		Sms cdt = new Sms();
		cdt.setMobile(mobile);
		cdt.setType(type);
		cdt.addOrderBy("create_time", true);
		cdt = smsDao.select(cdt);
		if (cdt != null) {
			Long now = new Date().getTime();
			Long crt = cdt.getCreateTime().getTime();
			if (now - crt < 60 * 1000) {
				return 0;
			}
		}
		synchronized (this.getClass()) {
			String code = AutoGnrtRandCode();
			Sms object = new Sms();
			object.setMobile(mobile);
			object.setType(type);
			Calendar calendar = Calendar.getInstance();
			calendar.add(Calendar.MINUTE, 30);
			object.setExceedTime(calendar.getTime());
			object.setVerifyCode(code);
			object.setStatus(Sms.STATUS_UN_USE);
			String token = UUID.randomUUID().toString();
			token = Crypto.MD5(token);
			object.setToken(token);
			if (smsDao.insert(object) == 1) {
				return SendCodeToMobile(mobile, type, code, map);
			}
			return 0;
		}
	}
	
	public String isok(String mobile, Integer type, String code) {
		Sms object = new Sms();
		object.setMobile(mobile);
		object.setType(type);
		object.setVerifyCode(code);
		object.setStatus(Sms.STATUS_UN_USE);
		SimpleDateFormat sdf = new SimpleDateFormat(TimeFormat.TIME_LOCALE);
		String exceed_time = "'" + sdf.format(new Date()) + "'";
		object.addCondition("exceed_time", 
				Sms.CDT_GT, exceed_time, Sms.SEP_AND);
		if ((object = smsDao.select(object)) != null) {
			return object.getToken();
		}
		return null;
	}
	
	public boolean isok(String mobile, String token) {
		Sms object = new Sms();
		object.setMobile(mobile);
		object.setToken(token);
		object.setStatus(Sms.STATUS_UN_USE);
		SimpleDateFormat sdf = new SimpleDateFormat(TimeFormat.TIME_LOCALE);
		String exceed_time = "'" + sdf.format(new Date()) + "'";
		object.addCondition("exceed_time", 
			Sms.CDT_GT, exceed_time, Sms.SEP_AND);
		return (smsDao.select(object) != null);
	}
	
	public int used(String token) {
		Sms object = new Sms();
		object.setToken(token);
		object = smsDao.select(object);
		if (object != null) {
			object.setStatus(Sms.STATUS_USE_ED);
			return smsDao.update(object);
		}
		return 0;
	}
	
	private int SendCodeToMobile(
			String mob, Integer type, String code, Map<String, String> map) {
		int result = 1;
		if (!Constants.DEVELOP.equals(Constants.get("main.status"))) {
			String msg = Constants.get("sms.scene_" + type);
			msg = msg.replaceAll("#code#", code);
			if (map != null && map.size() > 0) {
				for (Map.Entry<String, String> entry : map.entrySet()) {
					String key = entry.getKey();
					String value = entry.getValue();
					msg = msg.replaceAll("#" + key + "#", value);
				}
			}
			result = SmsSender.send(mob, URLEncoder.encode(msg)) ? 1 : 0;
		}
		return result;
	}
	
	private String AutoGnrtRandCode() {
		String code = null;
		if (Constants.PRODUCT.equals(
				Constants.get("main.status"))) {
			Random random = new Random();
			int bit = 4;
			String bitstr = Constants.get("sms.bit");
			if (StringUtil.isNotBlank(bitstr)) {
				bit = Integer.parseInt(bitstr);
			}
			int base = (int) Math.pow(10, (bit - 1));
			int rand = random.nextInt(9 * base);
			code = String.valueOf(rand + base);
		} else {
			code = Constants.get("def.sms_code");
			if (StringUtil.isEmpty(code)) {
				code = "1111";
			}
		}
		return code;
	}
	
}
