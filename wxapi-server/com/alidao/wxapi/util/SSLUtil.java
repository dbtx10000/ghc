package com.alidao.wxapi.util;

import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;

import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContextBuilder;
import org.apache.http.conn.ssl.TrustStrategy;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

/**
 * SSL工具
 * @author 胡永伟
 */
public final class SSLUtil {

	private SSLUtil() {}

	/**
	 * 创建https客户端
	 * @return
	 */
	public static CloseableHttpClient createSSLClient() {
		try {
			return HttpClients.custom().setSSLSocketFactory(
				new SSLConnectionSocketFactory(
					new SSLContextBuilder().loadTrustMaterial(
						null, new TrustStrategy() {
							public boolean isTrusted(
								X509Certificate[] chain, String authType)
									throws CertificateException {
								return true;
							}
						}
					).build()
				)
			).build();
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

}
