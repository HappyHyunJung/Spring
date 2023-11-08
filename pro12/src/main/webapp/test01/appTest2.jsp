<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String info = (String)pageContext.getAttribute("info");
	String userName = (String)session.getAttribute("name");
	String addr = (String)application.getAttribute("address");
%>
	정보 : <%=info%><br>
	이름 : <%=userName %><br>
	주소 : <%= addr %><br>
</body>
</html>