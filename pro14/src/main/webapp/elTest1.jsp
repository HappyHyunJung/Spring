<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현언어에서 사용되는 데이터들</title>
</head>
<body>
	<h1>표현언어로 여러 가지 데이터 출력하기</h1>
	정수 : ${100} <br>
	실수 : ${3.14} <br>
	문자열 : ${"안녕하세요" }<br>
	널 : ${null}<br>
	이스케이프 : \${1 }<br>
	
	
	<h2>연산</h2>
	덧셈 : ${10 + 5}<br>
	뺄셈 : ${10 - 5}<br>
	곱셈 : ${10 * 5}<br>
	나눗셈 : ${10 / 5},  ${12 div 3 }<br>
	나머지 : ${10 % 3 }, ${15 mod 7 }<br>
	
	<h2>문자열 결합 연산</h2>
	${"안녕" += "하세요" }<br>
	${ "10" + "2"}<br>
	${"10" + 2 }<br>
	${10 + "2" }<br>
	
	
	<h2>null 연산</h2>   <!-- null을 숫자와 연산하면 0으로 인식 // 문자열과 결합도 가능하다 -->
	${10 + null }<br>
	${null + 10 }<br>
	${null += "Hello" }<br>
	
	
	
</body>
</html>