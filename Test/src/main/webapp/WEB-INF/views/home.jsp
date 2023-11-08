<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="ko">
<head>
	<title>Home</title>
</head>
<body>

<h1>
	Hello world!  
</h1>
 	<a href="<c:url value="/register/step1" />">회원 가입하기</a>

<%-- <P>  The time on the server is ${serverTime}. </P> --%>

<!-- @Requestpara -->
<!--  
	<p>이메일 : <c:out value="${param.email }" /></p>
	<p>이름 : <c:out value="${param.name }" /></p>
	<p>비밀번호 : <c:out value="${param.pwd }" /></p>
	<p>비밀번호 확인 : <c:out value="${param.cfpwd }" /></p>
-->

<!-- @ModelAttribute -->

	<p>이메일 : <c:out value="${regi.email }" /></p>
	<p>이름 : <c:out value="${regi.name }" /></p>
	<p>비밀번호 : <c:out value="${regi.pwd }" /></p>
	<p>비밀번호 확인 : <c:out value="${regi.cfpwd }" /></p>
 

</body>
</html>
