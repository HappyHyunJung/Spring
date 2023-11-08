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
	String name = (String)request.getAttribute("name");
	String addr = (String)request.getAttribute("address");
%>
<h1>request3.jsp</h1>
이름 : <%= name %>
주소 : <%= addr %>

<a href = "request3.jsp">request3.jsp 페이지로 이동</a>
</body>
</html>