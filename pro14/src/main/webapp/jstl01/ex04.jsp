<%@page import="java.util.ArrayList"%>
<%@page import="sec01.ex01.MemberBean"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	List<MemberBean> memberList = new ArrayList();

	for(int i = 1; i <= 4;i++) {
		MemberBean member = new MemberBean();
		member.setId("hong" + i);
		member.setName("홍길동" + i);
		member.setPwd("1234" + i);
		member.setEmail("hong" + i + "@test.com");
		memberList.add(member);
	}
%>

<c:set var="memberList" value="<%= memberList%>"></c:set>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>c:forEach</h1>
<!-- 단순반복 -->
<c:forEach var="num" begin="2" end="6">
	${num }
</c:forEach>

<br>

<!-- 단순반복 -->
<c:forEach var="num" begin="0" end="10" step = "2" varStatus="loop">
	${loop.count }
	${num }
	<br>
</c:forEach>

<!-- list 요소 출력 -->
<c:forEach items="${memberList }" var="m" varStatus="Loop">
	<ul>
		<li>반복회수 : ${loop.count}</li>
		<li>인덱스 : ${loop.index }</li>
		<li>이름 : ${m.name }</li>
		<li>아이디 : ${m.id }</li>
		<li>비밀번호 : ${m.pwd }</li>
		<li>이메일 : ${m.email }</li>
	</ul>
</c:forEach>

</body>
</html>