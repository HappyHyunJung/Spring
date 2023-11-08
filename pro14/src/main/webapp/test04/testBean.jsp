<%@page import="sec01.ex01.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberBean m1 = new MemberBean();
	m1.setId("sky");
	m1.setPwd("asdf");
	m1.setName("하늘");
	m1.setEmail("skytop@naver.com");
%>

<jsp:useBean id="m2" class="sec01.ex01.MemberBean"></jsp:useBean>
<jsp:setProperty property="id" name="m2" value="earth"/>
<jsp:setProperty property="pwd" name="m2" value="qwert"/>
<jsp:setProperty property="name" name="m2" value="스트리트"/>
<jsp:setProperty property="email" name="m2" value="earth@gmail.com"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h2> 표현식 </h2>
아이디 : <%=m1.getId() %><br> 
비밀번호 : <%=m1.getPwd() %><br>
이름 : <%=m1.getName() %><br>
이메일 : <%=m1.getEmail() %><br>

<h2> 표현언어 </h2>

아이디 : ${m2.id }<br> 
비밀번호 : ${m2.pwd }<br>
이름 : ${m2.name }<br>
이메일 : ${m2.email }<br>
</body>
</html>