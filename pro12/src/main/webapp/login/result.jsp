<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결과출력창</title>
</head>
<body>
	<h1>결과 출력</h1>
	<%
		request.setCharacterEncoding("utf-8");
		String userId = request.getParameter("user_id");
		String userPw = request.getParameter("user_pw");
	%>
	아이디 : <%=userId %><br>
	비밀번호 :  <%=userPw %><br>
</body>
</html>