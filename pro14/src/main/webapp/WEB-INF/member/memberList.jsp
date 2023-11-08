<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="ctxPath" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<%-- 
	${memberList }
	 --%>
	 <div class="container">
	    <h1>회원목록</h1>
	 	<form action="${ctxPath }/member/list">
	 		<input type="text" name="searchName">
	 		<button>검색</button>
	 	</form>
	 
		<table class="table table-bordered">
			<tr>
				<th>아이디</th>
				<th>비밀번호</th>
				<th>이름</th>
				<th>이메일</th>
				<th>가입일</th>
			</tr>
			
			<c:if test="${empty memberList }">
				<tr>
					<td colspan="5">등록된 회원이 없습니다.</td>
				</tr>
			</c:if>
			
			<c:if test="${not empty memberList }">
				<c:forEach items="${memberList }" var="member">
					<tr>
						<td>${member.id }</td>
						<td>${member.pwd }</td>
						<td>${member.name }</td>
						<td>${member.email }</td>
						<td>${member.joinDate }</td>
					</tr>
				</c:forEach>
			</c:if>
			
			
		</table>
	</div>
</body>
</html>