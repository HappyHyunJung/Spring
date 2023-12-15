<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
$(function () {
	let Result = '<c:out value="${enroll_result}"/>';
	
	checkResult(Result);
	
	function checkResult(result) {
		if(result === '') {
			return;
		}
		alert("도서 '" + Result + "'을 등록했습니다");
	}
});
</script>
<title>Insert title here</title>
</head>
<body>
	<h2>도서 상품 관리 페이지</h2>
</body>
</html>