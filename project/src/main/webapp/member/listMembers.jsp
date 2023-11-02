<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
	document.addEventListener("DOMContentLoaded", function () {
		console.log("loaded");
		
		let msg = '<c:out value="${msg}"/>';
		
		if(msg === "addMember") {
			alert("회원추가가 완료되었습니다.");
		
		} else if(msg === "modified") {
			alert("회원정보가 수정되었습니다.");
		
		} else if(msg === "deleted") {
			alert("회원정보가 삭제되었습니다.");
		}
	});
</script>
</head>
<body>

	<div class="container">
	
		<table>
			<tr>
				<th width="10%">아이디</th>
				<th width="10%">비밀번호</th>
				<th width="10%">이름</th>
				<th width="10%">이메일</th>
				<th width="10%">가입일</th>
				<th width="10%">수정</th>
				<th width="10%">삭제</th>
			</tr>
			
			<c:choose>
				<c:when test="${empty membersList }">
					<td>등록된 회원이 없습니다.</td>
				</c:when>
				
				<c:otherwise>
					<c:forEach var="mem" items="${membersList }" >
						<tr>
							<td>${mem.id }</td>
							<td>${mem.pwd }</td>
							<td>${mem.name }</td>
							<td>${mem.email }</td>
							<td>${mem.joinDate }</td>
							<td><a href="${contextPath }/member/modMemberForm.do?id=${mem.id}">수정</a></td>
							<td><a href="${contextPath }/member/delMember.do?id=${mem.id}">삭제</a></td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
		</table>
	</div>
</body>
</html>