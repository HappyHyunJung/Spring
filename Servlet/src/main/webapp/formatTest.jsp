<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="now" class="java.util.Date"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h2>fmt의 number 태그를 이용한 숫자 포맷팅 예제</h2>
	<c:set var="price" value="100000000"/>
	일반 숫자로 표현 :
	<fmt:formatNumber type="number" value="${price }"></fmt:formatNumber><br>
	통화로 표현 :
	<fmt:formatNumber type="currency" currencySymbol="￦"  value="${price }" groupingUsed="true"></fmt:formatNumber><br>
	퍼센트로 표현 :
	<fmt:formatNumber type="percent" value="${price }" groupingUsed="false"></fmt:formatNumber><br>
	
	<h2>formatDate 예제</h2>
	<c:set var="now_set" value="${now }"></c:set>
	<fmt:formatDate value="${now_set }" type="date" dateStyle="full"/><br>
	<fmt:formatDate value="${now_set }" type="date" dateStyle="short"/><br>
	<fmt:formatDate value="${now_set }" type="time"/><br>
	<fmt:formatDate value="${now_set }" type="both" dateStyle="full" timeStyle="full"/><br>
	<fmt:formatDate value="${now_set }" pattern="YYYY-MM-dd :hh:mm:ss" /><br>
	한국 현재 시간:<fmt:formatDate value="${now_set }" type="both" dateStyle="full" timeStyle="full"/><br>
	<fmt:timeZone value="America/New_York">
	뉴욕 현재 시간:	 <fmt:formatDate value="${now_set }" type="both" dateStyle="full" timeStyle="full"/><br>
	</fmt:timeZone>
</body>
</html>