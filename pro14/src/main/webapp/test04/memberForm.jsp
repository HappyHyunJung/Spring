<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action = "${pageContext.request.contextPath }/test04/memberJoin3.jsp" method="post"><br>
	아이디 : <input type="text" name="user_id"><br>
	비밀번호 : <input type="password" name="user_pwd"><br>
	이름 : <input type="text" name="user_name"><br>
	이메일 : <input type="text" name="user_email"><br>
	<button>가입하기</button>
</form>
</body>
</html>