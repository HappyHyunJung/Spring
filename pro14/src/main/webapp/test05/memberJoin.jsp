<%@page import="java.util.*"%>
<%@page import="sec01.ex01.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="memberList" class="java.util.ArrayList"></jsp:useBean>
<jsp:useBean id="m1" class="sec01.ex01.MemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="m1"/>

<%
	memberList.add(m1);
	
	MemberBean m2 = new MemberBean();
	m2.setId("sony");
	m2.setName("손흥민");
	m2.setPwd("345");
	m2.setEmail("sony@Test.com");
	memberList.add(m2);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<h2> 각각의 객체에 접근</h2>
아이디 : ${memberList[0].id }<br>
비밀번호 : ${memberList[0].pwd }<br>
이름 : ${memberList[0].name }<br>
이메일 : ${memberList[0].email }<br>
<br>

아이디 : ${memberList[1].id }<br>
비밀번호 : ${memberList[1].pwd }<br>
이름 : ${memberList[1].name }<br>
이메일 : ${memberList[1].email }<br>
</body>
</html>