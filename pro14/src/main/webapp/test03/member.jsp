<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%-- 
아이디 : <%=id %><br>
비밀번호 : <%=pwd %><br>
이름 : <%=name %><br>
이메일 : <%=email %><br>
 --%>
아이디 : ${param.user_id} <br>
비밀번호 : ${param.user_pwd }<br>
이름 : ${param.user_name }<br>
이메일 : ${param.user_email }<br>
<%-- 주소 : ${requestScope.address }<br> --%>
주소 : ${address }<br>
</body>
</html>