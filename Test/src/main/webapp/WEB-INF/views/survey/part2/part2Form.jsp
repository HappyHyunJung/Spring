<%@page import="java.util.*"%>
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
	<form method="post">
		<h1>설문조사 파트2</h1>
		<c:if test="${!empty questions }">
		
			<c:forEach var="question" items="${questions }" varStatus="status">
				<p>
					<c:out value="${status.index + 1 }.${question.title }" /><br>
					<c:choose>
						<c:when test="${question.choice }">    <!-- Question 클래스에서 선택지가 있는 경우 -->
							<c:if test="${!question.select }">  <!-- Question 클래스에서 select=false -->
								<c:forEach var="option" items="${question.options }">
									<input type="radio" name="responses[${status.index }]" 
									value="${option }"/>${option }<br>
								</c:forEach>
							</c:if>
							
							<c:if test="${question.select }">    <!-- Question 클래스에서 select=true  -> 응답자 위치 -->
								<select name="responses[${status.index }]">
									<c:forEach var="option" items="${question.options }">
										<option value="${option }">${option }</option><br>
									</c:forEach>
								</select>
							</c:if>
						</c:when>
						<c:otherwise>    <!-- Question 클래스에서 선택지가 없는 경우 -->
							<input type="text" name="responses[${status.index }]" value="${option }"/>${option }
						</c:otherwise>
					</c:choose>
					<input type="hidden" name="titles[${status.index }]" value="${question.title }" />
				</p>
			</c:forEach>
			
			<input type="submit" value="전송">
		</c:if>
	</form>

</body>
</html>