package com.alidao.basic.service;

import java.util.Map;


public interface SmsService {

	public abstract int send(String mobile, Integer type, Map<String, String> map);
	
	public abstract boolean isok(String mobile, String token);

	public abstract String isok(String mobile, Integer type, String code);

	public abstract int used(String token);
	
}
