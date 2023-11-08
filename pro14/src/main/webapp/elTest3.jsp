<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현언어에서 사용되는 데이터들</title>
</head>
<body>
	<h2>논리 연산자</h2>
	<h3>AND 연산자</h3>
	${true && true }
	${true and true }
	${true and false }
	<br>
	<h3>OR 연산자</h3>
	${true || false }
	${true or false }
	<br>
	<h3>NOT 연산자</h3>
	${!true }
	
	<h3>empty 연산자</h3>
	특정 값이 있는 경우 : ${empty "Hello" } <br>
	null인 경우 : ${empty null } <br>
	빈문자 : ${empty "" } <br>
	공백문자 : ${empty "  " } <br>
	
	<h3>empty 연산자 부정</h3>
	특정 값이 있는 경우 : ${not empty "Hello" } <br>
	null인 경우 : ${!empty null } <br>
	빈문자 : ${!empty "" } <br>
	공백문자 : ${not empty "  " } <br>
	
	<h3>삼항 연산자</h3>
	${ 10 + 5 > 5 ? '결과는 참이다': '결과는 거짓이다' }
</body>
</html>