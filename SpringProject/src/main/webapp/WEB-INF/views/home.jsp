<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="./includes/header.jsp"%>

<html>
<head>
<style>
h1 {
	width:990px; margin: 0px auto;
}

p {
	width:990px; margin: 0px auto;
}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	$(function () {
		let msg = "${msg}";
		
		if (msg === "") {
			return;
		}
		let txt;
		if (msg === "logout") {
			txt = "로그아웃 되었습니다";
		}
		alert(txt);
	});
</script>
	<title>Home</title>
</head>
<body >
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
</body>
</html>
