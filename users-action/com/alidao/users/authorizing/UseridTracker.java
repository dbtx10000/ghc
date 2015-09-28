package com.alidao.users.authorizing;

import java.util.UUID;

import com.alidao.jse.util.Crypto;

public class UseridTracker {

	private static final ThreadLocal<String> 
			threadLocal = new ThreadLocal<String>();

	public static void set(String userid) {
		threadLocal.set(userid);
	}

	public static String get() {
		return threadLocal.get();
	}

	public static void rmv() {
		threadLocal.remove();
	}
	
	public static void main(String[] args) {
		System.out.println(Crypto.MD5(UUID.randomUUID().toString()));
	}

}
