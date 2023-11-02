<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:set var="title1" value="중앙직업전문학교"/>
	<c:set var="title2" value="JAVA+SPRING"/>
	<c:set var="title3" value="월화수목금"/>
	<c:set var="friday" value="금"/>
	
	<!-- 선언한 변수가 빈 상태인지 체크 -->
	<c:if test="${not empty title1 }" >
		${title1 }는 글자수가 ${fn:length(title1) }  입니다. <br>
	</c:if>
	
	<c:if test="${not empty title2 }" >
		<c:set var="buf" value="${fn:split(title2, '+') }" />
		<br>
		${title2 }은 
		<c:forEach var="str" items="${buf }" varStatus="status">
			${str }
			<c:if test="${status.index == 0 }">
			와 
			</c:if>
		</c:forEach>
		로 구성되어 있습니다.<br>
	</c:if>

	<br>
	<c:if test="${not empty title3 }" >
		'${title3 }'에서 '${friday }'은 ${fn:indexOf(title3, friday) }번째 입니다.
	</c:if>
</body>
</html>