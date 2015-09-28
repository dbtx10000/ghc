package com.alidao.exception;

/**
 * 提示异常
 * @author 胡永伟
 */
public class MessageException extends Exception {

	private static final long serialVersionUID = 1L;

	public MessageException() {
		super();
	}

	public MessageException(String message, Throwable cause) {
		super(message, cause);
	}

	public MessageException(String message) {
		super(message);
	}

	public MessageException(Throwable cause) {
		super(cause);
	}

}
