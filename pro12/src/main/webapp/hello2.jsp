<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%!
	//선언문
	String name = "이순신";
	public String getName() {return name;}
%>

<%
	//스크립트릿
	//  http://localhost:8090/pro12/hello2.jsp?age=22  s나이를 전달할 수 있다
	String age = request.getParameter("age");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스크립트릿 연습</title>
</head>
<body>

<!-- 표현식으로 출력 -->
	<h1>안녕하세요 <%=name %>님!!</h1>
	<h1>나이는 <%=age %>살입니다!!</h1>
</body>
</html>