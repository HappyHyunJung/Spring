<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="auth" value="${sessionScope.auth }"/>  <!-- 로그인 정보 저장 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

</head>
<body>
	<div>
	<c:choose>
	<c:when test="${not empty auth }">
		<div class="dropdown">
			<button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown">
				<c:out value="${auth.id }" /> 님
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" href="${contextPath }/member/modMemberForm.do?id=${auth.id}">회원정보 수정</a>
				<a class="dropdown-item" style="color:red;" href="${contextPath }/member/logout.do">로그아웃</a>
			</div>
		</div>
	</c:when>
	<c:otherwise>
		<div class="dropdown">
			<button type="button" class="btn btn-secondary dropdown-toggle" data-toggle="dropdown">
				로그아웃 상태
			</button>
			<div class="dropdown-menu dropdown-menu-right">
				<a class="dropdown-item" href="${contextPath }/member/loginForm.do">로그인</a>
				<a class="dropdown-item" href="${contextPath }/member/memberForm.do">회원가입</a>
			</div>
		</div>
	</c:otherwise>
	</c:choose>	
	</div>
</body>
</html>