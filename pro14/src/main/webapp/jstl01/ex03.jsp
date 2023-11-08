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
<h1>c:choose 변수 선언</h1>
<c:set var="num" value="5"></c:set>
<c:choose>
	<c:when test="${num > 5 }">
	${num }은 5보다 크다	
	</c:when>

	<c:when test="${num < 5 }">
	${num }은 5보다 작다	
	</c:when>
	
	<c:otherwise>
	${num }은 5와 같다
	</c:otherwise>
</c:choose>
</body>
</html>