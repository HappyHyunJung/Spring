<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("info", "pagecontext");
	session.setAttribute("name", "이순신");
	application.setAttribute("address", "서울시 성동구");
	
	String info = (String)pageContext.getAttribute("info");
	String userName = (String)session.getAttribute("name");
	String addr = (String)application.getAttribute("address");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내장 객체 스코프 테스트</title>
</head>
<body>
<h1>이름과 주소를 저장합니다.</h1>

	정보 : <%=info%><br>
	이름 : <%=userName %><br>
	주소 : <%= addr %><br>

<a href=appTest2.jsp>두번째 웹페이지로 이동</a>
</body>
</html>