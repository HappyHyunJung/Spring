<%@page import="sec01.ex01.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


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


<h2> 표현언어 </h2>

아이디 : ${m2.id }<br> 
비밀번호 : ${m2.pwd }<br>
이름 : ${m2.name }<br>
이메일 : ${m2.email }<br>
</body>
</html>