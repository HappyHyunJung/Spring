<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table class="board_table">
		<thead>
			<tr class="table_title">
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
	
		<tbody class="board_content">
			<c:forEach var="board" items="${ListBoardVO }" >
				<tr class="tr_list">
					<td><c:out value="${ board.bno}"></c:out></td>
					<td>
						<a class="get" href='<c:out value="${board.bno }"/>'>
							<c:out value="${ board.title}"></c:out>
						</a>
					</td>
					<td><c:out value="${ board.writer}"></c:out></td>
					<td>
						<c:choose>
							<c:when test="${board.regDate } == ${board.updateDate}">
								<fmt:formatDate pattern="YY-MM-dd hh:mm" value="${board.regDate }"/>
							</c:when>
							<c:otherwise>
								<fmt:formatDate pattern="YY-MM-dd hh:mm" value="${board.updateDate }"/>
							</c:otherwise>
						</c:choose>
					</td>
				</tr>
			</c:forEach>
		</tbody>
		
		
		<c:if test="${!empty ListBoardVO }">
		</c:if>
	
	</table>
	
<%@include file="../includes/footer.jsp" %>
</body>
</html>