<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<c:set var="file1" value="${param.param1 }" />
<c:set var="file2" value="${param.param2 }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:if test="${not empty file1 }" >  <!-- file1이 있는지 확인 *** -->
		<!-- 이미지를 보여주는 부분 -->
		<img src="${contextPath }/download.do?fileName=${file1}" width=300 height=300/><br>    
	</c:if>
	<a href="${contextPath }/download.do?fileName=${file1}">파일내려받기</a><br>

	<c:if test="${not empty file2 }" >  <!-- file2이 있는지 확인 *** -->
		<!-- 이미지를 보여주는 부분 -->
		<img src="${contextPath }/download.do?fileName=${file2}" width=300 height=300/><br>    
	</c:if>
	<a href="${contextPath }/download.do?fileName=${file2}">파일내려받기</a><br>
</body>
</html>