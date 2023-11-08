<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>contextPath 출력하기</h1>
표현식 : <%= request.getContextPath() %><br>  <!-- /pro14 -->
표현언어 : ${pageContext.request.contextPath } <br>

표현식 : <a href="<%= request.getContextPath() %>/test03/memberForm.html">회원가입</a>
표현언어 : <a href="${pageContext.request.contextPath }/test03/memberForm.html">회원가입</a>
</body>
</html>