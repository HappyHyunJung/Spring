<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>This is member.jsp</h1>
	<table id="tbl" >
		<thead>
			<tr bgcolor="yellow">
				<th>아이디</th>
				<th>비밀번호</th>
				<th>이름</th>
				<th>이메일</th>
				<th>가입일</th>
				<th>삭제</th>
			</tr>
		</thead>
		<c:forEach items="${list}" var="member" >
			<tr>
				<td><c:out value="${member.id}"/></td>
				<td><c:out value="${member.pwd}"/></td>
				<td><c:out value="${member.name}"/></td>
				<td><c:out value="${member.email}"/></td>
				<td><c:out value="${member.joinDate}"/></td>
				<td><a href='/Servlet/member?command=delMember&id=<c:out value="${member.id}" />'>삭제</a></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>