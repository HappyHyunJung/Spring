<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원 정보 입력</h1>
	<form name="step2" action="/register/step3" method="post" >
		<p>
			<label>이메일:<br><input name="email" /></label>
		</p>
		<p>
			<label>이름:<br><input name="name" /></label>
		</p>
		<p>
			<label>비밀번호:<br><input type="password" name="pwd"/></label>
		</p>
		<p>
			<label>비밀번호 확인:<br><input type="password" name="cfpwd" /></label>
		</p>
		<input type="submit" value="가입완료">
	</form>
	
</body>
</html>