<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Game</h1>
	Game score1 tottemham ${score } : ${team } 0
	${msg }
	<c:out value="Game score1 tottemham ${data.score } : ${data.team } 0" />
	<!-- c태그 taglib 없어서 동작안함 -->
</body>
</html>