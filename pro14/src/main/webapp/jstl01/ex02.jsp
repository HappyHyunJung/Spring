<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>c:if 변수 선언</h1>
<c:if test="${10 gt 5 }">
	<h3>10은 5보다 크다</h3>
</c:if> 

<c:if test="${10 lt 5 }">
	<h3>10은 5보다 작다</h3>
</c:if> 
</body>
</html>