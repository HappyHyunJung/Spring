<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action = "${pageContext.request.contextPath }/test04/memberJoin4.jsp" method="post"><br>
	아이디 : <input type="text" name="id"><br>
	비밀번호 : <input type="password" name="pwd"><br>
	이름 : <input type="text" name="name"><br>
	이메일 : <input type="text" name="email"><br>
	<button>가입하기</button>
</form>
</body>
</html>