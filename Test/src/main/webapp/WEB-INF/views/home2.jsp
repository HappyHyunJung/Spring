<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="ko">
<head>
	<title>Home</title>
</head>
<body>

<h1>Main page</h1>

	<p>입력한 아이디:<c:out value="${l.id }"></c:out></p> 	
	<p>입력한 비밀번호:<c:out value="${l.pwd }"></c:out></p> 	
</body>
</html>
