package com.alidao.cnpay.util;

import java.lang.reflect.Field;
import java.util.Map;

/**
 * 反射：MAP -> BEAN
 * @author 胡永伟
 */
public final class MapToObject {

	private MapToObject() {}
	
	public static <T> T parse(Map<String, ?> map, Class<T> clazz) {
		try {
			T object = clazz.newInstance();
			for (Map.Entry<String, ?> entry : map.entrySet()) {
				Field field = clazz.getDeclaredField(entry.getKey());
				if (field != null) {
					field.setAccessible(true);
					field.set(object, entry.getValue());
				}
			}
			return object;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
}
