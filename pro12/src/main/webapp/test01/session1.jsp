<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String name = (String) session.getAttribute("name");
	session.setAttribute("address", "대구시 수성구");  // jsp파일에서 session 설정
	
	String userId = (String)request.getAttribute("userId");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>session 내장 객체 테스트</title>
</head>
<body>
이름은 <%=name %>입니다. <br>
<a href = session2.jsp>두번째 페이지로 이동</a>
아이디 : <%=userId %>
</body>
</html>