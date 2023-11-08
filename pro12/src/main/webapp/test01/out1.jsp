<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String name = "이순신" ;%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
이름은 <%=name %> 입니다
<%
	out.println("이름 출력");
	out.println(name);
%>
<form method="post" action="out2.jsp">
	이름 : <input type="text" name="name"><br>
	나이 : <input type="text" name="age"><br>
</form>
</body>
</html>