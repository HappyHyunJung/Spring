<%@page import="sec01.ex01.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("user_id");
	String pwd = request.getParameter("user_pwd");
	String name = request.getParameter("user_name");
	String email = request.getParameter("user_email");

%>

<jsp:useBean id="m" class="sec01.ex01.MemberBean"></jsp:useBean>
<jsp:setProperty property="id" name="m" value="<%=id %>"/>
<jsp:setProperty property="pwd" name="m" value="<%=pwd %>"/>
<jsp:setProperty property="name" name="m" value="<%=name %>"/>
<jsp:setProperty property="email" name="m" value="<%=email %>"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>useBean으로 데이터 설정</h3>
아이디 : ${m.id }<br>
비밀번호 : ${m.pwd }<br>
이름 : ${m.name }<br>
이메일 : ${m.email }<br>
</body>
</html>