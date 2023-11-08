<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>표현언어에서 사용되는 데이터들</title>
</head>
<body>
	<h2>비교연산자</h2>
	<h3>같다</h3>
	${10 == 10 } <br>
	${10 == 12 } <br>
	<br>
	${'hello' == "hello" }<br>
	${'hello' == "hi" }<br>
	<br>
	${10 eq 10 } <br>
	${10 eq 12 } <br>
	<br>
	${'hello' eq "hello" }<br>
	${'hello' eq "hi" }<br>
	
	<h3>같지않다</h3>
	${10 != 10 } <br>
	${10 != 12 } <br>
	<br>
	${'hello' != "hello" }<br>
	${'hello' != "hi" }<br>
	<br>
	${10 ne 10 } <br>
	${10 ne 12 } <br>
	<br>
	${'hello' ne "hello" }<br>
	${'hello' ne "hi" }<br>
	
	<h3>보다 크다</h3>
	${10 < 12 } <br>
	${12 gt 10 } <br>
	
	<h3>보다 작다</h3>
	${12 < 10 } <br>
	${12 lt 10 } <br>

	<h3>크거나 같다</h3>
	${12 >= 10 } <br>
	${12 ge 10 } <br>
	<h3>보다 작다</h3>
	${12 <= 10 } <br>
	${12 le 10 } <br>
	
	
</body>
</html>