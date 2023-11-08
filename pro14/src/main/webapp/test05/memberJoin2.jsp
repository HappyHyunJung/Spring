<%@page import="java.util.*"%>
<%@page import="sec01.ex01.MemberBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
%>

<jsp:useBean id="memberList" class="java.util.ArrayList"></jsp:useBean>
<jsp:useBean id="membersMap" class="java.util.HashMap"></jsp:useBean>
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
	
	membersMap.put("members", memberList);
	membersMap.put("pizza", "피자");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

${membersMap.pizza } <br>
${membersMap.members[0].name } <br>
${membersMap.members[1].name } <br>

</body>
</html>