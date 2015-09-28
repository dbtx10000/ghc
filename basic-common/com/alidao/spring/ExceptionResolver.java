package com.alidao.spring;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.alidao.jxe.model.ParamException;

public class ExceptionResolver implements HandlerExceptionResolver {
	
	private static Log log = LogFactory.getLog(ExceptionResolver.class);
	
	public ModelAndView resolveException(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception e) {
		ModelAndView mav = null;
		log.error(e.getMessage(), e);
		try {
			String servletPath = request.getServletPath();
			if (servletPath.indexOf("/app/") > -1 || ajax(request)) {
				JSONObject result = new JSONObject();
				String resultstr = ajax(request) ? "result" : "resultCode";
				if (e instanceof ParamException) {
					result.put(resultstr, -2);
					result.put("message", e.getMessage());
				} else {
					result.put(resultstr, -3);
					result.put("message", "系统繁忙,请稍后...");
				}
				response.setContentType("application/json;charset=utf-8");
				PrintWriter writer = response.getWriter();
				writer.write(result.toString());
				writer.flush();
			} else {
				mav = new ModelAndView("error");
			}
		} catch (IOException ex) {
			log.error(ex.getMessage(), ex);
		}
		return mav;
	}
	
	private boolean ajax(HttpServletRequest request) {
		return "XMLHttpRequest".equals(request.getHeader("x-requested-with"));
	}
	
}
