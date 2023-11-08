<%@page import="java.util.*"%>
<%@page import="sec01.ex01.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
%>
<jsp:useBean id="addr" class="sec01.ex02.Address"></jsp:useBean>
<jsp:setProperty property="city" name="addr" value="대구시"/>
<jsp:setProperty property="zipcode" name="addr" value="777555"/>

<jsp:useBean id="m" class="sec01.ex02.MemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="m"/>
<jsp:setProperty property="address" name="m" value="${addr }"/>

<%
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!-- 
	m: MemberBean 객체
	address : MemberBean의 멤버변수
	city : Address 클래스의 멤버변수
 -->
아이디 : ${m.id }<br>
비밀번호 : ${m.pwd }<br>
이름 : ${m.name }<br>
이메일 : ${m.email }<br>
도시이름 : ${m.address.city }<br>
우편번호 : ${m.address.zipcode }<br>
</body>
</html>