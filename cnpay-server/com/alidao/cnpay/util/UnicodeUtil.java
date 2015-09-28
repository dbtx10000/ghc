package com.alidao.cnpay.util;

public final class UnicodeUtil {

	private UnicodeUtil() {}
	
	public static String toUnicode(String src) {
		StringBuilder builder = new StringBuilder("");
		if (src != null) {
			char[] chars = src.toCharArray();
			for (int i = 0; i < chars.length; i++) {
				String hex = Integer.toHexString((int) chars[i]);
				builder.append("\\u" + hex);
			}
		}
		return builder.toString();
	}
	
}
