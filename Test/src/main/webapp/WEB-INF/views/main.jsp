<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${!empty data }">
		<label>1.가장 좋아하는 과일:</label><c:out value="${data.fruits }"></c:out>
		<label>2.가장 좋아하는 영화 장르:</label><c:out value="${data.movie_genre }"></c:out>
		<label>3.가장 좋아하는 술:</label><c:out value="${data.alcohol_type }"></c:out>
		<label>4.응답자 위치:</label><c:out value="${data.area }"></c:out>
		<label>5.응답자 나이:</label><c:out value="${data.age }"></c:out>
	</c:if>
	<h1><a href=<c:url value="/survey/part1/"/>>설문조사 part1</a></h1>
</body>
</html>