package com.alidao.exception;

/**
 * 指令异常
 * @author 胡永伟
 */
public class CommandException extends Exception {

	private static final long serialVersionUID = 1L;

	public CommandException() {
		super();
	}

	public CommandException(String message, Throwable cause) {
		super(message, cause);
	}

	public CommandException(String message) {
		super(message);
	}

	public CommandException(Throwable cause) {
		super(cause);
	}

}
