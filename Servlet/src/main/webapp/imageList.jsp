<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/style.css">
<title>Insert title here</title>
</head>
<body>
	<ul>
		<li>
			<span>이미지&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			<span>이미지 이름&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
			<span>선택하기</span>
		</li>
		
		<c:forEach var="i" begin="1" end = "9">
			<li>
				<a href="#">
					<img src="${pageContext.request.contextPath }/resources/img/poppy.png">
				</a>
				<a href="#"><strong>이미지 이름 : 강아지${i }</strong></a>
				<a href="#"> <input name='chk${i }' type='checkbox'/></a>
			</li>
		</c:forEach>
		
	</ul>
</body>
</html>