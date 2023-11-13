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
			<c:out value="${status.index + 1 }.${question.title }"></c:out><br>
			<c:choose>
				<c:when test="${question.choice }">
					<c:if test="${!question.select }">
						<c:forEach var="option" items="${question.options }">
							<input type="radio" name="responses[${status.index }]" 
							value="${option }" > ${option }<br>
						</c:forEach>
						
					</c:if>
					
					<c:if test="${question.select }" >
						<select name="responses[${status.index }]">
							<c:forEach var="option" items="${question.options }">
								<option name="responses[${status.index }]">${option }</option>
							</c:forEach>
						</select><br>
					</c:if>	
				</c:when>
				
				<c:otherwise>
				
					<input type="text" name="responses[${status.index }]">
					<br>
					
				</c:otherwise>
			</c:choose>
			<input type="hidden" name="titles[${status.index }]" value="${question.title }" />
		</c:forEach>
		</c:if>
		<input type="submit" value="전송" />
	</form>
</body>
</html>