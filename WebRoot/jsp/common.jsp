<!-- Set pageEncoding -->
<%@ page language="java" pageEncoding="UTF-8"%>
<!-- Import URLEncoder -->
<%@ page language="java" import="java.net.URLEncoder"%>
<!-- Import Constants -->
<%@ page language="java" import="com.alidao.common.Constants"%>
<!-- Import Jstl Core -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!-- Import Jstl Func -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!-- Import Jstl Fmt -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!-- Context -->
<c:set var="snm" value="<%=Constants.get(\"proj.name\")%>" scope="request" />
<!-- Context -->
<c:set var="unv" value="<%=Constants.get(\"user.need_verify\")%>" scope="request" />
<c:set var="unv_for_own" value="<%=Constants.get(\"user.need_verify_for_ownreg\")%>" scope="request" />
<c:set var="unv_for_inv" value="<%=Constants.get(\"user.need_verify_for_invreg\")%>" scope="request" />
<!-- Context -->
<c:set var="ctx" value="${pageContext.request.contextPath}" scope="request" />
<!-- Js Path -->
<c:set var="js" value="${ctx}/js" scope="request" />
<!-- Css Path -->
<c:set var="css" value="${ctx}/css" scope="request" />
<!-- Image Path -->
<c:set var="img" value="${ctx}/images" scope="request" />

<%
	int port = request.getServerPort();
	String webapp = "http://" + request.getServerName();
	webapp = (port == 80) ? webapp : (webapp + ":" + port);
	webapp += request.getContextPath();
	String mizar = Constants.get("rms.mizar");
	request.setAttribute("qrcode", mizar + "/qrcode");
	request.setAttribute("upload", mizar + "/upload");
	String call = (webapp + "/js/kindeditor/call.html");
	call = "call=" + URLEncoder.encode(call, "UTF-8");
	request.setAttribute("ke_upload", mizar + "/upload.ke?" + call);
	
	String user_agent = request.getHeader("User-Agent"); 
	boolean from_micr = false, need_head = false, need_back = false;
	if (user_agent != null) {
		user_agent = user_agent.toLowerCase();
		String wechat = "micromessenger";
		if (user_agent.indexOf(wechat) > -1) {
			from_micr = true;
			if (user_agent.indexOf("android") > -1) {
				need_head = true;
				need_back = true;
			}
		}
	}
	request.setAttribute("from_micr", from_micr);
	request.setAttribute("need_head", need_head);
	request.setAttribute("need_back", need_back);
%>