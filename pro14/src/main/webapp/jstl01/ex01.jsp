<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="userName" value="이순신"></c:set>
<c:set var="userPwd" value="123"></c:set>
<c:set var="email" value="lee@test.com"></c:set>
<c:set var="ctxPath" value="${pageContext.request.contextPath }"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>C:set 변수 선언</h1>
이름 : ${userName }<br>
비밀번호 : ${userPwd }<br>
이메일 : ${email }<br>

컨텍스트 이름 : ${ctxPath } <br>
</body>
</html>