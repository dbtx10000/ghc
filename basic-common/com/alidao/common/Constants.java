package com.alidao.common;

import com.alidao.jse.icm.IcmProps;

public final class Constants {
	
	private Constants() {}
	
	/** 开发环境 **/
	public static final String DEVELOP = "develop";
	/** 测试环境 **/
	public static final String TEST = "test";
	/** 生产环境 **/
	public static final String PRODUCT = "product";
	
	private static IcmProps icmProps;
	
	static {
		IcmProps.bind("system", "classpath:system.properties");
		icmProps = IcmProps.getInstance("system");
	}
	
	public static String get(String name) {
		return icmProps.getProp(name);
	}
	
}
