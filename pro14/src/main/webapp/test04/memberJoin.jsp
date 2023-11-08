<%@page import="sec01.ex01.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8")
String id = request.getParameter("user_id");
String pwd = request.getParameter("user_pwd");
String name = request.getParameter("user_name");
String email = request.getParameter("user_email");

MemberBean m = new MemberBean();

m.setId(id);
m.setPwd(pwd);
m.setName(name);
m.setEmail(email);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
아이디 : <%=m.getId() %><br>
비밀번호 : <%=m.getPwd() %><br>
이름 : <%=m.getName() %><br>
이메일 : <%=m.getEmail() %><br>
</body>
</html>